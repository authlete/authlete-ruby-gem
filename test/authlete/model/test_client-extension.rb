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


class ClientExtensionTest < Minitest::Test
  REQUESTABLE_SCOPES         = %w(<requestable-scope0> <requestable-scope1>)
  REQUESTABLE_SCOPES_ENABLED = true
  ACCESS_TOKEN_DURATION      = 10000
  REFRESH_TOKEN_DURATION     = 10000


  def generate_json
    return <<~JSON
      {
        "requestableScopes":        [ "<requestable-scope0>", "<requestable-scope1>" ],
        "requestableScopesEnabled": true,
        "accessTokenDuration":      10000,
        "refreshTokenDuration":     10000
      }
    JSON
  end


  def generate_hash
    {
      requestableScopes:        %w(<requestable-scope0> <requestable-scope1>),
      requestableScopesEnabled: true,
      accessTokenDuration:      10000,
      refreshTokenDuration:     10000
    }
  end


  def set_params(obj)
    obj.requestable_scopes         = REQUESTABLE_SCOPES
    obj.requestable_scopes_enabled = REQUESTABLE_SCOPES_ENABLED
    obj.access_token_duration      = ACCESS_TOKEN_DURATION
    obj.refresh_token_duration     = REFRESH_TOKEN_DURATION
  end


  def match(obj)
    assert_equal REQUESTABLE_SCOPES,         obj.requestableScopes
    assert_equal REQUESTABLE_SCOPES_ENABLED, obj.requestableScopesEnabled
    assert_equal ACCESS_TOKEN_DURATION,      obj.accessTokenDuration
    assert_equal REFRESH_TOKEN_DURATION,     obj.refreshTokenDuration
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::ClientExtension.new(hsh)

    match(actual)
  end


  def test_setters
    actual = Authlete::Model::ClientExtension.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::ClientExtension.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
