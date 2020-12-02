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


class BackchannelAuthenticationCompleteRequestTest < Minitest::Test
  TICKET            = '<ticket>'
  RESULT            = 'AUTHORIZED'
  SUBJECT           = '<subject>'
  SUB               = '<sub>'
  AUTH_TIME         = 100
  ACR               = '<acr>'
  CLAIMS            = [ 'claim0', 'claim1' ]
  PROPERTY_KEY      = '<prop-key0>'
  PROPERTY_VALUE    = '<prop-value0>'
  PROPERTIES        = [ Authlete::Model::Property.new(key: PROPERTY_KEY, value: PROPERTY_VALUE) ]
  SCOPES            = [ 'scope0', 'scope1' ]
  ERROR_DESCRIPTION = '<error-description>'
  ERROR_URI         = '<error-uri>'


  def set_params(obj)
    obj.ticket            = TICKET
    obj.result            = RESULT
    obj.subject           = SUBJECT
    obj.sub               = SUB
    obj.auth_time         = AUTH_TIME
    obj.acr               = ACR
    obj.claims            = CLAIMS
    obj.properties        = PROPERTIES
    obj.scopes            = SCOPES
    obj.error_description = ERROR_DESCRIPTION
    obj.error_uri         = ERROR_URI
  end


  def match(obj)
    assert_equal TICKET,            obj.ticket
    assert_equal RESULT,            obj.result
    assert_equal SUBJECT,           obj.subject
    assert_equal SUB,               obj.sub
    assert_equal AUTH_TIME,         obj.authTime
    assert_equal ACR,               obj.acr
    assert_equal CLAIMS,            obj.claims
    assert_equal PROPERTY_KEY,      obj.properties[0].key
    assert_equal PROPERTY_VALUE,    obj.properties[0].value
    assert_equal SCOPES,            obj.scopes
    assert_equal ERROR_DESCRIPTION, obj.errorDescription
    assert_equal ERROR_URI,         obj.errorUri
  end


  def generate_hash
    {
      ticket:           '<ticket>',
      result:           'AUTHORIZED',
      subject:          '<subject>',
      sub:              '<sub>',
      authTime:         100,
      acr:              '<acr>',
      claims:           [ 'claim0', 'claim1' ],
      properties:       [ { key: '<prop-key0>', value: '<prop-value0>', hidden: false } ],
      scopes:           [ 'scope0', 'scope1' ],
      errorDescription: '<error-description>',
      errorUri:         '<error-uri>'
    }
  end


  def test_setters
    actual = Authlete::Model::Request::BackchannelAuthenticationCompleteRequest.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::Request::BackchannelAuthenticationCompleteRequest.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
