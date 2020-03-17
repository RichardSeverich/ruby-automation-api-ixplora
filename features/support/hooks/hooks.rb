# Delete Helper data before all Test Scenarios
Before do
  Helper.clear_data
end

# Delete all the created data in the preconditions
After('@delete_created_data') do
  Helper.obtain_data.each_value do |body|
    if body.is_a?(Hash) && !body['_id'].to_s.empty?
      MongoDBConnection.delete_in_collections(body)
    end
  end
end
