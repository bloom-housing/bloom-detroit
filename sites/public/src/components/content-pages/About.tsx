import React from "react"
import { t } from "@bloom-housing/ui-components"
import Layout from "../../layouts/application"
import { PageHeaderLayout } from "../../patterns/PageHeaderLayout"
import styles from "../../patterns/PageHeaderLayout.module.scss"

const About = () => {
  return (
    <Layout>
      <PageHeaderLayout heading={t("pageTitle.about")} inverse>
        <section className={styles["markdown"]}>
          <p>{t("about.body1")}</p>
          <br />
          <p>{t("about.body2")}</p>
          <br />
          <p>{t("about.moreInfoContact")}</p>
          <br />
          <p>{t("about.thankYouPartners")}</p>
          <br />
          <p>{t("about.partnersList")}</p>
        </section>
      </PageHeaderLayout>
    </Layout>
  )
}

export default About
