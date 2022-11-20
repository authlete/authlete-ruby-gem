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


class ResponseTypeTest < Minitest::Test
  def do_test(input, expected)
    output = Authlete::Types::ResponseType::constant_get(input)

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

  def test_code
    do_test('CODE', 'code')
  end

  def test_token
    do_test('TOKEN', 'token')
  end

  def test_id_token
    do_test('ID_TOKEN', 'id_token')
  end

  def test_code_token
    do_test('CODE_TOKEN', 'code token')
  end

  def test_code_id_token
    do_test('CODE_ID_TOKEN', 'code id_token')
  end

  def test_id_token_token
    do_test('ID_TOKEN_TOKEN', 'id_token token')
  end

  def test_code_id_token_token
    do_test('CODE_ID_TOKEN_TOKEN', 'code id_token token')
  end
end
