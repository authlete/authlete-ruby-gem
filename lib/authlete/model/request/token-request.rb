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
      class TokenRequest < Authlete::Model::Request::Base
        include Authlete::Utility

        attr_accessor :parameters

        attr_accessor :clientId
        alias_method  :client_id,  :clientId
        alias_method  :client_id=, :clientId=

        attr_accessor :clientSecret
        alias_method  :client_secret,  :clientSecret
        alias_method  :client_secret=, :clientSecret=

        attr_accessor :properties

        attr_accessor :clientCertificate
        alias_method  :client_certificate,  :clientCertificate
        alias_method  :client_certificate=, :clientCertificate=

        attr_accessor :clientCertificatePath
        alias_method  :client_certificate_path, :clientCertificatePath
        alias_method  :client_certificate_path=, :clientCertificatePath=

        attr_accessor :dpop

        attr_accessor :htu

        attr_accessor :htm

        private

        def defaults
          {
            parameters:            nil,
            clientId:              nil,
            clientSecret:          nil,
            properties:            nil,
            clientCertificate:     nil,
            clientCertificatePath: nil,
            dpop:                  nil,
            htu:                   nil,
            htm:                   nil
          }
        end

        def set_params(hash)
          @parameters            = hash[:parameters]
          @clientId              = hash[:clientId]
          @clientSecret          = hash[:clientSecret]
          @properties            = get_parsed_array(hash[:properties]) { |e| Authlete::Model::Property.parse(e) }
          @clientCertificate     = hash[:clientCertificate]
          @clientCertificatePath = hash[:clientCertificatePath]
          @dpop                  = hash[:dpop]
          @htu                   = hash[:htu]
          @htm                   = hash[:htm]
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
