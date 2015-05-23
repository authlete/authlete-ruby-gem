# :nodoc:
#
# Copyright (C) 2015 Authlete, Inc.
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
    class Scope
      # The description about this scope. (String)
      attr_accessor :description

      # The name of this scope. (String)
      attr_accessor :name

      # The flag to indicate whether this scope is included in the
      # default scope set. (boolean)
      attr_accessor :defaultEntry
    end
  end
end