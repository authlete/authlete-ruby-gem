# :nodoc:
#
# Copyright (C) 2014-2024 Authlete, Inc.
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


class TokenRevokeRequestTest < Minitest::Test
  ACCESS_TOKEN_IDENTIFIER   = '<access-token-identifier>'
  CLIENT_IDENTIFIER         = '<client-identifier>'
  REFRESH_TOKEN_IDENTIFIER  = '<refresh-token-identifier>'
  SUBJECT                   = '<subject>'


  def set_params(obj)
    obj.access_token_identifier   = ACCESS_TOKEN_IDENTIFIER
    obj.client_identifier         = CLIENT_IDENTIFIER
    obj.refresh_token_identifier  = REFRESH_TOKEN_IDENTIFIER
    obj.subject                   = SUBJECT
  end


  def match(obj)
    assert_equal ACCESS_TOKEN_IDENTIFIER,   obj.access_token_identifier
    assert_equal CLIENT_IDENTIFIER,         obj.client_identifier
    assert_equal REFRESH_TOKEN_IDENTIFIER,  obj.refresh_token_identifier
    assert_equal SUBJECT,                   obj.subject
  end


  def generate_hash
    {
      accessTokenIdentifier:  '<access-token-identifier>',
      clientIdentifier:       '<client-identifier>',
      refreshTokenIentifier:  '<refresh-token-identifier>',
      subject:                '<subject>'
    }
  end


  def test_setters
    actual = Authlete::Model::Request::TokenRevokeRequest.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::Request::TokenRevokeRequest.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
