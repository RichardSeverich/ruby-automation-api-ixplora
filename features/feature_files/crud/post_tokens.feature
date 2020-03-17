@crud @delete_created_data
Feature: User Tokens

  Background:
    Given I register a new "user" and I save the request as "user_request"
    When I store the response body as "user_response"
    And I run a query to filter the field "userId" with value "{user_response._id}" in "email_tokens"
    And I store the "token" of query result as "mail_token"

  Scenario: Verify that "/tokens" end point can performing "POST" request
    Given I perform "POST" request to "/tokens"
    When I set the following custom body and store as "token_request"
      | token | mail_token |
    And I send the request
    Then I expect a "201" status code
    And I store the response body as "token_response"
    And I verify the "token_response" schema with "post_tokens" template
    And I build the expected response with following data
      | request  | token_request  |
      | response | token_response |
      | template | post_tokens    |
    Then I verify "token_response" with built expected response
