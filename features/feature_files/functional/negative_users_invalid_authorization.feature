@functional
Feature: Users

  @delete_created_data
  Scenario Outline: Invalid Authorization
    Given I perform "<REQUEST>" request to "<END_POINT>"
    When I set the header "Authorization" with "Bearer 59cfd59f5641d906f70bdb00"
    And I send the request
    Then I expect a "401" status code
    And I store the response body as "user_response"
    And I verify the "user_response" schema with "error_response" template
    Then I verify "user_response" with following expected response
    """
    {
      "statusCode": 401,
      "details": "Not Authorize to continue"
    }
    """
    Examples:
      | END_POINT                              | REQUEST |
      | /users/59cfd59f5641d906f70bdb00        | GET     |
      | /users/59cfd59f5641d906f70bdb00/emails | POST    |
      | /users/logout                          | POST    |
      | /users/password                        | PUT     |
