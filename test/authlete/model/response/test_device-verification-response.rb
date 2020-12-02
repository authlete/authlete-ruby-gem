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


class DeviceVerificationResponseTest < Minitest::Test
  RESULT_CODE               = '<result-code>'
  RESULT_MESSAGE            = '<result-message>'
  ACTION                    = 'VALID'
  RESPONSE_CONTENT          = '<response-content>'
  CLIENT_ID                 = 12345
  CLIENT_ID_ALIAS           = '<client-id-alias>'
  CLIENT_ID_ALIAS_USED      = false
  CLIENT_NAME               = '<client-name>'
  SCOPE_NAME                = "scope0"
  SCOPE_DESCRIPTION         = "<scope0-description>"
  SCOPES                    = [ Authlete::Model::Scope.new(name: SCOPE_NAME, description: SCOPE_DESCRIPTION) ]
  CLIENT_NAMES              = [ 'client0', 'client1' ]
  ACRS                      = [ 'acr0', 'acr1' ]
  EXPIRES_AT                = 1000
  RESOURCES                 = [ 'resource0', 'resource1' ]


  def generate_json
    return <<~JSON
      {
        "resultCode":              "<result-code>",
        "resultMessage":           "<result-message>",
        "action":                  "VALID",
        "responseContent":         "<response-content>",
        "clientId":                12345,
        "clientIdAlias":           "<client-id-alias>",
        "clientIdAliasUsed":       false,
        "clientName":              "<client-name>",
        "scopes": [
          {
            "name":        "scope0",
            "description": "<scope0-description>"
          }
        ],
        "clientNames":             [ "client0", "client1" ],
        "acrs":                    [ "acr0", "acr1" ],
        "expiresAt":               1000,
        "resources":               [ "resource0", "resource1" ]
      }
    JSON
  end


  def match(obj)
    assert_equal RESULT_CODE,          obj.resultCode
    assert_equal RESULT_MESSAGE,       obj.resultMessage
    assert_equal ACTION,               obj.action
    assert_equal RESPONSE_CONTENT,     obj.responseContent
    assert_equal CLIENT_ID,            obj.clientId
    assert_equal CLIENT_ID_ALIAS,      obj.clientIdAlias
    assert_equal CLIENT_ID_ALIAS_USED, obj.clientIdAliasUsed
    assert_equal CLIENT_NAME,          obj.clientName
    assert_equal SCOPE_NAME,           obj.scopes[0].name
    assert_equal SCOPE_DESCRIPTION,    obj.scopes[0].description
    assert_equal CLIENT_NAMES,         obj.clientNames
    assert_equal ACRS,                 obj.acrs
    assert_equal EXPIRES_AT,           obj.expiresAt
    assert_equal RESOURCES,            obj.resources
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::DeviceVerificationResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual                      = Authlete::Model::Response::DeviceVerificationResponse.new
    actual.result_code          = RESULT_CODE
    actual.result_message       = RESULT_MESSAGE
    actual.action               = ACTION
    actual.response_content     = RESPONSE_CONTENT
    actual.client_id            = CLIENT_ID
    actual.client_id_alias      = CLIENT_ID_ALIAS
    actual.client_id_alias_used = CLIENT_ID_ALIAS_USED
    actual.client_name          = CLIENT_NAME
    actual.scopes               = SCOPES
    actual.client_names         = CLIENT_NAMES
    actual.acrs                 = ACRS
    actual.expires_at           = EXPIRES_AT
    actual.resources            = RESOURCES

    match(actual)
  end
end
