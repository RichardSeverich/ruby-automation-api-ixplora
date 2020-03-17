@functional
Feature: Surveys

  Background:
    Given I register a new "editor" and I save the request as "editor_request"
    When I store the response body as "editor_response"
    And I validate email using "editor_response._id"
    And I login to "MOBILE_APP" using "editor_response.primaryEmail" and "editor_request.password"
    And I store the response body as "login_response"

  @delete_created_data
  Scenario Outline: Non-existent surveys id
    Given I perform "<REQUEST>" request to "<END_POINT>"
    When I set the header "Authorization" with "Bearer {login_response.token}"
    And I send the request
    Then I expect a "404" status code
    And I store the response body as "surveys_response"
    And I verify the "surveys_response" schema with "error_response" template
    Then I verify "surveys_response" with following expected response
    """
     {
      "statusCode": 404,
      "details": "Survey does not exist"
     }
    """
    Examples:
      | END_POINT                                           | REQUEST |
      | /surveys/59cfd59f5641d906f70bdb00                   | GET     |
      | /surveys/59cfd59f5641d906f70bdb00/edit              | GET     |
      | /surveys/59cfd59f5641d906f70bdb00/overview          | GET     |
      | /surveys/59cfd59f5641d906f70bdb00/clone             | POST    |
      | /surveys/59cfd59f5641d906f70bdb00/answers           | POST    |
      | /surveys/59cfd59f5641d906f70bdb00/stats             | GET     |
      | /surveys/59cfd59f5641d906f70bdb00/results?type=json | GET     |
      | /surveys/59cfd59f5641d906f70bdb00/results?type=csv  | GET     |


  @delete_created_data
  Scenario: Non-existent surveys id in put state survey
    Given I perform "PUT" request to "/surveys/59cfd59f5641d906f70bdb00/state "
    When I set the header "Authorization" with "Bearer {login_response.token}"
    And  I set the following body
    """
      {
	    "state": 3
      }
    """
    And I send the request
    Then I expect a "404" status code
    And I store the response body as "surveys_response"
    And I verify the "surveys_response" schema with "error_response" template
    Then I verify "surveys_response" with following expected response
    """
     {
       "statusCode": 404,
       "details": "Survey does not exist"
     }
    """

  @delete_created_data
  Scenario: Non-existent surveys id put surveys
    Given I perform "PUT" request to "/surveys/59cfd59f5641d906f70bdb00"
    When I set the header "Authorization" with "Bearer {login_response.token}"
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

  @delete_created_data
  Scenario: Non-existent surveys id in delete surveys
    Given I perform "DELETE" request to "/surveys/59cfd59f5641d906f70bdb00"
    When I set the header "Authorization" with "Bearer {login_response.token}"
    And I send the request
    Then I expect a "404" status code
    And I store the response body as "surveys_response"
    And I verify the "surveys_response" schema with "error_response" template
    Then I verify "surveys_response" with following expected response
    """
     {
      "statusCode": 404,
      "details": "Survey couldn't be removed"
     }
    """
