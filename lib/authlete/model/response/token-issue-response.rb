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
      class TokenIssueResponse < Authlete::Model::Result
        include Authlete::Utility

        attr_accessor :action

        attr_accessor :responseContent
        alias_method  :response_content,  :responseContent
        alias_method  :response_content=, :responseContent=

        attr_accessor :accessToken
        alias_method  :access_token,  :accessToken
        alias_method  :access_token=, :accessToken=

        attr_accessor :accessTokenExpiresAt
        alias_method  :access_token_expires_at,  :accessTokenExpiresAt
        alias_method  :access_token_expires_at=, :accessTokenExpiresAt=

        attr_accessor :accessTokenDuration
        alias_method  :access_token_duration,  :accessTokenDuration
        alias_method  :access_token_duration=, :accessTokenDuration=

        attr_accessor :refreshToken
        alias_method  :refresh_token,  :refreshToken
        alias_method  :refresh_token=, :refreshToken=

        attr_accessor :refreshTokenExpiresAt
        alias_method  :refresh_token_expires_at,  :refreshTokenExpiresAt
        alias_method  :refresh_token_expires_at=, :refreshTokenExpiresAt=

        attr_accessor :refreshTokenDuration
        alias_method  :refresh_token_duration,  :refreshTokenDuration
        alias_method  :refresh_token_duration=, :refreshTokenDuration=

        attr_accessor :clientId
        alias_method  :client_id, :clientId
        alias_method  :client_id=, :clientId=

        attr_accessor :clientIdAlias
        alias_method  :client_id_alias,  :clientIdAlias
        alias_method  :client_id_alias=, :clientIdAlias=

        attr_accessor :clientIdAliasUsed
        alias_method  :client_id_alias_used,  :clientIdAliasUsed
        alias_method  :client_id_alias_used=, :clientIdAliasUsed=

        attr_accessor :subject

        attr_accessor :scopes

        attr_accessor :properties

        attr_accessor :jwtAccessToken
        alias_method  :jwt_access_token,  :jwtAccessToken
        alias_method  :jwt_access_token=, :jwtAccessToken=

        attr_accessor :accessTokenResources
        alias_method  :access_token_resources,  :accessTokenResources
        alias_method  :access_token_resources=, :accessTokenResources=

        private

        def defaults
          super.merge(
            action:                nil,
            responseContent:       nil,
            accessToken:           nil,
            accessTokenExpiresAt:  0,
            accessTokenDuration:   0,
            refreshToken:          nil,
            refreshTokenExpiresAt: 0,
            refreshTokenDuration:  0,
            clientId:              0,
            clientIdAlias:         nil,
            clientIdAliasUsed:     false,
            subject:               nil,
            scopes:                nil,
            properties:            nil,
            jwtAccessToken:        nil,
            accessTokenResources:  nil
          )
        end

        def set_params(hash)
          super(hash)

          @action                = hash[:action]
          @responseContent       = hash[:responseContent]
          @accessToken           = hash[:accessToken]
          @accessTokenExpiresAt  = hash[:accessTokenExpiresAt]
          @accessTokenDuration   = hash[:accessTokenDuration]
          @refreshToken          = hash[:refreshToken]
          @refreshTokenExpiresAt = hash[:refreshTokenExpiresAt]
          @refreshTokenDuration  = hash[:refreshTokenDuration]
          @clientId              = hash[:clientId]
          @clientIdAlias         = hash[:clientIdAlias]
          @clientIdAliasUsed     = hash[:clientIdAliasUsed]
          @subject               = hash[:subject]
          @scopes                = hash[:scopes]
          @properties            = get_parsed_array(hash[:properties]) { |e| Authlete::Model::Property.parse(e) }
          @jwtAccessToken        = hash[:jwtAccessToken]
          @accessTokenResources  = hash[:accessTokenResources]
        end
      end
    end
  end
end
