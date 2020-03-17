Then(/^I verify the "([^"]*)" schema with "([^"]*)" template$/) do |variable_name, schema_template_name|
  actual_response = Helper.get_stored_value(variable_name)
  base_path = File.dirname(__FILE__)
  relative_path = File.expand_path("../support/json_scheme_templates/#{schema_template_name}.json", base_path)
  schema_template = File.read(relative_path)
  expect(JSON::Validator.validate(schema_template, actual_response)).to be true
end
