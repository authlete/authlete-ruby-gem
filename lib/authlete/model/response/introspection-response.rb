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
      class IntrospectionResponse < Authlete::Model::Result
        include Authlete::Utility

        attr_accessor :action

        attr_accessor :clientId
        alias_method  :client_id,  :clientId
        alias_method  :client_id=, :clientId=

        attr_accessor :clientIdAlias
        alias_method  :client_id_alias,  :clientIdAlias
        alias_method  :client_id_alias=, :clientIdAlias=

        attr_accessor :clientIdAliasUsed
        alias_method  :client_id_alias_used,  :clientIdAliasUsed
        alias_method  :client_id_alias_used=, :clientIdAliasUsed=

        attr_accessor :expiresAt
        alias_method  :expires_at, :expiresAt
        alias_method  :expires_at=, :expiresAt=

        attr_accessor :subject

        attr_accessor :scopes

        attr_accessor :existent
        alias_method  :existent?, :existent
        alias_method  :exists,    :existent
        alias_method  :exists?,   :existent
        alias_method  :exist,     :existent
        alias_method  :exist?,    :existent

        attr_accessor :usable
        alias_method  :usable?, :usable

        attr_accessor :sufficient
        alias_method  :sufficient?, :sufficient

        attr_accessor :refreshable
        alias_method  :refreshable?, :refreshable

        attr_accessor :responseContent
        alias_method  :response_content,  :responseContent
        alias_method  :response_content=, :responseContent=

        attr_accessor :properties

        attr_accessor :certificateThumbprint
        alias_method  :certificate_thumbprint,  :certificateThumbprint
        alias_method  :certificate_thumbprint=, :certificateThumbprint=

        attr_accessor :resources

        attr_accessor :accessTokenResources
        alias_method  :access_token_resources,  :accessTokenResources
        alias_method  :access_token_resources=, :accessTokenResources=

        private

        def defaults
          super.merge(
            action:                nil,
            clientId:              0,
            clientIdAlias:         nil,
            clientIdAliasUsed:     false,
            expiresAt:             0,
            subject:               nil,
            scopes:                nil,
            existent:              false,
            usable:                false,
            sufficient:            false,
            refreshable:           false,
            responseContent:       nil,
            properties:            nil,
            certificateThumbprint: nil,
            resources:             nil,
            accessTokenResources:  nil
          )
        end

        def set_params(hash)
          super(hash)

          @action                = hash[:action]
          @clientId              = hash[:clientId]
          @clientIdAlias         = hash[:clientIdAlias]
          @clientIdAliasUsed     = hash[:clientIdAliasUsed]
          @expiresAt             = hash[:expiresAt]
          @subject               = hash[:subject]
          @scopes                = hash[:scopes]
          @existent              = hash[:existent]
          @usable                = hash[:usable]
          @sufficient            = hash[:sufficient]
          @refreshable           = hash[:refreshable]
          @responseContent       = hash[:responseContent]
          @properties            = get_parsed_array(hash[:properties]) { |e| Authlete::Model::Property.parse(e) }
          @certificateThumbprint = hash[:certificateThumbprint]
          @resources             = hash[:resources]
          @accessTokenResources  = hash[:accessTokenResources]
        end

        public

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
