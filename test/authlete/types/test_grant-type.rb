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


class GrantTypeTest < Minitest::Test
  def do_test(input, expected)
    output = Authlete::Types::GrantType::constant_get(input)

    if expected.nil?
      assert_nil output
    else
      assert_equal expected, output
    end
  end

  def test_unknown
    do_test('UNKNOWN', nil)
  end

  def test_authorization_code
    do_test('AUTHORIZATION_CODE', 'authorization_code')
  end

  def test_implicit
    do_test('IMPLICIT', 'implicit')
  end

  def test_password
    do_test('PASSWORD', 'password')
  end

  def test_client_credentials
    do_test('CLIENT_CREDENTIALS', 'client_credentials')
  end

  def test_refresh_token
    do_test('REFRESH_TOKEN', 'refresh_token')
  end

  def test_ciba
    do_test('CIBA', 'urn:openid:params:grant-type:ciba')
  end

  def test_device_code
    do_test('DEVICE_CODE', 'urn:ietf:params:oauth:grant-type:device_code')
  end

  def test_token_exchange
    do_test('TOKEN_EXCHANGE', 'urn:ietf:params:oauth:grant-type:token-exchange')
  end

  def test_jwt_bearer
    do_test('JWT_BEARER', 'urn:ietf:params:oauth:grant-type:jwt-bearer')
  end
end
