@smoke
Feature: Server Health

  Scenario: Verify that "/health" end point can perform "GET" request.
    Given I perform "GET" request to "/health"
    When I send the request
    Then I expect a "200" status code
