describe("applications/financial/vouchers", function () {
  const route = "/applications/financial/vouchers"

  beforeEach(() => {
    cy.visit(route)
  })

  // TODO: unskip after applications are implemented on the front end
  it.skip("should render vouchers sub-form", function () {
    cy.get("form").should("be.visible")
    cy.location("pathname").should("include", route)
  })

  // TODO: unskip after applications are implemented on the front end
  it.skip("should require form input", function () {
    cy.goNext()
    cy.location("pathname").should("include", route)
    cy.checkErrorAlert("be.visible")
  })
})
