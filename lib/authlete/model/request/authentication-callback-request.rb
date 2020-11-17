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


module Authlete
  module Model
    module Request
      class AuthenticationCallbackRequest < Authlete::Model::Request::Base

        attr_accessor :serviceApiKey
        alias_method  :service_api_key,  :serviceApiKey
        alias_method  :service_api_key=, :serviceApiKey=

        attr_accessor :clientId
        alias_method  :client_id,  :clientId
        alias_method  :client_id=, :clientId=

        attr_accessor :id

        attr_accessor :password

        attr_accessor :claims

        attr_accessor :claimsLocales
        alias_method  :claims_locales,  :claimsLocales
        alias_method  :claims_locales=, :claimsLocales=

        attr_accessor :sns

        attr_accessor :accessToken
        alias_method  :access_token,  :accessToken
        alias_method  :access_token=, :accessToken=

        attr_accessor :refreshToken
        alias_method  :refresh_token,  :refreshToken
        alias_method  :refresh_token=, :refreshToken=

        attr_accessor :expiresIn
        alias_method  :expires_in,  :expiresIn
        alias_method  :expires_in=, :expiresIn=

        attr_accessor :rawTokenResponse
        alias_method  :raw_token_response,  :rawTokenResponse
        alias_method  :raw_token_response=, :rawTokenResponse=

        private

        def defaults
          {
            serviceApiKey:    nil,
            clientId:         0,
            id:               nil,
            password:         nil,
            claims:           nil,
            claimsLocales:    nil,
            sns:              nil,
            accessToken:      nil,
            refreshToken:     nil,
            expiresIn:        0,
            rawTokenResponse: nil
          }
        end

        def set_params(hash)
          @serviceApiKey    = hash[:serviceApiKey]
          @clientId         = hash[:clientId]
          @id               = hash[:id]
          @password         = hash[:password]
          @claims           = hash[:claims]
          @claimsLocales    = hash[:claimsLocales]
          @sns              = hash[:sns]
          @accessToken      = hash[:accessToken]
          @refreshToken     = hash[:refreshToken]
          @expiresIn        = hash[:expiresIn]
          @rawTokenResponse = hash[:rawTokenResponse]
        end

        public

        def self.parse(json)
          AuthenticationCallbackRequest.new(JSON.parse(json))
        end
      end
    end
  end
end
