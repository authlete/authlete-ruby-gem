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
      class TokenUpdateRequest < Authlete::Model::Request::Base
        include Authlete::Utility

        attr_accessor :accessToken
        alias_method  :access_token,  :accessToken
        alias_method  :access_token=, :accessToken=

        attr_accessor :accessTokenExpiresAt
        alias_method  :access_token_expires_at,  :accessTokenExpiresAt
        alias_method  :access_token_expires_at=, :accessTokenExpiresAt=

        attr_accessor :scopes

        attr_accessor :properties

        attr_accessor :certificateThumbprint
        alias_method  :certificate_thumbprint,  :certificateThumbprint
        alias_method  :certificate_thumbprint=, :certificateThumbprint=

        attr_accessor :dpopKeyThumbprint
        alias_method  :dpop_key_thumbprint,  :dpopKeyThumbprint
        alias_method  :dpop_key_thumbprint=, :dpopKeyThumbprint=

        private

        def defaults
          {
            accessToken:           nil,
            accessTokenExpiresAt:  0,
            scopes:                nil,
            properties:            nil,
            certificateThumbprint: nil,
            dpopKeyThumbprint:     nil
          }
        end

        def set_params(hash)
          @accessToken           = hash[:accessToken]
          @accessTokenExpiresAt  = hash[:accessTokenExpiresAt]
          @scopes                = hash[:scopes]
          @properties            = get_parsed_array(hash[:properties]) { |e| Authlete::Model::Property.parse(e) }
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
