@crud @delete_created_data
Feature: Surveys clone

  Background:
    Given I register a new "editor" and I save the request as "editor_request"
    When I store the response body as "editor_response"
    And I validate email using "editor_response._id"
    And I login to "MOBILE_APP" using "editor_response.primaryEmail" and "editor_request.password"
    And I store the response body as "login_response"
    And I create a survey using the Authorization "login_response.token"
    And I store the request body as "survey_request"
    And I store the response body as "survey_response"

  Scenario: Verify that "/surveys/{surveyId}/clone" end point can perform "POST" request.
    Given I perform "POST" request to "/surveys/{survey_response._id}/clone"
    And I set the header "Authorization" with "Bearer {login_response.token}"
    When I send the request
    Then I expect a "201" status code
    And I store the response body as "clone_surveys_response"
    And I verify the "clone_surveys_response" schema with "post_surveys_clone" template
    And I build the expected response with following data
      | request  | survey_request         |
      | response | clone_surveys_response |
      | template | get_surveys_by_id      |
    Then I verify "clone_surveys_response" with built expected response
