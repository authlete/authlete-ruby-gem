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
      @message    = extract_value(hash, :message)
      @statusCode = extract_integer_value(hash, :statusCode)
      @result     = Authlete::Model::Result.new(extract_value(hash, :result))
    end

    public

    def available_message
      @result.resultMessage || @message || self.class.default_message
    end

    def self.default_message
      self.name
    end

    def to_s
      "#{self.class.default_message} => { message:'#{@message}', status_code:'#{@statusCode}', " +
      "result_code:'#{@result.resultCode}', result_message:'#{@result.resultMessage}' }"
    end
  end
end