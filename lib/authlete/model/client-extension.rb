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
    class ClientExtension < Authlete::Model::Base
      include Authlete::Model::Hashable

      attr_accessor :requestableScopes
      alias_method  :requestable_scopes,  :requestableScopes
      alias_method  :requestable_scopes=, :requestableScopes=

      attr_accessor :requestableScopesEnabled
      alias_method  :requestable_scopes_enabled, :requestableScopesEnabled
      alias_method  :requestable_scopes_enabled=, :requestableScopesEnabled=

      attr_accessor :accessTokenDuration
      alias_method  :access_token_duration,  :accessTokenDuration
      alias_method  :access_token_duration=, :accessTokenDuration=

      attr_accessor :refreshTokenDuration
      alias_method  :refresh_token_duration,  :refreshTokenDuration
      alias_method  :refresh_token_duration=, :refreshTokenDuration=

      private

      def defaults
        {
          requestableScopes:        nil,
          requestableScopesEnabled: false,
          accessTokenDuration:      0,
          refreshTokenDuration:     0
        }
      end

      def set_params(hash)
        @requestableScopes        = hash[:requestableScopes]
        @requestableScopesEnabled = hash[:requestableScopesEnabled]
        @accessTokenDuration      = hash[:accessTokenDuration]
        @refreshTokenDuration     = hash[:refreshTokenDuration]
      end
    end
  end
end
