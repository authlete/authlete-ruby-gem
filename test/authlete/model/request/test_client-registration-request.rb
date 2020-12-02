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


class ClientRegistrationRequestTest < Minitest::Test
  JSON      = '<json>'
  TOKEN     = '<token>'
  CLIENT_ID = '<client-id>'


  def set_params(obj)
    obj.json      = JSON
    obj.token     = TOKEN
    obj.client_id = CLIENT_ID
  end


  def match(obj)
    assert_equal JSON,      obj.json
    assert_equal TOKEN,     obj.token
    assert_equal CLIENT_ID, obj.clientId
  end


  def generate_hash
    {
      json:     '<json>',
      token:    '<token>',
      clientId: '<client-id>'
    }
  end


  def test_setters
    actual = Authlete::Model::Request::ClientRegistrationRequest.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::Request::ClientRegistrationRequest.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
