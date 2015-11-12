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
    class ClientList < Authlete::Model::Hashable
      include Authlete::Utility
      # The start index (inclusive) of the clients in this list.
      attr_accessor :start

      # The end index (exclusive) of the clients in this list.
      attr_accessor :end

      # The total count of clients.
      attr_accessor :totalCount
      alias_method  :total_count,  :totalCount
      alias_method  :total_count=, :totalCount=

      # The list of clients.
      attr_accessor :clients

      private

      # Integer attributes.
      INTEGER_ATTRIBUTES = ::Set.new([ :start, :end, :totalCount ])

      # Mapping from snake cases to camel cases.
      SNAKE_TO_CAMEL = { :total_count => :totalCount }

      # The constructor
      def initialize(hash = nil)
        # Set default values to integer attributes.
        INTEGER_ATTRIBUTES.each do |attr|
          send("#{attr}=", 0)
        end

        @clients = nil

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
        INTEGER_ATTRIBUTES.include?(key)
      end

      def authlete_model_update(hash)
        return if hash.nil?

        hash.each do |key, value|
          key = authlete_model_convert_key(key)

          if authlete_model_simple_attribute?(key)
            send("#{key}=", value)
          elsif key == :clients
            # Get an array consisting of "Client" objects.
            @clients = get_parsed_array(value) do |element|
              Authlete::Model::Client.parse(element)
            end
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

        return ClientList.new(hash)
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