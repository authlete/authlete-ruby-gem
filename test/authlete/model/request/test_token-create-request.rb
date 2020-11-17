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
require 'minitest/autorun'


class TokenCreateRequestTest < Minitest::Test
  GRANT_TYPE              = 'AUTHORIZATION_CODE'
  CLIENT_ID               = 12345
  SUBJECT                 = '<subject>'
  SCOPES                  = [ 'scope0', 'scope1' ]
  ACCESS_TOKEN_DURATION   = 10000
  REFRESH_TOKEN_DURATION  = 10000
  PROPERTY_KEY            = '<property0-key>'
  PROPERTY_VALUE          = '<property0-value>'
  PROPERTIES              = [ Authlete::Model::Property.new(key: PROPERTY_KEY, value: PROPERTY_VALUE) ]
  CLIENT_ID_ALIAS         = true
  ACCESS_TOKEN            = '<access-token>'
  REFRESH_TOKEN           = '<refresh-token>'
  ACCESS_TOKEN_PERSISTENT = false
  CERTIFICATE_THUMBPRINT  = '<certificate-thumbprint>'
  DPOP_KEY_THUMBPRINT     = '<dpop-key-thumbprint>'


  def set_params(obj)
    obj.grant_type              = GRANT_TYPE
    obj.client_id               = CLIENT_ID
    obj.subject                 = SUBJECT
    obj.scopes                  = SCOPES
    obj.access_token_duration   = ACCESS_TOKEN_DURATION
    obj.refresh_token_duration  = REFRESH_TOKEN_DURATION
    obj.properties              = PROPERTIES
    obj.client_id_alias         = CLIENT_ID_ALIAS
    obj.access_token            = ACCESS_TOKEN
    obj.refresh_token           = REFRESH_TOKEN
    obj.access_token_persistent = ACCESS_TOKEN_PERSISTENT
    obj.certificate_thumbprint  = CERTIFICATE_THUMBPRINT
    obj.dpop_key_thumbprint     = DPOP_KEY_THUMBPRINT
  end


  def match(obj)
    assert_equal GRANT_TYPE,              obj.grantType
    assert_equal CLIENT_ID,               obj.clientId
    assert_equal SUBJECT,                 obj.subject
    assert_equal SCOPES,                  obj.scopes
    assert_equal ACCESS_TOKEN_DURATION,   obj.accessTokenDuration
    assert_equal REFRESH_TOKEN_DURATION,  obj.refreshTokenDuration
    assert_equal PROPERTY_KEY,            obj.properties[0].key
    assert_equal PROPERTY_VALUE,          obj.properties[0].value
    assert_equal CLIENT_ID_ALIAS,         obj.clientIdAlias
    assert_equal ACCESS_TOKEN,            obj.accessToken
    assert_equal REFRESH_TOKEN,           obj.refreshToken
    assert_equal ACCESS_TOKEN_PERSISTENT, obj.accessTokenPersistent
    assert_equal CERTIFICATE_THUMBPRINT,  obj.certificateThumbprint
    assert_equal DPOP_KEY_THUMBPRINT,     obj.dpopKeyThumbprint
  end


  def generate_hash
    {
      grantType:             'AUTHORIZATION_CODE',
      clientId:              12345,
      subject:               '<subject>',
      scopes:                [ 'scope0', 'scope1' ],
      accessTokenDuration:   10000,
      refreshTokenDuration:  10000,
      properties:            [ { key: '<property0-key>', value: '<property0-value>', hidden: false } ],
      clientIdAlias:         true,
      accessToken:           '<access-token>',
      refreshToken:          '<refresh-token>',
      accessTokenPersistent: false,
      certificateThumbprint: '<certificate-thumbprint>',
      dpopKeyThumbprint:     '<dpop-key-thumbprint>'
    }
  end


  def test_setters
    actual = Authlete::Model::Request::TokenCreateRequest.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::Request::TokenCreateRequest.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
