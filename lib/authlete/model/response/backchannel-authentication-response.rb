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
      class BackchannelAuthenticationResponse < Authlete::Model::Result
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

        attr_accessor :clientAuthMethod
        alias_method  :client_auth_method,  :clientAuthMethod
        alias_method  :client_auth_method=, :clientAuthMethod=

        attr_accessor :deliveryMethod
        alias_method  :delivery_method,  :deliveryMethod
        alias_method  :delivery_method=, :deliveryMethod=

        attr_accessor :scopes

        attr_accessor :clientNames
        alias_method  :client_names,  :clientNames
        alias_method  :client_names=, :clientNames=

        attr_accessor :clientNotificationToken
        alias_method  :client_notification_token,  :clientNotificationToken
        alias_method  :client_notification_token=, :clientNotificationToken=

        attr_accessor :acrs

        attr_accessor :hintType
        alias_method  :hint_type,  :hintType
        alias_method  :hint_type=, :hintType=

        attr_accessor :hint

        attr_accessor :sub

        attr_accessor :bindingMessage
        alias_method  :binding_message,  :bindingMessage
        alias_method  :binding_message=, :bindingMessage=

        attr_accessor :userCode
        alias_method  :user_code,  :userCode
        alias_method  :user_code=, :userCode=

        attr_accessor :userCodeRequired
        alias_method  :user_code_required,  :userCodeRequired
        alias_method  :user_code_required=, :userCodeRequired=

        attr_accessor :requestedExpiry
        alias_method  :requested_expiry,  :requestedExpiry
        alias_method  :requested_expiry=, :requestedExpiry=

        attr_accessor :requestContext
        alias_method  :request_context,  :requestContext
        alias_method  :request_context=, :requestContext=

        attr_accessor :resources

        attr_accessor :warnings

        attr_accessor :ticket

        private

        def defaults()
          super.merge(
            action:                  nil,
            responseContent:         nil,
            clientId:                0,
            clientIdAlias:           nil,
            clientIdAliasUsed:       false,
            clientName:              nil,
            clientAuthMethod:        nil,
            deliveryMethod:          nil,
            scopes:                  nil,
            clientNames:             nil,
            clientNotificationToken: nil,
            acrs:                    nil,
            hintType:                nil,
            hint:                    nil,
            sub:                     nil,
            bindingMessage:          nil,
            userCode:                nil,
            userCodeRequired:        false,
            requestedExpiry:         0,
            requestContext:          nil,
            resources:               nil,
            warnings:                nil,
            ticket:                  nil
          )
        end

        def set_params(hash)
          super(hash)

          @action                  = hash[:action]
          @responseContent         = hash[:responseContent]
          @clientId                = hash[:clientId]
          @clientIdAlias           = hash[:clientIdAlias]
          @clientIdAliasUsed       = hash[:clientIdAliasUsed]
          @clientName              = hash[:clientName]
          @clientAuthMethod        = hash[:clientAuthMethod]
          @deliveryMethod          = hash[:deliveryMethod]
          @scopes                  = get_parsed_array(hash[:scopes]) { |e| Authlete::Model::Scope.parse(e) }
          @clientNames             = hash[:clientNames]
          @clientNotificationToken = hash[:clientNotificationToken]
          @acrs                    = hash[:acrs]
          @hintType                = hash[:hintType]
          @hint                    = hash[:hint]
          @sub                     = hash[:sub]
          @bindingMessage          = hash[:bindingMessage]
          @userCode                = hash[:userCode]
          @userCodeRequired        = hash[:userCodeRequired]
          @requestedExpiry         = hash[:requestedExpiry]
          @requestContext          = hash[:requestContext]
          @resources               = hash[:resources]
          @warnings                = hash[:warnings]
          @ticket                  = hash[:ticket]
        end
      end
    end
  end
end
