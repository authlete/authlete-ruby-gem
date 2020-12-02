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
      class DeviceCompleteRequest < Authlete::Model::Request::Base
        include Authlete::Utility

        attr_accessor :userCode
        alias_method  :user_code,  :userCode
        alias_method  :user_code=, :userCode=

        attr_accessor :result

        attr_accessor :subject

        attr_accessor :sub

        attr_accessor :authTime
        alias_method  :auth_time,  :authTime
        alias_method  :auth_time=, :authTime=

        attr_accessor :acr

        attr_accessor :claims

        attr_accessor :properties

        attr_accessor :scopes

        attr_accessor :errorDescription
        alias_method  :error_description,  :errorDescription
        alias_method  :error_description=, :errorDescription=

        attr_accessor :errorUri
        alias_method  :error_uri,  :errorUri
        alias_method  :error_uri=, :errorUri=

        private

        def defaults
          {
            userCode:         nil,
            result:           nil,
            subject:          nil,
            sub:              nil,
            authTime:         0,
            acr:              nil,
            claims:           nil,
            properties:       nil,
            scopes:           nil,
            errorDescription: nil,
            errorUri:         nil
          }
        end

        def set_params(hash)
          @userCode         = hash[:userCode]
          @result           = hash[:result]
          @subject          = hash[:subject]
          @sub              = hash[:sub]
          @authTime         = hash[:authTime]
          @acr              = hash[:acr]
          @claims           = hash[:claims]
          @properties       = get_parsed_array(hash[:properties]) { |e| Authlete::Model::Property.parse(e) }
          @scopes           = hash[:scopes]
          @errorDescription = hash[:errorDescription]
          @errorUri         = hash[:errorUri]
        end

        def to_hash_value(key, var)
          raw_val = instance_variable_get(var)

          case key
            when :properties
              raw_val&.map { |e| e.to_hash }
            else
              raw_val
          end
        end
      end
    end
  end
end
