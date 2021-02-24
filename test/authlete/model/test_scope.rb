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


class ScopeTest < Minitest::Test
  NAME              = '<name>'
  DEFAULT_ENTRY     = true
  DESCRIPTION       = '<description>'
  DESCRIPTION_TAG   = '<description0-tag>'
  DESCRIPTION_VALUE = '<description0-value>'
  DESCRIPTIONS      = [ Authlete::Model::TaggedValue.new(tag: DESCRIPTION_TAG, value: DESCRIPTION_VALUE) ]
  ATTRIBUTE_KEY     = '<attribute0-key>'
  ATTRIBUTE_VALUE   = '<attribute0-value>'
  ATTRIBUTES        = [ Authlete::Model::Pair.new(key: ATTRIBUTE_KEY, value: ATTRIBUTE_VALUE) ]


  def generate_json
    return <<~JSON
      {
        "name":         "<name>",
        "defaultEntry": true,
        "description":  "<description>",
        "descriptions": [ { "tag": "<description0-tag>", "value": "<description0-value>" } ],
        "attributes":   [ { "key": "<attribute0-key>", "value": "<attribute0-value>" } ]
      }
    JSON
  end


  def generate_hash
    {
      name:         '<name>',
      defaultEntry: true,
      description:  '<description>',
      descriptions: [ { tag: '<description0-tag>', value: '<description0-value>' } ],
      attributes:   [ { key: '<attribute0-key>', value: '<attribute0-value>' } ]
    }
  end


  def set_params(obj)
    obj.name          = NAME
    obj.default_entry = DEFAULT_ENTRY
    obj.description   = DESCRIPTION
    obj.descriptions  = DESCRIPTIONS
    obj.attributes    = ATTRIBUTES
  end


  def match(obj)
    assert_equal NAME,              obj.name
    assert_equal DEFAULT_ENTRY,     obj.defaultEntry
    assert_equal DESCRIPTION,       obj.description
    assert_equal DESCRIPTION_TAG,   obj.descriptions[0].tag
    assert_equal DESCRIPTION_VALUE, obj.descriptions[0].value
    assert_equal ATTRIBUTE_KEY,     obj.attributes[0].key
    assert_equal ATTRIBUTE_VALUE,   obj.attributes[0].value
  end


  def test_from_json
    jsn    = generate_json()
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Scope.new(hsh)

    match(actual)
  end


  def test_setters
    actual = Authlete::Model::Scope.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj      = Authlete::Model::Scope.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
