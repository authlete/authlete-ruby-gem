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
    class Result < Authlete::Model::Base
      include Authlete::Utility

      attr_accessor :resultCode
      alias_method  :result_code, :resultCode
      alias_method  :result_code=, :resultCode=

      attr_accessor :resultMessage
      alias_method  :result_message, :resultMessage
      alias_method  :result_message=, :resultMessage=

      private

      def defaults
        {
          resultCode:    nil,
          resultMessage: nil
        }
      end

      def set_params(hash)
        @resultCode    = hash[:resultCode]
        @resultMessage = hash[:resultMessage]
      end
    end
  end
end
