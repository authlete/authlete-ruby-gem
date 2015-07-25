# :nodoc:
#
# Copyright (C) 2014 Authlete, Inc.
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
# A library for {Authlete Web APIs}[https://www.authlete.com/authlete_web_apis.html].
#
module Authlete
  autoload :AuthenticationServer, 'authlete/authentication-server'
  autoload :Api, 'authlete/api'
  autoload :Host, 'authlete/host'
  autoload :Utility, 'authlete/utility'

  module Model
    autoload :Client, 'authlete/model/client'
    autoload :ClientList, 'authlete/model/client-list'
    autoload :Scope, 'authlete/model/scope'
    autoload :Service, 'authlete/model/service'
    autoload :ServiceList, 'authlete/model/service-list'
    autoload :SnsCredentials, 'authlete/model/sns-credentials'
    autoload :TaggedValue, 'authlete/model/tagged-value'
  end

  module Request
    autoload :AuthenticationCallbackRequest, 'authlete/request/authentication-callback-request'
  end

  module Response
    autoload :AuthenticationCallbackResponse, 'authlete/response/authentication-callback-response'
    autoload :BaseResponse, 'authlete/response/base-response'
    autoload :IntrospectionResponse, 'authlete/response/introspection-response'
  end
end
