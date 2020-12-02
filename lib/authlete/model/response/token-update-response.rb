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
      class TokenUpdateResponse < Authlete::Model::Result

        attr_accessor :action

        attr_accessor :accessToken
        alias_method  :access_token,  :accessToken
        alias_method  :access_token=, :accessToken=

        attr_accessor :tokenType
        alias_method  :token_type,  :tokenType
        alias_method  :token_type=, :tokenType=

        attr_accessor :accessTokenExpiresAt
        alias_method  :access_token_expires_at,  :accessTokenExpiresAt
        alias_method  :access_token_expires_at=, :accessTokenExpiresAt=

        attr_accessor :scopes

        attr_accessor :properties

        private

        def defaults
          super.merge(
            action:               nil,
            accessToken:          nil,
            tokenType:            nil,
            accessTokenExpiresAt: 0,
            scopes:               nil,
            properties:           nil
          )
        end

        def set_params(hash)
          super(hash)

          @action               = hash[:action]
          @accessToken          = hash[:accessToken]
          @tokenType            = hash[:tokenType]
          @accessTokenExpiresAt = hash[:accessTokenExpiresAt]
          @scopes               = hash[:scopes]
          @properties           = get_parsed_array(hash[:properties]) { |e| Authlete::Model::Property.parse(e) }
        end
      end
    end
  end
end
