@functional
Feature: Surveys

  Background:
    Given I register a new "editor" and I save the request as "editor_request"
    When I store the response body as "editor_response"
    And I validate email using "editor_response._id"
    And I login to "WEB_APP" using "editor_response.primaryEmail" and "editor_request.password"
    And I store the response body as "login_response"
    And I create a survey using the Authorization "login_response.token"
    And I store the response body as "survey_response"
    And I change the "survey_response._id" state to "1" with "login_response.token"

  @delete_created_data
  Scenario Outline: Verify that "/surveys/{surveyId}/stats" end point can perform "GET" request.
    Given I perform "GET" request to "/surveys/<SURVEY_ID>/stats"
    And I set the header "Authorization" with "Bearer {login_response.token}"
    When I send the request
    Then I expect a "404" status code
    And I store the response body as "surveys_stats_response"
    And I verify the "surveys_stats_response" schema with "error_response" template
    Then I verify "surveys_stats_response" with following expected response

    """
    {
    "statusCode": 404,
    "details": "Survey does not exist"
    }
    """
    Examples:
      | SURVEY_ID   |
      | 89761230    |
      | safmnASFSDF |
      |             |
