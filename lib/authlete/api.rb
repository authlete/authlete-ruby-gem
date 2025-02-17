# :nodoc:
#
# Copyright (C) 2014-2020 Authlete, Inc.
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
  class Api
    include Authlete::Utility

    attr_accessor :host
    attr_accessor :service_owner_api_key
    attr_accessor :service_owner_api_secret
    attr_accessor :service_api_key
    attr_accessor :service_api_secret
    attr_accessor :extra_headers

    private

    def initialize(config = {})
      @host                     = config[:host]
      @service_owner_api_key    = config[:service_owner_api_key]
      @service_owner_api_secret = config[:service_owner_api_secret]
      @service_api_key          = config[:service_api_key]
      @service_api_secret       = config[:service_api_secret]
      @extra_headers            = nil

      configure_logging(config[:logging_level])
    end
    
    private

    def configure_logging(level)
      return unless RestClient.log

      case level
      when LoggingLevel::SENSITIVE
        RestClient.log = Authlete::SensitiveLogger.new(RestClient.log)
      when LoggingLevel::NONE
        RestClient.log = Authlete::NullLogger.new
      when LoggingLevel::FULL, nil
        # Keep original logger (default behavior)
      end
    end

    def call_api(method, path, content_type, payload, user, password)
      headers = {}

      headers.merge!(content_type: content_type) unless content_type.nil?

      headers.merge!(@extra_headers) unless @extra_headers.nil?

      response = execute(
        method:   method,
        url:      @host + path,
        headers:  headers,
        payload:  payload,
        user:     user,
        password: password
      )

      body = body_as_string(response)

      body && JSON.parse(body, symbolize_names: true)
    end

    def execute(parameters)
      begin
        return RestClient::Request.new(parameters).execute
      rescue RestClient::Exception => e
        raise on_rest_client_exception(e)
      rescue => e
        raise on_general_exception(e)
      end
    end

    def on_rest_client_exception(exception)
      message  = exception.message
      response = exception.response

      # Create a base exception.
      authlete_exception = Authlete::Exception.new(message: message)

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
        response_body_json = JSON.parse(response_body.to_s, symbolize_names: true)
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

      body.empty? ? nil : body
    end

    def on_general_exception(exception)
      Authlete::Exception.new(message: exception.message)
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

    def to_query(params)
      return '' if params.nil? or params.empty?

      '?' + params.map { |k, v| "#{k.to_s}=#{v.to_s}" }.join('&')
    end

    def to_hash(object)
      # Return the object if it's already a hash.
      return object if object.kind_of?(Hash)

      # Convert the object to a hash if possible and return it.
      return object.to_hash if object.respond_to?('to_hash')

      # Otherwise, raise an exception.
      Authlete::Exception.new(message: "Failed to convert the object to a hash.")
    end

    def extract_requestable_scopes(hash)
      hash.kind_of?(Hash) ? hash[:requestableScopes] : nil
    end

    public

    def authorization(request)
      hash = call_api_json_service("/api/auth/authorization", to_hash(request))

      Authlete::Model::Response::AuthorizationResponse.new(hash)
    end

    def authorization_issue(request)
      hash = call_api_json_service("/api/auth/authorization/issue", to_hash(request))

      Authlete::Model::Response::AuthorizationIssueResponse.new(hash)
    end

    def authorization_fail(request)
      hash = call_api_json_service("/api/auth/authorization/fail", to_hash(request))

      Authlete::Model::Response::AuthorizationFailResponse.new(hash)
    end

    def token(request)
      hash = call_api_json_service("/api/auth/token", to_hash(request))

      Authlete::Model::Response::TokenResponse.new(hash)
    end

    def token_issue(request)
      hash = call_api_json_service("/api/auth/token/issue", to_hash(request))

      Authlete::Model::Response::TokenIssueResponse.new(hash)
    end

    def token_fail(request)
      hash = call_api_json_service("/api/auth/token/fail", to_hash(request))

      Authlete::Model::Response::TokenFailResponse.new(hash)
    end

    def token_revoke(request)
      hash = call_api_json_service("/api/auth/token/revoke", to_hash(request))

      Authlete::Model::Response::TokenRevokeResponse.new(hash)
    end

    def service_create(service)
      hash = call_api_json_service_owner("/api/service/create", to_hash(service))

      Authlete::Model::Service.new(hash)
    end

    def service_delete(api_key)
      call_api_service_owner(:delete, "/api/service/delete/#{api_key}", nil, nil)
    end

    def service_get(api_key)
      hash = call_api_service_owner(:get, "/api/service/get/#{api_key}", nil, nil)

      Authlete::Model::Service.new(hash)
    end

    def service_get_list(params = nil)
      hash = call_api_service_owner(:get, "/api/service/get/list#{to_query(params)}", nil, nil)

      Authlete::Model::Response::ServiceListResponse.new(hash)
    end

    def service_update(api_key, service)
      hash = call_api_json_service_owner("/api/service/update/#{api_key}", to_hash(service))

      Authlete::Model::Service.new(hash)
    end

    def serviceowner_get_self
      hash = call_api_service_owner(:get, "/api/serviceowner/get/self", nil, nil)

      Authlete::Model::ServiceOwner.new(hash)
    end

    def client_create(client)
      hash = call_api_json_service("/api/client/create", to_hash(client))

      Authlete::Model::Client.new(hash)
    end

    def client_delete(client_id)
      call_api_service(:delete, "/api/client/delete/#{client_id}", nil, nil)
    end

    def client_get(client_id)
      hash = call_api_service(:get, "/api/client/get/#{client_id}", nil, nil)

      Authlete::Model::Client.new(hash)
    end

    def client_get_list(params = nil)
      hash = call_api_service(:get, "/api/client/get/list#{to_query(params)}", nil, nil)

      Authlete::Model::Response::ClientListResponse.new(hash)
    end

    def client_update(client)
      hash = call_api_json_service("/api/client/update/#{client.clientId}", to_hash(client))

      Authlete::Model::Client.new(hash)
    end

    def refresh_client_secret(client_identifier)
      hash = call_api_service(:get, "/api/client/secret/refresh/#{client_identifier}", nil, nil)

      Authlete::Model::Response::ClientSecretRefreshResponse.new(hash)
    end

    def update_client_secret(client_identifier, client_secret)
      request = Authlete::Model::Request::ClientSecretUpdateRequest.new(clientSecret: client_secret)

      hash = call_api_json_service("/api/client/secret/update/#{client_identifier}", request.to_hash)

      Authlete::Model::Response::ClientSecretUpdateResponse.new(hash)
    end

    def get_client_authorization_list(request)
      hash = call_api_json_service("/api/client/authorization/get/list", to_hash(request))

      Authlete::Model::Response::AuthorizedClientListResponse.new(hash)
    end

    def update_client_authorization(client_id, request)
      call_api_json_service("/api/client/authorization/update/#{client_id}", to_hash(request))
    end

    def delete_client_authorization(client_id, subject)
      request = Authlete::Model::Request::ClientAuthorizationDeleteRequest.new(subject: subject)

      call_api_json_service("/api/client/authorization/delete/#{client_id}", request.to_hash)
    end

    def introspection(request)
      hash = call_api_json_service('/api/auth/introspection', to_hash(request))

      Authlete::Model::Response::IntrospectionResponse.new(hash)
    end

    def standard_introspection(request)
      hash = call_api_json_service('/api/auth/introspection/standard', to_hash(request))

      Authlete::Model::Response::StandardIntrospectionResponse.new(hash)
    end

    def revocation(request)
      hash = call_api_json_service("/api/auth/revocation", to_hash(request))

      Authlete::Model::Response::RevocationResponse.new(hash)
    end

    def user_info(request)
      hash = call_api_json_service("/api/auth/userinfo", to_hash(request))

      Authlete::Model::Response::UserInfoResponse.new(hash)
    end

    def user_info_issue(request)
      hash = call_api_json_service("/api/auth/userinfo/issue", to_hash(request))

      Authlete::Model::Response::UserInfoIssueResponse.new(hash)
    end

    def get_service_jwks(params = nil)
      call_api_service(:get, "/api/service/jwks/get#{to_query(params)}", nil, nil)
    end

    def get_service_configuration(params = nil)
      call_api_service(:get, "/api/service/configuration#{to_query(params)}", nil, nil)
    end

    def token_create(request)
      hash = call_api_json_service("/api/auth/token/create", to_hash(request))

      Authlete::Model::Response::TokenCreateResponse.new(hash)
    end

    def token_update(request)
      hash = call_api_json_service("/api/auth/token/update", to_hash(request))

      Authlete::Model::Response::TokenUpdateResponse.new(hash)
    end

    def get_token_list(params = nil)
      hash = call_api_service(:get, "/api/auth/token/get/list#{to_query(params)}", nil, nil)

      Authlete::Model::Response::TokenListResponse.new(hash)
    end

    def get_granted_scopes(client_id, subject)
      request = Authlete::Model::Request::GrantedScopesRequest.new(subject: subject)

      hash = call_api_json_service("/api/client/granted_scopes/get/#{client_id}", to_hash(request))

      Authlete::Model::Response::GrantedScopesGetResponse.new(hash)
    end

    def delete_granted_scopes(client_id, subject)
      request = Authlete::Model::Request::GrantedScopesRequest.new(subject: subject)

      call_api_json_service("/api/client/granted_scopes/delete/#{client_id}", to_hash(request))
    end

    def get_requestable_scopes(client_id)
      hash = call_api_service(:get, "/api/client/extension/requestable_scopes/get/#{client_id}", nil, nil)

      extract_requestable_scopes(hash)
    end

    def set_requestable_scopes(client_id, scopes)
      hash = call_api_json_service("/api/client/extension/requestable_scopes/update/#{client_id}", { requestableScopes: scopes })

      extract_requestable_scopes(hash)
    end

    def delete_requestable_scopes(client_id)
      call_api_service(:delete, "/api/client/extension/requestable_scopes/delete/#{client_id}", nil, nil)
    end

    def dynamic_client_register(request)
      hash = call_api_json_service("/api/client/registration", to_hash(request))

      Authlete::Model::Response::ClientRegistrationResponse.new(hash)
    end

    def dynamic_client_get(request)
      hash = call_api_json_service("/api/client/registration/get", to_hash(request))

      Authlete::Model::Response::ClientRegistrationResponse.new(hash)
    end

    def dynamic_client_update(request)
      hash = call_api_json_service("/api/client/registration/update", to_hash(request))

      Authlete::Model::Response::ClientRegistrationResponse.new(hash)
    end

    def dynamic_client_delete(request)
      hash = call_api_json_service("/api/client/registration/delete", to_hash(request))

      Authlete::Model::Response::ClientRegistrationResponse.new(hash)
    end

    def backchannel_authentication(request)
      hash = call_api_json_service("/api/backchannel/authentication", to_hash(request))

      Authlete::Model::Response::BackchannelAuthenticationResponse.new(hash)
    end

    def backchannel_authentication_issue(request)
      hash = call_api_json_service("/api/backchannel/authentication/issue", to_hash(request))

      Authlete::Model::Response::BackchannelAuthenticationIssueResponse.new(hash)
    end

    def backchannel_authentication_fail(request)
      hash = call_api_json_service("/api/backchannel/authentication/fail", to_hash(request))

      Authlete::Model::Response::BackchannelAuthenticationFailResponse.new(hash)
    end

    def backchannel_authentication_complete(request)
      hash = call_api_json_service("/api/backchannel/authentication/complete", to_hash(request))

      Authlete::Model::Response::BackchannelAuthenticationCompleteResponse.new(hash)
    end

    def device_authorization(request)
      hash = call_api_json_service("/api/device/authorization", to_hash(request))

      Authlete::Model::Response::DeviceAuthorizationResponse.new(hash)
    end

    def device_complete(request)
      hash = call_api_json_service("/api/device/complete", to_hash(request))

      Authlete::Model::Response::DeviceCompleteResponse.new(hash)
    end

    def device_verification(request)
      hash = call_api_json_service("/api/device/verification", to_hash(request))

      Authlete::Model::Response::DeviceVerificationResponse.new(hash)
    end

    def push_authorization_request(request)
      hash = call_api_json_service("/api/pushed_auth_req", to_hash(request))

      Authlete::Model::Response::PushedAuthReqResponse.new(hash)
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
          action:          'BAD_REQUEST',
          responseContent: 'Bearer error="invalid_token",error_description="The request does not contain a valid access token."'
        )
      end

      # Create a request for Authlete's /api/auth/introspection API.
      request = Authlete::Model::Request::IntrospectionRequest.new(
        token:   access_token,
        scopes:  scopes,
        subject: subject
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
          action:          'INTERNAL_SERVER_ERROR',
          responseContent: "Bearer error=\"server_error\",error_description=\"#{message}\""
        )
      end

      # Return the response from Authlete's /api/auth/introspection API.
      result
    end

    def emit_rack_error_message(request, message)
      begin
        # Logging if possible.
        request.env['rack.errors'].write("ERROR: #{message}\n")
      rescue => e
      end
    end
  end
end
