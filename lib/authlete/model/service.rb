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


require 'set'


module Authlete
  module Model
    class Service < Authlete::Model::Hashable
      include Authlete::Utility
      # The duration of access tokens in seconds. (Integer)
      attr_accessor :accessTokenDuration
      alias_method  :access_token_duration,  :accessTokenDuration
      alias_method  :access_token_duration=, :accessTokenDuration=

      # The access token type. (String)
      attr_accessor :accessTokenType
      alias_method  :access_token_type,  :accessTokenType
      alias_method  :access_token_type=, :accessTokenType=

      # The API key. (Long)
      attr_accessor :apiKey
      alias_method  :api_key,  :apiKey
      alias_method  :api_key=, :apiKey=

      # The API secret. (String)
      attr_accessor :apiSecret
      alias_method  :api_secret,  :apiSecret
      alias_method  :api_secret=, :apiSecret=

      # The API key to access the authentication callback endpoint. (String)
      attr_accessor :authenticationCallbackApiKey
      alias_method  :authentication_callback_api_key,  :authenticationCallbackApiKey
      alias_method  :authentication_callback_api_key=, :authenticationCallbackApiKey=

      # The API secret to access the authentication callback endpoint. (String)
      attr_accessor :authenticationCallbackApiSecret
      alias_method  :authentication_callback_api_secret,  :authenticationCallbackApiSecret
      alias_method  :authentication_callback_api_secret=, :authenticationCallbackApiSecret=

      # The URI of the authentication callback endpoint. (URI)
      attr_accessor :authenticationCallbackEndpoint
      alias_method  :authentication_callback_endpoint,  :authenticationCallbackEndpoint
      alias_method  :authentication_callback_endpoint=, :authenticationCallbackEndpoint=

      # The URI of the authorization endpoint. (URI)
      attr_accessor :authorizationEndpoint
      alias_method  :authorization_endpoint,  :authorizationEndpoint
      alias_method  :authorization_endpoint=, :authorizationEndpoint=

      # The flag which indicates whether the 'Client ID Alias' feature
      # is enabled or not. (Boolean)
      attr_accessor :clientIdAliasEnabled
      alias_method  :client_id_alias_enabled,  :clientIdAliasEnabled
      alias_method  :client_id_alias_enabled=, :clientIdAliasEnabled=

      # The number of client applications that one developer can create.
      # 0 means no limit. (Integer)
      attr_accessor :clientsPerDeveloper
      alias_method  :clients_per_developer,  :clientsPerDeveloper
      alias_method  :clients_per_developer=, :clientsPerDeveloper=

      # The timestamp at which the service was created. (Integer)
      attr_accessor :createdAt
      alias_method  :created_at, :createdAt
      alias_method  :created_at=, :createdAt=

      # The description of this service. (String)
      attr_accessor :description

      # The API key to access the developer authentication callback endpoint. (String)
      attr_accessor :developerAuthenticationCallbackApiKey
      alias_method  :developer_authentication_callback_api_key,  :developerAuthenticationCallbackApiKey
      alias_method  :developer_authentication_callback_api_key=, :developerAuthenticationCallbackApiKey=

      # The API secret to access the developer authentication callback endpoint. (String)
      attr_accessor :developerAuthenticationCallbackApiSecret
      alias_method  :developer_authentication_callback_api_secret,  :developerAuthenticationCallbackApiSecret
      alias_method  :developer_authentication_callback_api_secret=, :developerAuthenticationCallbackApiSecret=

      # The URI of the developer authentication callback endpoint. (URI)
      attr_accessor :developerAuthenticationCallbackEndpoint
      alias_method  :developer_authentication_callback_endpoint,  :developerAuthenticationCallbackEndpoint
      alias_method  :developer_authentication_callback_endpoint=, :developerAuthenticationCallbackEndpoint=

      # The list of SNS credentials for developer login. (SnsCredentials array)
      attr_accessor :developerSnsCredentials
      alias_method  :developer_sns_credentials,  :developerSnsCredentials
      alias_method  :developer_sns_credentials=, :developerSnsCredentials=

      # The flag to indicate whether the direct authorization endpoint
      # is enabled or not. The path of the endpoint is
      # <code>/api/auth/authorization/direct/{serviceApiKey}</code>
      # (Boolean)
      attr_accessor :directAuthorizationEndpointEnabled
      alias_method  :direct_authorization_endpoint_enabled,  :directAuthorizationEndpointEnabled
      alias_method  :direct_authorization_endpoint_enabled=, :directAuthorizationEndpointEnabled=

      # The flag to indicate whether the direct jwks endpoint
      # is enabled or not. The path of the endpoint is
      # <code>/api/service/jwks/get/direct/{serviceApiKey}</code>
      # (Boolean)
      attr_accessor :directJwksEndpointEnabled
      alias_method  :direct_jwks_endpoint_enabled,  :directJwksEndpointEnabled
      alias_method  :direct_jwks_endpoint_enabled=, :directJwksEndpointEnabled=

      # The flag to indicate whether the direct revocation endpoint
      # is enabled or not. The path of the endpoint is
      # <code>/api/auth/revocation/direct/{serviceApiKey}</code>
      # (Boolean)
      attr_accessor :directRevocationEndpointEnabled
      alias_method  :direct_revocation_endpoint_enabled,  :directRevocationEndpointEnabled
      alias_method  :direct_revocation_endpoint_enabled=, :directRevocationEndpointEnabled=

      # The flag to indicate whether the direct token endpoint
      # is enabled or not. The path of the endpoint is
      # <code>/api/auth/token/direct/{serviceApiKey}</code>
      # (Boolean)
      attr_accessor :directTokenEndpointEnabled
      alias_method  :direct_token_endpoint_enabled,  :directTokenEndpointEnabled
      alias_method  :direct_token_endpoint_enabled=, :directTokenEndpointEnabled=

      # The flag to indicate whether the direct user info endpoint
      # is enabled or not. The path of the endpoint is
      # <code>/api/auth/userinfo/direct/{serviceApiKey}</code>
      # (Boolean)
      attr_accessor :directUserInfoEndpointEnabled
      alias_method  :direct_user_info_endpoint_enabled,  :directUserInfoEndpointEnabled
      alias_method  :direct_user_info_endpoint_enabled=, :directUserInfoEndpointEnabled=

      # The duration of ID tokens in seconds. (Integer)
      attr_accessor :idTokenDuration
      alias_method  :id_token_duration,  :idTokenDuration
      alias_method  :id_token_duration=, :idTokenDuration=

      # The key ID to identify a JWK used for ID token signature using an
      # asymmetric key. (String)
      attr_accessor :idTokenSignatureKeyId
      alias_method :id_token_signature_key_id, :idTokenSignatureKeyId
      alias_method :id_token_signature_key_id=, :idTokenSignatureKeyId=

      # The issuer identifier of this OpenID Provider. (URI)
      attr_accessor :issuer

      # The JSON Web Key Set of this service. (String)
      attr_accessor :jwks

      # The URI of the service's JSON Web Key Set. (URI)
      attr_accessor :jwksUri
      alias_method  :jwks_uri,  :jwksUri
      alias_method  :jwks_uri=, :jwksUri=

      # The metadata of the service. (Pair Array)
      attr_accessor :metadata

      # The timestamp at which the service was modified. (Integer)
      attr_accessor :modifiedAt
      alias_method  :modified_at,  :modifiedAt
      alias_method  :modified_at=, :modifiedAt=

      # The service number. (Integer)
      attr_accessor :number

      # The flag to indicate whether the use of Proof Key for Code
      # Exchange (PKCE) is always required for authorization requests
      # Authorization Code Flow.
      # (Boolean)
      attr_accessor :pkceRequired
      alias_method  :pkce_required,  :pkceRequired
      alias_method  :pkce_required=, :pkceRequired=

      # The URI of the service's policy page. (URI)
      attr_accessor :policyUri
      alias_method  :policy_uri,  :policyUri
      alias_method  :policy_uri=, :policyUri=

      # The duration of refresh tokens in seconds. (Integer)
      attr_accessor :refreshTokenDuration
      alias_method  :refresh_token_duration,  :refreshTokenDuration
      alias_method  :refresh_token_duration=, :refreshTokenDuration=

      # The flag to indicate whether a refresh token remains unchanged
      # or gets renewed after its use.
      # (Boolean)
      attr_accessor :refreshTokenKept
      alias_method  :refresh_token_kept,  :refreshTokenKept
      alias_method  :refresh_token_kept=, :refreshTokenKept=

      # The URI of the registration endpoint. (URI)
      attr_accessor :registrationEndpoint
      alias_method  :registration_endpoint,  :registrationEndpoint
      alias_method  :registration_endpoint=, :registrationEndpoint=

      # The URI of the token revocation endpoint. (URI)
      attr_accessor :revocationEndpoint
      alias_method  :revocation_endpoint,  :revocationEndpoint
      alias_method  :revocation_endpoint=, :revocationEndpoint=

      # The URI of the service's documentation. (URI)
      attr_accessor :serviceDocumentation
      alias_method  :service_documentation,  :serviceDocumentation
      alias_method  :service_documentation=, :serviceDocumentation=

      # The service name. (String)
      attr_accessor :serviceName
      alias_method  :service_name,  :serviceName
      alias_method  :service_name=, :serviceName=

      # The service owner number. (Integer)
      attr_accessor :serviceOwnerNumber
      alias_method  :service_owner_number,  :serviceOwnerNumber
      alias_method  :service_owner_number=, :serviceOwnerNumber=

      # The flag to indicate whether the number of access tokens
      # per subject (and per client) is at most one or can be more. (Boolean)
      attr_accessor :singleAccessTokenPerSubject
      alias_method  :single_access_token_per_subject, :singleAccessTokenPerSubject
      alias_method  :single_access_token_per_subject=, :singleAccessTokenPerSubject=

      # The list of SNS credentials. (SnsCredentials array)
      attr_accessor :snsCredentials
      alias_method  :sns_credentials,  :snsCredentials
      alias_method  :sns_credentials=, :snsCredentials=

      # The list of supported ACRs. (String array)
      attr_accessor :supportedAcrs
      alias_method  :supported_acrs,  :supportedAcrs
      alias_method  :supported_acrs=, :supportedAcrs=

      # The list of supported claim locales. (String array)
      attr_accessor :supportedClaimLocales
      alias_method  :supported_claim_locales,  :supportedClaimLocales
      alias_method  :supported_claim_locales=, :supportedClaimLocales=

      # The list of supported claims. (String array)
      attr_accessor :supportedClaims
      alias_method  :supported_claims,  :supportedClaims
      alias_method  :supported_claims=, :supportedClaims=

      # The list of supported claim types. (String array)
      #
      # Valid values are "NORMAL", "AGGREGATED" and "DISTRIBUTED".
      attr_accessor :supportedClaimTypes
      alias_method  :supported_claim_types,  :supportedClaimTypes
      alias_method  :supported_claim_types=, :supportedClaimTypes=

      # The list of supported SNSes for developer login. (Sns array)
      attr_accessor :supportedDeveloperSnses
      alias_method  :supported_developer_snses,  :supportedDeveloperSnses
      alias_method  :supported_developer_snses=, :supportedDeveloperSnses=

      # The list of supported values of +display+ parameter. (String array)
      #
      # Valid values are "PAGE", "POPUP", "TOUCH" and "WAP".
      attr_accessor :supportedDisplays
      alias_method  :supported_displays,  :supportedDisplays
      alias_method  :supported_displays=, :supportedDisplays=

      # The list of supported grant types. (String array)
      #
      # Valid values are "AUTHORIZATION_CODE", "IMPLICIT", "PASSWORD",
      # "CLIENT_CREDENTIALS" and "REFRESH_TOKEN".
      attr_accessor :supportedGrantTypes
      alias_method  :supported_grant_types,  :supportedGrantTypes
      alias_method  :supported_grant_types=, :supportedGrantTypes=

      # The list of supported response types. (String array)
      #
      # Valid values are "NONE", "CODE", "TOKEN", "ID_TOKEN",
      # "CODE_TOKEN", "CODE_ID_TOKEN", "ID_TOKEN_TOKEN" and
      # "CODE_ID_TOKEN_TOKEN".
      attr_accessor :supportedResponseTypes
      alias_method  :supported_response_types,  :supportedResponseTypes
      alias_method  :supported_response_types=, :supportedResponseTypes=

      # The list of supported scopes. (Scope array)
      attr_accessor :supportedScopes
      alias_method  :supported_scopes,  :supportedScopes
      alias_method  :supported_scopes=, :supportedScopes=

      # The list of supported SNSes. (Sns array)
      attr_accessor :supportedSnses
      alias_method  :supported_snses,  :supportedSnses
      alias_method  :supported_snses=, :supportedSnses=

      # The list of supported client authentication methods at the token endpoint. (String array)
      #
      # Valid values are "NONE", "CLIENT_SECRET_BASIC", "CLIENT_SECRET_POST",
      # "CLIENT_SECRET_JWT" and "PRIVATE_KEY_JWT".
      attr_accessor :supportedTokenAuthMethods
      alias_method  :supported_token_auth_methods,  :supportedTokenAuthMethods
      alias_method  :supported_token_auth_methods=, :supportedTokenAuthMethods=

      # The list of supported UI locales. (String array)
      attr_accessor :supportedUiLocales
      alias_method  :supported_ui_locales,  :supportedUiLocales
      alias_method  :supported_ui_locales=, :supportedUiLocales=

      # The URI of the token endpoint. (URI)
      attr_accessor :tokenEndpoint
      alias_method  :token_endpoint,  :tokenEndpoint
      alias_method  :token_endpoint=, :tokenEndpoint=

      # The URI of the service's "Terms Of Service" page. (URI)
      attr_accessor :tosUri
      alias_method  :tos_uri,  :tosUri
      alias_method  :tos_uri=, :tosUri=

      # The URI of user info endpoint. (URI)
      attr_accessor :userInfoEndpoint
      alias_method  :user_info_endpoint,  :userInfoEndpoint
      alias_method  :user_info_endpoint=, :userInfoEndpoint=

      # The key ID to identify a JWK used for user info signature using an
      # asymmetric key. (String)
      attr_accessor :userInfoSignatureKeyId
      alias_method :user_info_signature_key_id, :userInfoSignatureKeyId
      alias_method :user_info_signature_key_id=, :userInfoSignatureKeyId=

      private

      # Integer attributes.
      INTEGER_ATTRIBUTES = ::Set.new([
        :accessTokenDuration, :apiKey, :clientsPerDeveloper, :createdAt,
        :idTokenDuration, :modifiedAt, :number, :refreshTokenDuration, :serviceOwnerNumber
      ])

      # Boolean attributes.
      BOOLEAN_ATTRIBUTES = ::Set.new([
        :clientIdAliasEnabled, :directAuthorizationEndpointEnabled,
        :directJwksEndpointEnabled, :directRevocationEndpointEnabled,
        :directTokenEndpointEnabled, :directUserInfoEndpointEnabled,
        :pkceRequired, :refreshTokenKept, :singleAccessTokenPerSubject
      ])

      # String attributes.
      STRING_ATTRIBUTES = ::Set.new([
        :accessTokenType, :apiSecret, :authenticationCallbackApiKey,
        :authenticationCallbackApiSecret, :authenticationCallbackEndpoint,
        :authorizationEndpoint, :description, :developerAuthenticationCallbackApiKey,
        :developerAuthenticationCallbackApiSecret, :developerAuthenticationCallbackEndpoint,
        :idTokenSignatureKeyId, :issuer, :jwks, :jwksUri, :policyUri, :registrationEndpoint,
        :serviceDocumentation, :serviceName, :tokenEndpoint, :tosUri, :userInfoEndpoint,
        :userInfoSignatureKeyId, :revocationEndpoint
      ])

      # String array attributes.
      STRING_ARRAY_ATTRIBUTES = ::Set.new([
        :supportedAcrs, :supportedClaimLocales, :supportedClaims,
        :supportedClaimTypes, :supportedDeveloperSnses, :supportedDisplays,
        :supportedGrantTypes, :supportedResponseTypes, :supportedSnses,
        :supportedTokenAuthMethods, :supportedUiLocales
      ])

      # Mapping from snake cases to camel cases.
      SNAKE_TO_CAMEL = {
        :access_token_duration                        => :accessTokenDuration,
        :access_token_type                            => :accessTokenType,
        :api_key                                      => :apiKey,
        :api_secret                                   => :apiSecret,
        :authentication_callback_api_key              => :authenticationCallbackApiKey,
        :authentication_callback_api_secret           => :authenticationCallbackApiSecret,
        :authentication_callback_endpoint             => :authenticationCallbackEndpoint,
        :authorization_endpoint                       => :authorizationEndpoint,
        :developer_authentication_callback_api_key    => :developerAuthenticationCallbackApiKey,
        :developer_authentication_callback_api_secret => :developerAuthenticationCallbackApiSecret,
        :developer_authentication_callback_endpoint   => :developerAuthenticationCallbackEndpoint,
        :developer_sns_credentials                    => :developerSnsCredentials,
        :client_id_alias_enabled                      => :clientIdAliasEnabled,
        :clients_per_developer                        => :clientsPerDeveloper,
        :created_at                                   => :createdAt,
        :direct_authorization_endpoint_enabled        => :directAuthorizationEndpointEnabled,
        :direct_jwks_endpoint_enabled                 => :directJwksEndpointEnabled,
        :direct_revocation_endpoint_enabled           => :directRevocationEndpointEnabled,
        :direct_token_endpoint_enabled                => :directTokenEndpointEnabled,
        :direct_user_info_endpoint_enabled            => :directUserInfoEndpointEnabled,
        :id_token_duration                            => :idTokenDuration,
        :id_token_signature_key_id                    => :idTokenSignatureKeyId,
        :jwks_uri                                     => :jwksUri,
        :modified_at                                  => :modifiedAt,
        :pkce_required                                => :pkceRequired,
        :policy_uri                                   => :policyUri,
        :refresh_token_duration                       => :refreshTokenDuration,
        :refresh_token_kept                           => :refreshTokenKept,
        :registration_endpoint                        => :registrationEndpoint,
        :revocation_endpoint                          => :revocationEndpoint,
        :service_documentation                        => :serviceDocumentation,
        :service_name                                 => :serviceName,
        :service_owner_number                         => :serviceOwnerNumber,
        :single_access_token_per_subject              => :singleAccessTokenPerSubject,
        :sns_credentials                              => :snsCredentials,
        :supported_acrs                               => :supportedAcrs,
        :supported_claim_locales                      => :supportedClaimLocales,
        :supported_claims                             => :supportedClaims,
        :supported_claim_types                        => :supportedClaimTypes,
        :supported_developer_snses                    => :supportedDeveloperSnses,
        :supported_displays                           => :supportedDisplays,
        :supported_grant_types                        => :supportedGrantTypes,
        :supported_response_types                     => :supportedResponseTypes,
        :supported_scopes                             => :supportedScopes,
        :supported_snses                              => :supportedSnses,
        :supported_token_auth_methods                 => :supportedTokenAuthMethods,
        :supported_ui_locales                         => :supportedUiLocales,
        :token_endpoint                               => :tokenEndpoint,
        :tos_uri                                      => :tosUri,
        :user_info_endpoint                           => :userInfoEndpoint,
        :user_info_signature_key_id                   => :usrInfoSignatureKeyId
      }

      # The constructor
      def initialize(hash = nil)
        # Set default values to integer attributes.
        INTEGER_ATTRIBUTES.each do |attr|
          send("#{attr}=", 0)
        end

        # Set default values to boolean attributes.
        BOOLEAN_ATTRIBUTES.each do |attr|
          send("#{attr}=", false)
        end

        # Set default values to string attributes.
        STRING_ATTRIBUTES.each do |attr|
          send("#{attr}=", nil)
        end

        # Set default values to string array attributes.
        STRING_ARRAY_ATTRIBUTES.each do |attr|
          send("#{attr}=", nil)
        end

        # Set default values to special objects.
        @developerSnsCredentials = nil
        @metadata                = nil
        @snsCredentials          = nil
        @supportedScopes         = nil

        # Set attribute values using the given hash.
        authlete_model_update(hash)
      end

      def authlete_model_convert_key(key)
        key = key.to_sym

        # Convert snakecase to camelcase, if necessary.
        if SNAKE_TO_CAMEL.has_key?(key)
          key = SNAKE_TO_CAMEL[key]
        end

        key
      end

      def authlete_model_simple_attribute?(key)
        INTEGER_ATTRIBUTES.include?(key) or
        BOOLEAN_ATTRIBUTES.include?(key) or
        STRING_ATTRIBUTES.include?(key) or
        STRING_ARRAY_ATTRIBUTES.include?(key)
      end

      def authlete_model_update(hash)
        return if hash.nil?

        hash.each do |key, value|
          key = authlete_model_convert_key(key)

          if authlete_model_simple_attribute?(key)
            send("#{key}=", value)
          elsif key == :developerSnsCredentials
            @developerSnsCredentials = get_parsed_array(value) do |element|
              Authlete::Model::SnsCredentials.parse(element)
            end
          elsif key == :metadata
            @metadata = get_parsed_array(value) do |element|
              Authlete::Model::Pair.parse(element)
            end
          elsif key == :snsCredentials
            @snsCredentials = get_parsed_array(value) do |element|
              Authlete::Model::SnsCredentials.parse(element)
            end
          elsif key == :supportedScopes
            @supportedScopes = get_parsed_array(value) do |element|
              Authlete::Model::Scope.parse(element)
            end
          end
        end

        self
      end

      public

      # Construct an instance from the given hash.
      #
      # If the given argument is nil or is not a Hash, nil is returned.
      # Otherwise, Service.new(hash) is returned.
      def self.parse(hash)
        if hash.nil? or (hash.kind_of?(Hash) == false)
          return nil
        end

        Service.new(hash)
      end

      # Convert this object into a hash.
      def to_hash
        hash = {}

        instance_variables.each do |var|
          key = var.to_s.delete("@").to_sym
          val = instance_variable_get(var)

          if authlete_model_simple_attribute?(key) or val.nil?
            hash[key] = val
          elsif val.kind_of?(Array)
            hash[key] = val.map { |element| element.to_hash }
          end
        end

        hash
      end
    end
  end
end