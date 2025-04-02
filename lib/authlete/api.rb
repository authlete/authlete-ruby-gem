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
require 'uri'
require_relative 'api_path/v2'
require_relative 'api_path/v3'

module Authlete
  class Api
    include Authlete::Utility

    module ApiVersion
      V2 = :v2
      V3 = :v3

      def self.from_string(version_string)
        case version_string&.downcase
        when 'v3'
          V3
        else
          # Defaults to V2 when the provided API version is not recognized or missing.
          V2
        end
      end
    end

    attr_accessor :host
    attr_accessor :service_owner_api_key
    attr_accessor :service_owner_api_secret
    attr_accessor :service_api_key
    attr_accessor :service_api_secret
    attr_accessor :organization_access_token
    attr_accessor :service_access_token
    attr_accessor :service_id
    attr_accessor :extra_headers
    attr_reader   :api_version

    private

    attr_reader :path_resolver

    def initialize(config = {})
      @host                      = config[:host]
      # v2
      @service_owner_api_key     = config[:service_owner_api_key]
      @service_owner_api_secret  = config[:service_owner_api_secret]
      @service_api_key           = config[:service_api_key]
      @service_api_secret        = config[:service_api_secret]
      # v3
      @organization_access_token = config[:organization_access_token]
      @service_access_token      = config[:service_access_token]
      @service_id                = if config[:service_id].nil? || config[:service_id].to_s.empty?
                                     nil
                                   else
                                     URI.encode_www_form_component(config[:service_id].to_s)
                                   end

      @extra_headers             = nil
      @api_version               = ApiVersion.from_string(config[:api_version])

      if @api_version == ApiVersion::V3 && @service_id.nil?
        warn "Warning: A Service ID (:service_id) is required for most APIs in Authlete version 3."
      end

      @path_resolver = case @api_version
                       when ApiVersion::V3
                         Authlete::ApiPath::V3.new(@service_id)
                       when ApiVersion::V2
                         Authlete::ApiPath::V2.new()
                       else
                          raise ArgumentError, "Unsupported API version for path resolver: #{@api_version.inspect}"
                       end

      configure_logging(config[:rest_client_logging_level])
    end

    private

    def configure_logging(level)
      return unless RestClient.log

      case level
      when LoggingLevel::SENSITIVE
        RestClient.log = Authlete::SensitiveLogger.new(RestClient.log)
      when LoggingLevel::NONE
        RestClient.log = Authlete::NullLogger.new
      when LoggingLevel::DEFAULT, nil
        # Keep original logger (default behavior)
      end
    end

    def call_api(method, path, content_type, payload, credential_type)
      headers = {}
      user = nil
      password = nil
      token = nil

      case @api_version
      when ApiVersion::V3
        token = case credential_type
                when :service_owner then @organization_access_token
                when :service       then @service_access_token
                else nil
                end
        headers.merge!(Authorization: "Bearer #{token}") unless token.nil?
      when ApiVersion::V2
        user, password = case credential_type
                         when :service_owner then [@service_owner_api_key, @service_owner_api_secret]
                         when :service       then [@service_api_key, @service_api_secret]
                         else [nil, nil]
                         end
      else
        raise ArgumentError, "Unsupported API version: #{@api_version.inspect}"
      end

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
      call_api(method, path, content_type, payload, :service_owner)
    end

    def call_api_service(method, path, content_type, payload)
      call_api(method, path, content_type, payload, :service)
    end

    def call_api_json(path, body, credential_type)
      call_api(:post, path, 'application/json;charset=UTF-8', JSON.generate(body), credential_type)
    end

    def call_api_json_service_owner(path, body)
      call_api_json(path, body, :service_owner)
    end

    def call_api_json_service(path, body)
      call_api_json(path, body, :service)
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
      path = @path_resolver.authorization
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::AuthorizationResponse.new(hash)
    end

    def authorization_issue(request)
      path = @path_resolver.authorization_issue
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::AuthorizationIssueResponse.new(hash)
    end

    def authorization_fail(request)
      path = @path_resolver.authorization_fail
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::AuthorizationFailResponse.new(hash)
    end

    def token(request)
      path = @path_resolver.token
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::TokenResponse.new(hash)
    end

    def token_issue(request)
      path = @path_resolver.token_issue
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::TokenIssueResponse.new(hash)
    end

    def token_fail(request)
      path = @path_resolver.token_fail
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::TokenFailResponse.new(hash)
    end

    def token_revoke(request)
      path = @path_resolver.token_revoke
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::TokenRevokeResponse.new(hash)
    end

    def service_create(service)
      path = @path_resolver.service_create
      hash = call_api_json_service_owner(path, to_hash(service))
      Authlete::Model::Service.new(hash)
    end

    def service_delete(service_id)
      path = @path_resolver.service_delete(service_id)
      call_api_service_owner(:delete, path, nil, nil)
    end

    def service_get(service_id)
      path = @path_resolver.service_get(service_id)
      hash = call_api_service_owner(:get, path, nil, nil)
      Authlete::Model::Service.new(hash)
    end

    def service_get_list(params = nil)
      base_path = @path_resolver.service_get_list
      relative_path = base_path + to_query(params)
      hash = call_api_service_owner(:get, relative_path, nil, nil)
      Authlete::Model::Response::ServiceListResponse.new(hash)
    end

    def service_update(service_id, service)
      path = @path_resolver.service_update(service_id)
      hash = call_api_json_service_owner(path, to_hash(service))
      Authlete::Model::Service.new(hash)
    end

    def serviceowner_get_self
      path = @path_resolver.serviceowner_get_self
      hash = call_api_service_owner(:get, path, nil, nil)
      Authlete::Model::ServiceOwner.new(hash)
    end

    def client_create(client)
      path = @path_resolver.client_create
      hash = call_api_json_service(path, to_hash(client))
      Authlete::Model::Client.new(hash)
    end

    def client_delete(client_id)
      path = @path_resolver.client_delete(client_id)
      call_api_service(:delete, path, nil, nil)
    end

    def client_get(client_id)
      path = @path_resolver.client_get(client_id)
      hash = call_api_service(:get, path, nil, nil)
      Authlete::Model::Client.new(hash)
    end

    def client_get_list(params = nil)
      base_path = @path_resolver.client_get_list
      relative_path = base_path + to_query(params)
      hash = call_api_service(:get, relative_path, nil, nil)
      Authlete::Model::Response::ClientListResponse.new(hash)
    end

    def client_update(client)
      path = @path_resolver.client_update(client.clientId)
      hash = call_api_json_service(path, to_hash(client))
      Authlete::Model::Client.new(hash)
    end

    def refresh_client_secret(client_identifier)
      path = @path_resolver.refresh_client_secret(client_identifier)
      hash = call_api_service(:get, path, nil, nil)
      Authlete::Model::Response::ClientSecretRefreshResponse.new(hash)
    end

    def update_client_secret(client_identifier, client_secret)
      request = Authlete::Model::Request::ClientSecretUpdateRequest.new(clientSecret: client_secret)
      path = @path_resolver.update_client_secret(client_identifier)
      hash = call_api_json_service(path, request.to_hash)
      Authlete::Model::Response::ClientSecretUpdateResponse.new(hash)
    end

    def get_client_authorization_list(request)
      path = @path_resolver.get_client_authorization_list
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::AuthorizedClientListResponse.new(hash)
    end

    def update_client_authorization(client_id, request)
      path = @path_resolver.update_client_authorization(client_id)
      call_api_json_service(path, to_hash(request))
    end

    def delete_client_authorization(client_id, subject)
      request = Authlete::Model::Request::ClientAuthorizationDeleteRequest.new(subject: subject)
      path = @path_resolver.delete_client_authorization(client_id)
      call_api_json_service(path, request.to_hash)
    end

    def introspection(request)
      path = @path_resolver.introspection
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::IntrospectionResponse.new(hash)
    end

    def standard_introspection(request)
      path = @path_resolver.standard_introspection
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::StandardIntrospectionResponse.new(hash)
    end

    def revocation(request)
      path = @path_resolver.revocation
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::RevocationResponse.new(hash)
    end

    def user_info(request)
      path = @path_resolver.user_info
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::UserInfoResponse.new(hash)
    end

    def user_info_issue(request)
      path = @path_resolver.user_info_issue
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::UserInfoIssueResponse.new(hash)
    end

    def get_service_jwks(params = nil)
      base_path = @path_resolver.get_service_jwks
      relative_path = base_path + to_query(params)
      call_api_service(:get, relative_path, nil, nil)
    end

    def get_service_configuration(params = nil)
      base_path = @path_resolver.get_service_configuration
      relative_path = base_path + to_query(params)
      call_api_service(:get, relative_path, nil, nil)
    end

    def token_create(request)
      path = @path_resolver.token_create
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::TokenCreateResponse.new(hash)
    end

    def token_update(request)
      path = @path_resolver.token_update
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::TokenUpdateResponse.new(hash)
    end

    def get_token_list(params = nil)
      base_path = @path_resolver.get_token_list
      relative_path = base_path + to_query(params)
      hash = call_api_service(:get, relative_path, nil, nil)
      Authlete::Model::Response::TokenListResponse.new(hash)
    end

    def get_granted_scopes(client_id, subject)
      request = Authlete::Model::Request::GrantedScopesRequest.new(subject: subject)
      path = @path_resolver.get_granted_scopes(client_id)
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::GrantedScopesGetResponse.new(hash)
    end

    def delete_granted_scopes(client_id, subject)
      request = Authlete::Model::Request::GrantedScopesRequest.new(subject: subject)

      path = @path_resolver.delete_granted_scopes(client_id)
      call_api_json_service(path, to_hash(request))
    end

    def get_requestable_scopes(client_id)
      path = @path_resolver.get_requestable_scopes(client_id)
      hash = call_api_service(:get, path, nil, nil)
      extract_requestable_scopes(hash)
    end

    def set_requestable_scopes(client_id, scopes)
      path = @path_resolver.set_requestable_scopes(client_id)
      hash = call_api_json_service(path, { requestableScopes: scopes })
      extract_requestable_scopes(hash)
    end

    def delete_requestable_scopes(client_id)
      path = @path_resolver.delete_requestable_scopes(client_id)
      call_api_service(:delete, path, nil, nil)
    end

    def dynamic_client_register(request)
      path = @path_resolver.dynamic_client_register
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::ClientRegistrationResponse.new(hash)
    end

    def dynamic_client_get(request)
      path = @path_resolver.dynamic_client_get
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::ClientRegistrationResponse.new(hash)
    end

    def dynamic_client_update(request)
      path = @path_resolver.dynamic_client_update
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::ClientRegistrationResponse.new(hash)
    end

    def dynamic_client_delete(request)
      path = @path_resolver.dynamic_client_delete
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::ClientRegistrationResponse.new(hash)
    end

    def backchannel_authentication(request)
      path = @path_resolver.backchannel_authentication
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::BackchannelAuthenticationResponse.new(hash)
    end

    def backchannel_authentication_issue(request)
      path = @path_resolver.backchannel_authentication_issue
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::BackchannelAuthenticationIssueResponse.new(hash)
    end

    def backchannel_authentication_fail(request)
      path = @path_resolver.backchannel_authentication_fail
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::BackchannelAuthenticationFailResponse.new(hash)
    end

    def backchannel_authentication_complete(request)
      path = @path_resolver.backchannel_authentication_complete
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::BackchannelAuthenticationCompleteResponse.new(hash)
    end

    def device_authorization(request)
      path = @path_resolver.device_authorization
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::DeviceAuthorizationResponse.new(hash)
    end

    def device_complete(request)
      path = @path_resolver.device_complete
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::DeviceCompleteResponse.new(hash)
    end

    def device_verification(request)
      path = @path_resolver.device_verification
      hash = call_api_json_service(path, to_hash(request))
      Authlete::Model::Response::DeviceVerificationResponse.new(hash)
    end

    def push_authorization_request(request)
      path = @path_resolver.push_authorization_request
      hash = call_api_json_service(path, to_hash(request))
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
        message = build_error_message(@path_resolver.introspection, e)

        # Emit a Rack error message.
        emit_rack_error_message(request, message)

        # Failed to introspect the access token.
        return Authlete::Model::Response::IntrospectionResponse.new(
          action:          'INTERNAL_SERVER_ERROR',
          responseContent: "Bearer error=\"server_error\",error_description=\"#{message}\""
        )
      end

      # Return the response from Authlete's introspection API.
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
