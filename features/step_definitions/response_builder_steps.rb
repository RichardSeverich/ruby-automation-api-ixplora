Given(/^I build the expected response with following data$/) do |table|
  data = table.rows_hash
  request = data['request'] ? Helper.get_stored_value(data['request']) : {}
  response = data['response'] ? Helper.get_stored_value(data['response']) : {}
  template = data['template']
  expected = ResponseBuilder.build_response(template, request.to_json, response.to_json)
  Helper.add_data('expected_response', expected)
end
