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
      class AuthorizationResponse < Authlete::Model::Result
        include Authlete::Utility

        attr_accessor :action

        attr_accessor :service

        attr_accessor :client

        attr_accessor :display

        attr_accessor :maxAge
        alias_method  :max_age,  :maxAge
        alias_method  :max_age=, :maxAge=

        attr_accessor :scopes

        attr_accessor :uiLocales
        alias_method  :ui_locales,  :uiLocales
        alias_method  :ui_locales=, :uiLocales=

        attr_accessor :claimsLocales
        alias_method  :claims_locales,  :claimsLocales
        alias_method  :claims_locales=, :claimsLocales=

        attr_accessor :claims

        attr_accessor :acrEssential
        alias_method  :acr_essential,  :acrEssential
        alias_method  :acr_essential=, :acrEssential=

        attr_accessor :clientIdAliasUsed
        alias_method  :client_id_alias_used,  :clientIdAliasUsed
        alias_method  :client_id_alias_used=, :clientIdAliasUsed=

        attr_accessor :acrs

        attr_accessor :subject

        attr_accessor :loginHint
        alias_method  :login_hint,  :loginHint
        alias_method  :login_hint=, :loginHint=

        attr_accessor :lowestPrompt
        alias_method  :lowest_prompt,  :lowestPrompt
        alias_method  :lowest_prompt=, :lowestPrompt=

        attr_accessor :prompts

        attr_accessor :requestObjectPayload
        alias_method  :request_object_payload,  :requestObjectPayload
        alias_method  :request_object_payload=, :requestObjectPayload=

        attr_accessor :idTokenClaims
        alias_method  :id_token_claims,  :idTokenClaims
        alias_method  :id_token_claims=, :idTokenClaims=

        attr_accessor :userInfoClaims
        alias_method  :user_info_claims,  :userInfoClaims
        alias_method  :user_info_claims=, :userInfoClaims=

        attr_accessor :resources

        attr_accessor :purpose

        attr_accessor :responseContent
        alias_method  :response_content,  :responseContent
        alias_method  :response_content=, :responseContent=

        attr_accessor :ticket

        private

        def defaults
          super.merge(
            action:               nil,
            service:              nil,
            client:               nil,
            display:              nil,
            maxAge:               0,
            scopes:               nil,
            uiLocales:            nil,
            claimsLocales:        nil,
            claims:               nil,
            acrEssential:         false,
            clientIdAliasUsed:    false,
            acrs:                 nil,
            subject:              nil,
            loginHint:            nil,
            lowestPrompt:         nil,
            prompts:              nil,
            requestObjectPayload: nil,
            idTokenClaims:        nil,
            userInfoClaims:       nil,
            resources:            nil,
            purpose:              nil,
            responseContent:      nil,
            ticket:               nil
          )
        end

        def set_params(hash)
          super(hash)

          @action               = hash[:action]
          @service              = Authlete::Model::Service.new(hash[:service])
          @client               = Authlete::Model::Client.new(hash[:client])
          @display              = hash[:display]
          @maxAge               = hash[:maxAge]
          @scopes               = get_parsed_array(hash[:scopes]) { |e| Authlete::Model::Scope.parse(e) }
          @uiLocales            = hash[:uiLocales]
          @claimsLocales        = hash[:claimsLocales]
          @claims               = hash[:claims]
          @acrEssential         = hash[:acrEssential]
          @clientIdAliasUsed    = hash[:clientIdAliasUsed]
          @acrs                 = hash[:acrs]
          @subject              = hash[:subject]
          @loginHint            = hash[:loginHint]
          @lowestPrompt         = hash[:lowestPrompt]
          @prompts              = hash[:prompts]
          @requestObjectPayload = hash[:requestObjectPayload]
          @idTokenClaims        = hash[:idTokenClaims]
          @userInfoClaims       = hash[:userInfoClaims]
          @resources            = hash[:resources]
          @purpose              = hash[:purpose]
          @responseContent      = hash[:responseContent]
          @ticket               = hash[:ticket]
        end
      end
    end
  end
end
