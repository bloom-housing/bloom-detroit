/*
5.2 Summary
Display a summary of application fields with edit links per section
*/
import {
  AppearanceStyleType,
  Button,
  FormCard,
  t,
  Form,
  ProgressNav,
} from "@bloom-housing/ui-components"
import FormsLayout from "../../../layouts/forms"
import { useForm } from "react-hook-form"
import FormSummaryDetails from "../../../src/forms/applications/FormSummaryDetails"
import { useFormConductor } from "../../../lib/hooks"
import { OnClientSide } from "@bloom-housing/shared-helpers"

const ApplicationSummary = () => {
  const { conductor, application, listing } = useFormConductor("summary")
  const currentPageSection = 5

  /* Form Handler */
  const { handleSubmit } = useForm()
  const onSubmit = () => conductor.routeToNextOrReturnUrl()

  return (
    <FormsLayout>
      <FormCard header={listing?.name}>
        <ProgressNav
          currentPageSection={currentPageSection}
          completedSections={application.completedSections}
          labels={conductor.config.sections.map((label) => t(`t.${label}`))}
          mounted={OnClientSide()}
        />
      </FormCard>
      <FormCard>
        <div className="form-card__lead">
          <h2 className="form-card__title is-borderless">
            {t("application.review.takeAMomentToReview")}
          </h2>
        </div>

        <FormSummaryDetails
          application={application}
          listing={listing}
          hidePreferences={listing?.listingPreferences.length === 0}
          editMode
        />

        <div className="form-card__group">
          <p className="field-note text-gray-800 text-center">
            {t("application.review.lastChanceToEdit")}
          </p>
        </div>

        <div className="form-card__pager">
          <div className="form-card__pager-row primary">
            <Form onSubmit={handleSubmit(onSubmit)}>
              <Button styleType={AppearanceStyleType.primary} data-test-id={"app-summary-confirm"}>
                {t("t.confirm")}
              </Button>
            </Form>
          </div>
        </div>
      </FormCard>
    </FormsLayout>
  )
}

export default ApplicationSummary
