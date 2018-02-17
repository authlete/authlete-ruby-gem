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


require 'set'


module Authlete
  module Model
    module Request
      # == Authlete::Model::Request::TokenUpdateRequest class
      #
      # This class represents a request to Authlete's /api/auth/token/update API.
      class TokenUpdateRequest < Authlete::Model::Hashable
        # An existing access token. (String)
        attr_accessor :accessToken
        alias_method  :access_token,  :accessToken
        alias_method  :access_token=, :accessToken=

        #A new date at which the access token will expire in milliseconds
        # since the Unix epoch (1970-01-01). If the accessTokenExpiresAt request
        # parameter is not included in a request or its value is 0 (or negative),
        # the expiration date of the access token is not changed. (Integer)
        attr_accessor :accessTokenExpiresAt
        alias_method  :access_token_expires_at,  :accessTokenExpiresAt
        alias_method  :access_token_expires_at=, :accessTokenExpiresAt=

        # A new set of scopes assigned to the access token. Scopes that are not
        # supported by the service and those that the client application associated
        # with the access token is not allowed to request are ignored on the
        # server side. If the scopes request parameter is not included in a
        # request or its value is nil, the scopes of the access token are not
        # changed. (String array)
        attr_accessor :scopes

        # A new set of properties assigned to the access token. If the properties
        # request parameter is not included in a request or its value is nil,
        # the properties of the access token are not changed.
        # (Property array)
        attr_accessor :properties

        private

        # Integer attributes.
        INTEGER_ATTRIBUTES = ::Set.new([ :accessTokenExpiresAt ])

        # String attributes.
        STRING_ATTRIBUTES = ::Set.new([ :accessToken ])

        # String array attributes.
        STRING_ARRAY_ATTRIBUTES = ::Set.new([ :scopes ])

        # Mapping from snake cases to camel cases.
        SNAKE_TO_CAMEL = {
          :access_token      => :accessToken,
          :access_expires_at => :accessTokenExpiresAt
        }

        # The constructor which takes a hash that represents a JSON request to
        # Authlete's /api/auth/token/update API.
        def initialize(hash = nil)
          # Set default values to integer attributes.
          INTEGER_ATTRIBUTES.each do |attr|
            send("#{attr}=", 0)
          end

          # Set default values to string attributes.
          STRING_ATTRIBUTES.each do |attr|
            send("#{attr}=", nil)
          end

          # Set default values to string array attributes.
          STRING_ARRAY_ATTRIBUTES.each do |attr|
            send("#{attr}=", nil)
          end

          @properties = nil

          # Set attribute values using the given hash.
          authlete_model_update(hash)
        end

        def authlete_model_convert_key(key)
          key = key.to_sym

          # Convert snakecase to camelcase, if necessary.
          if SNAKE_TO_CAMEL.has_key?(key)
            key = SNAKE_TO_CAMEL[key]
          end

          key
        end

        def authlete_model_simple_attribute?(key)
          INTEGER_ATTRIBUTES.include?(key) or
          STRING_ATTRIBUTES.include?(key) or
          STRING_ARRAY_ATTRIBUTES.include?(key)
        end

        def authlete_model_update(hash)
          return if hash.nil?

          hash.each do |key, value|
            key = authlete_model_convert_key(key)

            if authlete_model_simple_attribute?(key)
              send("#{key}=", value)
            elsif key == :properties
              @properties = get_parsed_array(value) do |element|
                Authlete::Model::Property.parse(element)
              end
            end
          end

          self
        end

        public

        # Construct an instance from the given hash.
        #
        # If the given argument is nil or is not a Hash, nil is returned.
        # Otherwise, TokenUpdateRequest.new(hash) is returned.
        def self.parse(hash)
          if hash.nil? or (hash.kind_of?(Hash) == false)
            return nil
          end

          return TokenUpdateRequest.new(hash)
        end

        # Convert this object into a hash.
        def to_hash
          hash = {}

          instance_variables.each do |var|
            key = var.to_s.delete("@").to_sym
            val = instance_variable_get(var)

            if authlete_model_simple_attribute?(key) or val.nil?
              hash[key] = val
            elsif key == :properties
              hash[key] = val.map { |element| element.to_hash }
            end
          end

          hash
        end
      end
    end
  end
end