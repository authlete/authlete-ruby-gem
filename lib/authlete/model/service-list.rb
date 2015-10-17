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
    class ServiceList
      # The start index (inclusive) of the services in this list.
      attr_accessor :start

      # The end index (exclusive) of the services in this list.
      attr_accessor :end

      # The total count of services.
      attr_accessor :totalCount
      alias_method  :total_count,  :totalCount
      alias_method  :total_count=, :totalCount=

      # The list of services.
      attr_accessor :services

      private

      # Integer attributes.
      INTEGER_ATTRIBUTES = ::Set.new([:start, :end, :totalCount])

      # Mapping from snake cases to camel cases.
      SNAKE_TO_CAMEL = { :total_count => :totalCount }

      # The constructor
      def initialize(hash = nil)
        # Set default values to integer attributes.
        INTEGER_ATTRIBUTES.each do |attr|
          send("#{attr}=", 0)
        end

        @services = nil

        # Set attribute values using the given hash.
        authlete_model_serviceList_update(hash)
      end

      def authlete_model_serviceList_to_key(key)
        key = key.to_sym

        # Convert snakecase to camelcase, if necessary.
        if SNAKE_TO_CAMEL.has_key?(key)
          key = SNAKE_TO_CAMEL[key]
        end

        return key
      end

      def authlete_model_serviceList_simple_attribute?(key)
        INTEGER_ATTRIBUTES.include?(key)
      end

      def authlete_model_serviceList_update(hash)
        if hash.nil?
          return
        end

        hash.each do |key, value|
          key = authlete_model_serviceList_to_key(key)

          # If the attribute is a simple one.
          if authlete_model_serviceList_simple_attribute?(key)
            send("#{key}=", value)
            next
          end

          if key == :services
            # The attribute 'services'.
            @services = authlete_model_serviceList_parse_array(value) do |element|
              Authlete::Model::Service.parse(element)
            end
          end
        end

        return self
      end

      def authlete_model_serviceList_parse_array(array)
        if array.nil? or (array.kind_of?(Array) == false) or (array.length == 0)
          return nil
        end

        elements = []

        array.each do |element|
          parsed_element = yield(element)

          if parsed_element.nil? == false
            elements.push(parsed_element)
          end
        end

        if elements.length == 0
          return nil
        end

        return elements
      end

      public

      # Construct an instance from the given hash.
      #
      # If the given argument is nil or is not a Hash, nil is returned.
      # Otherwise, ServiceList.new(hash) is returned.
      def self.parse(hash)
        if hash.nil? or (hash.kind_of?(Hash) == false)
          return nil
        end

        return ServiceList.new(hash)
      end

      # Set attribute values using the given hash.
      def update(hash)
        authlete_model_serviceList_update(hash)
      end

      # Convert this object into a hash.
      def to_hash
        hash = {}

        instance_variables.each do |var|
          key = var.to_s.delete("@").to_sym
          val = instance_variable_get(var)

          if authlete_model_serviceList_simple_attribute?(key) or val.nil?
            hash[key] = val
          elsif val.kind_of?(Array)
            hash[key] = val.map {|element| element.to_hash}
          end
        end

        return hash
      end

      def [](key)
        key = authlete_model_serviceList_to_key(key)

        if respond_to?(key)
          return send(key)
        else
          return nil
        end
      end

      def []=(key, value)
        key = authlete_model_serviceList_to_key(key)
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

