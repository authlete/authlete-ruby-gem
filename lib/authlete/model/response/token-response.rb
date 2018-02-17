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


module Authlete
  module Model
    module Response
      # == Authlete::Model::Response::TokenResponse class
      #
      # This class represents a response from Authlete's /api/auth/token API.
      class TokenResponse < Authlete::Model::Result
        include Authlete::Utility
        # The next action that the service implementation should take.
        # (String)
        attr_accessor :action

        # The response content which can be used to generate a response
        # to the client application. The format of the value varies
        # depending on the value of "action". (String)
        attr_accessor :responseContent
        alias_method  :response_content,  :responseContent
        alias_method  :response_content=, :responseContent=

        # The value of "username" request parameter.
        #
        # This value is non-nil only when the value of
        # "grant_type" request parameter in the token request is "password".
        attr_accessor :username

        # The value of "password" request parameter.
        #
        # This value is non-nil only when the value of
        # "grant_type" request parameter in the token request is "password".
        attr_accessor :password

        # The ticket issued from Authlete's /api/auth/token endpoint.
        # This parameter is to be used as "ticket" request parameter
        # for /api/auth/token/issue API or /api/auth/token/fail API.
        # This parameter is non-nil only when "action" is "PASSWORD PASSWORD".
        attr_accessor :ticket

        # The newly issued access token. (String)
        attr_accessor :accessToken
        alias_method  :access_token,  :accessToken
        alias_method  :access_token=, :accessToken=

        # The datetime at which the newly issued access token will expire.
        # The value is represented in milliseconds since the Unix epoch (1970-01-01).
        # (Integer)
        attr_accessor :accessTokenExpiresAt
        alias_method  :access_token_expires_at,  :accessTokenExpiresAt
        alias_method  :access_token_expires_at=, :accessTokenExpiresAt=

        # The duration of the newly issued access token in seconds. (Integer)
        attr_accessor :accessTokenDuration
        alias_method  :access_token_duration,  :accessTokenDuration
        alias_method  :access_token_duration=, :accessTokenDuration=

        # The newly issued refresh token. (String)
        attr_accessor :refreshToken
        alias_method  :refresh_token,  :refreshToken
        alias_method  :refresh_token=, :refreshToken=

        # The datetime at which the newly issued refresh token will expire.
        # The value is represented in milliseconds since the Unix epoch (1970-01-01).
        # (Integer)
        attr_accessor :refreshTokenExpiresAt
        alias_method  :refresh_token_expires_at,  :refreshTokenExpiresAt
        alias_method  :refresh_token_expires_at=, :refreshTokenExpiresAt=

        # The duration of the newly issued refresh token in seconds. (Integer)
        attr_accessor :refreshTokenDuration
        alias_method  :refresh_token_duration,  :refreshTokenDuration
        alias_method  :refresh_token_duration=, :refreshTokenDuration=

        # The newly issued ID token. Note that an ID token is issued from
        # a Token Endpoint only when the "response_type" request parameter
        # of the authorization request to an Authorization Endpoint has contained
        # "code" and the "scope" request parameter has contained "openid".
        # (String)
        attr_accessor :idToken
        alias_method  :id_token,  :idToken
        alias_method  :id_token=, :idToken=

        # The grant type of the token request. (String)
        attr_accessor :grantType
        alias_method  :grant_type,  :grantType
        alias_method  :grant_type=, :grantType=

        # The client ID. (Integer)
        attr_accessor :clientId
        alias_method  :client_id, :clientId
        alias_method  :client_id=, :clientId=

        # Alias of client ID. (String)
        attr_accessor :clientIdAlias
        alias_method  :client_id_alias,  :clientIdAlias
        alias_method  :client_id_alias=, :clientIdAlias=

        # The flag which indicates whether the client ID alias was used when
        # the token request was made. "true" if the client ID alias was used
        # when the token request was made. (Boolean)
        attr_accessor :clientIdAliasUsed
        alias_method  :client_id_alias_used,  :clientIdAliasUsed
        alias_method  :client_id_alias_used=, :clientIdAliasUsed=

        # The subject (= resource owner's ID) of the access token.
        # Even if an access token has been issued by the call of /api/auth/token API,
        # this parameter is "nil" if the flow of the token request was "Client Credentials Flow"
        # (grant_type=client_credentials) because it means the access token
        # is not associated with any specific end-user.
        # (String)
        attr_accessor :subject

        # The scopes covered by the access token.
        # (Scope array)
        attr_accessor :scopes

        # The extra properties associated with the access token.
        # This parameter is "nil" when no extra property is associated with
        # the issued access token.
        attr_accessor :properties

        private

        # The constructor which takes a hash that represents a JSON response
        # from Authlete's /api/auth/token API.
        def initialize(hash = {})
          super(hash)

          @action                = extract_value(hash, :action)
          @responseContent       = extract_value(hash, :responseContent)
          @username              = extract_value(hash, :username)
          @password              = extract_value(hash, :password)
          @ticket                = extract_value(hash, :ticket)
          @accessToken           = extract_value(hash, :accessToken)
          @accessTokenExpiresAt  = extract_integer_value(hash, :accessTokenExpiresAt)
          @accessTokenDuration   = extract_integer_value(hash, :accessTokenDuration)
          @refreshToken          = extract_value(hash, :refreshToken)
          @refreshTokenExpiresAt = extract_integer_value(hash, :refreshTokenExpiresAt)
          @refreshTokenDuration  = extract_integer_value(hash, :refreshTokenDuration)
          @idToken               = extract_value(hash, :idToken)
          @grantType             = extract_value(hash, :grantType)
          @clientId              = extract_integer_value(hash, :clientId)
          @clientIdAlias         = extract_value(hash, :clientIdAlias)
          @clientIdAliasUsed     = extract_boolean_value(hash, :clientIdAliasUsed)
          @subject               = extract_value(hash, :subject)
          @scopes                = extract_value(hash, :scopes)
          @properties            = extract_array_value(hash, :scopes) do |element|
            Authlete::Model::Property.parse(element)
          end
        end
      end
    end
  end
end