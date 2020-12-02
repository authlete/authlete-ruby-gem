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
      class IntrospectionRequest < Authlete::Model::Request::Base

        attr_accessor :token

        attr_accessor :scopes

        attr_accessor :subject

        attr_accessor :dpop

        attr_accessor :htu

        attr_accessor :htm

        private

        def defaults
          {
            token:   nil,
            scopes:  nil,
            subject: nil,
            dpop:    nil,
            htu:     nil,
            htm:     nil
          }
        end

        def set_params(hash)
          @token   = hash[:token]
          @scopes  = hash[:scopes]
          @subject = hash[:subject]
          @dpop    = hash[:dpop]
          @htu     = hash[:htu]
          @htm     = hash[:htu]
        end
      end
    end
  end
end
