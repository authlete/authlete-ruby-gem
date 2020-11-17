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
    module Request
      class BackchannelAuthenticationFailRequest < Authlete::Model::Request::Base

        attr_accessor :ticket

        attr_accessor :reason

        attr_accessor :errorDescription
        alias_method  :error_description,  :errorDescription
        alias_method  :error_description=, :errorDescription=

        attr_accessor :errorUri
        alias_method  :error_uri,  :errorUri
        alias_method  :error_uri=, :errorUri=

        private

        def defaults
          {
            ticket:           nil,
            reason:           nil,
            errorDescription: nil,
            errorUri:         nil
          }
        end

        def set_params(hash)
          @ticket           = hash[:ticket]
          @reason           = hash[:reason]
          @errorDescription = hash[:errorDescription]
          @errorUri         = hash[:errorUri]
        end
      end
    end
  end
end
