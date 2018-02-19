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


module Authlete
  module Model
    module Response
      # == Authlete::Model::Response::TokenCreateResponse class
      #
      # A class that represents a response from Authlete's
      # /api/auth/token/create API.
      class TokenCreateResponse < Authlete::Model::Result
        # The next action which the caller of the API should take next.
        # (String)
        attr_accessor :action

        # The newly issued access token. (String)
        attr_accessor :accessToken
        alias_method  :access_token,  :accessToken
        alias_method  :access_token=, :accessToken=

        # The ID of the client application which is associated with the access
        # token. (Integer)
        attr_accessor :clientId
        alias_method  :client_id,  :clientId
        alias_method  :client_id=, :clientId=

        # The time at which the access token expires. (Integer)
        attr_accessor :expiresAt
        alias_method  :expires_at,  :expiresAt
        alias_method  :expires_at=, :expiresAt=

        # The duration of the newly issued access token in seconds. (Integer)
        attr_accessor :expires_in
        alias_method  :expires_in,  :expiresIn
        alias_method  :expires_in=, :expiresIn=

        # The grant type for the newly issued access token. (String)
        attr_accessor :grantType
        alias_method  :grant_type,  :grantType
        alias_method  :grant_type=, :grantType=

        # Extra properties associated with the access token. (Property array)
        attr_accessor :properties

        # The newly issued refresh token. (String)
        attr_accessor :refreshToken
        alias_method  :refresh_token,  :refreshToken
        alias_method  :refresh_token=, :refreshToken=

        # The scopes which is associated with the access token. (String array)
        attr_accessor :scopes

        # The subject which is associated with the access token.
        # This is <tt>nil</tt> if the access token was created
        # through {Client Credentials Flow}[https://tools.ietf.org/html/rfc6749#section-4.4].
        # (String)
        attr_accessor :subject

        # The token type of the access token. (String)
        attr_accessor :tokenType
        alias_method  :token_type,  :tokenType
        alias_method  :token_type=, :tokenType=

        # The constructor which takes a hash that represents a JSON response
        # from /api/auth/token/create API.
        def initialize(hash = {})
          super(hash)

          @action       = extract_value(hash, :action)
          @accessToken  = extract_value(hash, :accessToken)
          @clientId     = extract_integer_value(hash, :clientId)
          @expiresAt    = extract_integer_value(hash, :expiresAt)
          @expiresIn    = extract_integer_value(hash, :expiresIn)
          @grantType    = extract_value(hash, :grantType)
          @properties   = extract_array_value(hash, :scopes) do |element|
            Authlete::Model::Property.parse(element)
          end
          @refreshToken = extract_value(hash, :refreshToken)
          @scopes       = extract_value(hash, :scopes)
          @subject      = extract_value(hash, :subject)
          @tokenType    = extract_value(hash, :tokenType)
        end
      end
    end
  end
end