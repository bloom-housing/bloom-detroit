import { useContext, useEffect, useState } from "react"
import axios from "axios"
import { useRouter } from "next/router"
import qs from "qs"
import {
  EnumListingFilterParamsComparison,
  EnumMultiselectQuestionFilterParamsComparison,
  FeatureFlagEnum,
  FilterAvailabilityEnum,
  Jurisdiction,
  Listing,
  ListingFilterParams,
  ListingOrderByKeys,
  ListingsStatusEnum,
  MultiselectQuestionsApplicationSectionEnum,
  MultiselectQuestionFilterParams,
  OrderByEnum,
  PaginatedListing,
} from "@bloom-housing/shared-helpers/src/types/backend-swagger"
import { ParsedUrlQuery } from "querystring"
import { AppSubmissionContext } from "./applications/AppSubmissionContext"
import { useRequireLoggedInUser, isInternalLink, AuthContext } from "@bloom-housing/shared-helpers"
import { fetchFavoriteListingIds } from "./helpers"

export const useRedirectToPrevPage = (defaultPath = "/") => {
  const router = useRouter()

  return (queryParams: ParsedUrlQuery = {}) => {
    const redirectUrl =
      typeof router.query.redirectUrl === "string" && isInternalLink(router.query.redirectUrl)
        ? router.query.redirectUrl
        : defaultPath
    const redirectParams = { ...queryParams }
    if (router.query.listingId) redirectParams.listingId = router.query.listingId

    return router.push({ pathname: redirectUrl, query: redirectParams })
  }
}

export const useFormConductor = (stepName: string) => {
  useRequireLoggedInUser("/", !process.env.showMandatedAccounts)
  const context = useContext(AppSubmissionContext)
  const conductor = context.conductor

  conductor.stepTo(stepName)

  useEffect(() => {
    conductor.skipCurrentStepIfNeeded()
  }, [conductor])
  return context
}

export const useProfileFavoriteListings = () => {
  const { profile, listingsService, userService } = useContext(AuthContext)
  const [loading, setLoading] = useState(true)
  const [listings, setListings] = useState<PaginatedListing>({ items: [] } as PaginatedListing)

  useEffect(() => {
    if (profile && loading) {
      void fetchFavoriteListingIds(profile.id, userService).then((listingIds) => {
        if (listingIds.length > 0) {
          listingsService
            .list({
              filter: [
                {
                  $comparison: EnumListingFilterParamsComparison.IN,
                  ids: listingIds,
                },
              ],
              limit: "all",
            })
            .then((res) => {
              setListings(res)
            })
            .catch((err) => {
              console.error(`Error fetching listings: ${err}`)
            })
            .finally(() => setLoading(false))
        } else {
          setListings({ items: [] } as PaginatedListing)
          setLoading(false)
        }
      })
    }
  }, [profile, loading, userService, listingsService])

  return [listings.items, loading] as [Listing[], boolean]
}

export async function fetchBaseListingData(
  {
    page,
    additionalFilters,
    orderBy,
    orderDir,
    limit,
  }: {
    page?: number
    additionalFilters?: ListingFilterParams[]
    orderBy?: ListingOrderByKeys[]
    orderDir?: OrderByEnum[]
    limit?: string
  },
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  req: any
) {
  let listings
  let pagination
  try {
    const { id: jurisdictionId, featureFlags } = await fetchJurisdictionByName(req)

    if (!jurisdictionId) {
      return listings
    }
    let filter: ListingFilterParams[] = [
      {
        $comparison: EnumListingFilterParamsComparison["="],
        jurisdiction: jurisdictionId,
      },
    ]

    if (additionalFilters) {
      filter = filter.concat(additionalFilters)
    }
    const params: {
      page?: number
      view: string
      limit: string
      filter: ListingFilterParams[]
      orderBy?: ListingOrderByKeys[]
      orderDir?: OrderByEnum[]
    } = {
      view: "base",
      limit: limit || "all",
      filter,
    }

    const enablePagination =
      featureFlags.find((flag) => flag.name === FeatureFlagEnum.enableListingPagination)?.active ||
      false

    if (page && enablePagination) {
      params.page = page
    }
    if (orderBy) {
      params.orderBy = orderBy
    }
    if (orderDir) {
      params.orderDir = orderDir
    }
    const response = await axios.post(`${process.env.listingServiceUrl}/list`, params, {
      headers: {
        passkey: process.env.API_PASS_KEY,
        "x-forwarded-for": req?.headers["x-forwarded-for"] ?? req?.socket?.remoteAddress,
      },
    })

    listings = response.data.items
    pagination = enablePagination ? response.data.meta : null
  } catch (e) {
    console.log("fetchBaseListingData error: ", e)
  }

  return {
    items: listings,
    meta: pagination,
  }
}

