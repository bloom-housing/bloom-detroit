import React from "react"
import { ContentMaintenance } from "../components/page/ContentMaintenance"
import Layout from "../layouts/application"

const MaintenancePage = () => {
  return (
    <Layout pageTitle={"Maintenance"}>
      <ContentMaintenance />
    </Layout>
  )
}

export { MaintenancePage as default, MaintenancePage }
