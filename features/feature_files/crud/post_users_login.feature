@crud @delete_created_data
Feature: Users login

  Background:
    Given I register a new "user" and I save the request as "user_request"
    When I store the response body as "user_response"
    And I validate email using "user_response._id"

  Scenario: Verify that "/users/login" end point can perform "POST" request
    Given I perform "POST" request to "/users/login"
    When I set the following custom body and store as "login_request"
      | email    | {user_response.primaryEmail} |
      | password | {user_request.password}      |
      | type     | 0                            |
      | app      | MOBILE_APP                   |
    And I send the request
    Then I expect a "201" status code
    And I store the response body as "login_response"
    And I verify the "login_response" schema with "post_users_login" template
