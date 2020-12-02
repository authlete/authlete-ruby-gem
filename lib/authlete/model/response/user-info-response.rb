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
      class UserInfoResponse < Authlete::Model::Result

        attr_accessor :action

        attr_accessor :clientId
        alias_method  :client_id,  :clientId
        alias_method  :client_id=, :clientId=

        attr_accessor :subject

        attr_accessor :scopes

        attr_accessor :claims

        attr_accessor :token

        attr_accessor :responseContent
        alias_method  :response_content,  :responseContent
        alias_method  :response_content=, :responseContent=

        attr_accessor :properties

        attr_accessor :clientIdAlias
        alias_method  :client_id_alias,  :clientIdAlias
        alias_method  :client_id_alias=, :clientIdAlias=

        attr_accessor :clientIdAliasUsed
        alias_method  :client_id_alias_used,  :clientIdAliasUsed
        alias_method  :client_id_alias_used=, :clientIdAliasUsed=

        attr_accessor :userInfoClaims
        alias_method  :user_info_claims,  :userInfoClaims
        alias_method  :user_info_claims=, :userInfoClaims=

        private

        def defaults
          super.merge(
            action:            nil,
            clientId:          0,
            subject:           nil,
            scopes:            nil,
            claims:            nil,
            token:             nil,
            responseContent:   nil,
            properties:        nil,
            clientIdAlias:     nil,
            clientIdAliasUsed: false,
            userInfoClaims:    nil
          )
        end

        def set_params(hash)
          super(hash)

          @action            = hash[:action]
          @clientId          = hash[:clientId]
          @subject           = hash[:subject]
          @scopes            = hash[:scopes]
          @claims            = hash[:claims]
          @token             = hash[:token]
          @responseContent   = hash[:responseContent]
          @properties        = get_parsed_array(hash[:properties]) { |e| Authlete::Model::Property.parse(e) }
          @clientIdAlias     = hash[:clientIdAlias]
          @clientIdAliasUsed = hash[:clientIdAliasUsed]
          @userInfoClaims    = hash[:userInfoClaims]
        end
      end
    end
  end
end
