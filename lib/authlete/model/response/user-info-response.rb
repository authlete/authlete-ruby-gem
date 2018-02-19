# :nodoc:
#
# Copyright (C) 2014-2018 Authlete, Inc.
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
      # == Authlete::Model::Response::UserInfoResponse class
      #
      # A class that represents a response from Authlete's
      # /api/auth/userinfo API.
      class UserInfoResponse < Authlete::Model::Result
        # The next action which the caller of the API should take next.
        # (String)
        attr_accessor :action

        # The list of claims that the client application requests to be
        # embedded in the ID token. (String array)
        attr_accessor :claims

        # The ID of the client application which is associated with
        # the access token. (Integer)
        attr_accessor :clientId
        alias_method  :client_id,  :clientId
        alias_method  :client_id=, :clientId=

        # The client ID alias when the authorization request for the access
        # token was made. (String)
        attr_accessor :clientIdAlias
        alias_method  :client_id_alias,  :clientIdAlias
        alias_method  :client_id_alias=, :clientIdAlias=

        # The flag which indicates whether the client ID alias was used when
        # the authorization request or the token request for the access token
        # was made. (Boolean)
        attr_accessor :clientIdAliasUsed
        alias_method  :client_id_alias_used,  :clientIdAliasUsed
        alias_method  :client_id_alias_used=, :clientIdAliasUsed=

        # The content of the error response that the service implementation
        # should return to the client application. (String)
        attr_accessor :response_content
        alias_method  :response_content,  :responseContent
        alias_method  :response_content=, :responseContent=

        # The scopes covered by the access token. (String array)
        attr_accessor :scopes

        # The subject (= resource owner's ID). (String)
        attr_accessor :subject

        # The access token that came along with the userinfo request. (String)
        attr_accessor :token

        # The constructor which takes a hash that represents a JSON response
        # from /api/auth/introspection API.
        def initialize(hash = {})
          super(hash)

          @action            = extract_value(hash, :action)
          @clientId          = extract_value(hash, :clientId)
          @clientIdAlias     = extract_value(hash, :clientIdAlias)
          @clientIdAliasUsed = extract_boolean_value(hash, :clientIdAliasUsed)
          @responseContent   = extract_value(hash, :responseContent)
          @scopes            = extract_value(hash, :scopes)
          @subject           = extract_value(hash, :subject)
          @token             = extract_value(hash, :token)
        end
      end
    end
  end
end