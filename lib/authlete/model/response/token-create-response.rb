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
      class TokenCreateResponse < Authlete::Model::Result

        attr_accessor :action

        attr_accessor :grantType
        alias_method  :grant_type,  :grantType
        alias_method  :grant_type=, :grantType=

        attr_accessor :clientId
        alias_method  :client_id,  :clientId
        alias_method  :client_id=, :clientId=

        attr_accessor :subject

        attr_accessor :scopes

        attr_accessor :accessToken
        alias_method  :access_token,  :accessToken
        alias_method  :access_token=, :accessToken=

        attr_accessor :tokenType
        alias_method  :token_type,  :tokenType
        alias_method  :token_type=, :tokenType=

        attr_accessor :expiresIn
        alias_method  :expires_in,  :expiresIn
        alias_method  :expires_in=, :expiresIn=

        attr_accessor :expiresAt
        alias_method  :expires_at,  :expiresAt
        alias_method  :expires_at=, :expiresAt=

        attr_accessor :refreshToken
        alias_method  :refresh_token,  :refreshToken
        alias_method  :refresh_token=, :refreshToken=

        attr_accessor :properties

        private

        def defaults
          super.merge(
            action:       nil,
            grantType:    nil,
            clientId:     0,
            subject:      nil,
            scopes:       nil,
            accessToken:  nil,
            tokenType:    nil,
            expiresIn:    0,
            expiresAt:    0,
            refreshToken: nil,
            properties:   nil
          )
        end

        def set_params(hash)
          super(hash)

          @action       = hash[:action]
          @grantType    = hash[:grantType]
          @clientId     = hash[:clientId]
          @subject      = hash[:subject]
          @scopes       = hash[:scopes]
          @accessToken  = hash[:accessToken]
          @tokenType    = hash[:tokenType]
          @expiresIn    = hash[:expiresIn]
          @expiresAt    = hash[:expiresAt]
          @refreshToken = hash[:refreshToken]
          @properties   = get_parsed_array(hash[:properties]) { |e| Authlete::Model::Property.parse(e) }
        end
      end
    end
  end
end
