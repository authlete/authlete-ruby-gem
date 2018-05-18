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


require 'set'


module Authlete
  module Model
    class Client < Authlete::Model::Hashable
      include Authlete::Utility
      # The sequential number of the client application. (Integer)
      attr_accessor :number

      # The sequential number of the service of the client application.
      # (Integer)
      attr_accessor :serviceNumber
      alias_method  :service_number,  :serviceNumber
      alias_method  :service_number=, :serviceNumber=

      # The developer of the client application. (String)
      attr_accessor :developer

      # The client ID. (Integer)
      attr_accessor :clientId
      alias_method  :client_id, :clientId
      alias_method  :client_id=, :clientId=

      # Alias of client ID. (String)
      attr_accessor :clientIdAlias
      alias_method  :client_id_alias,  :clientIdAlias
      alias_method  :client_id_alias=, :clientIdAlias=

      # The flag which indicates whether the 'Client ID Alias' feature
      # is enabled or not. (Boolean)
      attr_accessor :clientIdAliasEnabled
      alias_method  :client_id_alias_enabled,  :clientIdAliasEnabled
      alias_method  :client_id_alias_enabled=, :clientIdAliasEnabled=

      # The client secret. (String)
      attr_accessor :clientSecret
      alias_method  :client_secret, :clientSecret
      alias_method  :client_secret=, :clientSecret=

      # The client type. (String)
      attr_accessor :clientType
      alias_method  :client_type,  :clientType
      alias_method  :client_type=, :clientType=

      # Redirect URIs that the client application uses to receive a response
      # from the authorization endpoint. (URI array)
      attr_accessor :redirectUris
      alias_method  :redirect_uris,  :redirectUris
      alias_method  :redirect_uris=, :redirectUris=

      # A string array of response types which the client application declares
      # that it will restrict itself to using (String array)
      attr_accessor :responseTypes
      alias_method  :response_types,  :responseTypes
      alias_method  :response_types=, :responseTypes=

      # A string array of grant types which the client application declares
      # that it will restrict itself to using. (String array)
      attr_accessor :grantTypes
      alias_method  :grant_types,  :grantTypes
      alias_method  :grant_types=, :grantTypes=

      # The application type. (String)
      attr_accessor :applicationType
      alias_method  :application_type,  :applicationType
      alias_method  :application_type=, :applicationType=

      # An array of email addresses of people responsible for the client application.
      # (String array)
      attr_accessor :contacts

      # The name of the client application. (String)
      attr_accessor :clientName
      alias_method  :client_name,  :clientName
      alias_method  :client_name=, :clientName=

      # Client names with language tags. (TaggedValue array)
      attr_accessor :clientNames
      alias_method  :client_names,  :clientNames
      alias_method  :client_names=, :clientNames=

      # The URL pointing to the logo image of the client application. (URI)
      attr_accessor :logoUri
      alias_method  :logo_uri,  :logoUri
      alias_method  :logo_uri=, :logoUri=

      # Logo image URLs with language tags. (TaggedValue array)
      attr_accessor :logoUris
      alias_method  :logo_uris,  :logoUris
      alias_method  :logo_uris=, :logoUris=

      # The URL pointing to the home page of the client application. (URI)
      attr_accessor :clientUri
      alias_method  :client_uri,  :clientUri
      alias_method  :client_uri=, :clientUri=

      # Home page URLs with language tags. (TaggedValue array)
      attr_accessor :clientUris
      alias_method  :client_uris,  :clientUris
      alias_method  :client_uris=, :clientUris=

      # The URL pointing to the page which describes the policy
      # as to how end-users' profile data are used. (URI)
      attr_accessor :policyUri
      alias_method  :policy_uri,  :policyUri
      alias_method  :policy_uri=, :policyUri=

      # URLs of policy pages with language tags. (TaggedValue array)
      attr_accessor :policyUris
      alias_method  :policy_uris,  :policyUris
      alias_method  :policy_uris=, :policyUris=

      # The URL pointing to the "Terms Of Service" page. (URI)
      attr_accessor :tosUri
      alias_method  :tos_uri,  :tosUri
      alias_method  :tos_uri=, :tosUri=

      # URLs of "Terms Of Service" pages with language tags.
      # (TaggedValue array)
      attr_accessor :tosUris
      alias_method  :tos_uris,  :tosUris
      alias_method  :tos_uris=, :tosUris=

      # The URL pointing to the JWK Set of the client application. (URI)
      attr_accessor :jwksUri
      alias_method  :jwks_uri,  :jwksUri
      alias_method  :jwks_uri=, :jwksUri=

      # The content of the JWK Set of the client application. (String)
      attr_accessor :jwks

      # The DN of the certificate used in mutual client authentication
      attr_accessor :tlsClientAuthSubjectDn
      alias_method  :tls_client_auth_subject_dn, :tlsClientAuthSubjectDn
      alias_method  :tls_client_auth_subject_dn=, :tlsClientAuthSubjectDn=

      # The sector identifier which is a URL starting with https. (URI)
      attr_accessor :sectorIdentifier
      alias_method  :sector_identifier,  :sectorIdentifier
      alias_method  :sector_identifier=, :sectorIdentifier=

      # The subject type that the client application requests. (URI)
      attr_accessor :subjectType
      alias_method  :subject_type,  :subjectType
      alias_method  :subject_type=, :subjectType=

      # The value of alg header parameter of JWS that the client application
      # requires the service to use for signing an ID token. (String)
      attr_accessor :idTokenSignAlg
      alias_method  :id_token_sign_alg,  :idTokenSignAlg
      alias_method  :id_token_sign_alg=, :idTokenSignAlg=

      # The value of alg header parameter of JWE that the client application
      # requires the service to use for encrypting an ID token. (String)
      attr_accessor :idTokenEncryptionAlg
      alias_method  :id_token_encryption_alg,  :idTokenEncryptionAlg
      alias_method  :id_token_encryption_alg=, :idTokenEncryptionAlg=

      # The value of enc header parameter of JWE that the client application
      # requires the service to use for encrypting an ID token. (String)
      attr_accessor :idTokenEncryptionEnc
      alias_method  :id_token_encryption_enc,  :idTokenEncryptionEnc
      alias_method  :id_token_encryption_enc=, :idTokenEncryptionEnc=

      # The value of alg header parameter of JWS that the client application
      # requires the service to use for signing the JWT returned from the user
      # info endpoint. One of the values listed in JWS Algorithm. (String)
      attr_accessor :userInfoSignAlg
      alias_method  :user_info_sign_alg,  :userInfoSignAlg
      alias_method  :user_info_sign_alg=, :userInfoSignAlg=

      # The value of alg header parameter of JWE that the client application
      # requires the service to use for encrypting the JWT returned from
      # the user info endpoint. (String)
      attr_accessor :userInfoEncryptionAlg
      alias_method  :user_info_encryption_alg,  :userInfoEncryptionAlg
      alias_method  :user_info_encryption_alg=, :userInfoEncryptionAlg=

      # The value of enc header parameter of JWE that the client application
      # requires the service to use for encrypting the JWT returned from
      # the user info endpoint. (String)
      attr_accessor :userInfoEncryptionEnc
      alias_method  :user_info_encryption_enc,  :userInfoEncryptionEnc
      alias_method  :user_info_encryption_enc=, :userInfoEncryptionEnc=

      # The value of alg header parameter of JWS that the client application
      # uses for signing a request object. (String)
      attr_accessor :requestSignAlg
      alias_method  :request_sign_alg,  :requestSignAlg
      alias_method  :request_sign_alg=, :requestSignAlg=

      # The value of alg header parameter of JWE that the client application
      # uses for encrypting a request object. (String)
      attr_accessor :requestEncryptionAlg
      alias_method  :request_encryption_alg,  :requestEncryptionAlg
      alias_method  :request_encryption_alg=, :requestEncryptionAlg=

      # The value of enc header parameter of JWE that the client application
      # uses for encrypting a request object. (String)
      attr_accessor :requestEncryptionEnc
      alias_method  :request_encryption_enc,  :requestEncryptionEnc
      alias_method  :request_encryption_enc=, :requestEncryptionEnc=

      # The client authentication method that the client application
      # declares that it uses at the token endpoint. (String)
      attr_accessor :tokenAuthMethod
      alias_method  :token_auth_method,  :tokenAuthMethod
      alias_method  :token_auth_method=, :tokenAuthMethod=

      # The value of alg header parameter of JWS which is used
      # for client authentication at the token endpoint. (String)
      attr_accessor :tokenAuthSignAlg
      alias_method  :token_auth_sign_alg,  :tokenAuthSignAlg
      alias_method  :token_auth_sign_alg=, :tokenAuthSignAlg=

      # The default maximum authentication age in seconds. (Integer)
      attr_accessor :defaultMaxAge
      alias_method  :default_max_age,  :defaultMaxAge
      alias_method  :default_max_age=, :defaultMaxAge=

      # The default ACRs (Authentication Context Class References). (String array)
      attr_accessor :defaultAcrs
      alias_method  :default_acrs,  :defaultAcrs
      alias_method  :default_acrs=, :defaultAcrs=

      # The flag showing the client application requires the auth_time claim
      # to be in an ID token. (Boolean)
      attr_accessor :authTimeRequired
      alias_method  :auth_time_required,  :authTimeRequired
      alias_method  :auth_time_required=, :authTimeRequired=

      # The URL which a third party can use to initiate a login by the client
      # application. (URI)
      attr_accessor :loginUri
      alias_method  :login_uri,  :loginUri
      alias_method  :login_uri=, :loginUri=

      # An array of URLs each of which points to a request object.
      # (URI array)
      attr_accessor :requestUris
      alias_method  :request_uris,  :requestUris
      alias_method  :request_uris=, :requestUris=

      # The description about the client application. At most 200 letters in unicode.
      # (String)
      attr_accessor :description

      # Descriptions about the client application with language tags. (TaggedValue array)
      attr_accessor :descriptions

      # The timestamp at which the client was created. (Integer)
      attr_accessor :createdAt
      alias_method  :created_at, :createdAt
      alias_method  :created_at=, :createdAt=

      # The timestamp at which the client was modified. (Integer)
      attr_accessor :modifiedAt
      alias_method  :modified_at, :modifiedAt
      alias_method  :modified_at=, :modifiedAt=

      # The flag that indicates whether the client uses TLS client certificate bound access tokens
      attr_accessor :tlsClientCertificateBoundAccessTokens
      alias_method  :tls_client_certificate_bound_access_tokens,  :tlsClientCertificateBoundAccessTokens
      alias_method  :tls_client_certificate_bound_access_tokens=, :tlsClientCertificateBoundAccessTokens=

      # The key ID of a JWK containing a self-signed certificate of this client.
      attr_accessor :selfSignedCertificateKeyId
      alias_method  :self_signed_certificate_key_id,  :selfSignedCertificateKeyId
      alias_method  :self_signed_certificate_key_id=, :selfSignedCertificateKeyId=

      # The special information that extends the client. (ClientExtension)
      attr_accessor :extension

      private

      # Integer attributes.
      INTEGER_ATTRIBUTES = ::Set.new([
        :number, :serviceNumber, :clientId, :defaultMaxAge, :createdAt, :modifiedAt
      ])

      # Boolean attributes.
      BOOLEAN_ATTRIBUTES = ::Set.new([
        :authTimeRequired, :clientIdAliasEnabled, :tlsClientCertificateBoundAccessTokens
      ])

      # String attributes.
      STRING_ATTRIBUTES = ::Set.new([
        :developer, :clientSecret, :clientType, :responseTypes, :applicationType,
        :clientIdAlias, :clientName, :logoUri, :clientUri, :policyUri, :tosUri,
        :jwksUri, :jwks, :sectorIdentifier, :subjectType, :idTokenSignAlg,
        :idTokenEncryptionAlg, :idTokenEncryptionEnc, :userInfoSignAlg, :userInfoEncryptionAlg,
        :userInfoEncryptionEnc, :requestSignAlg, :requestEncryptionAlg, :requestEncryptionEnc,
        :tokenAuthMethod, :tokenAuthSignAlg, :loginUri, :description, :tlsClientAuthSubjectDn,
        :selfSignedCertificateKeyId
      ])

      # String array attributes.
      STRING_ARRAY_ATTRIBUTES = ::Set.new([
        :redirectUris, :responseTypes, :grantTypes, :contacts, :defaultAcrs, :requestUris
      ])

      # Tagged value array atributes.
      TAGGED_VALUE_ARRAY_ATTRIBUTES = ::Set.new([
        :clientNames, :logoUris, :clientUris, :policyUris, :tosUris, :descriptions
      ])

      # Mapping from snake cases to camel cases.
      SNAKE_TO_CAMEL = {
        :service_number                              => :serviceNumber,
        :client_id                                   => :clientId,
        :client_id_alias                             => :clientIdAlias,
        :client_id_alias_enabled                     => :clientIdAliasEnabled,
        :client_secret                               => :clientSecret,
        :client_type                                 => :clientType,
        :redirect_uris                               => :redirectUris,
        :response_types                              => :responseTypes,
        :grant_types                                 => :grantTypes,
        :application_type                            => :applicationType,
        :client_name                                 => :clientName,
        :client_names                                => :clientNames,
        :logo_uri                                    => :logoUri,
        :logo_uris                                   => :logoUris,
        :client_uri                                  => :clientUri,
        :client_uris                                 => :clientUris,
        :policy_uri                                  => :policyUri,
        :policy_uris                                 => :policyUris,
        :tos_uri                                     => :tosUri,
        :tos_uris                                    => :tosUris,
        :jwks_uri                                    => :jwksUri,
        :sector_identifier                           => :sectorIdentifier,
        :subject_type                                => :subjectType,
        :id_token_sign_alg                           => :idTokenSignAlg,
        :id_token_encryption_alg                     => :idTokenEncryptionAlg,
        :id_token_encryption_enc                     => :idTokenEncryptionEnc,
        :user_info_sign_alg                          => :userInfoSignAlg,
        :user_info_encryption_alg                    => :userInfoEncryptionAlg,
        :user_info_encryption_enc                    => :userInfoEncryptionEnc,
        :request_sign_alg                            => :requestSignAlg,
        :request_encryption_alg                      => :requestEncryptionAlg,
        :request_encryption_enc                      => :requestEncryptionEnc,
        :token_auth_method                           => :tokenAuthMethod,
        :token_auth_sign_alg                         => :tokenAuthSignAlg,
        :default_max_age                             => :defaultMaxAge,
        :default_acrs                                => :defaultAcrs,
        :auth_time_required                          => :authTimeRequired,
        :login_uri                                   => :loginUri,
        :request_uris                                => :requestUris,
        :created_at                                  => :createdAt,
        :modified_at                                 => :modifiedAt,
        :tls_client_auth_subject_dn                  => :tlsClientAuthSubjectDn,
        :tls_client_certificate_bound_access_tokens  => :tlsClientCertificateBoundAccessTokens,
        :self_signed_certificate_key_id              => :selfSignedCertificateKeyId
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

        # Set default values to tagged value array attributes.
        TAGGED_VALUE_ARRAY_ATTRIBUTES.each do |attr|
          send("#{attr}=", nil)
        end

        @extension = nil

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
          elsif TAGGED_VALUE_ARRAY_ATTRIBUTES.include?(key)
            # Get an array consisting of "TaggedValue" objects.
            parsed = get_parsed_array(value) do |element|
              Authlete::Model::TaggedValue.parse(element)
            end

            send("#{key}=", parsed)
          elsif key == :extension
            @extension = Authlete::Model::ClientExtension.new(value)
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

        Client.new(hash)
      end

      # Set attribute values using the given hash.
      def update(hash)
        authlete_model_update?(hash)
      end

      # Convert this object into a hash.
      def to_hash
        hash = {}

        instance_variables.each do |var|
          key = var.to_s.delete("@").to_sym
          val = instance_variable_get(var)

          if authlete_model_simple_attribute?(key) or val.nil?
            hash[key] = val
          elsif TAGGED_VALUE_ARRAY_ATTRIBUTES.include?(key)
            hash[key] = val.map { |element| element.to_hash }
          elsif key == :extension
            # For attributes such as :extension
            hash[key] = val.to_hash
          end
        end

        hash
      end
    end
  end
end