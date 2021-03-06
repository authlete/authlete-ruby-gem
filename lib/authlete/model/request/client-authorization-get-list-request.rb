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
      class ClientAuthorizationGetListRequest < Authlete::Model::Request::Base

        attr_accessor :subject

        attr_accessor :developer

        attr_accessor :start

        attr_accessor :end

        private

        def defaults
          {
            subject:    nil,
            developer:  nil,
            start:      0,
            end:        0
          }
        end

        def set_params(hash)
          @subject   = hash[:subject]
          @developer = hash[:developer]
          @start     = hash[:start]
          @end       = hash[:end]
        end
      end
    end
  end
end
