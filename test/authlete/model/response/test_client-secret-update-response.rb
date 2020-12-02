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


class ClientSecretUpdateResponseTest < Minitest::Test
  RESULT_CODE       = '<result-code>'
  RESULT_MESSAGE    = '<result-message>'
  NEW_CLEINT_SECRET = '<new-client-secret>'
  OLD_CLIENT_SECRET = '<old-client-secret>'


  def generate_json
    return <<~JSON
      {
        "resultCode":      "<result-code>",
        "resultMessage":   "<result-message>",
        "newClientSecret": "<new-client-secret>",
        "oldClientSecret": "<old-client-secret>"
      }
    JSON
  end


  def match(obj)
    assert_equal RESULT_CODE,       obj.resultCode
    assert_equal RESULT_MESSAGE,    obj.resultMessage
    assert_equal NEW_CLEINT_SECRET, obj.newClientSecret
    assert_equal OLD_CLIENT_SECRET, obj.oldClientSecret
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::ClientSecretUpdateResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual                   = Authlete::Model::Response::ClientSecretUpdateResponse.new
    actual.result_code       = RESULT_CODE
    actual.result_message    = RESULT_MESSAGE
    actual.new_client_secret = NEW_CLEINT_SECRET
    actual.old_client_secret = OLD_CLIENT_SECRET

    match(actual)
  end
end
