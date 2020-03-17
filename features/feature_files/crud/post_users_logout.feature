@crud @delete_created_data
Feature: Users logout

  Background:
    Given I register a new "user" and I save the request as "user_request"
    When I store the response body as "user_response"
    And I validate email using "user_response._id"
    And I login to "MOBILE_APP" using "user_response.primaryEmail" and "user_request.password"
    And I store the response body as "login_response"

  Scenario: Verify that "/users/logout" end point can perform "POST" request
    Given I perform "POST" request to "/users/logout"
    When I set the header "Authorization" with "Bearer {login_response.token}"
    And I set the following custom body:
      | id | {user_response._id} |
    And I send the request
    Then I expect a "201" status code
