Given(/^I register a new "(user|editor)" and I save the request as "([^"]*)"$/) do |user_type, user_request|
  user_name = Faker::Name.name
  user_email = Faker::Internet.email

  steps %(
   Given I perform "POST" request to "/users"
    When  I set the following body
    """
    {
     "_id": "",
     "name": "#{user_name}",
     "primaryEmail": "#{user_email}",
     "password": "secretixplora",
     "birthDate": "2001-01-01T00:00:00.000Z",
     "secondaryEmails": [],
     "validated": false,
     "country": "Bolivia",
     "city": "Cochabamba",
     "gender": "Male",
     "role": "#{user_type}"
    }
    """
    And I store the request body as "#{user_request}"
    And I send the request
    Then I expect a "201" status code
  )
end

And(/^I validate email using "(.*)"$/) do |user_id|
  steps %(
    And I run a query to filter the field "userId" with value "{#{user_id}}" in "email_tokens"
    And I store the "token" of query result as "mail_token"
    And I perform "POST" request to "/tokens"
    And I set the following custom body:
      | token | mail_token |
    And I send the request
    Then I expect a "200" status code
  )
end

And(/^I login to "(MOBILE_APP|WEB_APP)" using "(.*)" and "(.*)"$/) do |app_name, user_email, user_password|
  steps %(
    And I perform "POST" request to "/users/login"
    And I set the following custom body:
      | email    | {#{user_email}}     |
      | password | {#{user_password}}  |
      | type     | 0                   |
      | app      | #{app_name}         |
    And I send the request
    Then I expect a "200" status code
  )
end

When(/^I create a survey using the Authorization "([^"]*)"$/) do |login_response|
  survey_title = Faker::Educator.course
  survey_description = Faker::Lorem.sentence
  steps %(
    And I perform "POST" request to "/surveys"
    And I set the header "Authorization" with "Bearer {#{login_response}}"
    When I set the following body
    """
    {
      "_id": "",
      "title": "#{survey_title}",
      "description": "#{survey_description}",
      "audience": 0,
      "domains": [],
      "state": 0,
      "releaseDate": "2017-10-07T16:25:23.345Z",
      "creationDate": "2017-10-07T16:25:23.345Z",
      "expirationDate": "2017-10-14T16:25:23.345Z",
      "responseQuantity": 0,
      "questions": []
    }
    """
    And I send the request
    Then I expect a "201" status code
  )
end

When(/^I change the "([^"]*)" state to "(\d+)" with "([^"]*)"$/) do |survey_id, state_code, user_token|
  steps %(
    And I perform "PUT" request to "/surveys/{#{survey_id}}/state"
    And I set the header "Authorization" with "Bearer {#{user_token}}"
    And I set the following custom body:
    | state | #{state_code} |
    And I send the request
    Then I expect a "200" status code
  )
end
