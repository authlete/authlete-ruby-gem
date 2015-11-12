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


module Authlete
  module Model
    module Request
      # == Authlete::Model::Request::DeveloperAuthenticationCallbackRequest class
      #
      # This class represents a request to a developer authentication callback endpoint.
      class DeveloperAuthenticationCallbackRequest
        include Authlete::Utility
        # The API key of the service.
        attr_accessor :service_api_key

        # The login ID that the developer input to the login ID field.
        # When 'sns' attribute is not nil, this attribute holds the
        # subject (= unique identifier) of the developer in the SNS.
        attr_accessor :id

        # The password that the developer input to the password field.
        # If 'sns' property is nil, it is ensured that this attribute
        # is not nil. In such a case, authentication should be performed
        # on the pair of 'id' attribute and this 'password' attribute.
        # On the other hand, if 'sns' attribute is not nil, this attribute
        # has no meaning, because authentication has performed by the SNS.
        attr_accessor :password

        # The SNS which the developer used for social login.
        # For example, 'FACEBOOK'.
        attr_accessor :sns

        # The access token issued at the token endpoint of the SNS.
        attr_accessor :access_token

        # The refresh token issued along with the access token.
        attr_accessor :refresh_token

        # The duration of the access token.
        attr_accessor :expires_in

        # The raw content of the response from the token endpoint of the SNS.
        # Correct OAuth 2.0 implementations return 'application/json', but
        # Facebook returns 'application/x-www-form-url-encoded'.
        attr_accessor :raw_token_response

        # The constructor which takes a hash that represents a JSON request
        # to a developer authentication callback endpoint.
        def initialize(hash = {})
          @service_api_key    = extract_value(hash, :serviceApiKey)
          @id                 = extract_value(hash, :id)
          @password           = extract_value(hash, :password)
          @sns                = extract_value(hash, :sns)
          @access_token       = extract_value(hash, :accessToken)
          @refresh_token      = extract_value(hash, :refreshToken)
          @expires_in         = extract_integer_value(hash, :expiresIn)
          @raw_token_response = extract_value(hash, :rawTokenResponse)
        end

        # Parse a JSON string which represents a request to a developer
        # authentication callback endpoint and generate an instance of
        # DeveloperAuthenticationCallbackRequest.
        def self.parse(json)
          DeveloperAuthenticationCallbackRequest.new(JSON.parse(json))
        end
      end
    end
  end
end
