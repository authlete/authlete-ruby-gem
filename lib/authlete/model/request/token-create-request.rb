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
    module Request
      # == Authlete::Model::Request::TokenCreateRequest class
      #
      # This class represents a request to Authlete's /api/auth/token/create API.
      class TokenCreateRequest < Authlete::Model::Hashable
        # The grant type for a newly created access token. One of the following.
        # "REFRESH_TOKEN" is not allowed.
        #
        #   "AUTHORIZATION_CODE"
        #   "IMPLICIT"
        #   "PASSWORD"
        #   "CLINET_CREDENTIALS"
        #
        # When "grantType" is either "IMPLICIT" or "CLIENT_CREDENTIALS", a
        # refresh token is not issued. (String)
        attr_accessor :grantType
        alias_method  :grant_type,  :grantType
        alias_method  :grant_type=, :grantType=

        # The ID of the client application which will be associated with a
        # newly created access token. (Integer)
        attr_accessor :clientId
        alias_method  :client_id, :clientId
        alias_method  :client_id=, :clientId=

        # The subject (= unique identifier) of the user who will be associated
        # with a newly created access token. This parameter is required unless
        # the grant type is CLIENT_CREDENTIALS. (String)
        attr_accessor :subject

        # The scopes which will be associated with a newly created access token.
        # Scopes that are not supported by the service cannot be specified and
        # requesting them will cause an error. (String array)
        attr_accessor :scopes

        # The duration of a newly created access token in seconds. If the value
        # is 0, the duration is determined according to the settings of the
        # service. (Integer)
        attr_accessor :accessTokenDuration
        alias_method  :access_token_duration,  :accessTokenDuration
        alias_method  :access_token_duration=, :accessTokenDuration=

        # The duration of a newly created refresh token in seconds. If the value
        # is 0, the duration is determined according to the settings of the
        # service.
        # A refresh token is not created (1) if the service does not support
        # "REFRESH_TOKEN", or (2) if the specified grant type is either "IMPLICIT"
        # or "CLIENT_CREDENTIALS". (Integer)
        attr_accessor :refreshTokenDuration
        alias_method  :refresh_token_duration,  :refreshTokenDuration
        alias_method  :refresh_token_duration=, :refreshTokenDuration=

        # Extra properties to associate with a newly created access token.
        # (Property array)
        attr_accessor :properties

        # A boolean request parameter which indicates whether to emulate that
        # the client ID alias is used instead of the original numeric client
        # ID when a new access token is created.
        # This has an effect only on the value of the "aud" claim in a response
        # from UserInfo endpoint. When you access the UserInfo endpoint
        # (which is expected to be implemented using Authlete's /api/auth/userinfo
        # API and /api/auth/userinfo/issue API) with an access token which
        # has been created using Authlete's /api/auth/token/create API with
        # this property (clientIdAliasUsed) "true", the client ID alias is used
        # as the value of the "aud" claim in a response from the UserInfo endpoint.
        # Note that if a client ID alias is not assigned to the client when
        # Authlete's /api/auth/token/create API is called, this property
        # (clientIdAliasUsed) has no effect (it is always regarded as "false").
        # (String)
        attr_accessor :clientIdAlias
        alias_method  :client_id_alias,  :clientIdAlias
        alias_method  :client_id_alias=, :clientIdAlias=

        # The value of the new access token.
        # The /api/auth/token/create API generates an access token. Therefore,
        # callers of the API do not have to specify values of newly created
        # access tokens. However, in some cases, for example, if you want to
        # migrate existing access tokens from an old system to Authlete, you
        # may want to specify values of access tokens. In such a case, you
        # can specify the value of a newly created access token by passing
        # a non-nil value as the value of accessToken request parameter.
        # The implementation of the /api/auth/token/create uses the value of
        # the accessToken request parameter instead of generating a new value
        # when the request parameter holds a non-nil value.
        # Note that if the hash value of the specified access token already
        # exists in Authlete's database, the access token cannot be inserted
        # and the /api/auth/token/create API will report an error.
        # (String)
        attr_accessor :accessToken
        alias_method  :access_token,  :accessToken
        alias_method  :access_token=, :accessToken=

        # The value of the new refresh token.
        # The /api/auth/token/create API may generate a refresh token. Therefore,
        # callers of the API do not have to specify values of newly created
        # refresh tokens. However, in some cases, for example, if you want
        # to migrate existing refresh tokens from an old system to Authlete,
        # you may want to specify values of refresh tokens. In such a case,
        # you can specify the value of a newly created refresh token by passing
        # a non-nil value as the value of refreshToken request parameter.
        # The implementation of the /api/auth/token/create uses the value of
        # the refreshToken request parameter instead of generating a new value
        # when the request parameter holds a non-nil value.
        # Note that if the hash value of the specified refresh token already
        # exists in Authlete's database, the refresh token cannot be inserted
        # and the /api/auth/token/create API will report an error.
        # (String)
        attr_accessor :refreshToken
        alias_method  :refresh_token,  :refreshToken
        alias_method  :refresh_token=, :refreshToken=

        private

        # Integer attributes.
        INTEGER_ATTRIBUTES = ::Set.new([ :accessTokenDuration, :clientId, :refreshTokenDuration ])

        # String attributes.
        STRING_ATTRIBUTES = ::Set.new([ :accessToken, :refreshToken, :grantType, :subject, :clientIdAlias ])

        # String array attributes.
        STRING_ARRAY_ATTRIBUTES = ::Set.new([ :scopes ])

        # Mapping from snake cases to camel cases.
        SNAKE_TO_CAMEL = {
          :access_token           => :accessToken,
          :access_token_duration  => :accessTokenDuration,
          :client_id              => :clientId,
          :client_id_alias        => :clientIdAlias,
          :grant_type             => :grantType,
          :refresh_token          => :refreshToken,
          :refresh_token_duration => :refreshTokenDuration
        }

        # The constructor which takes a hash that represents a JSON request to
        # Authlete's /api/auth/token/create API.
        def initialize(hash = nil)
          # Set default values to integer attributes.
          INTEGER_ATTRIBUTES.each do |attr|
            send("#{attr}=", 0)
          end

          # Set default values to string attributes.
          STRING_ATTRIBUTES.each do |attr|
            send("#{attr}=", nil)
          end

          # Set default values to string array attributes.
          STRING_ARRAY_ATTRIBUTES.each do |attr|
            send("#{attr}=", nil)
          end

          @properties = nil

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
          STRING_ATTRIBUTES.include?(key) or
          STRING_ARRAY_ATTRIBUTES.include?(key)
        end

        def authlete_model_update(hash)
          return if hash.nil?

          hash.each do |key, value|
            key = authlete_model_convert_key(key)

            if authlete_model_simple_attribute?(key)
              send("#{key}=", value)
            elsif key == :properties
              @properties = get_parsed_array(value) do |element|
                Authlete::Model::Property.parse(element)
              end
            end
          end

          self
        end

        public

        # Construct an instance from the given hash.
        #
        # If the given argument is nil or is not a Hash, nil is returned.
        # Otherwise, TokenCreateRequest.new(hash) is returned.
        def self.parse(hash)
          if hash.nil? or (hash.kind_of?(Hash) == false)
            return nil
          end

          return TokenCreateRequest.new(hash)
        end

        # Convert this object into a hash.
        def to_hash
          hash = {}

          instance_variables.each do |var|
            key = var.to_s.delete("@").to_sym
            val = instance_variable_get(var)

            if authlete_model_simple_attribute?(key) or val.nil?
              hash[key] = val
            elsif key == :properties
              hash[key] = val.map { |element| element.to_hash }
            end
          end

          hash
        end
      end
    end
  end
end