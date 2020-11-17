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


class AuthorizationIssueResponseTest < Minitest::Test
  RESULT_CODE             = '<result-code>'
  RESULT_MESSAGE          = '<result-message>'
  ACTION                  = 'LOCATION'
  RESPONSE_CONTENT        = '<response-content>'
  ACCESS_TOKEN            = '<access-token>'
  ACCESS_TOKEN_EXPIRES_AT = 1000
  ACCESS_TOKEN_DURATION   = 300
  ID_TOKEN                = '<id-token>'
  AUTHORIZATION_CODE      = '<authorization-code>'
  JWT_ACCESS_TOKEN        = '<jwt-access-token>'


  def generate_json
    return <<~JSON
      {
        "resultCode":           "<result-code>",
        "resultMessage":        "<result-message>",
        "action":               "LOCATION",
        "responseContent":      "<response-content>",
        "accessToken":          "<access-token>",
        "accessTokenExpiresAt": 1000,
        "accessTokenDuration":  300,
        "idToken":              "<id-token>",
        "authorizationCode":    "<authorization-code>",
        "jwtAccessToken":       "<jwt-access-token>"
      }
    JSON
  end


  def match(obj)
    assert_equal RESULT_CODE,             obj.resultCode
    assert_equal RESULT_MESSAGE,          obj.resultMessage
    assert_equal ACTION,                  obj.action
    assert_equal RESPONSE_CONTENT,        obj.responseContent
    assert_equal ACCESS_TOKEN,            obj.accessToken
    assert_equal ACCESS_TOKEN_EXPIRES_AT, obj.accessTokenExpiresAt
    assert_equal ACCESS_TOKEN_DURATION,   obj.accessTokenDuration
    assert_equal ID_TOKEN,                obj.idToken
    assert_equal AUTHORIZATION_CODE,      obj.authorizationCode
    assert_equal JWT_ACCESS_TOKEN,        obj.jwtAccessToken
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::AuthorizationIssueResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual                         = Authlete::Model::Response::AuthorizationIssueResponse.new
    actual.result_code             = RESULT_CODE
    actual.result_message          = RESULT_MESSAGE
    actual.action                  = ACTION
    actual.response_content        = RESPONSE_CONTENT
    actual.access_token            = ACCESS_TOKEN
    actual.access_token_expires_at = ACCESS_TOKEN_EXPIRES_AT
    actual.access_token_duration   = ACCESS_TOKEN_DURATION
    actual.id_token                = ID_TOKEN
    actual.authorization_code      = AUTHORIZATION_CODE
    actual.jwt_access_token        = JWT_ACCESS_TOKEN

    match(actual)
  end
end
