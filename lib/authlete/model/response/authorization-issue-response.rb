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
      # == Authlete::Model::Response::AuthorizationIssueResponse class
      #
      # This class represents a response from Authlete's /api/auth/authorization/issue API.
      class AuthorizationIssueResponse < Authlete::Model::Result
        # The next action that the service implementation should take.
        # (String)
        attr_accessor :action

        # The response content which can be used to generate a response
        # to the client application. The format of the value varies
        # depending on the value of "action". (String)
        attr_accessor :responseContent
        alias_method  :response_content,  :responseContent
        alias_method  :response_content=, :responseContent=

        # The newly issued access token. Note that an access token is issued
        # from an Authorization Endpoint only when "response_type" contains "token".
        # (String)
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

        # The newly issued ID token. Note that an ID token is issued from
        # an Authorization Endpoint only when "response_type" contains "id_token".
        # (String)
        attr_accessor :idToken
        alias_method  :id_token,  :idToken
        alias_method  :id_token=, :idToken=

        # The newly issued authorization code. Note that an authorization code
        # is issued only when "response_type" contains "code". (String)
        attr_accessor :authorizationCode
        alias_method  :authorization_code,  :authorizationCode
        alias_method  :authorization_code=, :authorizationCode=

        private

        # The constructor which takes a hash that represents a JSON response
        # from Authlete's /api/auth/authorization/issue API.
        def initialize(hash = {})
          super(hash)

          @action               = extract_value(hash, :action)
          @responseContent      = extract_value(hash, :responseContent)
          @accessToken          = extract_value(hash, :accessToken)
          @accessTokenExpiresAt = extract_integer_value(hash, :accessTokenExpiresAt)
          @accessTokenDuration  = extract_integer_value(hash, :accessTokenDuration)
          @idToken              = extract_value(hash, :idToken)
          @authorizationCode    = extract_value(hash, :authorizationCode)
        end
      end
    end
  end
end