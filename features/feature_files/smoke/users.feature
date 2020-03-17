@smoke @delete_created_data
Feature: Users

  Background:
    Given I register a new "user" and I save the request as "user_request"
    And I store the response body as "user_response"
    And I validate email using "user_response._id"
    And I login to "MOBILE_APP" using "user_response.primaryEmail" and "user_request.password"
    And I store the response body as "login_response"

  Scenario: Verify that "/users/{userId}" end point can perform "GET" request.
    Given I perform "GET" request to "/users/{user_response._id}"
    And I set the header "Authorization" with "Bearer {login_response.token}"
    When I send the request
    Then I expect a "200" status code
