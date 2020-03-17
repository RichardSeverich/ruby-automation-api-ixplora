# Turn off debug-mode
Mongo::Logger.logger.level = Logger::WARN

# Class for MongoDB connection and query manager
module MongoDBConnection
  include Mongo

  def self.initialize
    start_connection
  end

  def self.start_connection
    client_host = ["#{$mongodb_host}:#{$mongodb_port}"]
    client_options = { database: $mongodb_db_name,
                       user: $mongodb_username,
                       password: $mongodb_password }
    @client = Mongo::Client.new(client_host, client_options)
  end

  def self.close_connection
    @client.close
  end

  def self.find_document_by_field(field, value, collection, object_id = false)
    result = []
    value = BSON::ObjectId(value) if object_id || field.eql?('_id')
    @client[collection.to_sym].find(field.to_sym => value).each do |data|
      result << data
    end
    result
  end

  def self.delete_document(field, value, collection, object_id = false)
    value = BSON::ObjectId(value) if object_id || field.eql?('_id')
    @client[collection.to_sym].find(field.to_sym => value).delete_many
  end

  def self.collections
    @client.database.collection_names
  end

  def self.delete_in_collections(body)
    MongoDBConnection.collections.each do |collection|
      field = '_id'
      object_id = false
      case collection
      when 'email_tokens'
        field = 'userId'
      when 'session_tokens'
        field = 'id'
      when 'surveys'
        field = 'owner'
      else
        object_id = true
      end
      MongoDBConnection.delete_document(field, body['_id'], collection, object_id)
    end
  end
end
