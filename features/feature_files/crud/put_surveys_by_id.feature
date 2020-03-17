@crud @delete_created_data
Feature: Modify Surveys

  Background:
    Given I register a new "editor" and I save the request as "editor_request"
    When I store the response body as "editor_response"
    And I validate email using "editor_response._id"
    And I login to "WEB_APP" using "editor_response.primaryEmail" and "editor_request.password"
    And I store the response body as "login_response"
    And I create a survey using the Authorization "login_response.token"
    And I store the request body as "survey_request"
    And I store the response body as "survey_response"

  Scenario: Verify that "/surveys/{surveyId}" end point can perform "PUT" request.
    Given I perform "PUT" request to "/surveys/{survey_response._id}"
    And I set the header "Authorization" with "Bearer {login_response.token}"
    And I set the following body
    """
    {
      "_id": "<{survey_response._id}>",
      "title": "<{survey_response.title}>",
      "description": "New Survey Description",
      "audience": 1,
      "domains": [],
      "state": 0,
      "releaseDate": "2017-10-08T23:00:38.604Z",
      "creationDate": "2017-10-08T23:00:38.604Z",
      "expirationDate": "2017-10-15T23:00:38.604Z",
      "responseQuantity": 0,
      "questions": [{
          "_id": "",
          "text": "Question 01",
          "type": "radiobutton",
          "required": false,
          "sequence": 0,
          "valid": true,
          "options": [{
              "_id": "",
              "label": "Option A",
              "default": false,
              "sequence": 0
          }, {
              "_id": "",
              "label": "Option B",
              "default": false,
              "sequence": 1
          }]
      }]
    }
    """
    And I store the request body as "survey_put_request"
    When I send the request
    Then I expect a "200" status code
    And I store the response body as "surveys_put_response"
    And I verify the "surveys_put_response" schema with "delete_surveys" template
