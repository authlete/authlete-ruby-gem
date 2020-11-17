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
  class Exception < StandardError
    include Authlete::ParamInitializer

    attr_accessor :message

    attr_accessor :statusCode
    alias_method  :status_code, :statusCode
    alias_method  :status_code=, :statusCode=

    attr_accessor :result

    private

    def defaults
      {
        message:    nil,
        statusCode: 0,
        result:     nil
      }
    end

    def set_params(hash)
      @message    = hash[:message]
      @statusCode = hash[:statusCode]
      @result     = Authlete::Model::Result.parse(hash[:result])
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
