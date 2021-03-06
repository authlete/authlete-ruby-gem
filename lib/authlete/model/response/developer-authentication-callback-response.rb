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


require 'json'


module Authlete
  module Model
    module Response
      class DeveloperAuthenticationCallbackResponse < Authlete::Model::Base
        include Authlete::Utility

        attr_accessor :authenticated

        attr_accessor :subject

        attr_accessor :displayName
        alias_method  :display_name,  :displayName
        alias_method  :display_name=, :displayName=

        private

        def defaults
          {
            authenticated: false,
            subject:       nil,
            displayName:   nil
          }
        end

        def set_params(hash)
          @authenticated = hash[:authenticated]
          @subject       = hash[:subject]
          @displayName   = hash[:displayName]
        end

        def to_rack_response
          to_rack_response_json(200, JSON.generate(
            authenticated: @authenticated,
            subject:       @subject,
            displayNam:    @displayName
          ))
        end
      end
    end
  end
end
