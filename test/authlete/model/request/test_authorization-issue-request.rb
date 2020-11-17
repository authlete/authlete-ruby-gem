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


class AuthorizationIssueRequestTest < Minitest::Test
  TICKET            = '<ticket>'
  SUBJECT           = '<subject>'
  AUTH_TIME         = 100
  ACR               = '<acr>'
  CLAIMS            = [ 'claim0', 'claim1' ]
  PROPERTY_KEY      = '<property0-key>'
  PROPERTY_VALUE    = '<property0-value>'
  PROPERTIES        = [ Authlete::Model::Property.new(key: PROPERTY_KEY, value: PROPERTY_VALUE) ]
  SCOPES            = [ 'scope0', 'scope1' ]
  SUB               = '<sub>'
  IDT_HEADER_PARAMS = '<idt-header-params>'


  def set_params(obj)
    obj.ticket          = TICKET
    obj.subject         = SUBJECT
    obj.auth_time       = AUTH_TIME
    obj.acr             = ACR
    obj.claims          = CLAIMS
    obj.properties      = PROPERTIES
    obj.scopes          = SCOPES
    obj.sub             = SUB
    obj.idtHeaderParams = IDT_HEADER_PARAMS
  end


  def match(obj)
    assert_equal TICKET,            obj.ticket
    assert_equal SUBJECT,           obj.subject
    assert_equal AUTH_TIME,         obj.authTime
    assert_equal ACR,               obj.acr
    assert_equal CLAIMS,            obj.claims
    assert_equal PROPERTY_KEY,      obj.properties[0].key
    assert_equal PROPERTY_VALUE,    obj.properties[0].value
    assert_equal SCOPES,            obj.scopes
    assert_equal SUB,               obj.sub
    assert_equal IDT_HEADER_PARAMS, obj.idtHeaderParams
  end


  def generate_hash
    {
      ticket:          '<ticket>',
      subject:         '<subject>',
      authTime:        100,
      acr:             '<acr>',
      claims:          [ 'claim0', 'claim1' ],
      properties:      [ { key: '<property0-key>', value: '<property0-value>', hidden: false } ],
      scopes:          [ 'scope0', 'scope1' ],
      sub:             '<sub>',
      idtHeaderParams: '<idt-header-params>'
    }
  end


  def test_setters
    actual = Authlete::Model::Request::AuthorizationIssueRequest.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::Request::AuthorizationIssueRequest.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
