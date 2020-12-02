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


class TokenUpdateRequestTest < Minitest::Test
  ACCESS_TOKEN            = '<access-token>'
  ACCESS_TOKEN_EXPIRES_AT = 1000
  SCOPES                  = [ 'scope0', 'scope1' ]
  PROPERTY_KEY            = '<property0-key>'
  PROPERTY_VALUE          = '<property0-value>'
  PROPERTIES              = [ Authlete::Model::Property.new(key: PROPERTY_KEY, value: PROPERTY_VALUE) ]
  CERTIFICATE_THUMBPRINT  = '<certificate-thumbprint>'
  DPOP_KEY_THUMBPRINT     = '<dpop-key-thumbprint>'


  def set_params(obj)
    obj.access_token            = ACCESS_TOKEN
    obj.access_token_expires_at = ACCESS_TOKEN_EXPIRES_AT
    obj.scopes                  = SCOPES
    obj.properties              = PROPERTIES
    obj.certificate_thumbprint  = CERTIFICATE_THUMBPRINT
    obj.dpop_key_thumbprint     = DPOP_KEY_THUMBPRINT
  end


  def match(obj)
    assert_equal ACCESS_TOKEN,            obj.accessToken
    assert_equal ACCESS_TOKEN_EXPIRES_AT, obj.accessTokenExpiresAt
    assert_equal SCOPES,                  obj.scopes
    assert_equal PROPERTY_KEY,            obj.properties[0].key
    assert_equal PROPERTY_VALUE,          obj.properties[0].value
    assert_equal CERTIFICATE_THUMBPRINT,  obj.certificateThumbprint
    assert_equal DPOP_KEY_THUMBPRINT,     obj.dpopKeyThumbprint
  end


  def generate_hash
    {
      accessToken:           '<access-token>',
      accessTokenExpiresAt:  1000,
      scopes:                [ 'scope0', 'scope1' ],
      properties:            [ { key: '<property0-key>', value: '<property0-value>', hidden: false } ],
      certificateThumbprint: '<certificate-thumbprint>',
      dpopKeyThumbprint:     '<dpop-key-thumbprint>'
    }
  end


  def test_setters
    actual = Authlete::Model::Request::TokenUpdateRequest.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::Request::TokenUpdateRequest.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
