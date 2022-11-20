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


class JWSAlgTest < Minitest::Test
  def do_test(input, expected)
    output = Authlete::Types::JWSAlg::constant_get(input)

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

  def test_hs256
    do_test('HS256', 'HS256')
  end

  def test_hs384
    do_test('HS384', 'HS384')
  end

  def test_hs512
    do_test('HS512', 'HS512')
  end

  def test_rs256
    do_test('RS256', 'RS256')
  end

  def test_rs384
    do_test('RS384', 'RS384')
  end

  def test_rs512
    do_test('RS512', 'RS512')
  end

  def test_es256
    do_test('ES256', 'ES256')
  end

  def test_es384
    do_test('ES384', 'ES384')
  end

  def test_es512
    do_test('ES512', 'ES512')
  end

  def test_ps256
    do_test('PS256', 'PS256')
  end

  def test_ps384
    do_test('PS384', 'PS384')
  end

  def test_ps512
    do_test('PS512', 'PS512')
  end

  def test_es256k
    do_test('ES256K', 'ES256K')
  end

  def test_eddsa
    do_test('EdDSA', 'EdDSA')
  end
end
