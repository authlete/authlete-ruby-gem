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


class JWEEncTest < Minitest::Test
  def do_test(input, expected)
    output = Authlete::Types::JWEEnc::constant_get(input)

    if expected.nil?
      assert_nil output
    else
      assert_equal expected, output
    end
  end

  def test_unknown
    do_test('UNKNOWN', nil)
  end

  def test_a128cbc_hs256
    do_test('A128CBC_HS256', 'A128CBC-HS256')
  end

  def test_a192cbc_hs384
    do_test('A192CBC_HS384', 'A192CBC-HS384')
  end

  def test_a256cbc_hs512
    do_test('A256CBC_HS512', 'A256CBC-HS512')
  end

  def test_a128gcm
    do_test('A128GCM', 'A128GCM')
  end

  def test_a192gcm
    do_test('A192GCM', 'A192GCM')
  end

  def test_a256gcm
    do_test('A256GCM', 'A256GCM')
  end
end
