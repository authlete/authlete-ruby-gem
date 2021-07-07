# :nodoc:
#
# Copyright (C) 2014-2021 Authlete, Inc.
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
    class Hsk < Authlete::Model::Base
      include Authlete::Model::Hashable
      include Authlete::Utility

      attr_accessor :kty

      attr_accessor :use

      attr_accessor :alg

      attr_accessor :kid

      attr_accessor :hsmName
      alias_method  :hsm_name,  :hsmName
      alias_method  :hsm_name=, :hsmName=

      attr_accessor :handle

      attr_accessor :publicKey
      alias_method  :public_key,  :publicKey
      alias_method  :public_key=, :publicKey=

      private

      def defaults
        {
          kty:        nil,
          use:        nil,
          alg:        nil,
          kid:        nil,
          hsmName:    nil,
          handle:     nil,
          publicKey:  nil,
        }
      end

      def set_params(hash)
        @kty         = hash[:kty]
        @use         = hash[:use]
        @alg         = hash[:alg]
        @kid         = hash[:kid]
        @hsmName     = hash[:hsmName]
        @handle      = hash[:handle]
        @publicKey   = hash[:publicKey]
      end
    end
  end
end
