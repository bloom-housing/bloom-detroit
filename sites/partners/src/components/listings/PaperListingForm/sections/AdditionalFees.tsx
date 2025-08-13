import React, { useContext, useMemo, useEffect } from "react"
import { useFormContext } from "react-hook-form"
import { t, Field, Textarea, FieldGroup } from "@bloom-housing/ui-components"
import { Grid } from "@bloom-housing/ui-seeds"
import { defaultFieldProps } from "../../../../lib/helpers"
import { AuthContext, listingUtilities } from "@bloom-housing/shared-helpers"
import {
  FeatureFlagEnum,
  ListingUtilities,
} from "@bloom-housing/shared-helpers/src/types/backend-swagger"
import SectionWithGrid from "../../../shared/SectionWithGrid"
import styles from "../ListingForm.module.scss"

type AdditionalFeesProps = {
  existingUtilities: ListingUtilities
  requiredFields: string[]
  isNonRegulated?: boolean
}

const AdditionalFees = (props: AdditionalFeesProps) => {
  const formMethods = useFormContext()
  const { doJurisdictionsHaveFeatureFlagOn } = useContext(AuthContext)
  // eslint-disable-next-line @typescript-eslint/unbound-method
  const { register, watch, errors, clearErrors, setValue } = formMethods

  const jurisdiction = watch("jurisdictions.id")
  const isFixedDeposit = watch("isFixedDeposit")

  const utilitiesFields = useMemo(() => {
    return listingUtilities.map((utility) => {
      return {
        id: utility,
        label: t(`listings.utilities.${utility}`),
        defaultChecked: props.existingUtilities ? props.existingUtilities[utility] : false,
        register,
      }
    })
  }, [props.existingUtilities, register])

  const enableUtilitiesIncluded = doJurisdictionsHaveFeatureFlagOn(
    FeatureFlagEnum.enableUtilitiesIncluded,
    jurisdiction
  )

  useEffect(() => {
    // clear the utilities values if the new jurisdiction doesn't have utilities included functionality
    if (!enableUtilitiesIncluded) {
      setValue("utilities", undefined)
    }
  }, [enableUtilitiesIncluded, setValue])

  // Set default deposit type for non-regulated forms
  useEffect(() => {
    if (props.isNonRegulated && !isFixedDeposit) {
      setValue("isFixedDeposit", "true")
    }
  }, [props.isNonRegulated, isFixedDeposit, setValue])

  return (
    <>
      <hr className="spacer-section-above spacer-section" />
      <SectionWithGrid
        heading={t("listings.sections.additionalFees")}
        subheading={t("listings.sections.additionalFeesSubtitle")}
      >
        <Grid.Row>
          <Grid.Cell>
            <Field
              register={register}
              type={"currency"}
              prepend={"$"}
              {...defaultFieldProps(
                "applicationFee",
                t("listings.applicationFee"),
                props.requiredFields,
                errors,
                clearErrors
              )}
            />
          </Grid.Cell>
          {props.isNonRegulated ? (
            <>
              <Grid.Cell>
                <FieldGroup
                  name="isFixedDeposit"
                  type="radio"
                  register={register}
                  groupLabel="Deposit Type"
                  fieldLabelClassName={`${styles["label-option"]} seeds-m-bs-2`}
                  fields={[
                    {
                      label: "Fixed Deposit",
                      value: "true",
                      id: "isFixedDepositYes",
                    },
                    {
                      label: "Deposit Range",
                      value: "false",
                      id: "isFixedDepositNo",
                    },
                  ]}
                />
              </Grid.Cell>
            </>
          ) : (
            <>
              <Grid.Cell>
                <Field
                  register={register}
                  type={"currency"}
                  prepend={"$"}
                  {...defaultFieldProps(
                    "depositMin",
                    t("listings.depositMin"),
                    props.requiredFields,
                    errors,
                    clearErrors
                  )}
                />
              </Grid.Cell>
              <Grid.Cell>
                <Field
                  register={register}
                  type={"currency"}
                  prepend={"$"}
                  {...defaultFieldProps(
                    "depositMax",
                    t("listings.depositMax"),
                    props.requiredFields,
                    errors,
                    clearErrors
                  )}
                />
              </Grid.Cell>
            </>
          )}
        </Grid.Row>
        {props.isNonRegulated && (
          <>
            {isFixedDeposit === "true" ? (
              <Grid.Row columns={2}>
                <Grid.Cell>
                  <Field
                    register={register}
                    type={"currency"}
                    prepend={"$"}
                    {...defaultFieldProps(
                      "deposit",
                      "Deposit",
                      props.requiredFields,
                      errors,
                      clearErrors
                    )}
                  />
                </Grid.Cell>
              </Grid.Row>
            ) : (
              <Grid.Row>
                <Grid.Cell>
                  <Field
                    register={register}
                    type={"currency"}
                    prepend={"$"}
                    {...defaultFieldProps(
                      "depositLowEnd",
                      "Deposit From:",
                      props.requiredFields,
                      errors,
                      clearErrors
                    )}
                  />
                </Grid.Cell>
                <Grid.Cell>
                  <Field
                    register={register}
                    type={"currency"}
                    prepend={"$"}
                    {...defaultFieldProps(
                      "depositHighEnd",
                      "Deposit To:",
                      props.requiredFields,
                      errors,
                      clearErrors
                    )}
                  />
                </Grid.Cell>
              </Grid.Row>
            )}
          </>
        )}
        <Grid.Row>
          <Grid.Cell>
            <Textarea
              aria-describedby={"depositHelperText"}
              fullWidth={true}
              register={register}
              placeholder={""}
              {...defaultFieldProps(
                "depositHelperText",
                t("listings.sections.depositHelperText"),
                props.requiredFields,
                errors,
                clearErrors
              )}
            />
          </Grid.Cell>
          <Grid.Cell>
            <Textarea
              aria-describedby={"costsNotIncluded"}
              fullWidth={true}
              register={register}
              placeholder={""}
              {...defaultFieldProps(
                "costsNotIncluded",
                t("listings.sections.costsNotIncluded"),
                props.requiredFields,
                errors,
                clearErrors
              )}
            />
          </Grid.Cell>
        </Grid.Row>
        {enableUtilitiesIncluded && (
          <Grid.Row>
            <FieldGroup
              type="checkbox"
              name="utilities"
              groupLabel={t("listings.sections.utilities")}
              fields={utilitiesFields}
              register={register}
              fieldGroupClassName="grid grid-cols-2 mt-2"
              fieldLabelClassName={styles["label-option"]}
            />
          </Grid.Row>
        )}
      </SectionWithGrid>
    </>
  )
}

export default AdditionalFees
