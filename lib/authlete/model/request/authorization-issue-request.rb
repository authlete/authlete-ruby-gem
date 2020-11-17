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
      class AuthorizationIssueRequest < Authlete::Model::Request::Base
        include Authlete::Utility

        attr_accessor :ticket

        attr_accessor :subject

        attr_accessor :authTime
        alias_method  :auth_time, :authTime
        alias_method  :auth_time=, :authTime=

        attr_accessor :acr

        attr_accessor :claims

        attr_accessor :properties

        attr_accessor :scopes

        attr_accessor :sub

        attr_accessor :idtHeaderParams
        alias_method  :idt_header_params,  :idtHeaderParams
        alias_method  :idt_header_params=, :idtHeaderParams=

        private

        def defaults
          {
            ticket:           nil,
            subject:          nil,
            authTime:         0,
            acr:              nil,
            claims:           nil,
            properties:       nil,
            scopes:           nil,
            sub:              nil,
            idtHeaderParams:  nil
          }
        end

        def set_params(hash)
          @ticket          = hash[:ticket]
          @subject         = hash[:subject]
          @authTime        = hash[:authTime]
          @acr             = hash[:acr]
          @claims          = hash[:claims]
          @properties      = get_parsed_array(hash[:properties]) { |e| Authlete::Model::Property.parse(e) }
          @scopes          = hash[:scopes]
          @sub             = hash[:sub]
          @idtHeaderParams = hash[:idtHeaderParams]
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
