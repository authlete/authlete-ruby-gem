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


class TokenResponseTest < Minitest::Test
  RESULT_CODE              = '<result-code>'
  RESULT_MESSAGE           = '<result-message>'
  ACTION                   = 'OK'
  RESPONSE_CONTENT         = '<response-content>'
  USERNAME                 = '<username>'
  PASSWORD                 = '<password>'
  TICKET                   = '<ticket>'
  ACCESS_TOKEN             = '<access-token>'
  ACCESS_TOKEN_EXPIRES_AT  = 1000
  ACCESS_TOKEN_DURATION    = 100
  REFRESH_TOKEN            = '<refresh-token>'
  REFRESH_TOKEN_DURATION   = 200
  REFRESH_TOKEN_EXPIRES_AT = 1000
  ID_TOKEN                 = '<id-token>'
  GRANT_TYPE               = 'AUTHORIZATION_CODE'
  CLIENT_ID                = 12345
  CLIENT_ID_ALIAS          = '<client-id-alias>'
  CLIENT_ID_ALIAS_USED     = true
  SUBJECT                  = '<subject>'
  SCOPES                   = [ 'scope0', 'scope1' ]
  PROPERTY_KEY             = '<property0-key>'
  PROPERTY_VALUE           = '<property0-value>'
  PROPERTIES               = [ Authlete::Model::Property.new(key: PROPERTY_KEY, value: PROPERTY_VALUE) ]
  JWT_ACCESS_TOKEN         = '<jwt-access-token>'
  ACCESS_TOKEN_RESOURCES   = [ 'access-token-resource0', 'access-token-resource1' ]


  def generate_json
    return <<~JSON
      {
        "resultCode":            "<result-code>",
        "resultMessage":         "<result-message>",
        "action":                "OK",
        "responseContent":       "<response-content>",
        "username":              "<username>",
        "password":              "<password>",
        "ticket":                "<ticket>",
        "accessToken":           "<access-token>",
        "accessTokenExpiresAt":  1000,
        "accessTokenDuration":   100,
        "refreshToken":          "<refresh-token>",
        "refreshTokenDuration":  200,
        "refreshTokenExpiresAt": 1000,
        "idToken":               "<id-token>",
        "grantType":             "AUTHORIZATION_CODE",
        "clientId":              12345,
        "clientIdAlias":         "<client-id-alias>",
        "clientIdAliasUsed":     true,
        "subject":               "<subject>",
        "scopes":                [ "scope0", "scope1" ],
        "properties":             [ { "key": "<property0-key>", "value": "<property0-value>" } ],
        "jwtAccessToken":        "<jwt-access-token>",
        "accessTokenResources":  [ "access-token-resource0", "access-token-resource1" ]
      }
    JSON
  end


  def match(obj)
    assert_equal RESULT_CODE,              obj.resultCode
    assert_equal RESULT_MESSAGE,           obj.resultMessage
    assert_equal ACTION,                   obj.action
    assert_equal RESPONSE_CONTENT,         obj.responseContent
    assert_equal USERNAME,                 obj.username
    assert_equal PASSWORD,                 obj.password
    assert_equal TICKET,                   obj.ticket
    assert_equal ACCESS_TOKEN,             obj.accessToken
    assert_equal ACCESS_TOKEN_EXPIRES_AT,  obj.accessTokenExpiresAt
    assert_equal ACCESS_TOKEN_DURATION,    obj.accessTokenDuration
    assert_equal REFRESH_TOKEN,            obj.refreshToken
    assert_equal REFRESH_TOKEN_EXPIRES_AT, obj.refreshTokenExpiresAt
    assert_equal REFRESH_TOKEN_DURATION,   obj.refreshTokenDuration
    assert_equal ID_TOKEN,                 obj.idToken
    assert_equal GRANT_TYPE,               obj.grantType
    assert_equal CLIENT_ID,                obj.clientId
    assert_equal CLIENT_ID_ALIAS,          obj.clientIdAlias
    assert_equal CLIENT_ID_ALIAS_USED,     obj.clientIdAliasUsed
    assert_equal SUBJECT,                  obj.subject
    assert_equal SCOPES,                   obj.scopes
    assert_equal PROPERTY_KEY,             obj.properties[0].key
    assert_equal PROPERTY_VALUE,           obj.properties[0].value
    assert_equal JWT_ACCESS_TOKEN,         obj.jwtAccessToken
    assert_equal ACCESS_TOKEN_RESOURCES,   obj.accessTokenResources
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::TokenResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual                          = Authlete::Model::Response::TokenResponse.new
    actual.result_code              = RESULT_CODE
    actual.result_message           = RESULT_MESSAGE
    actual.action                   = ACTION
    actual.response_content         = RESPONSE_CONTENT
    actual.username                 = USERNAME
    actual.password                 = PASSWORD
    actual.ticket                   = TICKET
    actual.access_token             = ACCESS_TOKEN
    actual.access_token_expires_at  = ACCESS_TOKEN_EXPIRES_AT
    actual.access_token_duration    = ACCESS_TOKEN_DURATION
    actual.refresh_token            = REFRESH_TOKEN
    actual.refresh_token_expires_at = REFRESH_TOKEN_EXPIRES_AT
    actual.refresh_token_duration   = REFRESH_TOKEN_DURATION
    actual.id_token                 = ID_TOKEN
    actual.grant_type               = GRANT_TYPE
    actual.client_id                = CLIENT_ID
    actual.client_id_alias          = CLIENT_ID_ALIAS
    actual.client_id_alias_used     = CLIENT_ID_ALIAS_USED
    actual.subject                  = SUBJECT
    actual.scopes                   = SCOPES
    actual.properties               = PROPERTIES
    actual.jwt_access_token         = JWT_ACCESS_TOKEN
    actual.access_token_resources   = ACCESS_TOKEN_RESOURCES

    match(actual)
  end
end
