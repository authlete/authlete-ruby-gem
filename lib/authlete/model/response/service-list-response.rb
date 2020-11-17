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
      class ServiceListResponse < Authlete::Model::Base
        include Authlete::Utility

        attr_accessor :start

        attr_accessor :end

        attr_accessor :totalCount
        alias_method  :total_count,  :totalCount
        alias_method  :total_count=, :totalCount=

        attr_accessor :services

        private

        def defaults
          {
            start:      0,
            end:        0,
            totalCount: 0,
            services:   nil
          }
        end

        def set_params(hash)
          @start      = hash[:start]
          @end        = hash[:end]
          @totalCount = hash[:totalCount]
          @services   = get_parsed_array(hash[:services]) { |e| Authlete::Model::Service.parse(e) }
        end
      end
    end
  end
end
