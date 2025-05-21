import React, { useEffect, useContext } from "react"
import { PageView, pushGtmEvent, AuthContext } from "@bloom-housing/shared-helpers"
import { t } from "@bloom-housing/ui-components"
import Layout from "../layouts/application"
import MaxWidthLayout from "../layouts/max-width"
import { UserStatus } from "../lib/constants"
import { PageHeaderLayout } from "../patterns/PageHeaderLayout"

const About = () => {
  const { profile } = useContext(AuthContext)

  useEffect(() => {
    pushGtmEvent<PageView>({
      event: "pageView",
      pageTitle: "About",
      status: profile ? UserStatus.LoggedIn : UserStatus.NotLoggedIn,
    })
  }, [profile])

  return (
    <Layout>
      <PageHeaderLayout heading={t("pageTitle.about")} inverse>
        <MaxWidthLayout>
          <>
            <p>{t("about.body1")}</p>
            <br />
            <p>{t("about.body2")}</p>
            <br />
            <p>{t("about.moreInfoContact")}</p>
            <br />
            <p>{t("about.thankYouPartners")}</p>
            <br />
            <p>{t("about.partnersList")}</p>
          </>
        </MaxWidthLayout>
      </PageHeaderLayout>
    </Layout>
  )
}

export default About
