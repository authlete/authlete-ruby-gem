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
  class Exception < StandardError
    # The HTTP status code of the error.
    attr_reader :status_code

    # The code of the result of an Authlete API call.
    attr_reader :result_code

    # The messasge of the result of an Authlete API call.
    attr_reader :result_message

    private

    def initialize(hash = {})
      @message        = hash[:message]
      @status_code    = hash[:statusCode]
      @result_code    = hash[:resultCode]
      @result_message = hash[:resultMessage]
    end

    public

    def message
      @result_message || @message || self.class.default_message
    end

    def self.default_message
      self.name
    end

    def to_s
      super + " { status_code:'#{@status_code}', message:'#{@message}',"
            + " result_code:'#{@result_code}', result_message:'#{@result_message}' }"
    end
  end
end