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


class TokenIssueRequestTest < Minitest::Test
  TICKET         = '<ticket>'
  SUBJECT        = '<subject>'
  PROPERTY_KEY   = '<property0-key>'
  PROPERTY_VALUE = '<property0-value>'
  PROPERTIES     = [ Authlete::Model::Property.new(key: PROPERTY_KEY, value: PROPERTY_VALUE) ]


  def set_params(obj)
    obj.ticket     = TICKET
    obj.subject    = SUBJECT
    obj.properties = PROPERTIES
  end


  def match(obj)
    assert_equal TICKET,           obj.ticket
    assert_equal SUBJECT,          obj.subject
    assert_equal PROPERTY_KEY,     obj.properties[0].key
    assert_equal PROPERTY_VALUE,   obj.properties[0].value
  end


  def generate_hash
    {
      ticket:     '<ticket>',
      subject:    '<subject>',
      properties: [ { key: '<property0-key>', value: '<property0-value>', hidden: false } ],
    }
  end


  def test_setters
    actual = Authlete::Model::Request::TokenIssueRequest.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::Request::TokenIssueRequest.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
