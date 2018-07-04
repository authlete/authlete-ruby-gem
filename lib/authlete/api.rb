# :nodoc:
#
# Copyright (C) 2014-2018 Authlete, Inc.
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

      headers.merge!(:content_type => content_type) unless content_type.nil?

      headers.merge!(@extra_headers) unless @extra_headers.nil?

      response = execute(
        :method   => method,
        :url      => @host + path,
        :headers  => headers,
        :payload  => payload,
        :user     => user,
        :password => password
      )

      body = body_as_string(response)

      body.nil? ? nil : JSON.parse(response.body.to_s, :symbolize_names => true)
    end

    def execute(parameters)
      begin
        return RestClient::Request.new(parameters).execute
      rescue => e
        raise create_api_exception(e)
      end
    end

    def create_api_exception(exception)
      message  = exception.message
      response = exception.response

      # Create a base exception.
      authlete_exception = Authlete::Exception.new(:message => message)

      if response.nil?
        # No response information. Then, return an exception without HTTP
        # response information.
        return authlete_exception
      end

      # Extract information from the HTTP response.
      status_code   = response.code
      response_body = response.body

      # Set the status code.
      authlete_exception.status_code = status_code

      response_body_json = nil

      begin
        # Parse the response body as a json.
        response_body_json = JSON.parse(response_body.to_s, :symbolize_names => true)
      rescue
        # Failed to parse the response body as a json. Then, return an exception
        # without HTTP response information.
        return authlete_exception
      end

      # Set the Authlete API result info if it's available.
      if has_authlete_api_result?(response_body_json)
        authlete_exception.result = Authlete::Model::Result.new(response_body_json)
      end

      authlete_exception
    end

    def has_authlete_api_result?(json)
      json && json.key?(:resultCode) && json.key?(:resultMessage)
    end

    def body_as_string(response)
      return nil if response.body.nil?

      body = response.body.to_s

      body.length == 0 ? nil : body
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

      "?" + array.join("&")
    end

    def to_hash(object)
      # Return the object if it's already a hash.
      return object if object.kind_of?(Hash)

      # Convert the object to a hash if possible and return it.
      return object.to_hash if object.respond_to?('to_hash')

      # Otherwise, raise an exception.
      Authlete::Exception.new(:message => "Failed to convert the object to a hash.")
    end

    public

    # Call Authlete's /api/auth/authorization API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::AuthorizationRequest.
    #
    # On success, an instance of Authlete::Model::Response::AuthorizationResponse is returned.
    # On error, Authlete::Exception is raised.
    def authorization(request)
      hash = call_api_json_service("/api/auth/authorization", to_hash(request))

      Authlete::Model::Response::AuthorizationResponse.new(hash)
    end

    # Call Authlete's /api/auth/authorization/issue API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::AuthorizationIssueRequest.
    #
    # On success, an instance of Authlete::Model::Response::AuthorizationIssueResponse is returned.
    # On error, Authlete::Exception is raised.
    def authorization_issue(request)
      hash = call_api_json_service("/api/auth/authorization/issue", to_hash(request))

      Authlete::Model::Response::AuthorizationIssueResponse.new(hash)
    end

    # Call Authlete's /api/auth/authorization/fail API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::AuthorizationFailRequest.
    #
    # On success, an instance of Authlete::Model::Response::AuthorizationFailResponse is returned.
    # On error, Authlete::Exception is raised.
    def authorization_fail(request)
      hash = call_api_json_service("/api/auth/authorization/fail", to_hash(request))

      Authlete::Model::Response::AuthorizationFailResponse.new(hash)
    end

    # Call Authlete's /api/auth/token API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::TokenRequest.
    #
    # On success, an instance of Authlete::Model::Response::TokenResponse is returned.
    # On error, Authlete::Exception is raised.
    def token(request)
      hash = call_api_json_service("/api/auth/token", to_hash(request))

      Authlete::Model::Response::TokenResponse.new(hash)
    end

    # Call Authlete's /api/auth/token/issue API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::TokenIssueRequest.
    #
    # On success, an instance of Authlete::Model::Response::TokenIssueResponse is returned.
    # On error, Authlete::Exception is raised.
    def token_issue(request)
      hash = call_api_json_service("/api/auth/token/issue", to_hash(request))

      Authlete::Model::Response::TokenIssueResponse.new(hash)
    end

    # Call Authlete's /api/auth/token/fail API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::TokenFailRequest.
    #
    # On success, an instance of Authlete::Model::Response::TokenFailResponse is returned.
    # On error, Authlete::Exception is raised.
    def token_fail(request)
      hash = call_api_json_service("/api/auth/token/fail", to_hash(request))

      Authlete::Model::Response::TokenFailResponse.new(hash)
    end

    # Call Authlete's /api/service/creatable API.
    #
    # On success, an instance of Authlete::Model::Response::ServiceCreatableResponse is returned.
    # On error, Authlete::Exception is raised.
    def service_creatable
      hash = call_api_service_owner(:get, "/api/service/creatable", nil, nil)

      Authlete::Model::Response::ServiceCreatableResponse.new(hash)
    end

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
      hash = call_api_json_service_owner("/api/service/create", to_hash(service))

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
      hash = call_api_json_service_owner("/api/service/update/#{api_key}", to_hash(service))

      Authlete::Model::Service.new(hash)
    end

    # Call Authlete's /api/serviceowner/get/self API.
    #
    # On success, an instance of Authlete::Model::ServiceOwner is returned.
    # On error, Authlete::Exception is raised.
    def serviceowner_get_self
      hash = call_api_service_owner(:get, "/api/serviceowner/get/self", nil, nil)

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
      hash = call_api_json_service("/api/client/create", to_hash(client))

      Authlete::Model::Client.new(hash)
    end

    # Call Authlete's /api/client/delete/{clientId} API.
    #
    # <tt>client_id</tt> is the client ID of a client.
    #
    # On error, Authlete::Exception is raised.
    def client_delete(client_id)
      call_api_service(:delete, "/api/client/delete/#{client_id}", nil, nil)
    end

    # Call Authlete's /api/client/get/{clientId} API.
    #
    # <tt>client_id</tt> is the client ID of a client.

    # On success, an instance of Authlete::Model::Client is returned.
    # On error, Authlete::Exception is raised.
    def client_get(client_id)
      hash = call_api_service(:get, "/api/client/get/#{client_id}", nil, nil)

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
      hash = call_api_json_service("/api/client/update/#{client[:clientId]}", to_hash(client))

      Authlete::Model::Client.new(hash)
    end

    # Call Authlete's /api/client/secret/refresh/{clientIdentifier} API.
    #
    # <tt>clientIdentifier</tt> is the client ID or the client ID alias of a client.
    #
    # On success, an instance of Authlete::Model::Response::ClientSecretRefreshResponse is returned.
    # On error, Authlete::Exception is raised.
    def refresh_client_secret(client_identifier)
      hash = call_api_service(:get, "/api/client/secret/refresh/#{client_identifier}", nil, nil)

      Authlete::Model::Response::ClientSecretRefreshResponse.new(hash)
    end

    # Call Authlete's /api/client/secret/update/{clientIdentifier} API.
    #
    # <tt>client_identifier</tt> is the client ID or the client ID alias of a client.
    # <tt>client_secret</tt> is the client secret of a client.
    #
    # On success, an instance of Authlete::Model::Response::ClientSecretUpdateResponse is returned.
    # On error, Authlete::Exception is raised.
    def update_client_secret(client_identifier, client_secret)
      request = Authlete::Model::Request::ClientSecretUpdateRequest.new(:client_secret => client_secret)

      hash = call_api_json_service("/api/client/secret/update/#{client_identifier}", request.to_hash)

      Authlete::Model::Response::ClientSecretUpdateResponse.new(hash)
    end

    # Call Authlete's /api/client/authorization/get/list API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::ClientSecretUpdateRequest.
    #
    # On success, an instance of Authlete::Model::Response::ClientAuthorizationListResponse is returned.
    # On error, Authlete::Exception is raised.
    def get_client_authorization_list(request)
      hash = call_api_json_service("/api/client/authorization/get/list", to_hash(request))

      Authlete::Model::Response::ClientAuthorizationListResponse.new(hash)
    end

    # Call Authlete's /api/client/authorization/update API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::ClientSecretUpdateRequest.
    #
    # On error, Authlete::Exception is raised.
    def update_client_authorization(client_id, request)
      call_api_json_service("/api/client/authorization/update/#{client_id}", to_hash(request))
    end

    # Call Authlete's /api/client/authorization/delete/{clientId} API.
    #
    # <tt>client_id</tt> is the client ID of a client.
    # <tt>subject</tt> is the unique ID of an end user.
    #
    # On error, Authlete::Exception is raised.
    def delete_client_authorization(client_id, subject)
      request = Authlete::Model::Request::ClientAuthorizationDeleteRequest.new(:subject => subject)

      call_api_json_service("/api/client/authorization/delete/#{client_id}", request.to_hash)
    end

    # Call Authlete's /api/auth/introspection API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::IntrospectionRequest.
    #
    # On success, an instance of Authlete::Model::Response::IntrospectionResponse is returned.
    # On error, Authlete::Exception is raised.
    def introspection(request)
      hash = call_api_json_service('/api/auth/introspection', to_hash(request))

      Authlete::Model::Response::IntrospectionResponse.new(hash)
    end

    # Call Authlete's /api/auth/introspection/standard API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::StandardIntrospectionRequest.
    #
    # On success, an instance of Authlete::Model::Response::StandardIntrospectionResponse is returned.
    # On error, Authlete::Exception is raised.
    def standard_introspection(request)
      hash = call_api_json_service('/api/auth/introspection/standard', to_hash(request))

      Authlete::Model::Response::StandardIntrospectionResponse.new(hash)
    end

    # Call Authlete's /api/auth/revocation API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::RevocationRequest.
    #
    # On success, an instance of Authlete::Model::Response::RevocationResponse is returned.
    # On error, Authlete::Exception is raised.
    def revocation(request)
      hash = call_api_json_service("/api/auth/revocation", to_hash(request))

      Authlete::Model::Response::RevocationResponse.new(hash)
    end

    # Call Authlete's /api/auth/userinfo API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::UserInfoRequest.
    #
    # On success, an instance of Authlete::Model::Response::UserInfoResponse is returned.
    # On error, Authlete::Exception is raised.
    def user_info(request)
      hash = call_api_json_service("/api/auth/userinfo", to_hash(request))

      Authlete::Model::Response::UserInfoResponse.new(hash)
    end

    # Call Authlete's /api/auth/userinfo/issue API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::UserInfoIssueRequest.
    #
    # On success, an instance of Authlete::Model::Response::UserInfoIssueResponse is returned.
    # On error, Authlete::Exception is raised.
    def user_info_issue(request)
      hash = call_api_json_service("/api/auth/userinfo/issue", to_hash(request))

      Authlete::Model::Response::UserInfoIssueResponse.new(hash)
    end

    # Call Authlete's /api/service/jwks/get API.
    #
    # <tt>params</tt> is an optional hash which contains query parameters
    # for /api/service/jwks/get API. The hash can contain the following parameters.
    #
    # <tt>:includePrivateKeys</tt>
    #   This boolean value indicates whether the response should include the
    #   private keys associated with the service or not. If "true", the private
    #   keys are included in the response. The default value is "false".
    #
    # <tt>:pretty</tt>
    #   This boolean value indicates whether the JSON in the response should
    #   be formatted or not. If true, the JSON in the response is pretty-formatted.
    #   The default value is false.
    #
    # On success, a JWK Set for a service is returned.
    # On error, Authlete::Exception is raised.
    def get_service_jwks(params = nil)
      call_api_service(:get, "/api/service/jwks/get#{to_query(params)}", nil, nil)
    end

    # Call Authlete's /api/service/configuration API.
    #
    # <tt>params</tt> is an optional hash which contains query parameters
    # for /api/service/configuration API. The hash can contain the following
    # parameter.
    #
    # <tt>:includePrivateKeys</tt>
    #   This boolean value indicates whether the response should include the
    #   private keys associated with the service or not. If "true", the private
    #   keys are included in the response. The default value is "false".
    #
    # On success, configuration information of a service is returned.
    # On error, Authlete::Exception is raised.
    def get_service_configuration(params = nil)
      call_api_service(:get, "/api/service/configuration#{to_query(params)}", nil, nil)
    end

    # Call Authlete's /api/auth/token/create API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::TokenCreateRequest.
    #
    # On success, an instance of Authlete::Model::Response::TokenCreateResponse is returned.
    # On error, Authlete::Exception is raised.
    def token_create(request)
      hash = call_api_json_service("/api/auth/token/create", to_hash(request))

      Authlete::Model::Response::TokenCreateResponse.new(hash)
    end

    # Call Authlete's /api/auth/token/update API.
    #
    # <tt>request</tt> is an instance of Authlete::Model::Request::TokenUpdateRequest.
    #
    # On success, an instance of Authlete::Model::Response::TokenUpdateResponse is returned.
    # On error, Authlete::Exception is raised.
    def token_update(request)
      hash = call_api_json_service("/api/auth/token/update", to_hash(request))

      Authlete::Model::Response::TokenUpdateResponse.new(hash)
    end

    # Call Authlete's /api/client/granted_scopes/get/{clientId} API.
    #
    # <tt>client_id</tt> is the client ID of a client.
    # <tt>subject</tt> is the unique ID of an end user.
    #
    # On success, an instance of Authlete::Model::Response::GrantedScopesGetResponse is returned.
    # On error, Authlete::Exception is raised.
    def get_granted_scopes(client_id, subject)
      request = Authlete::Model::Request::GrantedScopesRequest.new(:subject => subject)

      hash = call_api_json_service("/api/client/granted_scopes/get/#{client_id}", request.to_hash)

      Authlete::Model::Response::GrantedScopesGetResponse.new(hash)
    end

    # Call Authlete's /api/client/granted_scopes/delete/{clientId} API.
    #
    # <tt>client_id</tt> is the client ID of a client.
    # <tt>subject</tt> is the unique ID of an end user.
    #
    # On error, Authlete::Exception is raised.
    def delete_granted_scopes(client_id, subject)
      request = Authlete::Model::Request::GrantedScopesRequest.new(:subject => subject)

      call_api_json_service("/api/client/granted_scopes/delete/#{client_id}", request.to_hash)
    end

    # Ensure that the request contains a valid access token.
    #
    # This method extracts an access token from the given request based on the
    # rules described in RFC 6750 and introspects the access token by calling
    # Authlete's /api/auth/introspection API.
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
    # <tt>Authlete::Model::Response::IntrospectionResponse</tt>. If its <tt>action</tt>
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
        return Authlete::Model::Response::IntrospectionResponse.new(
          :action          => 'BAD_REQUEST',
          :responseContent => 'Bearer error="invalid_token",error_description="The request does not contain a valid access token."'
        )
      end

      # Create a request for Authlete's /api/auth/introspection API.
      request = Authlete::Model::Request::IntrospectionRequest.new(
        :token   => access_token,
        :scopes  => scopes,
        :subject => subject
      )

      begin
        # Call Authlete's /api/auth/introspection API to introspect the access token.
        result = introspection(request)
      rescue => e
        # Error message.
        message = build_error_message('/api/auth/introspection', e)

        # Emit a Rack error message.
        emit_rack_error_message(request, message)

        # Failed to introspect the access token.
        return Authlete::Model::Response::IntrospectionResponse.new(
          :action          => 'INTERNAL_SERVER_ERROR',
          :responseContent => "Bearer error=\"server_error\",error_description=\"#{message}\""
        )
      end

      # Return the response from Authlete's /api/auth/introspection API.
      result
    end
  end
end