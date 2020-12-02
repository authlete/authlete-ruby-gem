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
      class ClientRegistrationRequest < Authlete::Model::Request::Base

        attr_accessor :json

        attr_accessor :token

        attr_accessor :clientId
        alias_method  :client_id,  :clientId
        alias_method  :client_id=, :clientId=

        private

        def defaults
          {
            json:      nil,
            token:     nil,
            clientId:  nil
          }
        end

        def set_params(hash)
          @json     = hash[:json]
          @token    = hash[:token]
          @clientId = hash[:clientId]
        end
      end
    end
  end
end
