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
      class BackchannelAuthenticationCompleteResponse < Authlete::Model::Result

        attr_accessor :action

        attr_accessor :responseContent
        alias_method  :response_content,  :responseContent
        alias_method  :response_content=, :responseContent=

        attr_accessor :clientId
        alias_method  :client_id,  :clientId
        alias_method  :client_id=, :clientId=

        attr_accessor :clientIdAlias
        alias_method  :client_id_alias,  :clientIdAlias
        alias_method  :client_id_alias=, :clientIdAlias=

        attr_accessor :clientIdAliasUsed
        alias_method  :client_id_alias_used,  :clientIdAliasUsed
        alias_method  :client_id_alias_used=, :clientIdAliasUsed=

        attr_accessor :clientName
        alias_method  :client_name,  :clientName
        alias_method  :client_name=, :clientName=

        attr_accessor :deliveryMethod
        alias_method  :delivery_method,  :deliveryMethod
        alias_method  :delivery_method=, :deliveryMethod=

        attr_accessor :clientNotificationEndpoint
        alias_method  :client_notification_endpoint,  :clientNotificationEndpoint
        alias_method  :client_notification_endpoint=, :clientNotificationEndpoint=

        attr_accessor :clientNotificationToken
        alias_method  :client_notification_token,  :clientNotificationToken
        alias_method  :client_notification_token=, :clientNotificationToken=

        attr_accessor :authReqId
        alias_method  :auth_req_id,  :authReqId
        alias_method  :auth_req_id=, :authReqId=

        attr_accessor :accessToken
        alias_method  :access_token,  :accessToken
        alias_method  :access_token=, :accessToken=

        attr_accessor :refreshToken
        alias_method  :refresh_token,  :refreshToken
        alias_method  :refresh_token=, :refreshToken=

        attr_accessor :idToken
        alias_method  :id_token,  :idToken
        alias_method  :id_token=, :idToken=

        attr_accessor :accessTokenDuration
        alias_method  :access_token_duration,  :accessTokenDuration
        alias_method  :access_token_duration=, :accessTokenDuration=

        attr_accessor :refreshTokenDuration
        alias_method  :refresh_token_duration,  :refreshTokenDuration
        alias_method  :refresh_token_duration=, :refreshTokenDuration=

        attr_accessor :idTokenDuration
        alias_method  :id_token_duration,  :idTokenDuration
        alias_method  :id_token_duration=, :idTokenDuration=

        attr_accessor :jwtAccessToken
        alias_method  :jwt_access_token,  :jwtAccessToken
        alias_method  :jwt_access_token=, :jwtAccessToken=

        attr_accessor :resources

        private

        def defaults
          super.merge(
            action:                     nil,
            responseContent:            nil,
            clientId:                   0,
            clientIdAlias:              nil,
            clientIdAliasUsed:          false,
            clientName:                 nil,
            clientAuthMethod:           nil,
            deliveryMethod:             nil,
            clientNotificationToken:    nil,
            clientNotificationEndpoint: nil,
            authReqId:                  nil,
            accessToken:                nil,
            refreshToken:               nil,
            idToken:                    nil,
            accessTokenDuration:        0,
            refreshTokenDuration:       0,
            idTokenDuration:            0,
            jwtAccessToken:             nil,
            resources:                  nil
          )
        end

        def set_params(hash)
          super(hash)

          @action                     = hash[:action]
          @responseContent            = hash[:responseContent]
          @clientId                   = hash[:clientId]
          @clientIdAlias              = hash[:clientIdAlias]
          @clientIdAliasUsed          = hash[:clientIdAliasUsed]
          @clientName                 = hash[:clientName]
          @clientAuthMethod           = hash[:clientAuthMethod]
          @deliveryMethod             = hash[:deliveryMethod]
          @clientNotificationToken    = hash[:clientNotificationToken]
          @clientNotificationEndpoint = hash[:clientNotificationEndpoint]
          @authReqId                  = hash[:authReqId]
          @accessToken                = hash[:accessToken]
          @refreshToken               = hash[:refreshToken]
          @idToken                    = hash[:idToken]
          @accessTokenDuration        = hash[:accessTokenDuration]
          @refreshTokenDuration       = hash[:refreshTokenDuration]
          @idTokenDuration            = hash[:idTokenDuration]
          @jwtAccessToken             = hash[:jwtAccessToken]
          @resources                  = hash[:resources]
        end
      end
    end
  end
end
