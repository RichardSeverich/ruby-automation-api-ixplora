Then(/^I verify "([^"]*)" with built expected response$/) do |variable_name|
  expected_response = Helper.get_stored_value('expected_response')
  actual_response = Helper.get_stored_value(variable_name)
  expected_response.to_json.should be_json_eql(actual_response.to_json).excluding('password')
end

Then(/^I verify "([^"]*)" with following expected response$/) do |variable_name, json_string|
  expected_response = Helper.get_stored_value(variable_name)
  expected_response.to_json.should be_json_eql(JSON.parse(json_string).to_json).excluding('password', '_id')
end
