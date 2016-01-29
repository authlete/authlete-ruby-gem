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
      # == Authlete::Model::Response::TokenResponse class
      #
      # This class represents a response from Authlete's /api/auth/token API.
      class TokenResponse < Authlete::Model::Result
        include Authlete::Utility
        # The next action that the service implementation should take.
        # (String)
        attr_accessor :action

        # The value of "password" request parameter.
        #
        # This value is non-null only when the value of
        # "grant_type" request parameter in the token request is "password".
        attr_accessor :password

        # The response content which can be used to generate a response
        # to the client application. The format of the value varies
        # depending on the value of "action". (String)
        attr_accessor :responseContent
        alias_method  :response_content,  :responseContent
        alias_method  :response_content=, :responseContent=

        # The ticket issued from Authlete's /api/auth/token endpoint.
        # This parameter is to be used as "ticket" request parameter
        # for /api/auth/token/issue API or /api/auth/token/fail API.
        # This parameter is non-null only when "action" is "PASSWORD PASSWORD".
        attr_accessor :ticket

        # The value of "username" request parameter.
        #
        # This value is non-null only when the value of
        # "grant_type" request parameter in the token request is "password".
        attr_accessor :username

        private

        # The constructor which takes a hash that represents a JSON response
        # from Authlete's /api/auth/token API.
        def initialize(hash = {})
          super(hash)

          @action          = extract_value(hash, :action)
          @responseContent = extract_value(hash, :responseContent)
          @password        = extract_value(hash, :password)
          @ticket          = extract_value(hash, :ticket)
          @username        = extract_value(hash, :username)
        end
      end
    end
  end
end