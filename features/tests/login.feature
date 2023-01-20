Feature: SeeTestDemoApp - Login Demo

  @smoke @login
  Scenario: Login successfully
    Given fill user name on the page
    And fill password on the page
    When click login on the page
    Then verify login
    And logout
    Then verify logout
