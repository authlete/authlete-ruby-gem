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


class JWEAlgTest < Minitest::Test
  def do_test(input, expected)
    output = Authlete::Types::JWEAlg::constant_get(input)

    if expected.nil?
      assert_nil output
    else
      assert_equal expected, output
    end
  end

  def test_unknown
    do_test('UNKNOWN', nil)
  end

  def test_rsa1_5
    do_test('RSA1_5', 'RSA1_5')
  end

  def test_oaep
    do_test('RSA_OAEP', 'RSA-OAEP')
  end

  def test_oaep_256
    do_test('RSA_OAEP_256', 'RSA-OAEP-256')
  end

  def test_a128kw
    do_test('A128KW', 'A128KW')
  end

  def test_a192kw
    do_test('A192KW', 'A192KW')
  end

  def test_a256kw
    do_test('A256KW', 'A256KW')
  end

  def test_dir
    do_test('DIR', 'dir')
  end

  def test_ecdh_es
    do_test('ECDH_ES', 'ECDH-ES')
  end

  def test_ecdh_es_a128kw
    do_test('ECDH_ES_A128KW', 'ECDH-ES+A128KW')
  end

  def test_ecdh_es_a192kw
    do_test('ECDH_ES_A192KW', 'ECDH-ES+A192KW')
  end

  def test_ecdh_es_a256kw
    do_test('ECDH_ES_A256KW', 'ECDH-ES+A256KW')
  end

  def test_a128gcmkw
    do_test('A128GCMKW', 'A128GCMKW')
  end

  def test_a192gcmkw
    do_test('A192GCMKW', 'A192GCMKW')
  end

  def test_a256gcmkw
    do_test('A256GCMKW', 'A256GCMKW')
  end

  def test_pbes2_hs256_a128kw
    do_test('PBES2_HS256_A128KW', 'PBES2-HS256+A128KW')
  end

  def test_pbes2_hs384_a192kw
    do_test('PBES2_HS384_A192KW', 'PBES2-HS384+A192KW')
  end

  def test_pbes2_hs512_a256kw
    do_test('PBES2_HS512_A256KW', 'PBES2-HS512+A256KW')
  end
end
