# :nodoc:
#
# Copyright (C) 2014-2018 Authlete, Inc.
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
      # == Authlete::Model::Request::IntrospectionRequest class
      #
      # This class represents a request to Authlete's /api/auth/introspection API.
      class IntrospectionRequest < Authlete::Model::Hashable
        # An access token to introspect. (String)
        attr_accessor :token

        # Scopes which are required to access the target protected resource.
        # (String array)
        attr_accessor :scopes

        # Unique user ID. (String)
        attr_accessor :subject

        private

        # String attributes.
        STRING_ATTRIBUTES = ::Set.new([ :token, :subject ])

        # String array attributes.
        STRING_ARRAY_ATTRIBUTES = ::Set.new([ :scopes ])

        # The constructor which takes a hash that represents a JSON request to
        # Authlete's /api/auth/introspection API.
        def initialize(hash = nil)
          # Set default values to string attributes.
          STRING_ATTRIBUTES.each do |attr|
            send("#{attr}=", nil)
          end

          # Set default values to string array attributes.
          STRING_ARRAY_ATTRIBUTES.each do |attr|
            send("#{attr}=", nil)
          end

          # Set attribute values using the given hash.
          authlete_model_update(hash)
        end

        def authlete_model_convert_key(key)
          key.to_sym
        end

        def authlete_model_simple_attribute?(key)
          STRING_ATTRIBUTES.include?(key) or
          STRING_ARRAY_ATTRIBUTES.include?(key)
        end

        def authlete_model_update(hash)
          return if hash.nil?

          hash.each do |key, value|
            key = authlete_model_convert_key(key)

            if authlete_model_simple_attribute?(key)
              send("#{key}=", value)
            end
          end

          self
        end

        public

        # Construct an instance from the given hash.
        #
        # If the given argument is nil or is not a Hash, nil is returned.
        # Otherwise, IntrospectionRequest.new(hash) is returned.
        def self.parse(hash)
          if hash.nil? or (hash.kind_of?(Hash) == false)
            return nil
          end

          return IntrospectionRequest.new(hash)
        end

        # Convert this object into a hash.
        def to_hash
          hash = {}

          instance_variables.each do |var|
            key = var.to_s.delete("@").to_sym
            val = instance_variable_get(var)

            if authlete_model_simple_attribute?(key) or val.nil?
              hash[key] = val
            end
          end

          hash
        end
      end
    end
  end
end