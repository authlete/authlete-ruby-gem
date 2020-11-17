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
      class DeviceVerificationResponse < Authlete::Model::Result
        include Authlete::Utility

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

        attr_accessor :scopes

        attr_accessor :clientNames
        alias_method  :client_names,  :clientNames
        alias_method  :client_names=, :clientNames=

        attr_accessor :acrs

        attr_accessor :expiresAt
        alias_method  :expires_at,  :expiresAt
        alias_method  :expires_at=, :expiresAt=

        attr_accessor :resources

        private

        def defaults
          super.merge(
            action:            nil,
            responseContent:   nil,
            clientId:          0,
            clientIdAlias:     nil,
            clientIdAliasUsed: false,
            clientName:        nil,
            scopes:            nil,
            clientNames:       nil,
            acrs:              nil,
            expiresAt:         0,
            resources:         nil
          )
        end

        def set_params(hash)
          super(hash)

          @action            = hash[:action]
          @responseContent   = hash[:responseContent]
          @clientId          = hash[:clientId]
          @clientIdAlias     = hash[:clientIdAlias]
          @clientIdAliasUsed = hash[:clientIdAliasUsed]
          @clientName        = hash[:clientName]
          @scopes            = get_parsed_array(hash[:scopes]) { |e| Authlete::Model::Scope.parse(e) }
          @clientNames       = hash[:clientNames]
          @acrs              = hash[:acrs]
          @expiresAt         = hash[:expiresAt]
          @resources         = hash[:resources]
        end
      end
    end
  end
end
