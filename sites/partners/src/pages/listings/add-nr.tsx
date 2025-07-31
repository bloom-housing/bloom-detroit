import React from "react"
import Head from "next/head"
import { t, Breadcrumbs, BreadcrumbLink } from "@bloom-housing/ui-components"
import Layout from "../../layouts"
import PaperListingForm from "../../components/listings/PaperListingForm"
import { MetaTags } from "../../components/shared/MetaTags"
import { NavigationHeader } from "../../components/shared/NavigationHeader"
import ListingGuard from "../../components/shared/ListingGuard"

const NewNonRegulatedListing = () => {
  const metaDescription = ""
  const metaImage = "" // TODO: replace with hero image

  return (
    <ListingGuard>
      <Layout>
        <Head>
          <title>{t("nav.siteTitlePartners")}</title>
        </Head>
        <MetaTags
          title={t("nav.siteTitlePartners")}
          image={metaImage}
          description={metaDescription}
        />
        <NavigationHeader
          className="relative"
          title={t("listings.newNonRegulatedListing")}
          breadcrumbs={
            <Breadcrumbs>
              <BreadcrumbLink href="/">{t("t.listing")}</BreadcrumbLink>
              <BreadcrumbLink href="/listings/add-nr" current>
                {t("listings.newNonRegulatedListing")}
              </BreadcrumbLink>
            </Breadcrumbs>
          }
        />
        <PaperListingForm isNonRegulated={true} />
      </Layout>
    </ListingGuard>
  )
}

export default NewNonRegulatedListing
