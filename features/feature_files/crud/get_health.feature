@crud @delete_created_data
Feature: health

  Scenario: Verify that "/health" end point can perform "GET" request.
    Given I perform "GET" request to "/health"
    When I send the request
    Then I expect a "200" status code
    And I store the response body as "health_response"
    And I verify the "health_response" schema with "get_health" template
    And I build the expected response with following data
      | response | health_response |
      | template | get_health      |
    Then I verify "health_response" with built expected response
