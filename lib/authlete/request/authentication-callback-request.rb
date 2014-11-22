# :nodoc:
#
# Copyright (C) 2014 Authlete, Inc.
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
  module Request
    # == Authlete::Request::AuthenticationCallbackRequest class
    #
    # This class represents a request to an authentication callback endpoint.
    class AuthenticationCallbackRequest
      include Authlete::Utility

      # The API key of the service.
      attr_accessor :service_api_key

      # The ID of the client application which has triggered the authentication
      # callback request.
      attr_accessor :client_id

      # The login ID that the end-user input to the login ID field.
      attr_accessor :id

      # The password that the end-user input to the password field.
      attr_accessor :password

      # Names of requested claims (string array).
      attr_accessor :claims

      # Names of requested claim locales (string array). The values come
      # from 'claims_locales' request parameter of an authorization request.
      attr_accessor :claimsLocales

      # The constructor which takes a hash that represents a JSON request
      # to an authentication callback endpoint.
      def initialize(hash = {})
        @service_api_key = extract_value(hash, :serviceApiKey)
        @client_id       = extract_value(hash, :clientId)
        @id              = extract_value(hash, :id)
        @password        = extract_value(hash, :password)
        @claims          = extract_value(hash, :claims)
        @claimsLocales   = extract_value(hash, :claimsLocales)
      end

      # Parse a JSON string which represents a request to an authentication
      # callback endpoint and generate an instance of AuthenticationCallbackRequest.
      def self.parse(json)
        AuthenticationCallbackRequest.new(JSON.parse(json))
      end
    end
  end
end
