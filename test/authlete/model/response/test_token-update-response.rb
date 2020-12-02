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


class TokenUpdateResponseTest < Minitest::Test
  RESULT_CODE             = '<result-code>'
  RESULT_MESSAGE          = '<result-message>'
  ACTION                  = 'OK'
  ACCESS_TOKEN            = '<access-token>'
  TOKEN_TYPE              = 'Bearer'
  ACCESS_TOKEN_EXPIRES_AT = 1000
  SCOPES                  = [ 'scope0', 'scope1' ]
  PROPERTY_KEY            = '<property0-key>'
  PROPERTY_VALUE          = '<property0-value>'
  PROPERTIES              = [ Authlete::Model::Property.new(key: PROPERTY_KEY, value: PROPERTY_VALUE) ]


  def generate_json
    return <<~JSON
      {
        "resultCode":           "<result-code>",
        "resultMessage":        "<result-message>",
        "action":               "OK",
        "accessToken":          "<access-token>",
        "tokenType":            "Bearer",
        "accessTokenExpiresAt": 1000,
        "scopes":               [ "scope0", "scope1" ],
        "properties":           [ { "key": "<property0-key>", "value": "<property0-value>" } ]
      }
    JSON
  end


  def match(obj)
    assert_equal RESULT_CODE,             obj.resultCode
    assert_equal RESULT_MESSAGE,          obj.resultMessage
    assert_equal ACTION,                  obj.action
    assert_equal ACCESS_TOKEN,            obj.accessToken
    assert_equal TOKEN_TYPE,              obj.tokenType
    assert_equal ACCESS_TOKEN_EXPIRES_AT, obj.accessTokenExpiresAt
    assert_equal SCOPES,                  obj.scopes
    assert_equal PROPERTY_KEY,            obj.properties[0].key
    assert_equal PROPERTY_VALUE,          obj.properties[0].value
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::TokenUpdateResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual                         = Authlete::Model::Response::TokenUpdateResponse.new
    actual.result_code             = RESULT_CODE
    actual.result_message          = RESULT_MESSAGE
    actual.action                  = ACTION
    actual.access_token            = ACCESS_TOKEN
    actual.token_type              = TOKEN_TYPE
    actual.access_token_expires_at = ACCESS_TOKEN_EXPIRES_AT
    actual.scopes                  = SCOPES
    actual.properties              = PROPERTIES

    match(actual)
  end
end
