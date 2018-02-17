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


module Authlete
  module Model
    module Response
      # == Authlete::Model::Response::IntrospectionResponse class
      #
      # A class that represents a response from Authlete's
      # /api/auth/introspection API.
      class IntrospectionResponse < Authlete::Model::Result
        # The next action which the caller of the API should take next.
        # (String)
        attr_accessor :action

        # The ID of the client application which is associated with
        # the access token. (Integer)
        attr_accessor :clientId
        alias_method  :client_id,  :clientId
        alias_method  :client_id=, :clientId=

        # The flag which indicates whether the client ID alias was used when
        # the authorization request for the access token was made. (String)
        attr_accessor :clientIdAlias
        alias_method  :client_id_alias,  :clientIdAlias
        alias_method  :client_id_alias=, :clientIdAlias=

        # The flag which indicates whether the client ID alias was used when
        # the authorization request or the token request for the access token
        # was made. (Boolean)
        attr_accessor :clientIdAliasUsed
        alias_method  :client_id_alias_used,  :clientIdAliasUsed
        alias_method  :client_id_alias_used=, :clientIdAliasUsed=

        # The time at which the access token expires. (Integer)
        attr_accessor :expiresAt
        alias_method  :expires_at, :expiresAt
        alias_method  :expires_at=, :expiresAt=

        # The subject which is associated with the access token.
        # This is <tt>nil</tt> if the access token was created
        # through {Client Credentials Flow}[https://tools.ietf.org/html/rfc6749#section-4.4].
        # (String)
        attr_accessor :subject

        # The scopes which is associated with the access token. (String array)
        attr_accessor :scopes

        # True when the access token exists. (Boolean)
        attr_accessor :existent

        # True when the access token is usable (= exists and has not expired).
        # (Boolean)
        attr_accessor :usable

        # True when the access token covers all the scopes (if specified).
        # (Boolean)
        attr_accessor :sufficient

        # True when the access token can be refreshed using its corresponding
        # refresh token. (Boolean)
        attr_accessor :refreshable

        # The content of the error response that the service implementation
        # should return to the client application. (String)
        attr_accessor :response_content
        alias_method  :response_content,  :responseContent
        alias_method  :response_content=, :responseContent=

        # Extra properties associated with the access token. (Property array)
        attr_accessor :properties

        # The constructor which takes a hash that represents a JSON response
        # from /api/auth/introspection API.
        def initialize(hash = {})
          super(hash)

          @action            = extract_value(hash, :action)
          @clientId          = extract_value(hash, :clientId)
          @clientIdAlias     = extract_value(hash, :clientIdAlias)
          @clientIdAliasUsed = extract_boolean_value(hash, :clientIdAliasUsed)
          @expiresAt         = extract_integer_value(hash, :expiresAt)
          @subject           = extract_value(hash, :subject)
          @scopes            = extract_value(hash, :scopes)
          @existent          = extract_boolean_value(hash, :existent)
          @usable            = extract_boolean_value(hash, :usable)
          @sufficient        = extract_boolean_value(hash, :sufficient)
          @refreshable       = extract_boolean_value(hash, :refreshable)
          @responseContent   = extract_value(hash, :responseContent)
          @properties        = extract_array_value(hash, :scopes) do |element|
            Authlete::Model::Property.parse(element)
          end
        end

        alias_method :existent?,    :existent
        alias_method :exists,       :existent
        alias_method :exists?,      :existent
        alias_method :exist,        :existent
        alias_method :exist?,       :existent
        alias_method :usable?,      :usable
        alias_method :sufficient?,  :sufficient
        alias_method :refreshable?, :refreshable

        # Generate an array which is usable as a Rack response from this instance.
        # When <tt>action</tt> method returns other value than 'OK', the array
        # returned from this method satisfies RFC 6750.
        def to_rack_response
          # 'action' denotes the next action.
          case @action
            when 'INTERNAL_SERVER_ERROR'
              # 500 Internal Server Error
              #   The API request from this implementation was wrong
              #   or an error occurred in Authlete.
              return to_rack_response_www_authenticate(500, @response_content)

            when 'BAD_REQUEST'
              # 400 Bad Request
              #   The request from the client application does not
              #   contain an access token.
              return to_rack_response_www_authenticate(400, @response_content)

            when 'UNAUTHORIZED'
              # 401 Unauthorized
              #   The presented access token does not exist or has expired.
              return to_rack_response_www_authenticate(401, @response_content)

            when 'FORBIDDEN'
              # 403 Forbidden
              #   The access token does not cover the required scopes
              #   or the subject associated with the access token is
              #   different.
              return to_rack_response_www_authenticate(403, @response_content)

            when 'OK'
              # The access token is valid (= exists and has not expired).
              # Basically, the caller won't use the array returned from here.
              # Instead, it will return the protected resource to the client
              # application which has presented the valid access token.
              return [ 200, nil, nil ]

            else
              # This should not happen.
              return to_rack_response_www_authenticate(500,
                'Bearer error="server_error",error_description="Unknown action"')
          end
        end
      end
    end
  end
end