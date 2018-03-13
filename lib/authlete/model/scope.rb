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
    class Scope < Authlete::Model::Hashable
      include Authlete::Utility
      # The attributes of this scopes. (Pair array)
      attr_accessor :attributes

      # The description about this scope. (String)
      attr_accessor :description

      # The descriptions about this scope with language tags.
      # (TaggedValue array)
      attr_accessor :descriptions

      # The name of this scope. (String)
      attr_accessor :name

      # The flag to indicate whether this scope is included in the
      # default scope set. (Boolean)
      attr_accessor :defaultEntry
      alias_method  :default_entry,  :defaultEntry
      alias_method  :default_entry=, :defaultEntry=

      private

      # Boolean attributes.
      BOOLEAN_ATTRIBUTES = ::Set.new([ :defaultEntry ])

      # String attributes.
      STRING_ATTRIBUTES = ::Set.new([ :description, :name ])

      # Tagged value array attributes.
      TAGGED_VALUE_ARRAY_ATTRIBUTES = ::Set.new([ :descriptions ])

      # Mapping from snake cases to camel cases.
      SNAKE_TO_CAMEL = { :default_entry => :defaultEntry }

      # The constructor
      def initialize(hash = nil)
        # Set default values to boolean attributes.
        BOOLEAN_ATTRIBUTES.each do |attr|
          send("#{attr}=", false)
        end

        # Set default values to string attributes.
        STRING_ATTRIBUTES.each do |attr|
          send("#{attr}=", nil)
        end

        # Set default values to tagged value array attributes.
        TAGGED_VALUE_ARRAY_ATTRIBUTES.each do |attr|
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
        BOOLEAN_ATTRIBUTES.include?(key) or
        STRING_ATTRIBUTES.include?(key)
      end

      def authlete_model_update(hash)
        return if hash.nil?

        hash.each do |key, value|
          key = authlete_model_convert_key(key)

          if authlete_model_simple_attribute?(key)
            send("#{key}=", value)
          elsif TAGGED_VALUE_ARRAY_ATTRIBUTES.include?(key)
            # Get an array consisting of "TaggedValue" objects.
            parsed = get_parsed_array(value) do |element|
              Authlete::Model::TaggedValue.parse(element)
            end

            send("#{key}=", parsed)
          elsif key == :attributes
            @metadata = get_parsed_array(value) do |element|
              Authlete::Model::Pair.parse(element)
            end
          end
        end

        self
      end

      public

      # Construct an instance from the given hash.
      #
      # If the given argument is nil or is not a Hash, nil is returned.
      # Otherwise, Scope.new(hash) is returned.
      def self.parse(hash)
        if hash.nil? or (hash.kind_of?(Hash) == false)
          return nil
        end

        Authlete::Model::Scope.new(hash)
      end

      # Set attribute values using the given hash.
      def update(hash)
        authlete_model_update(hash)
      end

      # Convert this object into a hash.
      def to_hash
        hash = {}

        instance_variables.each do |var|
          key = var.to_s.delete("@").to_sym
          val = instance_variable_get(var)

          if authlete_model_simple_attribute?(key) or val.nil?
            hash[key] = val
          elsif key == :attributes or key == :descriptions
            hash[key] = val.map { |element| element.to_hash }
          end
        end

        hash
      end
    end
  end
end