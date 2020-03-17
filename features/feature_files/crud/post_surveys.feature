@crud @delete_created_data
Feature: Surveys

  Background:
    Given I register a new "editor" and I save the request as "editor_request"
    When I store the response body as "editor_response"
    And I validate email using "editor_response._id"
    And I login to "WEB_APP" using "editor_response.primaryEmail" and "editor_request.password"
    And I store the response body as "login_response"

  Scenario: Verify that "/surveys" end point can perform "POST" request
    Given I perform "POST" request to "/surveys"
    When I set the header "Authorization" with "Bearer {login_response.token}"
    And  I set the following body
    """
    {
      "_id": "",
      "title": "New Survey 01",
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
    And I store the request body as "survey_request"
    And I send the request
    Then I expect a "201" status code
    And I store the response body as "survey_response"
    And I verify the "survey_response" schema with "post_surveys" template
