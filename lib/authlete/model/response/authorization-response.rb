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
      # == Authlete::Model::Response::AuthorizationResponse class
      #
      # This class represents a response from Authlete's /api/auth/authorization API.
      class AuthorizationResponse < Authlete::Model::Result
        # The flag which indicates whether the end-user authentication
        # must satisfy one of the requested ACRs. (BOOLEAN)
        attr_accessor :acrEssential
        alias_method  :acr_essential,  :acrEssential
        alias_method  :acr_essential=, :acrEssential=

        # The list of ACRs (Authentication Context Class References)
        # requested by the client application.
        # The value come from (1) "acr" claim in "claims" request parameter,
        # (2) "acr_values" request parameter or (3) "default_acr_values"
        # configuration parameter of the client application.
        # (String array)
        attr_accessor :acrs

        # The next action that the service implementation should take.
        # (String)
        attr_accessor :action

        # NOTE: Deprecated
        attr_accessor :claimLocales
        alias_method  :claim_locales,  :claimLocales
        alias_method  :claim_locales=, :claimLocales=

        # The list of preferred languages and scripts for claim
        # values contained in the ID token. The value comes from
        # "claims_locales" request parameter.
        # (String array)
        attr_accessor :claimsLocales
        alias_method  :claims_locales,  :claimsLocales
        alias_method  :claims_locales=, :claimsLocales=

        # The list of claims that the client application requests
        # to be embedded in the ID token. The value comes from
        # "scope" and "claims" request parameters of
        # the original authorization request. (String array)
        attr_accessor :claims

        # The information about the client application which has made
        # the authorization request. (Client)
        attr_accessor :client

        # "true" if the value of the client_id request parameter included in
        # the authorization request is the client ID alias. "false" if the
        # value is the original numeric client ID. (Boolean)
        attr_accessor :clientIdAliasUsed
        alias_method  :client_id_alias_used,  :clientIdAliasUsed
        alias_method  :client_id_alias_used=, :clientIdAliasUsed=

        # The display mode which the client application requests
        # by "display" request parameter. When the authorization
        # request does not contain "display" request parameter,
        # this method returns "PAGE" as the default value.
        # (String)
        attr_accessor :display

        # The value of the "id_token" property in the "claims" request
        # parameter or in the "claims" property in a request object.
        # (String in JSON format)
        attr_accessor :idTokenClaims
        alias_method  :id_token_claims,  :idTokenClaims
        alias_method  :id_token_claims=, :idTokenClaims=

        # The value of login hint, which is specified by the client
        # application using "login_hint" request parameter.
        # (String)
        attr_accessor :loginHint
        alias_method  :login_hint,  :loginHint
        alias_method  :login_hint=, :loginHint=

        # The prompt that the UI displayed to the end-user must satisfy
        # at least. The value comes from "prompt" request parameter.
        # When the authorization request does not contain "prompt"
        # parameter, this method returns "CONSENT CONSENT" as
        # the default value. (String)
        #
        # NOTE: Deprecated
        attr_accessor :lowestPrompt
        alias_method  :lowest_prompt,  :lowestPrompt
        alias_method  :lowest_prompt=, :lowestPrompt=

        # The maximum authentication age which is the allowable
        # elapsed time in seconds since the last time the end-user
        # was actively authenticated by the service implementation.
        # The value comes from "max_age" request parameter
        # or "default_max_age" configuration parameter of
        # the client application. 0 may be returned which means
        # that the max age constraint does not have to be imposed.
        # (Integer)
        attr_accessor :maxAge
        alias_method  :max_age,  :maxAge
        alias_method  :max_age=, :maxAge=

        # The list of values of prompt request parameter. Possible element
        # values are "CONSENT", "LOGIN", "SELECT_ACCOUNT" and "NONE".
        # (String array)
        attr_accessor :prompts

        # The value of the "purpose" request parameter. The parameter is
        # defined in OpenID Connect for Identity Assurance 1.0.
        attr_accessor :purpose

        # The payload part of the request object.
        # (String in JSON format)
        attr_accessor :requestObjectPayload
        alias_method  :request_object_payload,  :requestObjectPayload
        alias_method  :request_object_payload=, :requestObjectPayload=

        # The resources specified by the "resource" request parameters or
        # by the "resource" property in the request object. If both are
        # given, the value in the request object takes precedence.
        # (URI array)
        attr_accessor :resources

        # The response content which can be used to generate a response
        # to the client application. The format of the value varies
        # depending on the value of "action". (String)
        attr_accessor :responseContent
        alias_method  :response_content,  :responseContent
        alias_method  :response_content=, :responseContent=

        # The information about the service to which the authorization request
        # has been made. (Service)
        attr_accessor :service

        # The scopes which the client application requests by "scope"
        # request parameter. When the authorization request does
        # not contain "scope" request parameter, this method
        # returns a list of scopes which are marked as default by the
        # service implementation. "nil" may be returned if the
        # authorization request does not contain valid scopes and none
        # of registered scopes is marked as default.
        # (Scope array)
        attr_accessor :scopes

        # The subject (= end-user's login ID) that the client
        # application requests. The value comes from "sub"
        # claim in "claims" request parameter. This method
        # may return "nil" (probably in most cases).
        # (String)
        attr_accessor :subject

        # The ticket which has been issued to the service implementation
        # from Authlete's /api/auth/authorization API. This ticket is
        # needed for /api/auth/authorization/issue API and
        # /api/auth/authorization/fail API. (String)
        attr_accessor :ticket

        # The list of preferred languages and scripts for the user
        # interface. The value comes from "ui_locales" request
        # parameter. (String array)
        attr_accessor :uiLocales
        alias_method  :ui_locales,  :uiLocales
        alias_method  :ui_locales=, :uiLocales=

        # The value of the "userinfo" property in the "claims" request
        # parameter or in the "claims" property in the request object.
        # (String in JSON format)
        attr_accessor :userInfoClaims
        alias_method  :user_info_claims,  :userInfoClaims
        alias_method  :user_info_claims=, :userInfoClaims=

        private

        # The constructor which takes a hash that represents a JSON response
        # from Authlete's /api/auth/authorization API.
        def initialize(hash = {})
          super(hash)

          @acrEssential         = extract_value(hash, :acrEssential)
          @acrs                 = extract_value(hash, :acrs)
          @action               = extract_value(hash, :action)
          @claimLocales         = extract_value(hash, :claimLocales)
          @claimsLocales        = extract_value(hash, :claimsLocales)
          @claims               = extract_value(hash, :claims)
          @client               = Authlete::Model::Client.new(extract_value(hash, :client))
          @clientIdAliasUsed    = extract_boolean_value(hash, :clientIdAliasUsed)
          @display              = extract_value(hash, :display)
          @idTokenClaims        = extract_value(hash, :idTokenClaims)
          @loginHint            = extract_value(hash, :loginHint)
          @lowestPrompt         = extract_value(hash, :lowestPrompt)
          @maxAge               = extract_integer_value(hash, :maxAge)
          @prompts              = extract_value(hash, :prompts)
          @purpose              = extract_value(hash, :purpose)
          @requestObjectPayload = extract_value(hash, :requestObjectPayload)
          @resources            = extract_value(hash, :resources)
          @responseContent      = extract_value(hash, :responseContent)
          @service              = Authlete::Model::Service.new(extract_value(hash, :service))
          @scopes               = extract_array_value(hash, :scopes) do |element|
            Authlete::Model::Scope.parse(element)
          end
          @subject              = extract_value(hash, :subject)
          @ticket               = extract_value(hash, :ticket)
          @uiLocales            = extract_value(hash, :uiLocales)
          @userInfoClaims       = extract_value(hash, :userInfoClaims)
        end
      end
    end
  end
end