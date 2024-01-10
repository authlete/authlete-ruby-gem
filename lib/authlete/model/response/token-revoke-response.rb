# :nodoc:
#
# Copyright (C) 2014-2024 Authlete, Inc.
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
      class TokenRevokeResponse < Authlete::Model::Result

        attr_accessor :count

        private

        def defaults
          super.merge(
            count: nil
          )
        end

        def set_params(hash)
          super(hash)

          @count = hash[:count]
        end
      end
    end
  end
end
