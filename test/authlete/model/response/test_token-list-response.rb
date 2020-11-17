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


class TokenListResponseTest < Minitest::Test
  START_PARAM        = 0
  END_PARAM          = 2
  CLIENT_NAME        = '<client-name>'
  CLIENT_DEVELOPER   = '<developer>'
  CLIENT             = Authlete::Model::Client.new(clientName: CLIENT_NAME, developer: CLIENT_DEVELOPER)
  SUBJECT            = '<subject>'
  TOTAL_COUNT        = 2
  ACCESS_TOKEN0_HASH = '<access-token0-hash>'
  ACCESS_TOKEN1_HASH = '<access-token1-hash>'
  ACCESS_TOKENS      = [ Authlete::Model::Response::AccessToken.new(accessTokenHash: ACCESS_TOKEN0_HASH),
                         Authlete::Model::Response::AccessToken.new(accessTokenHash: ACCESS_TOKEN1_HASH) ]


  def generate_json
    return <<~JSON
      {
        "start":        0,
        "end":          2,
        "client":       { "clientName": "<client-name>", "developer": "<developer>" },
        "subject":      "<subject>",
        "totalCount":   2,
        "accessTokens": [ { "accessTokenHash": "<access-token0-hash>" },
                          { "accessTokenHash": "<access-token1-hash>" } ]
      }
    JSON
  end


  def match(obj)
    assert_equal START_PARAM,        obj.start
    assert_equal END_PARAM,          obj.end
    assert_equal CLIENT_NAME,        obj.client.clientName
    assert_equal CLIENT_DEVELOPER,   obj.client.developer
    assert_equal SUBJECT,            obj.subject
    assert_equal TOTAL_COUNT,        obj.totalCount
    assert_equal ACCESS_TOKEN0_HASH, obj.accessTokens[0].accessTokenHash
    assert_equal ACCESS_TOKEN1_HASH, obj.accessTokens[1].accessTokenHash
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::TokenListResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual               = Authlete::Model::Response::TokenListResponse.new
    actual.start         = START_PARAM
    actual.end           = END_PARAM
    actual.client        = CLIENT
    actual.subject       = SUBJECT
    actual.total_count   = TOTAL_COUNT
    actual.access_tokens = ACCESS_TOKENS

    match(actual)
  end
end
