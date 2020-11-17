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
    module Response
      class AccessToken < Authlete::Model::Base
        include Authlete::Utility

        attr_accessor :accessTokenHash
        alias_method  :access_token_hash,  :accessTokenHash
        alias_method  :access_token_hash=, :accessTokenHash=

        attr_accessor :refreshTokenHash
        alias_method  :refresh_token_hash,  :refreshTokenHash
        alias_method  :refresh_token_hash=, :refreshTokenHash=

        attr_accessor :clientId
        alias_method  :client_id,  :clientId
        alias_method  :client_id=, :clientId=

        attr_accessor :subject

        attr_accessor :grantType
        alias_method  :grant_type,  :grantType
        alias_method  :grant_type=, :grantType=

        attr_accessor :scopes

        attr_accessor :accessTokenExpiresAt
        alias_method  :access_token_expires_at,  :accessTokenExpiresAt
        alias_method  :access_token_expires_at=, :accessTokenExpiresAt=

        attr_accessor :refreshTokenExpiresAt
        alias_method  :refresh_token_expires_at,  :refreshTokenExpiresAt
        alias_method  :refresh_token_expires_at=, :refreshTokenExpiresAt=

        attr_accessor :createdAt
        alias_method  :created_at,  :createdAt
        alias_method  :created_at=, :createdAt=

        attr_accessor :lastRefreshedAt
        alias_method  :last_refreshed_at,  :lastRefreshedAt
        alias_method  :last_refreshed_at=, :lastRefreshedAt=

        attr_accessor :properties

        private

        def defaults
          {
            accessTokenHash:       nil,
            refreshTokenHash:      nil,
            clientId:              0,
            subject:               nil,
            grantType:             nil,
            scopes:                nil,
            accessTokenExpiresAt:  0,
            refreshTokenExpiresAt: 0,
            createdAt:             0,
            lastRefreshedAt:       0,
            properties:            nil
          }
        end

        def set_params(hash)
          @accessTokenHash       = hash[:accessTokenHash]
          @refreshTokenHash      = hash[:refreshTokenHash]
          @clientId              = hash[:clientId]
          @subject               = hash[:subject]
          @grantType             = hash[:grantType]
          @scopes                = hash[:scopes]
          @accessTokenExpiresAt  = hash[:accessTokenExpiresAt]
          @refreshTokenExpiresAt = hash[:refreshTokenExpiresAt]
          @createdAt             = hash[:createdAt]
          @lastRefreshedAt       = hash[:lastRefreshedAt]
          @properties            = get_parsed_array(hash[:properties]) { |e| Authlete::Model::Property.parse(e) }
        end
      end
    end
  end
end
