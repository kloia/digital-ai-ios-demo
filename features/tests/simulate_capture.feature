Feature: SeeTestDemoApp - Simulate Capture Demo

  @smoke @simulate_capture
  Scenario: Simulate Capture
    Given fill user name on the page
    And fill password on the page
    When click login on the page
    And click advance options
    And click scan
    And simulate capture
