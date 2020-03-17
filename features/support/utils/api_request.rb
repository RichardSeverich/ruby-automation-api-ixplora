require 'json'

# Request class that abstracts the properties and fields of a API Request.
class APIRequest
  attr_reader :method, :header, :endpoint, :body

  def initialize(method)
    @method = method
    @body = {}
    @header = { content_type: 'application/json' }
  end

  def add_header(key, value)
    @header[key] = value
  end

  def add_body(content)
    @body = content
  end

  def append_endpoint(endpoint)
    @endpoint = CommonActions.built_data("#{$server_base_endpoint}#{endpoint}")
  end
end
