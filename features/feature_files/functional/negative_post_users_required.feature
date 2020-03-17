@functional
Feature: Users

  @delete_created_data
  Scenario Outline: Verify the negative responses after POST a new user
    Given I perform "POST" request to "/users"
    When  I set the following body
    """
    {
      "birthDate": "<BIRTH>",
      "city": "<CITY>",
      "country": "<COUNTRY>",
      "gender": "<GENDER>",
      "name": "<NAME>",
      "password": "<PASS>",
      "primaryEmail": "<PRI_MAIL>",
      "role": "<ROLE>",
      "secondaryEmails": "<SEC_MAIL>",
      "validated": "<VAL>",
      "__v": 0,
      "_id": ""

    }
    """
    And I store the request body as "user_request"
    And I send the request
    Then I expect a "409" status code
    And I store the response body as "user_response"
    Then I verify "user_response" with following expected response
    """
    {
     "statusCode": 409,
     "details": "Email address is already taken, please try another one"
    }
    """
    Examples:
      | BIRTH                | CITY   | COUNTRY | GENDER | NAME      | PASS    | PRI_MAIL      | ROLE | SEC_MAIL | VAL   |
      |                      | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z |        | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz |         | Male   | Simon Gav | secret1 | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia |        | Simon Gav | secret1 | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   |           | secret1 | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav |         | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 |               | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com |      |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          |       |
      |                      |        |         |        |           |         |               |      |          |       |
      | /*-+-*//             | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z | +-*-++ | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz | +-*-++  | Male   | Simon Gav | secret1 | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | +-*-++ | Simon Gav | secret1 | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | +-*-++*** | secret1 | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | +-*-++  | user@mail.com | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | +-*-++        | user |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | +-*- |          | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          | +-*-+ |
      | +-*-++***            | +-*-++ | +-*-++  | +-*-++ | +-*-++*** | +-*-++  | +-*-++        | +-*- |          | +-*-+ |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | false |
      |                      | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z |        | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz |         | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia |        | Simon Gav | secret1 | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   |           | secret1 | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav |         | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 |               | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com |      | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   |       |
      |                      |        |         |        |           |         |               |      | +-*-++   |       |
      | +-*-++***            | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | +-*-++ | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | +-*-++  | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | +-*-++ | Simon Gav | secret1 | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | +-*-++*** | secret1 | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | +-*-++  | user@mail.com | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | +-*-++        | user | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | +-*- | +-*-++   | false |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | +-*-+ |
      | +-*-++***            | +-*-++ | +-*-++  | +-*-++ | +-*-++*** | +-*-++  | +-*-++        | +-*- | +-*-++   | +-*-+ |
      |                      | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          | true  |
      | 1980-03-08T13:00:00Z |        | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          | true  |
      | 1980-03-08T13:00:00Z | La Paz |         | Male   | Simon Gav | secret1 | user@mail.com | user |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia |        | Simon Gav | secret1 | user@mail.com | user |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   |           | secret1 | user@mail.com | user |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav |         | user@mail.com | user |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 |               | user |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com |      |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          | true  |
      | +-*-++***            | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          | true  |
      | 1980-03-08T13:00:00Z | +-*-++ | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | +-*-++  | Male   | Simon Gav | secret1 | user@mail.com | user |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | +-*-++ | Simon Gav | secret1 | user@mail.com | user |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | +-*-++*** | secret1 | user@mail.com | user |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | +-*-++  | user@mail.com | user |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | +-*-++        | user |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | +-*- |          | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | true  |
      |                      | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z |        | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz |         | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia |        | Simon Gav | secret1 | user@mail.com | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   |           | secret1 | user@mail.com | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav |         | user@mail.com | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 |               | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com |      | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | true  |
      | +-*-++***            | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | +-*-++ | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz | +-*-++  | Male   | Simon Gav | secret1 | user@mail.com | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | +-*-++ | Simon Gav | secret1 | user@mail.com | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | +-*-++*** | secret1 | user@mail.com | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | +-*-++  | user@mail.com | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | +-*-++        | user | +-*-++   | true  |
      | 1980-03-08T13:00:00Z | La Paz | Bolivia | Male   | Simon Gav | secret1 | user@mail.com | +-*- | +-*-++   | true  |
