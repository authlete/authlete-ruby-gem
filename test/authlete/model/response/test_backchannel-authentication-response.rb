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


class BackchannelAuthenticationResponseTest < Minitest::Test
  RESULT_CODE               = '<result-code>'
  RESULT_MESSAGE            = '<result-message>'
  ACTION                    = 'USER_IDENTIFICATION'
  RESPONSE_CONTENT          = '<response-content>'
  CLIENT_ID                 = 12345
  CLIENT_ID_ALIAS           = '<client-id-alias>'
  CLIENT_ID_ALIAS_USED      = false
  CLIENT_NAME               = '<client-name>'
  CLIENT_AUTH_METHOD        = 'BASIC'
  DELIVERY_METHOD           = 'POLL'
  SCOPE_NAME                = "scope0"
  SCOPE_DESCRIPTION         = "<scope0-description>"
  SCOPES                    = [ Authlete::Model::Scope.new(name: SCOPE_NAME, description: SCOPE_DESCRIPTION) ]
  CLIENT_NAMES              = [ 'client0', 'client1' ]
  CLIENT_NOTIFICATION_TOKEN = '<client-notification-token>'
  ACRS                      = [ 'acr0', 'acr1' ]
  HINT_TYPE                 = 'LOGIN_HINT'
  SUB                       = '<sub>'
  BINDING_MESSAGE           = '<binding-message>'
  USER_CODE                 = '<user-code>'
  USER_CODE_REQUIRED        = true
  REQUESTED_EXPIRY          = 100
  REQUEST_CONTEXT           = '<request-context>'
  RESOURCES                 = [ 'resource0', 'resource1' ]
  WARNINGS                  = [ 'warning0', 'warning1' ]
  TICKET                    = "<ticket>"


  def generate_json
    return <<~JSON
      {
        "resultCode":              "<result-code>",
        "resultMessage":           "<result-message>",
        "action":                  "USER_IDENTIFICATION",
        "responseContent":         "<response-content>",
        "clientId":                12345,
        "clientIdAlias":           "<client-id-alias>",
        "clientIdAliasUsed":       false,
        "clientName":              "<client-name>",
        "clientAuthMethod":        "BASIC",
        "deliveryMethod":          "POLL",
        "scopes": [
          {
            "name":         "scope0",
            "description":  "<scope0-description>"
          }
        ],
        "clientNames":             [ "client0", "client1" ],
        "clientNotificationToken": "<client-notification-token>",
        "acrs":                    ["acr0", "acr1"],
        "hintType":                "LOGIN_HINT",
        "sub":                     "<sub>",
        "bindingMessage":          "<binding-message>",
        "userCode":                "<user-code>",
        "userCodeRequired":        true,
        "requestedExpiry":         100,
        "requestContext":          "<request-context>",
        "resources":               [ "resource0", "resource1" ],
        "warnings":                [ "warning0", "warning1" ],
        "ticket":                  "<ticket>"
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
    assert_equal DELIVERY_METHOD,           obj.deliveryMethod
    assert_equal SCOPE_NAME,                obj.scopes[0].name
    assert_equal SCOPE_DESCRIPTION,         obj.scopes[0].description
    assert_equal CLIENT_NAMES,              obj.clientNames
    assert_equal CLIENT_NOTIFICATION_TOKEN, obj.clientNotificationToken
    assert_equal ACRS,                      obj.acrs
    assert_equal HINT_TYPE,                 obj.hintType
    assert_equal SUB,                       obj.sub
    assert_equal BINDING_MESSAGE,           obj.bindingMessage
    assert_equal USER_CODE,                 obj.userCode
    assert_equal USER_CODE_REQUIRED,        obj.userCodeRequired
    assert_equal REQUESTED_EXPIRY,          obj.requestedExpiry
    assert_equal REQUEST_CONTEXT,           obj.requestContext
    assert_equal RESOURCES,                 obj.resources
    assert_equal WARNINGS,                  obj.warnings
    assert_equal TICKET,                    obj.ticket
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::BackchannelAuthenticationResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual                           = Authlete::Model::Response::BackchannelAuthenticationResponse.new
    actual.result_code               = RESULT_CODE
    actual.result_message            = RESULT_MESSAGE
    actual.action                    = ACTION
    actual.response_content          = RESPONSE_CONTENT
    actual.client_id                 = CLIENT_ID
    actual.client_id_alias           = CLIENT_ID_ALIAS
    actual.client_id_alias_used      = CLIENT_ID_ALIAS_USED
    actual.client_name               = CLIENT_NAME
    actual.client_auth_method        = CLIENT_AUTH_METHOD
    actual.delivery_method           = DELIVERY_METHOD
    actual.scopes                    = SCOPES
    actual.client_names              = CLIENT_NAMES
    actual.client_notification_token = CLIENT_NOTIFICATION_TOKEN
    actual.acrs                      = ACRS
    actual.hint_type                 = HINT_TYPE
    actual.sub                       = SUB
    actual.binding_message           = BINDING_MESSAGE
    actual.user_code                 = USER_CODE
    actual.user_code_required        = USER_CODE_REQUIRED
    actual.requested_expiry          = REQUESTED_EXPIRY
    actual.request_context           = REQUEST_CONTEXT
    actual.resources                 = RESOURCES
    actual.warnings                  = WARNINGS
    actual.ticket                    = TICKET

    match(actual)
  end
end
