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
    class ClientExtension < Authlete::Model::Hashable
      include Authlete::Utility

      # The set of scopes that a client application is allowed to request.
      # (String array)
      attr_accessor :requestableScopes
      alias_method  :requestable_scopes,  :requestableScopes
      alias_method  :requestable_scopes=, :requestableScopes=

      # The flag to show whether a client application can only request
      # the set of scopes that it is allowed to request or it can request
      # all of the scopes that the service supports. (Boolean)
      attr_accessor :requestableScopesEnabled
      alias_method  :requestable_scopes_enabled, :requestableScopesEnabled
      alias_method  :requestable_scopes_enabled=, :requestableScopesEnabled=

      # The duration of access tokens in seconds that are issued to a client.
      # (Integer)
      attr_accessor :accessTokenDuration
      alias_method  :access_token_duration,  :accessTokenDuration
      alias_method  :access_token_duration=, :accessTokenDuration=

      # The duration of refresh tokens in seconds that are issued to a client.
      # (Integer)
      attr_accessor :refreshTokenDuration
      alias_method  :refresh_token_duration,  :refreshTokenDuration
      alias_method  :refresh_token_duration=, :refreshTokenDuration=

      private

      # Integer attributes.
      INTEGER_ATTRIBUTES = ::Set.new([
        :accessTokenDuration, :refreshTokenDuration
      ])

      # Boolean attributes.
      BOOLEAN_ATTRIBUTES = ::Set.new([
        :requestableScopesEnabled
      ])

      # String array attributes.
      STRING_ARRAY_ATTRIBUTES = ::Set.new([
        :requestableScopes
      ])

      # Mapping from snake cases to camel cases.
      SNAKE_TO_CAMEL = {
        :requestable_scopes         => :requestableScopes,
        :requestable_scopes_enabled => :requestableScopesEnabled,
        :access_token_duration      => :accessTokenDuration,
        :refresh_token_duration     => :refreshTokenDuration
      }

      # The constructor
      def initialize(hash = nil)
        # Set default values to integer attributes.
        INTEGER_ATTRIBUTES.each do |attr|
          send("#{attr}=", 0)
        end

        # Set default values to boolean attributes.
        BOOLEAN_ATTRIBUTES.each do |attr|
          send("#{attr}=", false)
        end

        # Set default values to string array attributes.
        STRING_ARRAY_ATTRIBUTES.each do |attr|
          send("#{attr}=", nil)
        end

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
        BOOLEAN_ATTRIBUTES.include?(key) or
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
      # Otherwise, ClientList.new(hash) is returned.
      def self.parse(hash)
        if hash.nil? or (hash.kind_of?(Hash) == false)
          return nil
        end

        return ClientExtension.new(hash)
      end

      # Convert this object into a hash.
      def to_hash
        hash = {}

        instance_variables.each do |var|
          key = var.to_s.delete("@").to_sym
          val = instance_variable_get(var)

          if authlete_model_simple_attribute?(key) or val.nil?
            hash[key] = val
          elsif val.kind_of?(Array)
            hash[key] = val.map { |element| element.to_hash }
          end
        end

        hash
      end
    end
  end
end