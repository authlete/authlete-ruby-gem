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
      class BackchannelAuthenticationIssueResponse < Authlete::Model::Result

        attr_accessor :action

        attr_accessor :responseContent
        alias_method  :response_content,  :responseContent
        alias_method  :response_content=, :responseContent=

        attr_accessor :authReqId
        alias_method  :auth_req_id,  :authReqId
        alias_method  :auth_req_id=, :authReqId=

        attr_accessor :expiresIn
        alias_method  :expires_in,  :expiresIn
        alias_method  :expires_in=, :expiresIn=

        attr_accessor :interval

        private

        def defaults
          super.merge(
            action:          nil,
            responseContent: nil,
            authReqId:       nil,
            expiresIn:       0,
            interval:        0
          )
        end

        def set_params(hash)
          super(hash)

          @action          = hash[:action]
          @responseContent = hash[:responseContent]
          @authReqId       = hash[:authReqId]
          @expiresIn       = hash[:expiresIn]
          @interval        = hash[:interval]
        end
      end
    end
  end
end
