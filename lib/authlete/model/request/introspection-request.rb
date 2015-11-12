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
    module Request
      # == Authlete::Model::Request::IntrospectionRequest class
      #
      # This class represents a request to Authlete's /api/auth/introspection API.
      class IntrospectionRequest
        include Authlete::Utility
        # The constructor which takes a hash that represents a JSON request
        # to Authlete's /api/auth/introspection API.
        def initialize(hash = {})
        end

        # Parse a JSON string which represents a request to
        # Authlete's /api/auth/introspection API
        # and generate an instance of IntrospectionRequest.
        def self.parse(json)
          IntrospectionRequest.new(parse_json(json))
        end
      end
    end
  end
end
