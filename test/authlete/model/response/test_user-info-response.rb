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


class UserInfoResponseTest < Minitest::Test
  RESULT_CODE          = '<result-code>'
  RESULT_MESSAGE       = '<result-message>'
  ACTION               = 'OK'
  CLIENT_ID            = 12345
  SUBJECT              = '<subject>'
  SCOPES               = [ 'scope0', 'scope1' ]
  CLAIMS               = [ 'claim0', 'claim1' ]
  TOKEN                = '<token>'
  RESPONSE_CONTENT     = '<response-content>'
  PROPERTY_KEY         = '<property0-key>'
  PROPERTY_VALUE       = '<property0-value>'
  PROPERTIES           = [ Authlete::Model::Property.new(key: PROPERTY_KEY, value: PROPERTY_VALUE) ]
  CLIENT_ID_ALIAS      = '<client-id-alias>'
  CLIENT_ID_ALIAS_USED = true
  USER_INFO_CLAIMS     = '<user-info-claims>'


  def generate_json
    return <<~JSON
      {
        "resultCode":        "<result-code>",
        "resultMessage":     "<result-message>",
        "action":            "OK",
        "clientId":          12345,
        "subject":           "<subject>",
        "scopes":            [ "scope0", "scope1" ],
        "claims":            [ "claim0", "claim1" ],
        "token":             "<token>",
        "responseContent":   "<response-content>",
        "properties":        [ { "key": "<property0-key>", "value": "<property0-value>" } ],
        "clientIdAlias":     "<client-id-alias>",
        "clientIdAliasUsed": true,
        "userInfoClaims":    "<user-info-claims>"
      }
    JSON
  end


  def match(obj)
    assert_equal RESULT_CODE,          obj.resultCode
    assert_equal RESULT_MESSAGE,       obj.resultMessage
    assert_equal ACTION,               obj.action
    assert_equal CLIENT_ID,            obj.clientId
    assert_equal SUBJECT,              obj.subject
    assert_equal SCOPES,               obj.scopes
    assert_equal CLAIMS,               obj.claims
    assert_equal TOKEN,                obj.token
    assert_equal RESPONSE_CONTENT,     obj.responseContent
    assert_equal PROPERTY_KEY,         obj.properties[0].key
    assert_equal PROPERTY_VALUE,       obj.properties[0].value
    assert_equal CLIENT_ID_ALIAS,      obj.clientIdAlias
    assert_equal CLIENT_ID_ALIAS_USED, obj.clientIdAliasUsed
    assert_equal USER_INFO_CLAIMS,     obj.userInfoClaims
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::UserInfoResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual                        = Authlete::Model::Response::UserInfoResponse.new
    actual.result_code            = RESULT_CODE
    actual.result_message         = RESULT_MESSAGE
    actual.action                 = ACTION
    actual.client_id              = CLIENT_ID
    actual.subject                = SUBJECT
    actual.scopes                 = SCOPES
    actual.claims                 = CLAIMS
    actual.token                  = TOKEN
    actual.response_content       = RESPONSE_CONTENT
    actual.properties             = PROPERTIES
    actual.client_id_alias        = CLIENT_ID_ALIAS
    actual.client_id_alias_used   = CLIENT_ID_ALIAS_USED
    actual.user_info_claims       = USER_INFO_CLAIMS

    match(actual)
  end
end
