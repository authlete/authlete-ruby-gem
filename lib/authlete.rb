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


require 'authlete/version'


# == Authlete Module
#
# A library for Authlete Web APIs.
module Authlete
  autoload :AuthenticationServer, 'authlete/authentication-server'
  autoload :Api, 'authlete/api'
  autoload :Exception, 'authlete/exception'
  autoload :Utility, 'authlete/utility'

  module Model
    autoload :Client, 'authlete/model/client'
    autoload :ClientList, 'authlete/model/client-list'
    autoload :ClientExtension, 'authlete/model/client-extension'
    autoload :Hashable, 'authlete/model/hashable'
    autoload :Result, 'authlete/model/result'
    autoload :Pair, 'authlete/model/pair'
    autoload :Property, 'authlete/model/property'
    autoload :Scope, 'authlete/model/scope'
    autoload :Service, 'authlete/model/service'
    autoload :ServiceList, 'authlete/model/service-list'
    autoload :ServiceOwner, 'authlete/model/service-owner'
    autoload :SnsCredentials, 'authlete/model/sns-credentials'
    autoload :TaggedValue, 'authlete/model/tagged-value'

    module Request
      autoload :AuthenticationCallbackRequest, 'authlete/model/request/authentication-callback-request'
      autoload :AuthorizationFailRequest, 'authlete/model/request/authorization-fail-request'
      autoload :AuthorizationIssueRequest, 'authlete/model/request/authorization-issue-request'
      autoload :AuthorizationRequest, 'authlete/model/request/authorization-request'
      autoload :ClientAuthorizationDeleteRequest, 'authlete/model/request/client-authorization-delete-request'
      autoload :ClientAuthorizationGetListRequest, 'authlete/model/request/client-authorization-get-list-request'
      autoload :ClientAuthorizationUpdateRequest, 'authlete/model/request/client-authorization-update-request'
      autoload :ClientSecretUpdateRequest, 'authlete/model/request/client-secret-update-request'
      autoload :DeveloperAuthenticationCallbackRequest, 'authlete/model/request/developer-authentication-callback-request'
      autoload :GrantedScopesRequest, 'authlete/model/request/granted-scopes-request'
      autoload :IntrospectionRequest, 'authlete/model/request/introspection-request'
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
      autoload :AuthenticationCallbackResponse, 'authlete/model/response/authentication-callback-response'
      autoload :AuthorizationFailResponse, 'authlete/model/response/authorization-fail-response'
      autoload :AuthorizationIssueResponse, 'authlete/model/response/authorization-issue-response'
      autoload :AuthorizationResponse, 'authlete/model/response/authorization-response'
      autoload :ClientAuthorizationGetListResponse, 'authlete/model/response/client-authorization-get-list-response'
      autoload :ClientSecretRefreshResponse, 'authlete/model/response/client-secret-refresh-response'
      autoload :ClientSecretUpdateResponse, 'authlete/model/response/client-secret-update-response'
      autoload :ClientSecretRefreshResponse, 'authlete/model/response/client-secret-refresh-response'
      autoload :DeveloperAuthenticationCallbackResponse, 'authlete/model/response/developer-authentication-callback-response'
      autoload :GrantedScopesGetResponse, 'authlete/model/response/granted-scopes-get-response'
      autoload :IntrospectionResponse, 'authlete/model/response/introspection-response'
      autoload :RevocationResponse, 'authlete/model/response/revocation-response'
      autoload :ServiceCreatableResponse, 'authlete/model/response/service-creatable-response'
      autoload :StandardIntrospectionResponse, 'authlete/model/response/standard-introspection-response'
      autoload :TokenCreateResponse, 'authlete/model/response/token-create-response'
      autoload :TokenFailResponse, 'authlete/model/response/token-fail-response'
      autoload :TokenIssueResponse, 'authlete/model/response/token-issue-response'
      autoload :TokenResponse, 'authlete/model/response/token-response'
      autoload :TokenUpdateResponse, 'authlete/model/response/token-update-response'
      autoload :UserInfoIssueResponse, 'authlete/model/response/user-info-issue-response'
      autoload :UserInfoResponse, 'authlete/model/response/user-info-response'
    end
  end
end