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
  class Exception < StandardError
    include Authlete::Utility

    # The error message.
    attr_accessor :message

    # The HTTP status code of the error.
    attr_accessor :statusCode
    alias_method  :status_code, :statusCode
    alias_method  :status_code=, :statusCode=

    # The result of the API call.
    attr_accessor :result

    private

    def initialize(hash = {})
      # The error message from RestClient or the other general exceptions.
      @message = extract_value(hash, :message)

      # HTTP status code.
      @statusCode = extract_integer_value(hash, :statusCode)

      # Set result.
      result = extract_value(hash, :result)
      @result = result.nil? ? nil : Authlete::Model::Result.new(result)
    end

    public

    def result_code
      @result && @result.resultCode
    end

    def result_message
      @result && @result.resultMessage
    end

    def available_message
      result_message || @message || self.class.default_message
    end

    def to_s
      "#{self.class.default_message} => { message:'#{@message}', status_code:'#{@statusCode}', " +
      "result_code:'#{result_code}', result_message:'#{result_message}' }"
    end

    def self.default_message
      self.name
    end
  end
end