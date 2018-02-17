# :nodoc:
#
# Copyright (C) 2014-2015 Authlete, Inc.
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
      # == Authlete::Model::Response::ClientAuthorizationGetListResponse class
      #
      # This class represents a response from Authlete's /api/client/authorization/get/list API.
      class ClientAuthorizationGetListResponse
        # Start index of search results (inclusive).
        # (Integer)
        attr_accessor :start

        # End index of search results (exclusive).
        # (Integer)
        attr_accessor :end

        # Unique Developer ID. (String)
        attr_accessor :developer

        # The total number of clients that meet the conditions. (Integer)
        attr_accessor :totalCount
        alias_method  :total_count,  :totalCount
        alias_method  :total_count=, :totalCount=

        # The list of clients. (Client array)
        attr_accessor :clients

        private

        # The constructor which takes a hash that represents a JSON response
        # from Authlete's /api/client/authorization/get/list API.
        def initialize(hash = {})
          @start      = extract_integer_value(hash, :start)
          @end        = extract_integer_value(hash, :end)
          @developer  = extract_value(hash, :developer)
          @totalCount = extract_integer_value(hash, :totalCount)
          @clients    = extract_array_value(hash, :clients) do |element|
            Authlete::Model::Client.parse(element)
          end
        end
      end
    end
  end
end