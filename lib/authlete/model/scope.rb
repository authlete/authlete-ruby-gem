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
    class Scope < Authlete::Model::Base
      include Authlete::Model::Hashable
      include Authlete::Utility

      attr_accessor :name

      attr_accessor :defaultEntry
      alias_method  :default_entry,  :defaultEntry
      alias_method  :default_entry=, :defaultEntry=

      attr_accessor :description

      attr_accessor :descriptions

      attr_accessor :attributes

      private

      def defaults
        {
          name:          nil,
          defaultEntry:  false,
          description:   nil,
          descriptions:  nil,
          attributes:    nil
        }
      end

      def set_params(hash)
        @name         = hash[:name]
        @defaultEntry = hash[:defaultEntry]
        @description  = hash[:description]
        @descriptions = get_parsed_array(hash[:descriptions]) { |e| Authlete::Model::TaggedValue.parse(e) }
        @attributes   = get_parsed_array(hash[:attributes]) { |e| Authlete::Model::Pair.parse(e) }
      end

      def to_hash_value(key, var)
        raw_val = instance_variable_get(var)

        case key
          when :descriptions, :attributes
            raw_val&.map { |e| e.to_hash }
          else
            raw_val
        end
      end
    end
  end
end
