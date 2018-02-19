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
      # == Authlete::Model::Response::ServiceCreatableResponse class
      class ServiceCreatableResponse
        include Authlete::Utility
        # A boolean flag to indicate whether the service owner can
        # create a new service or not.
        attr_accessor :creatable

        # The number of services that the service owner currently has.
        attr_accessor :count

        # The maximum number of services allowed in the plan of the
        # service owner.
        attr_accessor :limit

        # The plan of the service owner.
        attr_accessor :plan

        # The constructor which takes a hash that represents a JSON
        # response from /api/service/creatable API.
        def initialize(hash = {})
          @creatable = extract_boolean_value(hash, :creatable)
          @count     = extract_integer_value(hash, :count)
          @limit     = extract_integer_value(hash, :limit)
          @plan      = extract_value(hash, :plan)
        end

        alias_method :creatable?, :creatable
      end
    end
  end
end