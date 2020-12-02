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
    module Hashable

      private

      def to_hash_key(var)
        var.to_s.delete("@").to_sym
      end

      def to_hash_value(key, var)
        instance_variable_get(var)
      end

      def to_key_value_pair(var)
        key   = to_hash_key(var)
        value = to_hash_value(key, var)
        [ key, value ]
      end

      public

      def to_hash
        Hash[ instance_variables.map { |var| to_key_value_pair(var) } ]
      end
    end
  end
end
