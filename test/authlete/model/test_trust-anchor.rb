# :nodoc:
#
# Copyright (C) 2014-2021 Authlete, Inc.
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


class TrustAnchorTest < Minitest::Test
  ENTITY_ID   = '<entity-id>'
  JWKS        = '<jwks>'


  def generate_json
    return <<~JSON
      {
        "entityId":   "<entity-id>",
        "jwks":       "<jwks>"
      }
    JSON
  end


  def generate_hash
    {
      entityId:    '<entity-id>',
      jwks:        '<jwks>',
    }
  end


  def set_params(obj)
    obj.entity_id   = ENTITY_ID
    obj.jwks        = JWKS
  end


  def match(obj)
    assert_equal ENTITY_ID,   obj.entityId
    assert_equal JWKS,        obj.jwks
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)

    actual = Authlete::Model::TrustAnchor.new(hsh)

    match(actual)
  end


  def test_setters
    actual = Authlete::Model::TrustAnchor.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::TrustAnchor.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
