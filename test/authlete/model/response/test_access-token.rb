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


class AccessTokenTest < Minitest::Test
  ACCESS_TOKEN_HASH        = '<access-token-hash>'
  REFRESH_TOKEN_HASH       = '<refresh-token-hash>'
  CLIENT_ID                = 12345
  SUBJECT                  = '<subject>'
  GRANT_TYPE               = 'AUTHORIZATION_CODE'
  SCOPES                   = [ 'scope0', 'scope1' ]
  ACCESS_TOKEN_EXPIRES_AT  = 1000
  REFRESH_TOKEN_EXPIRES_AT = 1000
  CREATED_AT               = 10000
  LAST_REFRESHED_AT        = 10000
  PROPERTY_KEY             = '<property0-key>'
  PROPERTY_VALUE           = '<property0-value>'
  PROPERTY_HIDDEN          = true
  PROPERTIES               = [ Authlete::Model::Property.new(key: PROPERTY_KEY, value: PROPERTY_VALUE, hidden: PROPERTY_HIDDEN) ]


  def generate_json
    return <<~JSON
      {
        "accessTokenHash":       "<access-token-hash>",
        "refreshTokenHash":      "<refresh-token-hash>",
        "clientId":              12345,
        "subject":               "<subject>",
        "grantType":             "AUTHORIZATION_CODE",
        "scopes":                [ "scope0", "scope1" ],
        "accessTokenExpiresAt":  1000,
        "refreshTokenExpiresAt": 1000,
        "createdAt":             10000,
        "lastRefreshedAt":       10000,
        "properties":            [ { "key": "<property0-key>", "value": "<property0-value>", "hidden": true } ]
      }
    JSON
  end


  def match(obj)
    assert_equal ACCESS_TOKEN_HASH,        obj.accessTokenHash
    assert_equal REFRESH_TOKEN_HASH,       obj.refreshTokenHash
    assert_equal CLIENT_ID,                obj.clientId
    assert_equal SUBJECT,                  obj.subject
    assert_equal GRANT_TYPE,               obj.grantType
    assert_equal SCOPES,                   obj.scopes
    assert_equal ACCESS_TOKEN_EXPIRES_AT,  obj.accessTokenExpiresAt
    assert_equal REFRESH_TOKEN_EXPIRES_AT, obj.refreshTokenExpiresAt
    assert_equal CREATED_AT,               obj.createdAt
    assert_equal LAST_REFRESHED_AT,        obj.lastRefreshedAt
    assert_equal PROPERTY_KEY,             obj.properties[0].key
    assert_equal PROPERTY_VALUE,           obj.properties[0].value
    assert_equal PROPERTY_HIDDEN,          obj.properties[0].hidden
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::AccessToken.new(hsh)

    match(actual)
  end


  def test_setters
    actual                          = Authlete::Model::Response::AccessToken.new
    actual.access_token_hash        = ACCESS_TOKEN_HASH
    actual.refresh_token_hash       = REFRESH_TOKEN_HASH
    actual.client_id                = CLIENT_ID
    actual.subject                  = SUBJECT
    actual.grant_type               = GRANT_TYPE
    actual.scopes                   = SCOPES
    actual.access_token_expires_at  = ACCESS_TOKEN_EXPIRES_AT
    actual.refresh_token_expires_at = REFRESH_TOKEN_EXPIRES_AT
    actual.created_at               = CREATED_AT
    actual.last_refreshed_at        = LAST_REFRESHED_AT
    actual.properties               = PROPERTIES

    match(actual)
  end
end
