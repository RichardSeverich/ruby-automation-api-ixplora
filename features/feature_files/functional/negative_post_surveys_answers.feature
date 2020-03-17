@functional
Feature: Surveys

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
    And I store the request body as "survey_request"
    And I send the request
    Then I expect a "201" status code
    And I store the response body as "survey_response"
    And I register a new "user" and I save the request as "user_request"
    And I store the response body as "user_response"
    And I validate email using "user_response._id"
    And I login to "MOBILE_APP" using "user_response.primaryEmail" and "user_request.password"
    And I store the response body as "login_response"

  @delete_created_data
  Scenario Outline: Verify answers end point can not performing "POST" request with invalid data.
    Given I perform "POST" request to "/surveys/{survey_response._id}/answers"
    And I set the header "Authorization" with "Bearer {login_response.token}"
    When  I set the following body
    """
    {
     "answers": [{
      "questionId": "<QUESTION_ID>",
      "answers": "<ANSWERS>",
      "type": "<TYPE>"
     }],
      "userId": "<USER_ID>"
    }
    """
    And I store the request body as "answers_request"
    When I send the request
    Then I expect a "404" status code
    And I store the response body as "answers_response"
    And I verify the "surveys_result_response" schema with "get_surveys_results_json" template
    Then I verify "surveys_stats_response" with following expected response

    """
    {
    "status": "404",
    "source": "/surveys/surveyId/answers",
    "detail": "Survey does not exist"
    }
    """
    Examples:
      | QUESTION_ID              | ANSWERS | TYPE            | USER_ID                  |
      | GHFEDSXZ213              | A       | JRWRBX          | BFE4234ZX                |
      |                          |         |                 |                          |
      | $#%&/)=                  | %#&!    | /=#(!           | &#/=                     |
      | 4231                     | 423432  | 432             | 432423                   |
      |                          | 1       | singleSelection | 59cfd59f5641d906f70bdb99 |
      | 59cfe2e95641d906f70bdb15 | 2       | singleSelection |                          |
      | 59cfe2e95641d906f70bdb15 | 8       |                 | 59cfd59f5641d906f70bdb99 |
      | 59cfe2e95641d906f70bdb15 |         | singleSelection | 59cfd59f5641d906f70bdb99 |
      |                          | 7       | singleSelection | 59cfd59f5641d906f70bdb99 |
      |                          |         | singleSelection | 59cfd59f5641d906f70bdb99 |
      |                          |         |                 | 59cfd59f5641d906f70bdb99 |
      | 59cfe2e95641d906f70bdb15 | 5       | singleSelection |                          |
      | 59cfe2e95641d906f70bdb15 | 9       |                 |                          |
      | 59cfe2e95641d906f70bdb15 |         |                 |                          |
