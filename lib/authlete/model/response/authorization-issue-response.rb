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
      class AuthorizationIssueResponse < Authlete::Model::Result

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

        attr_accessor :idToken
        alias_method  :id_token,  :idToken
        alias_method  :id_token=, :idToken=

        attr_accessor :authorizationCode
        alias_method  :authorization_code,  :authorizationCode
        alias_method  :authorization_code=, :authorizationCode=

        attr_accessor :jwtAccessToken
        alias_method  :jwt_access_token,  :jwtAccessToken
        alias_method  :jwt_access_token=, :jwtAccessToken=

        private

        def defaults
          super.merge(
            action:               nil,
            responseContent:      nil,
            accessToken:          nil,
            accessTokenExpiresAt: 0,
            accessTokenDuration:  0,
            idToken:              nil,
            authorizationCode:    nil,
            jwtAccessToken:       nil
          )
        end

        def set_params(hash = {})
          super(hash)

          @action               = hash[:action]
          @responseContent      = hash[:responseContent]
          @accessToken          = hash[:accessToken]
          @accessTokenExpiresAt = hash[:accessTokenExpiresAt]
          @accessTokenDuration  = hash[:accessTokenDuration]
          @idToken              = hash[:idToken]
          @authorizationCode    = hash[:authorizationCode]
          @jwtAccessToken       = hash[:jwtAccessToken]
        end
      end
    end
  end
end
