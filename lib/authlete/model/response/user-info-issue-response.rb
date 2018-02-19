# :nodoc:
#
# Copyright (C) 2014-2018 Authlete, Inc.
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
      # == Authlete::Model::Response::UserInfoIssueResponse class
      #
      # A class that represents a response from Authlete's
      # /api/auth/userinfo/issue API.
      class UserInfoIssueResponse < Authlete::Model::Result
        # The next action which the caller of the API should take next.
        # (String)
        attr_accessor :action

        # The content of the error response that the service implementation
        # should return to the client application. (String)
        attr_accessor :response_content
        alias_method  :response_content,  :responseContent
        alias_method  :response_content=, :responseContent=

        # The constructor which takes a hash that represents a JSON response
        # from /api/auth/userinfo/issue API.
        def initialize(hash = {})
          super(hash)

          @action          = extract_value(hash, :action)
          @responseContent = extract_value(hash, :responseContent)
        end
      end
    end
  end
end