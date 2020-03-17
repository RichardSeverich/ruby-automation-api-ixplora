require 'rest-client'

# This module perform the Request using the rest-client gem.
module RequestManager
  def self.request(request)
    RestClient::Request.execute(method: request.method,
                                url: request.endpoint,
                                payload: request.body,
                                headers: request.header,
                                timeout: $server_timeout)
  rescue RestClient::ExceptionWithResponse => e
    e.response
  end
end
