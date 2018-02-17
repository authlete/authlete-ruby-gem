# :nodoc:
#
# Copyright (C) 2014-2015 Authlete, Inc.
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
      # == Authlete::Model::Response::TokenUpdateResponse class
      #
      # A class that represents a response from Authlete's
      # /api/auth/token/update API.
      class TokenUpdateResponse < Authlete::Model::Result
        # The next action which the caller of the API should take next.
        # (String)
        attr_accessor :action

        # The access token which has been specified by the request. (String)
        attr_accessor :accessToken
        alias_method  :access_token,  :accessToken
        alias_method  :access_token=, :accessToken=

        # The date at which the access token will expire. (Integer)
        attr_accessor :accessTokenExpiresAt
        alias_method  :access_token_expires_at,  :accessTokenExpiresAt
        alias_method  :access_token_expires_at=, :accessTokenExpiresAt=

        # Extra properties associated with the access token. (Property array)
        attr_accessor :properties

        # The scopes which is associated with the access token. (String array)
        attr_accessor :scopes

        # The constructor which takes a hash that represents a JSON response
        # from /api/auth/token/update API.
        def initialize(hash = {})
          super(hash)

          @action               = extract_value(hash, :action)
          @accessToken          = extract_value(hash, :accessToken)
          @accessTokenExpiresAt = extract_integer_value(hash, :accessTokenExpiresAt)
          @properties           = extract_array_value(hash, :scopes) do |element|
            Authlete::Model::Property.parse(element)
          end
          @scopes               = extract_value(hash, :scopes)
        end
      end
    end
  end
end