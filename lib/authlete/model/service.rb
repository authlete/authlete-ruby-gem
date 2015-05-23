# :nodoc:
#
# Copyright (C) 2015 Authlete, Inc.
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
    class Service
      # The duration of access tokens in seconds. (Integer)
      attr_accessor :accessTokenDuration

      # The access token type. (String)
      attr_accessor :accessTokenType

      # The API key. (Long)
      attr_accessor :apiKey

      # The API secret. (String)
      attr_accessor :apiSecret

      # The API key to access the authentication callback endpoint. (String)
      attr_accessor :authenticationCallbackApiKey

      # The API secret to access the authentication callback endpoint. (String)
      attr_accessor :authenticationCallbackApiSecret

      # The URI of the authentication callback endpoint. (URI)
      attr_accessor :authenticationCallbackEndpoint

      # The URI of the authorization endpoint. (URI)
      attr_accessor :authorizationEndpoint

      # The description of this service. (String)
      attr_accessor :description

      # The duration of ID tokens in seconds. (Integer)
      attr_accessor :idTokenDuration

      # The issuer identifier of this OpenID Provider. (URI)
      attr_accessor :issuer

      # The JSON Web Key Set of this service. (String)
      attr_accessor :jwks

      # The URI of the service's JSON Web Key Set. (URI)
      attr_accessor :jwksUri

      # The service number. (Integer)
      attr_accessor :number

      # The URI of the service's policy page. (URI)
      attr_accessor :policyUri

      # The duration of refresh tokens in seconds. (Integer)
      attr_accessor :refreshTokenDuration

      # The URI of the registration endpoint. (URI)
      attr_accessor :registrationEndpoint

      # The URI of the service's documentation. (URI)
      attr_accessor :serviceDocumentation

      # The service name. (String)
      attr_accessor :serviceName

      # The service owner number. (Integer)
      attr_accessor :serviceOwnerNumber

      # The list of SNS credentials. (SnsCredentials array)
      attr_accessor :snsCredentials

      # The list of supported ACRs. (String array)
      attr_accessor :supportedAcrs

      # The list of supported claim locales. (String array)
      attr_accessor :supportedClaimLocales

      # The list of supported claims. (String array)
      attr_accessor :supportedClaims

      # The list of supported claim types. (String array)
      #
      # Valid values are "NORMAL", "AGGREGATED" and "DISTRIBUTED".
      attr_accessor :supportedClaimTypes

      # The list of supported values of +display+ parameter. (String array)
      #
      # Valid values are "PAGE", "POPUP", "TOUCH" and "WAP".
      attr_accessor :supportedDisplays

      # The list of supported grant types. (String array)
      #
      # Valid values are "AUTHORIZATION_CODE", "IMPLICIT", "PASSWORD",
      # "CLIENT_CREDENTIALS" and "REFRESH_TOKEN".
      attr_accessor :supportedGrantTypes

      # The list of supported response types. (String array)
      #
      # Valid values are "NONE", "CODE", "TOKEN", "ID_TOKEN",
      # "CODE_TOKEN", "CODE_ID_TOKEN", "ID_TOKEN_TOKEN" and
      # "CODE_ID_TOKEN_TOKEN".
      attr_accessor :supportedResponseTypes

      # The list of supported scopes. (Scope array)
      attr_accessor :supportedScopes

      # The list of supported SNSes. (Sns array)
      attr_accessor :supportedSnses

      # The list of supported client authentication methods at the token endpoint. (String array)
      #
      # Valid values are "NONE", "CLIENT_SECRET_BASIC", "CLIENT_SECRET_POST",
      # "CLIENT_SECRET_JWT" and "PRIVATE_KEY_JWT".
      attr_accessor :supportedTokenAuthMethods

      # The list of supported UI locales. (String array)
      attr_accessor :supportedUiLocales

      # The URI of the token endpoint. (URI)
      attr_accessor :tokenEndpoint

      # The URI of the service's "Terms Of Service" page. (URI)
      attr_accessor :tosUri

      # The URI of UserInfo endpoint. (URI)
      attr_accessor :userInfoEndpoint
    end
  end
end
