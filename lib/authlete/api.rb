# :nodoc:
#
# Copyright (C) 2014-2015 Authlete, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


require 'json'
require 'rack'
require 'rest-client'


module Authlete
  # == Authlete::Api Module
  #
  # A web client that accesses Authlete Web APIs.
  #
  class Api
    include Authlete::Utility

    # The host which provides Authlete Web APIs.
    # For example, <tt>https://dev-api.authlete.com</tt>
    attr_accessor :host

    # The API key of a service owner.
    attr_accessor :service_owner_api_key

    # The API secret of a service owner.
    attr_accessor :service_owner_api_secret

    # The API key of a service.
    attr_accessor :service_api_key

    # The API secret of a service.
    attr_accessor :service_api_secret

    # Extra HTTP headers
    attr_accessor :extra_headers

    private

    # The constructor which takes a hash containing configuration
    # parameters. Valid configuration parameter names are as follows.
    #
    # - <tt>:host</tt>
    # - <tt>:service_owner_api_key</tt>
    # - <tt>:service_owner_api_secret</tt>
    # - <tt>:service_api_key</tt>
    # - <tt>:service_api_secret</tt>
    #
    def initialize(config = {})
      @host                     = extract_value(config, :host)
      @service_owner_api_key    = extract_value(config, :service_owner_api_key)
      @service_owner_api_secret = extract_value(config, :service_owner_api_secret)
      @service_api_key          = extract_value(config, :service_api_key)
      @service_api_secret       = extract_value(config, :service_api_secret)
    end

    def call_api(method, path, content_type, payload, user, password)
      headers = {}

      if content_type.nil? == false
        headers.merge!(:content_type => content_type)
      end

      if @extra_headers.nil? == false
        headers.merge!(@extra_headers)
      end

      response = execute(
        :method   => method,
        :url      => @host + path,
        :headers  => headers,
        :payload  => payload,
        :user     => user,
        :password => password
      )

      body = body_as_string(response)

      if body.nil?
        return nil
      end

      JSON.parse(response.body.to_s, :symbolize_names => true)
    end

    def execute(parameters)
      begin
        return RestClient::Request.new(parameters).execute
      rescue => e
        raise_api_exception(e)
      end
    end

    def raise_api_exception(exception)
      message  = exception.message
      response = exception.response

      if response.nil?
        # Raise an error without HTTP response information.
        raise Authlete::Exception.new(:message => message)
      end

      # Raise an error with HTTP response information.
      raise_api_exception_with_http_response_info(message, response.code, response.body)
    end

    def raise_api_exception_with_http_response_info(message, status_code, response_body)
      # Parse the response body as a json.
      json = parse_response_body(response_body, message, status_code)

      # If the json has the HTTP response information from an Authlete API.
      if has_authlete_api_response_info(json)
        # Raise an error with it.
        hash = json.merge!(:statusCode => status_code)
        raise Authlete::Exception.new(hash)
      end

      # Raise an error with 'status_code' and the original error message.
      raise Authlete::Exception.new(
        :message     => message,
        :status_code => status_code
      )
    end

    def parse_response_body(response_body, message, status_code)
      begin
        return JSON.parse(response_body.to_s, :symbolize_names => true)
      rescue
        # Failed to parse the response body as a json.
        raise Authlete::Exception.new(
          :message     => message,
          :status_code => status_code
        )
      end
    end

    def has_authlete_api_response_info(json)
      json && json.key?(:resultCode) && json.key?(:resultMessage)
    end

    def body_as_string(response)
      if response.body.nil?
        return nil
      end

      body = response.body.to_s

      if body.length == 0
        return nil
      end

      return body
    end

    def call_api_service_owner(method, path, content_type, payload)
      call_api(method, path, content_type, payload, @service_owner_api_key, @service_owner_api_secret)
    end

    def call_api_service(method, path, content_type, payload)
      call_api(method, path, content_type, payload, @service_api_key, @service_api_secret)
    end

    def call_api_json(path, body, user, password)
      call_api(:post, path, 'application/json;charset=UTF-8', JSON.generate(body), user, password)
    end

    def call_api_json_service_owner(path, body)
      call_api_json(path, body, @service_owner_api_key, @service_owner_api_secret)
    end

    def call_api_json_service(path, body)
      call_api_json(path, body, @service_api_key, @service_api_secret)
    end

    def build_error_message(path, exception)
      begin
        # Use "resultMessage" if the response can be parsed as JSON.
        JSON.parse(exception.response.to_str)['resultMessage']
      rescue
        # Build a generic error message.
        "Authlete's #{path} API failed."
      end
    end

    def emit_rack_error_message(request, message)
      begin
        # Logging if possible.
        request.env['rack.errors'].write("ERROR: #{message}\n")
      rescue => e
      end
    end

    def to_query(params)
      if params.nil? || params.size == 0
        return ""
      end

      array = []

      params.each do |key, value|
        array.push("#{key}=#{value}")
      end

      return "?" + array.join("&")
    end

    public

    # Call Authlete's /api/service/create API.
    #
    # <tt>service</tt> is the content of a new service to create. The type of
    # the given object is either <tt>Hash</tt> or any object which
    # responds to <tt>to_hash</tt>. In normal cases, Authlete::Model::Service
    # (which responds to <tt>to_hash</tt>) should be used.
    #
    # On success, an instance of Authlete::Model::ServiceList is returned.
    # On error, Authlete::Exception is raised.
    def service_create(service)
      if service.kind_of?(Hash) == false
        if service.respond_to?('to_hash')
          service = service.to_hash
        end
      end

      hash = call_api_json_service_owner("/api/service/create", service)

      Authlete::Model::Service.new(hash)
    end

    # Call Authlete's /api/service/delete/{api_key} API.
    #
    # On error, Authlete::Exception is raised.
    def service_delete(api_key)
      call_api_service_owner(:delete, "/api/service/delete/#{api_key}", nil, nil)
    end


    # Call Authlete's /api/service/get/{api_key} API.
    #
    # <tt>api_key</tt> is the API key of the service whose information
    # you want to get.
    #
    # On success, an instance of Authlete::Model::Service is returned.
    # On error, Authlete::Exception is raised.
    def service_get(api_key)
      hash = call_api_service_owner(:get, "/api/service/get/#{api_key}", nil, nil)

      Authlete::Model::Service.new(hash)
    end

    # Call Authlete's /api/service/get/list API.
    #
    # <tt>params</tt> is an optional hash which contains query parameters
    # for /api/service/get/list API. <tt>:start</tt> and <tt>:end</tt> are
    # a start index (inclusive) and an end index (exclusive), respectively.
    #
    # On success, an instance of Authlete::Model::ServiceList is returned.
    # On error, Authlete::Exception is raised.
    def service_get_list(params = nil)
      hash = call_api_service_owner(:get, "/api/service/get/list#{to_query(params)}", nil, nil)

      Authlete::Model::ServiceList.new(hash)
    end

    # Call Authlete's /api/service/update/{api_key} API.
    #
    # <tt>api_key</tt> is the API key of the service whose information
    # you want to get.
    #
    # <tt>service</tt> is the new content of the service. The type of
    # the given object is either <tt>Hash</tt> or any object which
    # responds to <tt>to_hash</tt>. In normal cases, Authlete::Model::Service
    # (which responds to <tt>to_hash</tt>) should be used.
    #
    # On success, an instance of Authlete::Model::Service is returned.
    # On error, Authlete::Exception is raised.
    def service_update(api_key, service)
      if service.kind_of?(Hash) == false
        if service.respond_to?('to_hash')
          service = service.to_hash
        end
      end

      hash = call_api_json_service_owner("/api/service/update/#{api_key}", service)

      Authlete::Model::Service.new(hash)
    end

    # Call Authlete's /api/serviceowner/get/self API.
    #
    # On success, an instance of Authlete::Model::ServiceOwner is returned.
    # On error, Authlete::Exception is raised.
    def serviceowner_get_self
      hash = call_api_json_service_owner(:get, "/api/serviceowner/get/self")

      Authlete::Model::ServiceOwner.new(hash)
    end

    # Call Authlete's /api/client/create API.
    #
    # <tt>client</tt> is the content of a new service to create. The type of
    # the given object is either <tt>Hash</tt> or any object which
    # responds to <tt>to_hash</tt>. In normal cases, Authlete::Model::Client
    # (which responds to <tt>to_hash</tt>) should be used.
    #
    # On success, an instance of Authlete::Model::ClientList is returned.
    # On error, Authlete::Exception is raised.
    def client_create(client)
      if client.kind_of?(Hash) == false
        if client.respond_to?('to_hash')
          client = client.to_hash
        end
      end

      hash = call_api_json_service("/api/client/create", client)

      Authlete::Model::Client.new(hash)
    end

    # Call Authlete's /api/client/delete/{clientId} API.
    #
    # On error, Authlete::Exception is raised.
    def client_delete(clientId)
      call_api_service(:delete, "/api/client/delete/#{clientId}", nil, nil)
    end

    # Call Authlete's /api/client/get/{clientId} API.
    #
    # On success, an instance of Authlete::Model::Service is returned.
    # On error, Authlete::Exception is raised.
    def client_get(clientId)
      hash = call_api_service(:get, "/api/client/get/#{clientId}", nil, nil)

      Authlete::Model::Client.new(hash)
    end

    # Call Authlete's /api/client/get/list API.
    #
    # <tt>params</tt> is an optional hash which contains query parameters
    # for /api/client/get/list API. <tt>:start</tt> and <tt>:end</tt> are
    # a start index (inclusive) and an end index (exclusive), respectively.
    #
    # On success, an instance of Authlete::Model::ClientList is returned.
    # On error, Authlete::Exception is raised.
    def client_get_list(params = nil)
      hash = call_api_service(:get, "/api/client/get/list#{to_query(params)}", nil, nil)

      Authlete::Model::ClientList.new(hash)
    end

    # Call Authlete's /api/client/update/{clientId} API.
    #
    # <tt>client</tt> is the new content of the client. The type of
    # the given object is either <tt>Hash</tt> or any object which
    # responds to <tt>to_hash</tt>. In normal cases, Authlete::Model::Client
    # (which responds to <tt>to_hash</tt>) should be used.
    #
    # On success, an instance of Authlete::Model::Client is returned.
    # On error, Authlete::Exception is raised.
    def client_update(client)
      if client.kind_of?(Hash) == false
        if client.respond_to?('to_hash')
          client = client.to_hash
        end
      end

      hash = call_api_json_service("/api/client/update/#{client[:clientId]}", client)

      Authlete::Model::Client.new(hash)
    end

    # Call Authlete's {/auth/introspection}
    # [https://www.authlete.com/authlete_web_apis_introspection.html#auth_introspection]
    # API.
    #
    # <tt>token</tt> is an access token presented by a client application.
    # This is a must parameter. In a typical case, a client application uses
    # one of the means listed in {RFC 6750}[https://tools.ietf.org/html/rfc6750]
    # to present an access token to a {protected resource endpoint}
    # [https://tools.ietf.org/html/rfc6749#section-7].
    #
    # <tt>scopes</tt> is an array of scope names. This is an optional parameter.
    # When the specified scopes are not covered by the access token, Authlete
    # prepares the content of the error response.
    #
    # <tt>subject</tt> is a unique identifier of an end-user. This is an optional
    # parameter. When the access token is not associated with the specified
    # subject, Authlete prepares the content of the error response.
    #
    # On success, this method returns an instance of
    # <tt>Authlete::Response::IntrospectionResponse</tt>. On error, this method
    # throws <tt>RestClient::Exception</tt>.
    def introspection(token, scopes = nil, subject = nil)
      hash = call_api_json_service('/api/auth/introspection',
                                   :token => token, :scopes => scopes, :subject => subject)

      Authlete::Response::IntrospectionResponse.new(hash)
    end


    # Ensure that the request contains a valid access token.
    #
    # This method extracts an access token from the given request based on the
    # rules described in RFC 6750 and introspects the access token by calling
    # Authlete's /auth/introspection API.
    #
    # The first argument <tt>request</tt> is a Rack request.
    #
    # The second argument <tt>scopes</tt> is an array of scope names required
    # to access the target protected resource. This argument is optional.
    #
    # The third argument <tt>subject</tt> is a string which representing a
    # subject which has to be associated with the access token. This argument
    # is optional.
    #
    # This method returns an instance of
    # <tt>Authlete::Response::IntrospectionResponse</tt>. If its <tt>action</tt>
    # method returns 'OK', it means that the access token exists, has not
    # expired, covers the requested scopes (if specified), and is associated
    # with the requested subject (if specified). Otherwise, it means that the
    # request does not contain any access token or that the access token does
    # not satisfy the conditions to access the target protected resource.
    def protect_resource(request, scopes = nil, subject = nil)
      # Extract an access token from the request.
      access_token = extract_access_token(request)

      # If the request does not contain any access token.
      if access_token.nil?
        # The request does not contain a valid access token.
        return Authlete::Response::IntrospectionResponse.new(
          :action          => 'BAD_REQUEST',
          :responseContent => 'Bearer error="invalid_token",error_description="The request does not contain a valid access token."'
        )
      end

      begin
        # Call Authlete's /auth/introspection API to introspect the access token.
        result = introspection(access_token, scopes, subject)
      rescue => e
        # Error message.
        message = build_error_message('/auth/introspection', e)

        # Emit a Rack error message.
        emit_rack_error_message(request, message)

        # Failed to introspect the access token.
        return Authlete::Response::IntrospectionResponse.new(
          :action          => 'INTERNAL_SERVER_ERROR',
          :responseContent => "Bearer error=\"server_error\",error_description=\"#{message}\""
        )
      end

      # Return the response from Authlete's /auth/introspection API.
      result
    end
  end
end