export async function fetchOpenListings(
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  req: any,
  page: number,
  additionalFilters: ListingFilterParams[] = []
) {
  return await fetchBaseListingData(
    {
      page: page,
      additionalFilters: [
        {
          $comparison: EnumListingFilterParamsComparison["="],
          status: ListingsStatusEnum.active,
        },
        ...additionalFilters,
      ],
      orderBy: [ListingOrderByKeys.marketingType, ListingOrderByKeys.mostRecentlyPublished],
      orderDir: [OrderByEnum.desc, OrderByEnum.desc],
      limit: process.env.maxBrowseListings,
    },
    req
  )
}

export async function fetchClosedListings(
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  req: any,
  page: number,
  additionalFilters: ListingFilterParams[] = []
) {
  return await fetchBaseListingData(
    {
      page: page,
      additionalFilters: [
        {
          $comparison: EnumListingFilterParamsComparison["="],
          status: ListingsStatusEnum.closed,
        },
        ...additionalFilters,
      ],
      orderBy: [ListingOrderByKeys.mostRecentlyClosed],
      orderDir: [OrderByEnum.desc],
      limit: process.env.maxBrowseListings,
    },
    req
  )
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export async function fetchLimitedUnderConstructionListings(req?: any, limit?: number) {
  return await fetchBaseListingData(
    {
      additionalFilters: [
        {
          $comparison: EnumListingFilterParamsComparison["="],
          status: ListingsStatusEnum.active,
          availability: FilterAvailabilityEnum.comingSoon,
        },
      ],
      orderBy: [ListingOrderByKeys.mostRecentlyPublished],
      orderDir: [OrderByEnum.desc],
      limit: limit ? limit.toString() : "3",
    },
    req
  )
}

let jurisdiction: Jurisdiction | null = null

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export async function fetchJurisdictionByName(req?: any) {
  try {
    if (jurisdiction) {
      return jurisdiction
    }

    const jurisdictionName = process.env.jurisdictionName

    const headers = {
      passkey: process.env.API_PASS_KEY,
    }
    if (req) {
      headers["x-forwarded-for"] = req.headers["x-forwarded-for"] ?? req.socket.remoteAddress
    }
    const jurisdictionRes = await axios.get(
      `${process.env.backendApiBase}/jurisdictions/byName/${jurisdictionName}`,
      {
        headers,
      }
    )
    jurisdiction = jurisdictionRes?.data
  } catch (error) {
    console.log("error = ", error)
  }

  return jurisdiction
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export async function fetchMultiselectData(req: any, jurisdictionId: string) {
  try {
    const headers = {
      passkey: process.env.API_PASS_KEY,
    }
    if (req) {
      headers["x-forwarded-for"] = req.headers["x-forwarded-for"] ?? req.socket.remoteAddress
    }

    const params: {
      filter: MultiselectQuestionFilterParams[]
    } = {
      filter: [
        {
          $comparison: EnumMultiselectQuestionFilterParamsComparison["="],
          applicationSection: MultiselectQuestionsApplicationSectionEnum.programs,
        },
        {
          $comparison: EnumMultiselectQuestionFilterParamsComparison["IN"],
          jurisdiction: jurisdictionId && jurisdictionId !== "" ? jurisdictionId : undefined,
        },
      ],
    }

    const paramsString = qs.stringify(params)

    const multiselectDataResponse = await axios.get(
      `${process.env.backendApiBase}/multiselectQuestions?${paramsString}`,
      {
        headers,
      }
    )
    return multiselectDataResponse?.data
  } catch (error) {
    console.log("error = ", error)
  }
}
