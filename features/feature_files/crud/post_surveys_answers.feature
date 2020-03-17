@crud @delete_created_data
Feature: Surveys answers

  Background:
    Given I register a new "editor" and I save the request as "editor_request"
    When I store the response body as "editor_response"
    And I validate email using "editor_response._id"
    And I login to "WEB_APP" using "editor_response.primaryEmail" and "editor_request.password"
    And I store the response body as "editor_login_response"
    And I perform "POST" request to "/surveys"
    And I set the header "Authorization" with "Bearer {editor_login_response.token}"
    When  I set the following body
    """
     {
       "_id": "",
       "title": "Expertise Questions",
       "description": "These are questions of experiences",
       "audience": 0,
       "domains": [],
       "state": 0,
       "releaseDate": "2017-10-05T20:41:46.835Z",
       "creationDate": "2017-10-05T20:41:46.835Z",
       "expirationDate": "2017-10-12T20:41:46.835Z",
       "responseQuantity": 0,
       "questions": [{
                        "_id": "",
                       "text": "What is your best experience?",
                       "type": "checkbox",
                       "required": false,
                       "sequence": 0,
                       "valid": true,
                       "options": [{
                                       "_id": "",
                                       "label": "option1",
                                       "default": false,
                                       "sequence": 0
                                   }, {
                                       "_id": "",
                                       "label": "option2",
                                       "default": false,
                                       "sequence": 1
                                   }]
                   }]
     }
    """
    And I store the request body as "surveys_request"
    And I send the request
    Then I expect a "201" status code
    And I store the response body as "survey_response"
    And I register a new "user" and I save the request as "user_request"
    And I store the response body as "user_response"
    And I validate email using "user_response._id"
    And I login to "MOBILE_APP" using "user_response.primaryEmail" and "user_request.password"
    And I store the response body as "login_response"

  Scenario: Verify that "/surveys/{surveyId}/answers" end point can performing "POST" request.
    Given I perform "POST" request to "/surveys/{survey_response._id}/answers"
    And I set the header "Authorization" with "Bearer {login_response.token}"
    And I set the following body
    """
    {
     "answers": [{
      "questionId": "<{survey_response.questions._id}>",
      "answers": "1",
      "type": "singleSelection"
     }],
      "userId": "<{user_response._id}>"
    }
    """
    And I store the request body as "answers_request"
    When I send the request
    Then I expect a "201" status code
    And I store the response body as "answers_response"
    And I verify the "answers_response" schema with "post_surveys_answers" template
