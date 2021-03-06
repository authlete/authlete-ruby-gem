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
    module Response
      class ClientSecretUpdateResponse < Authlete::Model::Result
        attr_accessor :newClientSecret
        alias_method  :new_client_secret,  :newClientSecret
        alias_method  :new_client_secret=, :newClientSecret=

        attr_accessor :oldClientSecret
        alias_method  :old_client_secret,  :oldClientSecret
        alias_method  :old_client_secret=, :oldClientSecret=

        private

        def defaults
          super.merge(
            newClientSecret: nil,
            oldClientSecret: nil
          )
        end

        def set_params(hash)
          super(hash)

          @newClientSecret = hash[:newClientSecret]
          @oldClientSecret = hash[:oldClientSecret]
        end
      end
    end
  end
end
