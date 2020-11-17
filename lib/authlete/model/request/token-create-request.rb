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
      class TokenCreateRequest < Authlete::Model::Request::Base
        include Authlete::Utility

        attr_accessor :grantType
        alias_method  :grant_type,  :grantType
        alias_method  :grant_type=, :grantType=

        attr_accessor :clientId
        alias_method  :client_id, :clientId
        alias_method  :client_id=, :clientId=

        attr_accessor :subject

        attr_accessor :scopes

        attr_accessor :accessTokenDuration
        alias_method  :access_token_duration,  :accessTokenDuration
        alias_method  :access_token_duration=, :accessTokenDuration=

        attr_accessor :refreshTokenDuration
        alias_method  :refresh_token_duration,  :refreshTokenDuration
        alias_method  :refresh_token_duration=, :refreshTokenDuration=

        attr_accessor :properties

        attr_accessor :clientIdAlias
        alias_method  :client_id_alias,  :clientIdAlias
        alias_method  :client_id_alias=, :clientIdAlias=

        attr_accessor :accessToken
        alias_method  :access_token,  :accessToken
        alias_method  :access_token=, :accessToken=

        attr_accessor :refreshToken
        alias_method  :refresh_token,  :refreshToken
        alias_method  :refresh_token=, :refreshToken=

        attr_accessor :accessTokenPersistent
        alias_method  :access_token_persistent,  :accessTokenPersistent
        alias_method  :access_token_persistent=, :accessTokenPersistent=

        attr_accessor :certificateThumbprint
        alias_method  :certificate_thumbprint,  :certificateThumbprint
        alias_method  :certificate_thumbprint=, :certificateThumbprint=

        attr_accessor :dpopKeyThumbprint
        alias_method  :dpop_key_thumbprint,  :dpopKeyThumbprint
        alias_method  :dpop_key_thumbprint=, :dpopKeyThumbprint=

        private

        def defaults
          {
            grantType:             nil,
            clientId:              0,
            subject:               nil,
            scopes:                nil,
            accessTokenDuration:   0,
            refreshTokenDuration:  0,
            properties:            nil,
            clientIdAlias:         nil,
            accessToken:           nil,
            refreshToken:          nil,
            accessTokenPersistent: false,
            certificateThumbprint: nil,
            dpopKeyThumbprint:     nil
          }
        end

        def set_params(hash)
          @grantType             = hash[:grantType]
          @clientId              = hash[:clientId]
          @subject               = hash[:subject]
          @scopes                = hash[:scopes]
          @accessTokenDuration   = hash[:accessTokenDuration]
          @refreshTokenDuration  = hash[:refreshTokenDuration]
          @properties            = get_parsed_array(hash[:properties]) { |e| Authlete::Model::Property.parse(e) }
          @clientIdAlias         = hash[:clientIdAlias]
          @accessToken           = hash[:accessToken]
          @refreshToken          = hash[:refreshToken]
          @accessTokenPersistent = hash[:accessTokenPersistent]
          @certificateThumbprint = hash[:certificateThumbprint]
          @dpopKeyThumbprint     = hash[:dpopKeyThumbprint]
        end

        def to_hash_value(key, var)
          raw_val = instance_variable_get(var)

          case key
            when :properties
              raw_val&.map { |e| e.to_hash }
            else
              raw_val
          end
        end
      end
    end
  end
end
