@functional
Feature: Users logout

  Background:
    Given I register a new "user" and I save the request as "user_request"
    When I store the response body as "user_response"
    And I validate email using "user_response._id"
    And I login to "MOBILE_APP" using "user_response.primaryEmail" and "user_request.password"
    And I store the response body as "login_response"

  @delete_created_data
  Scenario Outline: Verify that "/users/logout" end point can perform "POST" request
    Given I perform "POST" request to "/users/logout"
    When I set the header "Authorization" with "Bearer {login_response.token}"
    When  I set the following body
      """
      {
      "id": "<ID>"
      }
      """
    And I send the request
    Then I expect a "409" status code
    And I store the response body as "logout_response"
    And I verify "login_response" with following expected response
    """
      {
      "status": "409",
      "source": "/users/logout",
      "detail": "Session Token couldn't be deleted"
      }
    """
    Examples:
      | ID                       |
      |                          |
      | !$·)%                    |
      | 59d7e00a9eb6160dee1d7c25 |
      | ASDKJHWQIUB2389742119123 |
