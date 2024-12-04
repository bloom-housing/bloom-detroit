import React, { useEffect, useContext } from "react"
import { PageHeader, t } from "@bloom-housing/ui-components"
import { PageView, pushGtmEvent, AuthContext } from "@bloom-housing/shared-helpers"
import { UserStatus } from "../lib/constants"
import Layout from "../layouts/application"

const Feedback = () => {
  const { profile } = useContext(AuthContext)

  useEffect(() => {
    pushGtmEvent<PageView>({
      event: "pageView",
      pageTitle: "Feedback",
      status: profile ? UserStatus.LoggedIn : UserStatus.NotLoggedIn,
    })
  }, [profile])

  const pageTitle = <>{t("pageTitle.feedback")}</>

  return (
    <Layout>
      <PageHeader inverse={true} title={pageTitle} />
      <iframe
        src="https://docs.google.com/forms/d/e/1FAIpQLSe8Npioi4fChtWbTZUsfE23lEoeFXVn9vlCAHA9lMGWsQUAGA/viewform?embedded=true"
        width="100%"
        height="1400"
        title="Website feedback form"
      />
    </Layout>
  )
}

export default Feedback
