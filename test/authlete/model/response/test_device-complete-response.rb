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


class DeviceCompleteResponseTest < Minitest::Test
  RESULT_CODE    = '<result-code>'
  RESULT_MESSAGE = '<result-message>'
  ACTION         = 'SUCCESS'


  def generate_json
    return <<~JSON
      {
        "resultCode":    "<result-code>",
        "resultMessage": "<result-message>",
        "action":        "SUCCESS"
      }
    JSON
  end


  def match(obj)
    assert_equal RESULT_CODE,    obj.resultCode
    assert_equal RESULT_MESSAGE, obj.resultMessage
    assert_equal ACTION,         obj.action
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::DeviceVerificationResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual                = Authlete::Model::Response::DeviceVerificationResponse.new
    actual.result_code    = RESULT_CODE
    actual.result_message = RESULT_MESSAGE
    actual.action         = ACTION

    match(actual)
  end
end
