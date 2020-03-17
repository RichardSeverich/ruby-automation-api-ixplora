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
  Scenario Outline: Invalid Authorization
    Given I perform "POST" request to "/surveys"
    When I set the header "Authorization" with "Bearer {login_response.token}"
    And  I set the following body
    """
     {
      "_id": "<ID>",
      "title": "<TITLE>",
      "description": "<DESCRIPTION>",
      "audience": <AUD>,
      "domains": [],
      "state": <STATE>,
      "releaseDate": "<RELEASE_DATE>",
      "creationDate": "<CREATION_DATE>",
      "expirationDate": "<EXPIRATION_DATE>",
      "responseQuantity": <RES_Q>,
      "questions": []
    }
    """
    And I store the request body as "survey_request"
    And I send the request
    Then I expect a "400" status code
    And I store the response body as "surveys_response"
    And I verify the "surveys_response" schema with "error_response" template
    Then I verify "surveys_response" with following expected response
    """
    {
     "statusCode": 400,
     "details": "Invalid survey fields"
    }
    """
    Examples:
    #INVALID ID
      | ID      | TITLE  | DESCRIPTION      | AUD | STATE | RELEASE_DATE             | CREATION_DATE            | EXPIRATION_DATE          | RES_Q |
      | 5928025 | Sports | Sports questions | 0   | 0     | 2017-10-07T16:25:23.345Z | 2017-10-07T16:25:23.345Z | 2017-10-14T16:25:23.345Z | 0     |
    #INVALID AND UN-EXISTENT AUDIENCE
      |         | Sports | Sports questions | 3   | 0     | 2017-10-07T16:25:23.345Z | 2017-10-07T16:25:23.345Z | 2017-10-14T16:25:23.345Z | 0     |
    #INVALID STATES
      |         | Sports | Sports questions | 0   | 1     | 2017-10-07T16:25:23.345Z | 2017-10-07T16:25:23.345Z | 2017-10-14T16:25:23.345Z | 0     |
      |         | Sports | Sports questions | 0   | 2     | 2017-10-07T16:25:23.345Z | 2017-10-07T16:25:23.345Z | 2017-10-14T16:25:23.345Z | 0     |
      |         | Sports | Sports questions | 0   | 3     | 2017-10-07T16:25:23.345Z | 2017-10-07T16:25:23.345Z | 2017-10-14T16:25:23.345Z | 0     |
    #UNEXISTENT STATES
      |         | Sports | Sports questions | 0   | 4     | 2017-10-07T16:25:23.345Z | 2017-10-07T16:25:23.345Z | 2017-10-14T16:25:23.345Z | 0     |
      |         |        |                  |     |       |                          |                          |                          |       |

    #INVALID DATES
      |         | Sports | Sports questions | 0   | 0     | 26/05/2017               | 26/05/2017               | 26/05/2017               | 0     |
      |         | Sports | Sports questions | 0   | 0     | 2017-10-07               | 2017-10-07               | 2017-10-14               | 0     |
     #INVALID DATES
      |         | valid  | valid            | 1   | 1     | 2017-10-07T16:25:23.345Z | 2017-10-07T16:25:23.345Z | Invalid_date             | 0     |
      |         | valid  | valid            | 1   | 1     | 2017-10-07T16:25:23.345Z | 2017-10-07T16:25:23.345Z | 2017-10-14T16:25:23.345Z | 0     |
      |         | valid  | valid            | 1   | 1     | 2017-10-07T16:25:23.345Z | 2017-10-07T16:25:23.345Z | 2017-10-14T16:25:23.345Z | 0     |
