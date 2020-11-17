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


class DeviceAuthorizationResponseTest < Minitest::Test
  RESULT_CODE               = '<result-code>'
  RESULT_MESSAGE            = '<result-message>'
  ACTION                    = 'OK'
  RESPONSE_CONTENT          = '<response-content>'
  CLIENT_ID                 = 12345
  CLIENT_ID_ALIAS           = '<client-id-alias>'
  CLIENT_ID_ALIAS_USED      = false
  CLIENT_NAME               = '<client-name>'
  CLIENT_AUTH_METHOD        = 'BASIC'
  SCOPE_NAME                = "scope0"
  SCOPE_DESCRIPTION         = "<scope0-description>"
  SCOPES                    = [ Authlete::Model::Scope.new(name: SCOPE_NAME, description: SCOPE_DESCRIPTION) ]
  CLIENT_NAMES              = [ 'client0', 'client1' ]
  ACRS                      = [ 'acr0', 'acr1' ]
  DEVICE_CODE               = '<device-code>'
  USER_CODE                 = '<user-code>'
  VERIFICATION_URI          = '<verification-uri>'
  VERIFICATION_URI_COMPLETE = '<verification-uri-complete>'
  EXPIRES_IN                = 1000
  INTERVAL                  = 100
  RESOURCES                 = [ 'resource0', 'resource1' ]
  WARNINGS                  = [ 'warning0', 'warning1' ]


  def generate_json
    return <<~JSON
      {
        "resultCode":             "<result-code>",
        "resultMessage":          "<result-message>",
        "action":                  "OK",
        "responseContent":         "<response-content>",
        "clientId":                12345,
        "clientIdAlias":           "<client-id-alias>",
        "clientIdAliasUsed":       false,
        "clientName":              "<client-name>",
        "clientAuthMethod":        "BASIC",
        "scopes": [
          {
            "name":        "scope0",
            "description": "<scope0-description>"
          }
        ],
        "clientNames":             [ "client0", "client1" ],
        "acrs":                    [ "acr0", "acr1" ],
        "deviceCode":              "<device-code>",
        "userCode":                "<user-code>",
        "verificationUri":         "<verification-uri>",
        "verificationUriComplete": "<verification-uri-complete>",
        "expiresIn":               1000,
        "interval":                100,
        "resources":               [ "resource0", "resource1" ],
        "warnings":                [ "warning0", "warning1" ]
      }
    JSON
  end


  def match(obj)
    assert_equal RESULT_CODE,               obj.resultCode
    assert_equal RESULT_MESSAGE,            obj.resultMessage
    assert_equal ACTION,                    obj.action
    assert_equal RESPONSE_CONTENT,          obj.responseContent
    assert_equal CLIENT_ID,                 obj.clientId
    assert_equal CLIENT_ID_ALIAS,           obj.clientIdAlias
    assert_equal CLIENT_ID_ALIAS_USED,      obj.clientIdAliasUsed
    assert_equal CLIENT_NAME,               obj.clientName
    assert_equal CLIENT_AUTH_METHOD,        obj.clientAuthMethod
    assert_equal SCOPE_NAME,                obj.scopes[0].name
    assert_equal SCOPE_DESCRIPTION,         obj.scopes[0].description
    assert_equal CLIENT_NAMES,              obj.clientNames
    assert_equal ACRS,                      obj.acrs
    assert_equal DEVICE_CODE,               obj.deviceCode
    assert_equal USER_CODE,                 obj.userCode
    assert_equal VERIFICATION_URI,          obj.verificationUri
    assert_equal VERIFICATION_URI_COMPLETE, obj.verificationUriComplete
    assert_equal EXPIRES_IN,                obj.expiresIn
    assert_equal INTERVAL,                  obj.interval
    assert_equal RESOURCES,                 obj.resources
    assert_equal WARNINGS,                  obj.warnings
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::DeviceAuthorizationResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual                           = Authlete::Model::Response::DeviceAuthorizationResponse.new
    actual.result_code               = RESULT_CODE
    actual.result_message            = RESULT_MESSAGE
    actual.action                    = ACTION
    actual.response_content          = RESPONSE_CONTENT
    actual.client_id                 = CLIENT_ID
    actual.client_id_alias           = CLIENT_ID_ALIAS
    actual.client_id_alias_used      = CLIENT_ID_ALIAS_USED
    actual.client_name               = CLIENT_NAME
    actual.client_auth_method        = CLIENT_AUTH_METHOD
    actual.scopes                    = SCOPES
    actual.client_names              = CLIENT_NAMES
    actual.acrs                      = ACRS
    actual.device_code               = DEVICE_CODE
    actual.user_code                 = USER_CODE
    actual.verification_uri          = VERIFICATION_URI
    actual.verification_uri_complete = VERIFICATION_URI_COMPLETE
    actual.expires_in                = EXPIRES_IN
    actual.interval                  = INTERVAL
    actual.resources                 = RESOURCES
    actual.warnings                  = WARNINGS

    match(actual)
  end
end
