import React, { useEffect, useMemo, useState } from "react"
import { SWRConfig } from "swr"
import type { AppProps } from "next/app"
import { GoogleReCaptchaProvider } from "react-google-recaptcha-v3"

import "@bloom-housing/ui-components/src/global/css-imports.scss"
import "@bloom-housing/ui-components/src/global/app-css.scss"
import "@bloom-housing/ui-seeds/src/global/app-css.scss"
import { addTranslation, NavigationContext, GenericRouter } from "@bloom-housing/ui-components"
import { Maintenance } from "@bloom-housing/shared-helpers"

// TODO: Make these not-global
import "ag-grid-community/dist/styles/ag-grid.css"
import "ag-grid-community/dist/styles/ag-theme-alpine.css"

import LinkComponent from "../components/core/LinkComponent"
import { translations, overrideTranslations } from "../lib/translations"

import "../../styles/overrides.scss"
import Layout from "../layouts"

const signInMessage = "Login is required to view this page."

function BloomApp({ Component, router, pageProps }: AppProps) {
  const { locale } = router
  const skipLoginRoutes = ["/forgot-password", "/reset-password", "/users/confirm", "/users/terms"]

  // fix for rehydration
  const [hasMounted, setHasMounted] = useState(false)
  useEffect(() => {
    setHasMounted(true)
  }, [])

  useMemo(() => {
    addTranslation(translations.general, true)
    if (locale && locale !== "en" && translations[locale]) {
      addTranslation(translations[locale])
    }
    addTranslation(overrideTranslations.en)
    if (overrideTranslations[locale]) {
      addTranslation(overrideTranslations[locale])
    }
  }, [locale])

  const pageContent = (
    <Layout>
      <Maintenance isPartners />
    </Layout>
  )

  return (
    <SWRConfig
      value={{
        onError: (error) => {
          const { status } = error.response || {}
          if (status === 403) {
            window.location.href = "/unauthorized"
          }
        },
      }}
    >
      <NavigationContext.Provider
        value={{
          LinkComponent: LinkComponent,
          router: router as GenericRouter,
        }}
      >
        {process.env.reCaptchaKey ? (
          <GoogleReCaptchaProvider reCaptchaKey={process.env.reCaptchaKey}>
            {pageContent}
          </GoogleReCaptchaProvider>
        ) : (
          pageContent
        )}
      </NavigationContext.Provider>
    </SWRConfig>
  )
}

export default BloomApp
