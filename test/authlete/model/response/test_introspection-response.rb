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


class IntrospectionResponseTest < Minitest::Test
  RESULT_CODE            = '<result-code>'
  RESULT_MESSAGE         = '<result-message>'
  ACTION                 = 'OK'
  CLIENT_ID              = 12345
  CLIENT_ID_ALIAS        = '<client-id-alias>'
  CLIENT_ID_ALIAS_USED   = false
  EXPIRES_AT             = 1000
  SUBJECT                = '<subject>'
  SCOPES                 = [ 'scope0', 'scope1' ]
  EXISTENT               = true
  USABLE                 = true
  SUFFICIENT             = true
  REFRESHABLE            = true
  RESPONSE_CONTENT       = '<response-content>'
  PROPERTY_KEY           = '<property0-key>'
  PROPERTY_VALUE         = '<property0-value>'
  PROPERTIES             = [ Authlete::Model::Property.new(key: PROPERTY_KEY, value: PROPERTY_VALUE) ]
  CERTIFICATE_THUMBPRINT = '<certificate-thumbprint>'
  RESOURCES              = [ 'resource0', 'resource1' ]
  ACCESS_TOKEN_RESOURCES = [ 'access-token-resource0', 'access-token-resource1' ]


  def generate_json
    return <<~JSON
      {
        "resultCode":             "<result-code>",
        "resultMessage":          "<result-message>",
        "action":                 "OK",
        "clientId":               12345,
        "clientIdAlias":          "<client-id-alias>",
        "clientIdAliasUsed":      false,
        "expiresAt":              1000,
        "subject":                "<subject>",
        "scopes":                 [ "scope0", "scope1" ],
        "existent":               true,
        "usable":                 true,
        "sufficient":             true,
        "refreshable":            true,
        "responseContent":        "<response-content>",
        "properties":             [ { "key": "<property0-key>", "value": "<property0-value>" } ],
        "certificateThumbprint" : "<certificate-thumbprint>",
        "resources":              [ "resource0", "resource1" ],
        "accessTokenResources":   [ "access-token-resource0", "access-token-resource1" ]
      }
    JSON
  end


  def match(obj)
    assert_equal RESULT_CODE,            obj.resultCode
    assert_equal RESULT_MESSAGE,         obj.resultMessage
    assert_equal ACTION,                 obj.action
    assert_equal CLIENT_ID,              obj.clientId
    assert_equal CLIENT_ID_ALIAS,        obj.clientIdAlias
    assert_equal CLIENT_ID_ALIAS_USED,   obj.clientIdAliasUsed
    assert_equal EXPIRES_AT,             obj.expiresAt
    assert_equal SUBJECT,                obj.subject
    assert_equal SCOPES,                 obj.scopes
    assert_equal EXISTENT,               obj.existent
    assert_equal USABLE,                 obj.usable
    assert_equal SUFFICIENT,             obj.sufficient
    assert_equal REFRESHABLE,            obj.refreshable
    assert_equal RESPONSE_CONTENT,       obj.responseContent
    assert_equal PROPERTY_KEY,           obj.properties[0].key
    assert_equal PROPERTY_VALUE,         obj.properties[0].value
    assert_equal CERTIFICATE_THUMBPRINT, obj.certificateThumbprint
    assert_equal RESOURCES,              obj.resources
    assert_equal ACCESS_TOKEN_RESOURCES, obj.accessTokenResources
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::IntrospectionResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual                        = Authlete::Model::Response::IntrospectionResponse.new
    actual.result_code            = RESULT_CODE
    actual.result_message         = RESULT_MESSAGE
    actual.action                 = ACTION
    actual.client_id              = CLIENT_ID
    actual.client_id_alias        = CLIENT_ID_ALIAS
    actual.client_id_alias_used   = CLIENT_ID_ALIAS_USED
    actual.expires_at             = EXPIRES_AT
    actual.subject                = SUBJECT
    actual.scopes                 = SCOPES
    actual.existent               = EXISTENT
    actual.usable                 = USABLE
    actual.sufficient             = SUFFICIENT
    actual.refreshable            = REFRESHABLE
    actual.response_content       = RESPONSE_CONTENT
    actual.properties             = PROPERTIES
    actual.certificate_thumbprint = CERTIFICATE_THUMBPRINT
    actual.resources              = RESOURCES
    actual.access_token_resources = ACCESS_TOKEN_RESOURCES

    match(actual)
  end
end
