@smoke @delete_created_data
Feature: Survey

  Background:
    Given I register a new "user" and I save the request as "user_request"
    When I store the response body as "user_response"
    And I validate email using "user_response._id"
    And I login to "MOBILE_APP" using "user_response.primaryEmail" and "user_request.password"
    And I store the response body as "login_response"
    And I create a survey using the Authorization "login_response.token"
    And I store the request body as "survey_request"
    And I store the response body as "survey_response"
    And I change the "survey_response._id" state to "1" with "login_response.token"

  Scenario Outline:  Verify that "/surveys" end point can perform "GET" request.
    Given I perform "GET" request to "<End Point>"
    And I set the header "Authorization" with "Bearer {login_response.token}"
    When I send the request
    Then I expect a "200" status code
    Examples:
      | End Point                                        |
      | /surveys                                         |
      | /surveys/{survey_response._id}                   |
      | /surveys/{survey_response._id}/edit              |
      | /surveys/{survey_response._id}/overview          |
      | /surveys/{survey_response._id}/results?type=json |
      | /surveys/{survey_response._id}/results?type=csv  |
