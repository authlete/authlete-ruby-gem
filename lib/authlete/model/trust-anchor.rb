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
    class TrustAnchor < Authlete::Model::Base
      include Authlete::Model::Hashable

      attr_accessor :entityId
      alias_method  :entity_id,  :entityId
      alias_method  :entity_id=, :entityId=

      attr_accessor :jwks

      private

      def defaults
        {
          entityId: nil,
          jwks:     nil
        }
      end

      def set_params(hash)
        @entityId  = hash[:entityId]
        @jwks      = hash[:jwks]
      end
    end
  end
end
