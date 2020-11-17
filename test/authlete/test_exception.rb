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


require 'authlete'
require 'json'
require 'minitest/autorun'


class ExceptionTest < Minitest::Test
  MESSAGE        = '<message>'
  STATUS_CODE    = 500
  RESULT_CODE    = '<result-code>'
  RESULT_MESSAGE = '<result-message>'
  RESULT         = Authlete::Model::Result.new(resultCode: RESULT_CODE, resultMessage: RESULT_MESSAGE)


  def generate_json
    return <<~JSON
      {
        "message":    "<message>",
        "statusCode": 500,
        "result":     {
          "resultCode":    "<result-code>",
          "resultMessage": "<result-message>"
        }
      }
    JSON
  end


  def match(obj)
    assert_equal MESSAGE,        obj.message
    assert_equal STATUS_CODE,    obj.statusCode
    assert_equal RESULT_CODE,    obj.result.resultCode
    assert_equal RESULT_MESSAGE, obj.result.resultMessage
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Exception.new(hsh)

    match(actual)
  end


  def test_setters
    actual             = Authlete::Exception.new
    actual.message     = MESSAGE
    actual.status_code = STATUS_CODE
    actual.result      = RESULT

    match(actual)
  end
end
