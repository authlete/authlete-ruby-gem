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
require 'minitest/autorun'


class ClientAuthorizationGetListRequestTest < Minitest::Test
  SUBJECT     = '<subject>'
  DEVELOPER   = '<developer>'
  START_PARAM = 0
  END_PARAM   = 2


  def set_params(obj)
    obj.subject   = SUBJECT
    obj.developer = DEVELOPER
    obj.start     = START_PARAM
    obj.end       = END_PARAM
  end


  def match(obj)
    assert_equal SUBJECT,     obj.subject
    assert_equal DEVELOPER,   obj.developer
    assert_equal START_PARAM, obj.start
    assert_equal END_PARAM,   obj.end
  end


  def generate_hash
    {
      subject:   '<subject>',
      developer: '<developer>',
      start:     0,
      end:       2
    }
  end


  def test_setters
    actual = Authlete::Model::Request::ClientAuthorizationGetListRequest.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::Request::ClientAuthorizationGetListRequest.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
