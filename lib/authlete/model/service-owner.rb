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
    class ServiceOwner < Authlete::Model::Base
      include Authlete::Model::Hashable
      include Authlete::Utility

      attr_accessor :number

      attr_accessor :name

      attr_accessor :email

      attr_accessor :loginId
      alias_method  :login_id,  :loginId
      alias_method  :login_id=, :loginId=

      attr_accessor :apiKey
      alias_method  :api_key,  :apiKey
      alias_method  :api_key=, :apiKey=

      attr_accessor :apiSecret
      alias_method  :api_secret,  :apiSecret
      alias_method  :api_secret=, :apiSecret=

      attr_accessor :plan

      private

      def defaults
        {
          number:    0,
          name:      nil,
          email:     nil,
          loginId:   nil,
          apiKey:    nil,
          apiSecret: nil,
          plan:      nil
        }
      end

      def set_params(hash)
        @number    = hash[:number]
        @name      = hash[:name]
        @email     = hash[:email]
        @loginId   = hash[:loginId]
        @apiKey    = hash[:apiKey]
        @apiSecret = hash[:apiSecret]
        @plan      = hash[:plan]
      end
    end
  end
end
