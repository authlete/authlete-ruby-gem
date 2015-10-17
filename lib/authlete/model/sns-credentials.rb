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
    class SnsCredentials
      # The API key. (String)
      attr_accessor :apiKey
      alias_method  :api_key,  :apiKey
      alias_method  :api_key=, :apiKey=

      # The API secret. (String)
      attr_accessor :apiSecret
      alias_method  :api_secret,  :apiSecret
      alias_method  :api_secret=, :apiSecret=

      # The SNS. (String)
      #
      # Valid values are "FACEBOOK".
      attr_accessor :sns

      private

      # String attributes.
      STRING_ATTRIBUTES = ::Set.new([:apiKey, :apiSecret, :sns])

      # Mapping from snake cases to camel cases.
      SNAKE_TO_CAMEL = {
        :api_key    => :apiKey,
        :api_secret => :apiSecret
      }

      # The constructor.
      def initialize(hash = nil)
        # Set default values to string attributes.
        STRING_ATTRIBUTES.each do |attr|
          send("#{attr}=", nil)
        end

        # Set attribute values using the given hash.
        authlete_model_snsCredentials_update(hash)
      end

      def authlete_model_snsCredentials_to_key(key)
        key = key.to_sym

        # Convert snakecase to camelcase, if necessary.
        if SNAKE_TO_CAMEL.has_key?(key)
          key = SNAKE_TO_CAMEL[key]
        end

        return key
      end

      def authlete_model_snsCredentials_simple_attribute?(key)
        STRING_ATTRIBUTES.include?(key)
      end

      def authlete_model_snsCredentials_update(hash)
        if hash.nil?
          return
        end

        hash.each do |key, value|
          key = authlete_model_snsCredentials_to_key(key)

          # If the attribute is a simple one.
          if authlete_model_snsCredentials_simple_attribute?(key)
            send("#{key}=", value)
            next
          end
        end

        return self
      end

      public

      # Construct an instance from the given hash.
      #
      # If the given argument is nil or is not a Hash, nil is returned.
      # Otherwise, SnsCredentials.new(hash) is returned.
      def self.parse(hash)
        if hash.nil? or (hash.kind_of?(Hash) == false)
          return nil
        end

        return Authlete::Model::SnsCredentials.new(hash)
      end

      # Set attribute values using the given hash.
      def update(hash)
        authlete_model_snsCredentials_update(hash)
      end

      # Convert this object into a hash.
      def to_hash
        hash = {}

        instance_variables.each do |var|
          key = var.to_s.delete("@").to_sym
          val = instance_variable_get(var)

          hash[key] = val
        end

        return hash
      end

      def [](key)
        key = authlete_model_snsCredentials_to_key(key)

        if respond_to?(key)
          return send(key)
        else
          return nil
        end
      end

      def []=(key, value)
        key = authlete_model_snsCredentials_to_key(key)
        method = "#{key}="

        if respond_to?(method)
          return send(method, value)
        else
          return nil
        end
      end
    end
  end
end
