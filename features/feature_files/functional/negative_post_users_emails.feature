@functional
Feature: Users email validation

  Background:
    Given I register a new "user" and I save the request as "user_request"
    When I store the response body as "user_response"
    And I validate email using "user_response._id"
    And I login to "MOBILE_APP" using "user_response.primaryEmail" and "user_request.password"
    And I store the response body as "login_response"

  @delete_created_data
  Scenario Outline: Verify the negative responses after POST the Email
    Given I perform "POST" request to "/users/<USER_ID>/emails"
    When I set the header "Authorization" with "Bearer {login_response.token}"
    And I set the following body
    """
    {
      "email": "<EMAIL>"
    }
    """
    And I store the request body as "user_request_email"
    And I send the request
    Then I expect a "404" status code
    And I store the response body as "email_response_post"
    And I verify the "email_response_post" schema with "error_response" template
    And I verify "email_response_post" with following expected response
    """
    {
     "status": "404",
     "source": "/users/userId/emails",
     "detail": "User does not exist"
    }
    """
    Examples:

      | USER_ID                  | EMAIL     |
      |                          |           |
      | /*-+-*/                  | 23533.    |
      | 59d7e00a9eb6160dee1d7c25 | asdQEF    |
      | ASDKJHWQIUB2389742119123 | @SDDS.COM |
      |                          | ..@@      |
