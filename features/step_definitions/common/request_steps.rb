Given(/^I perform "(GET|POST|PUT|DELETE)" request to "(.*)"$/) do |method, endpoint|
  @request = APIRequest.new(method)
  @request.append_endpoint(endpoint)
end

When(/^I set the following body$/) do |content|
  @custom_json = CommonActions.built_custom_json(content)
  @request.add_body(@custom_json)
end

And(/^I store the request body as "([^"]*)"$/) do |type|
  Helper.add_data(type, JSON.parse(@custom_json))
end

When(/^I set the following custom body:$/) do |table|
  data = table.rows_hash
  data = CommonActions.built_json(data)
  @request.add_body(data.to_json)
end

And(/^I send the request$/) do
  @response = RequestManager.request(@request)
end

Then(/^I expect a "(\d+)" status code$/) do |code|
  expect(@response.code).to eql(code)
end

And(/^I store the response body as "([^"]*)"$/) do |type|
  if @response.body.include?('DOCTYPE html')
    Helper.add_data(type, {})
  else
    Helper.add_data(type, JSON.parse(@response.body))
  end
end

And(/^I set the header "([^"]*)" with "(.*)"$/) do |key, value|
  @request.add_header(key, CommonActions.built_data(value))
end

When(/^I set the following custom body and store as "([^"]*)"$/) do |request_name, table|
  data = table.rows_hash
  data = CommonActions.built_json(data)
  Helper.add_data(request_name, data)
  @request.add_body(data.to_json)
end
