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


class BackchannelAuthenticationCompleteResponseTest < Minitest::Test
  RESULT_CODE                  = '<result-code>'
  RESULT_MESSAGE               = '<result-message>'
  ACTION                       = 'NOTIFICATION'
  RESPONSE_CONTENT             = '<response-content>'
  CLIENT_ID                    = 12345
  CLIENT_ID_ALIAS              = '<client-id-alias>'
  CLIENT_ID_ALIAS_USED         = false
  CLIENT_NAME                  = '<client-name>'
  DELIVERY_METHOD              = 'POLL'
  CLIENT_NOTIFICATION_ENDPOINT = '<client-notification-endpoint>'
  CLIENT_NOTIFICATION_TOKEN    = '<client-notification-token>'
  AUTH_REQ_ID                  = '<auth-req-id>'
  ACCESS_TOKEN                 = '<access-token>'
  REFRESH_TOKEN                = '<refresh-token>'
  ID_TOKEN                     = '<id-token>'
  ACCESS_TOKEN_DURATION        = 100
  REFRESH_TOKEN_DURATION       = 200
  ID_TOKEN_DURATION            = 300
  JWT_ACCESS_TOKEN             = '<jwt-access-token>'
  RESOURCES                    = [ 'resource0', 'resource1' ]


  def generate_json
    return <<~JSON
      {
        "resultCode":                 "<result-code>",
        "resultMessage":              "<result-message>",
        "action":                     "NOTIFICATION",
        "responseContent":            "<response-content>",
        "clientId":                   12345,
        "clientIdAlias":              "<client-id-alias>",
        "clientIdAliasUsed":          false,
        "clientName":                 "<client-name>",
        "deliveryMethod":             "POLL",
        "clientNotificationEndpoint": "<client-notification-endpoint>",
        "clientNotificationToken":    "<client-notification-token>",
        "authReqId":                  "<auth-req-id>",
        "accessToken":                "<access-token>",
        "refreshToken":               "<refresh-token>",
        "idToken":                    "<id-token>",
        "accessTokenDuration":        100,
        "refreshTokenDuration":       200,
        "idTokenDuration":            300,
        "jwtAccessToken":             "<jwt-access-token>",
        "resources":                  [ "resource0", "resource1" ]
      }
    JSON
  end


  def match(obj)
    assert_equal RESULT_CODE,                  obj.resultCode
    assert_equal RESULT_MESSAGE,               obj.resultMessage
    assert_equal ACTION,                       obj.action
    assert_equal RESPONSE_CONTENT,             obj.responseContent
    assert_equal CLIENT_ID,                    obj.clientId
    assert_equal CLIENT_ID_ALIAS,              obj.clientIdAlias
    assert_equal CLIENT_ID_ALIAS_USED,         obj.clientIdAliasUsed
    assert_equal CLIENT_NAME,                  obj.clientName
    assert_equal DELIVERY_METHOD,              obj.deliveryMethod
    assert_equal CLIENT_NOTIFICATION_ENDPOINT, obj.clientNotificationEndpoint
    assert_equal CLIENT_NOTIFICATION_TOKEN,    obj.clientNotificationToken
    assert_equal AUTH_REQ_ID,                  obj.authReqId
    assert_equal ACCESS_TOKEN,                 obj.accessToken
    assert_equal REFRESH_TOKEN,                obj.refreshToken
    assert_equal ID_TOKEN,                     obj.idToken
    assert_equal ACCESS_TOKEN_DURATION,        obj.accessTokenDuration
    assert_equal REFRESH_TOKEN_DURATION,       obj.refreshTokenDuration
    assert_equal ID_TOKEN_DURATION,            obj.idTokenDuration
    assert_equal JWT_ACCESS_TOKEN,             obj.jwtAccessToken
    assert_equal RESOURCES,                    obj.resources
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::BackchannelAuthenticationCompleteResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual                              = Authlete::Model::Response::BackchannelAuthenticationCompleteResponse.new
    actual.result_code                  = RESULT_CODE
    actual.result_message               = RESULT_MESSAGE
    actual.action                       = ACTION
    actual.response_content             = RESPONSE_CONTENT
    actual.client_id                    = CLIENT_ID
    actual.client_id_alias              = CLIENT_ID_ALIAS
    actual.client_id_alias_used         = CLIENT_ID_ALIAS_USED
    actual.client_name                  = CLIENT_NAME
    actual.delivery_method              = DELIVERY_METHOD
    actual.client_notification_endpoint = CLIENT_NOTIFICATION_ENDPOINT
    actual.client_notification_token    = CLIENT_NOTIFICATION_TOKEN
    actual.auth_req_id                  = AUTH_REQ_ID
    actual.access_token                 = ACCESS_TOKEN
    actual.refresh_token                = REFRESH_TOKEN
    actual.id_token                     = ID_TOKEN
    actual.access_token_duration        = ACCESS_TOKEN_DURATION
    actual.refresh_token_duration       = REFRESH_TOKEN_DURATION
    actual.id_token_duration            = ID_TOKEN_DURATION
    actual.jwt_access_token             = JWT_ACCESS_TOKEN
    actual.resources                    = RESOURCES

    match(actual)
  end
end
