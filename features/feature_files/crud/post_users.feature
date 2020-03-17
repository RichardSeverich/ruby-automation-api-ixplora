@crud @delete_created_data
Feature: Create a new user

  Scenario: Verify that "/users" end point can perform "POST" request
    Given I perform "POST" request to "/users"
    When  I set the following body
    """
    {
     "_id": "",
     "name": "Juan Delgadillo",
     "primaryEmail": "juan@mail.com",
     "password": "secret",
     "birthDate": "2000-01-01T00:00:00.000Z",
     "secondaryEmails": [],
     "validated": false,
     "country": "Bolivia",
     "city": "Cochabamba",
     "gender": "Male",
     "role": "user"
    }
    """
    And I store the request body as "user_request"
    And I send the request
    Then I expect a "201" status code
    And I store the response body as "user_response"
    And I verify the "user_response" schema with "post_users" template
    And I build the expected response with following data
      | request  | user_request  |
      | response | user_response |
      | template | post_users    |
    Then I verify "user_response" with built expected response
