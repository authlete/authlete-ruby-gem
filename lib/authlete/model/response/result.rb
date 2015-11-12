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
      # == Authlete::Model::Response::BaseResponse
      #
      # The base class of responses from Authlete Web APIs.
      class Result
        include Authlete::Utility
        # The code assigned to the result of the API call.
        # (String)
        attr_accessor :result_code

        # The message about the result of the API call.
        # (String)
        attr_accessor :result_message

        private

        # The constructor which takes a hash that represents a JSON response
        # from /api/auth/introspection API.
        def initialize(hash = {})
          @result_code      = extract_value(hash, :resultCode)
          @response_content = extract_value(hash, :responseContent)
        end
      end
    end
  end
end