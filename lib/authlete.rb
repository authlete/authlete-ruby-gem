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


require 'authlete/version'


module Authlete
  autoload :AuthenticationServer, 'authlete/authentication-server'
  autoload :Api, 'authlete/api'
  autoload :Exception, 'authlete/exception'
  autoload :ParamInitializer, 'authlete/model/param-initializer'
  autoload :Utility, 'authlete/utility'

  module Model
    autoload :Base, 'authlete/model/base'
    autoload :Client, 'authlete/model/client'
    autoload :ClientExtension, 'authlete/model/client-extension'
    autoload :Hashable, 'authlete/model/hashable'
    autoload :Result, 'authlete/model/result'
    autoload :Pair, 'authlete/model/pair'
    autoload :Property, 'authlete/model/property'
    autoload :Scope, 'authlete/model/scope'
    autoload :Service, 'authlete/model/service'
    autoload :ServiceOwner, 'authlete/model/service-owner'
    autoload :SnsCredentials, 'authlete/model/sns-credentials'
    autoload :TaggedValue, 'authlete/model/tagged-value'
    autoload :NamedUri, 'authlete/model/named-uri'
    autoload :Hsk, 'authlete/model/hsk'
    autoload :TrustAnchor, 'authlete/model/trust-anchor'

    module Request
      autoload :AuthenticationCallbackRequest, 'authlete/model/request/authentication-callback-request'
      autoload :AuthorizationFailRequest, 'authlete/model/request/authorization-fail-request'
      autoload :AuthorizationIssueRequest, 'authlete/model/request/authorization-issue-request'
      autoload :AuthorizationRequest, 'authlete/model/request/authorization-request'
      autoload :BackchannelAuthenticationCompleteRequest, 'authlete/model/request/backchannel-authentication-complete-request'
      autoload :BackchannelAuthenticationFailRequest, 'authlete/model/request/backchannel-authentication-fail-request'
      autoload :BackchannelAuthenticationIssueRequest, 'authlete/model/request/backchannel-authentication-issue-request'
      autoload :BackchannelAuthenticationRequest, 'authlete/model/request/backchannel-authentication-request'
      autoload :Base, 'authlete/model/request/base'
      autoload :ClientAuthorizationDeleteRequest, 'authlete/model/request/client-authorization-delete-request'
      autoload :ClientAuthorizationGetListRequest, 'authlete/model/request/client-authorization-get-list-request'
      autoload :ClientAuthorizationUpdateRequest, 'authlete/model/request/client-authorization-update-request'
      autoload :ClientRegistrationRequest, 'authlete/model/request/client-registration-request'
      autoload :ClientSecretUpdateRequest, 'authlete/model/request/client-secret-update-request'
      autoload :DeveloperAuthenticationCallbackRequest, 'authlete/model/request/developer-authentication-callback-request'
      autoload :DeviceAuthorizationRequest, 'authlete/model/request/device-authorization-request'
      autoload :DeviceCompleteRequest, 'authlete/model/request/device-complete-request'
      autoload :DeviceVerificationRequest, 'authlete/model/request/device-verification-request'
      autoload :GrantedScopesRequest, 'authlete/model/request/granted-scopes-request'
      autoload :IntrospectionRequest, 'authlete/model/request/introspection-request'
      autoload :PushedAuthReqRequest, 'authlete/model/request/pushed-auth-req-request'
      autoload :RevocationRequest, 'authlete/model/request/revocation-request'
      autoload :StandardIntrospectionRequest, 'authlete/model/request/standard-introspection-request'
      autoload :TokenCreateRequest, 'authlete/model/request/token-create-request'
      autoload :TokenFailRequest, 'authlete/model/request/token-fail-request'
      autoload :TokenIssueRequest, 'authlete/model/request/token-issue-request'
      autoload :TokenRequest, 'authlete/model/request/token-request'
      autoload :TokenUpdateRequest, 'authlete/model/request/token-update-request'
      autoload :UserInfoIssueRequest, 'authlete/model/request/user-info-issue-request'
      autoload :UserInfoRequest, 'authlete/model/request/user-info-request'
    end

    module Response
      autoload :AccessToken, 'authlete/model/response/access-token'
      autoload :AuthenticationCallbackResponse, 'authlete/model/response/authentication-callback-response'
      autoload :AuthorizationFailResponse, 'authlete/model/response/authorization-fail-response'
      autoload :AuthorizationIssueResponse, 'authlete/model/response/authorization-issue-response'
      autoload :AuthorizationResponse, 'authlete/model/response/authorization-response'
      autoload :AuthorizedClientListResponse, 'authlete/model/response/authorized-client-list-response'
      autoload :BackchannelAuthenticationCompleteResponse, 'authlete/model/response/backchannel-authentication-complete-response'
      autoload :BackchannelAuthenticationFailResponse, 'authlete/model/response/backchannel-authentication-fail-response'
      autoload :BackchannelAuthenticationIssueResponse, 'authlete/model/response/backchannel-authentication-issue-response'
      autoload :BackchannelAuthenticationResponse, 'authlete/model/response/backchannel-authentication-response'
      autoload :ClientListResponse, 'authlete/model/response/client-list-response'
      autoload :ClientRegistrationResponse, 'authlete/model/response/client-registration-response'
      autoload :ClientSecretRefreshResponse, 'authlete/model/response/client-secret-refresh-response'
      autoload :ClientSecretUpdateResponse, 'authlete/model/response/client-secret-update-response'
      autoload :ClientSecretRefreshResponse, 'authlete/model/response/client-secret-refresh-response'
      autoload :DeveloperAuthenticationCallbackResponse, 'authlete/model/response/developer-authentication-callback-response'
      autoload :DeviceAuthorizationResponse, 'authlete/model/response/device-authorization-response'
      autoload :DeviceCompleteResponse, 'authlete/model/response/device-complete-response'
      autoload :DeviceVerificationResponse, 'authlete/model/response/device-verification-response'
      autoload :GrantedScopesGetResponse, 'authlete/model/response/granted-scopes-get-response'
      autoload :IntrospectionResponse, 'authlete/model/response/introspection-response'
      autoload :PushedAuthReqResponse, 'authlete/model/response/pushed-auth-req-response'
      autoload :RevocationResponse, 'authlete/model/response/revocation-response'
      autoload :ServiceListResponse, 'authlete/model/response/service-list-response'
      autoload :StandardIntrospectionResponse, 'authlete/model/response/standard-introspection-response'
      autoload :TokenCreateResponse, 'authlete/model/response/token-create-response'
      autoload :TokenFailResponse, 'authlete/model/response/token-fail-response'
      autoload :TokenIssueResponse, 'authlete/model/response/token-issue-response'
      autoload :TokenListResponse, 'authlete/model/response/token-list-response'
      autoload :TokenResponse, 'authlete/model/response/token-response'
      autoload :TokenUpdateResponse, 'authlete/model/response/token-update-response'
      autoload :UserInfoIssueResponse, 'authlete/model/response/user-info-issue-response'
      autoload :UserInfoResponse, 'authlete/model/response/user-info-response'
    end
  end
end
