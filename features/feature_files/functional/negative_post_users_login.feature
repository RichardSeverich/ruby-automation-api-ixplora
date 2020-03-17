@functional
Feature: Users login

  Background:
    Given I register a new "user" and I save the request as "user_request"
    When I store the response body as "user_response"
    And I validate email using "user_response._id"
    And I login to "MOBILE_APP" using "user_response.primaryEmail" and "user_request.password"
    And I store the response body as "login_response"

  @delete_created_data
  Scenario Outline: Verify that "/users/login" returns error when send invalid information
    Given I perform "POST" request to "/users/login"
    When I set the header "Authorization" with "Bearer {login_response.token}"
    When  I set the following body
      """
      {
       "email": "<EMAIL>",
       "password": "<PASSWORD>"
      }
      """
    And I store the request body as "user_request_login"
    And I send the request
    Then I expect a "400" status code
    And I store the response body as "login_response"
    And I verify the "login_response" schema with "post_login" template
    And I verify "login_response" with following expected response
    """
      {
      "status": "400",
      "source": "/users/login",
      "detail": "Invalid email or password"
      }
    """

    Examples:
      | EMAIL | PASSWORD |
      |       |          |
      | !2)%  | %&$#!    |
      | &$#!? |          |
      |       | )%2#?!   |
      | VQWKM | .        |
