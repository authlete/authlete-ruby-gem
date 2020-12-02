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


class TokenRequestTest < Minitest::Test
  PARAMETERS              = '<parameters>'
  CLIENT_ID               = '<client-id>'
  CLIENT_SECRET           = '<client-secret>'
  PROPERTY_KEY            = '<property0-key>'
  PROPERTY_VALUE          = '<property0-value>'
  PROPERTIES              = [ Authlete::Model::Property.new(key: PROPERTY_KEY, value: PROPERTY_VALUE) ]
  CLIENT_CERTIFICATE      = '<client-certificate>'
  CLIENT_CERTIFICATE_PATH = [ 'path0', 'path1' ]
  DPOP                    = '<dpop>'
  HTU                     = '<htu>'
  HTM                     = '<htm>'


  def set_params(obj)
    obj.parameters              = PARAMETERS
    obj.client_id               = CLIENT_ID
    obj.client_secret           = CLIENT_SECRET
    obj.properties              = PROPERTIES
    obj.client_certificate      = CLIENT_CERTIFICATE
    obj.client_certificate_path = CLIENT_CERTIFICATE_PATH
    obj.dpop                    = DPOP
    obj.htu                     = HTU
    obj.htm                     = HTM
  end


  def match(obj)
    assert_equal PARAMETERS,              obj.parameters
    assert_equal CLIENT_ID,               obj.clientId
    assert_equal CLIENT_SECRET,           obj.clientSecret
    assert_equal PROPERTY_KEY,            obj.properties[0].key
    assert_equal PROPERTY_VALUE,          obj.properties[0].value
    assert_equal CLIENT_CERTIFICATE,      obj.clientCertificate
    assert_equal CLIENT_CERTIFICATE_PATH, obj.clientCertificatePath
    assert_equal DPOP,                    obj.dpop
    assert_equal HTU,                     obj.htu
    assert_equal HTM,                     obj.htm
  end


  def generate_hash
    {
      parameters:            '<parameters>',
      clientId:              '<client-id>',
      clientSecret:          '<client-secret>',
      properties:            [ { key: '<property0-key>', value: '<property0-value>', hidden: false } ],
      clientCertificate:     '<client-certificate>',
      clientCertificatePath: [ 'path0', 'path1' ],
      dpop:                  '<dpop>',
      htu:                   '<htu>',
      htm:                   '<htm>'
    }
  end


  def test_setters
    actual = Authlete::Model::Request::TokenRequest.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::Request::TokenRequest.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
