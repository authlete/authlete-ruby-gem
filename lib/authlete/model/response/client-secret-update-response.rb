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


module Authlete
  module Model
    module Response
      # == Authlete::Model::Response::ClientSecretUpdateResponse class
      #
      # This class represents a response from Authlete's /api/client/secret/update/{clientIdentifier} API.
      class ClientSecretUpdateResponse < Authlete::Model::Result
        # The new client secret. (String)
        attr_accessor :newClientSecret
        alias_method  :new_client_secret,  :newClientSecret
        alias_method  :new_client_secret=, :newClientSecret=

        # The old client secret. (String)
        attr_accessor :oldClientSecret
        alias_method  :old_client_secret,  :oldClientSecret
        alias_method  :old_client_secret=, :oldClientSecret=

        private

        # The constructor which takes a hash that represents a JSON response
        # from Authlete's /api/client/secret/update/{clientIdentifier} API.
        def initialize(hash = {})
          super(hash)

          @newClientSecret = extract_value(hash, :newClientSecret)
          @oldClientSecret = extract_value(hash, :oldClientSecret)
        end
      end
    end
  end
end