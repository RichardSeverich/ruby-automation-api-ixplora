@functional
Feature: Users

  Background:
    Given I register a new "user" and I save the request as "user_request"
    When I store the response body as "user_response"
    And I validate email using "user_response._id"
    And I login to "MOBILE_APP" using "user_response.primaryEmail" and "user_request.password"
    And I store the response body as "login_response"

  @delete_created_data
  Scenario Outline: Verify that user is not "GET" with invalid information
    Given I perform "GET" request to "/users/<USER_ID>"
    When I set the header "Authorization" with "bearer {login_response.token}"
    And I send the request
    Then I expect a "400" status code
    And I store the response body as "user_response_get"
    And I verify the "user_response_get" schema with "error_response" template
    And I verify "user_response_get" with following expected response
    """
    {
      "status": "400",
      "source": "/users/userId",
      "detail": "Invalid data"
    }
    """
    Examples:
      | USER_ID                  |
      | 59d7e00a9eb6160dee1d7c25 |
      | -+*/*-++-++              |
