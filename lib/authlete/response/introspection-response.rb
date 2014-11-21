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


module Authlete
  module Response
    # == Authlete::Response::IntrospectionResponse class
    #
    # A class that represents a response from Authlete's
    # {/auth/introspection}[https://www.authlete.com/authlete_web_apis_introspection.html#auth_introspection]
    # API.
    #
    class IntrospectionResponse < Athlete::Response::BaseResponse
      # The next action which the caller of the API should take next.
      attr_accessor :action

      # The ID of the client application which is associated with
      # the access token.
      attr_accessor :client_id

      # The subject which is associated with the access token.
      # This is <tt>nil</tt> if the access token was created
      # through {Client Credentials Flow}[https://tools.ietf.org/html/rfc6749#section-4.4].
      attr_accessor :subject

      # The scopes which is associated with the access token.
      attr_accessor :scopes

      # True when the access token exists.
      attr_accessor :existent

      # True when the access token is usable (= exists and has not expired).
      attr_accessor :usable

      # True when the access token covers all the scopes (if specified).
      attr_accessor :sufficient

      # True when the access token can be refreshed using its corresponding
      # refresh token.
      attr_accessor :refreshable

      # The content of the error response that the service implementation
      # should return to the client application.
      attr_accessor :response_content

      # The constructor which takes a hash that represents a JSON response from
      # {/auth/introspection}[https://www.authlete.com/authlete_web_apis_introspection.html#auth_introspection]
      # API.
      def initialize(hash = {})
        super(hash)

        @action           = extract_value(hash, :action)
        @client_id        = extract_value(hash, :clientId)
        @subject          = extract_value(hash, :subject)
        @scopes           = extract_value(hash, :scopes)
        @existent         = extract_boolean_value(hash, :existent)
        @usable           = extract_boolean_value(hash, :usable)
        @sufficient       = extract_boolean_value(hash, :sufficient)
        @refreshable      = extract_boolean_value(hash, :refreshable)
        @response_content = extract_value(hash, :responseContent)
      end

      alias_method :existent?,    :existent
      alias_method :exists,       :existent
      alias_method :exists?,      :existent
      alias_method :exist,        :existent
      alias_method :exist?,       :existent
      alias_method :usable?,      :usable
      alias_method :sufficient?,  :sufficient
      alias_method :refreshable?, :refreshable
    end
  end
end
