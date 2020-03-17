@functional
Feature: Surveys

  Background:
    Given I register a new "editor" and I save the request as "editor_request"
    When I store the response body as "editor_response"
    And I validate email using "editor_response._id"
    And I login to "MOBILE_APP" using "editor_response.primaryEmail" and "editor_request.password"
    And I store the response body as "login_response"
    And I create a survey using the Authorization "login_response.token"
    And I store the request body as "survey_request"

  @delete_created_data
  Scenario Outline: Valid audience
    Given I perform "POST" request to "/surveys"
    When I set the header "Authorization" with "Bearer {login_response.token}"
    And  I set the following body
    """
     {
      "_id": "",
      "title": "Sports",
      "description": "Sports questions",
      "audience": <AUD>,
      "domains": [],
      "state": 0,
      "releaseDate": "2017-10-07T16:25:23.345Z",
      "creationDate": "2017-10-07T16:25:23.345Z",
      "expirationDate": "2017-10-14T16:25:23.345Z",
      "responseQuantity": 0,
      "questions": []
    }
    """
    And I store the request body as "survey_request"
    And I send the request
    Then I expect a "201" status code
    And I store the response body as "survey_response"
    And I verify the "survey_response" schema with "post_survey" template
    And I build the expected response with following data
      | request_name  | survey_request  |
      | response_name | survey_response |
      | template_name | post_survey     |
    Then I verify "surveys_response" with built expected response
    Examples:
      | AUD |
      | 0   |
      | 1   |
      | 2   |
