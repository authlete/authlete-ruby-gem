# :nodoc:
#
# Copyright (C) 2022 Authlete, Inc.
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


class ClientAuthMethodTest < Minitest::Test
  def do_test(input, expected)
    output = Authlete::Types::ClientAuthMethod::constant_get(input)

    if expected.nil?
      assert_nil output
    else
      assert_equal expected, output
    end
  end

  def test_unknown
    do_test('UNKNOWN', nil)
  end

  def test_none
    do_test('NONE', 'none')
  end

  def test_client_secret_basic
    do_test('CLIENT_SECRET_BASIC', 'client_secret_basic')
  end

  def test_client_secret_post
    do_test('CLIENT_SECRET_POST', 'client_secret_post')
  end

  def test_client_secret_jwt
    do_test('CLIENT_SECRET_JWT', 'client_secret_jwt')
  end

  def test_private_key_jwt
    do_test('PRIVATE_KEY_JWT', 'private_key_jwt')
  end

  def test_tls_client_auth
    do_test('TLS_CLIENT_AUTH', 'tls_client_auth')
  end

  def test_self_signed_tls_client_auth
    do_test('SELF_SIGNED_TLS_CLIENT_AUTH', 'self_signed_tls_client_auth')
  end
end
