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


module Authlete
  module Model
    class Hashable
      private

      def authlete_model_convert_key(key)
      end

      def authelte_model_simple_attribute?(key)
      end

      def authlete_model_update(hash)
      end

      public

      # Convert this object into a hash.
      def to_hash
      end

      # Set attribute values using the given hash.
      def update(hash = {})
        authlete_model_update(hash)
      end

      def [](key)
        key = authlete_model_convert_key(key)

        if respond_to?(key)
          send(key)
        else
          nil
        end
      end

      def []=(key, value)
        key = authlete_model_convert_key(key)
        method = "#{key}="

        if respond_to?(method)
          send(method, value)
        else
          nil
        end
      end
    end
  end
end