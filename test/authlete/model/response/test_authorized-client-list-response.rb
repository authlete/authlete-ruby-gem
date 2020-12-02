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


class AuthorizedClientListResponseTest < Minitest::Test
  START_PARAM  = 0
  END_PARAM    = 2
  DEVELOPER    = '<developer>'
  TOTAL_COUNT  = 2
  CLIENT0_NAME = 'client0'
  CLIENT1_NAME = 'client1'
  CLIENTS      = [ Authlete::Model::Client.new(clientName: CLIENT0_NAME, developer: DEVELOPER),
                   Authlete::Model::Client.new(clientName: CLIENT1_NAME, developer: DEVELOPER) ]
  SUBJECT      = '<subject>'


  def generate_json
    return <<~JSON
      {
        "start":      0,
        "end":        2,
        "developer":  "<developer>",
        "totalCount": 2,
        "clients":    [ { "clientName": "client0", "developer": "<developer>" },
                        { "clientName": "client1", "developer": "<developer>" } ],
        "subject": "<subject>"
      }
    JSON
  end


  def match(obj)
    assert_equal START_PARAM,  obj.start
    assert_equal END_PARAM,    obj.end
    assert_equal DEVELOPER,    obj.developer
    assert_equal TOTAL_COUNT,  obj.totalCount
    assert_equal CLIENT0_NAME, obj.clients[0].clientName
    assert_equal DEVELOPER,    obj.clients[0].developer
    assert_equal CLIENT1_NAME, obj.clients[1].clientName
    assert_equal DEVELOPER,    obj.clients[1].developer
    assert_equal SUBJECT,      obj.subject
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::AuthorizedClientListResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual             = Authlete::Model::Response::AuthorizedClientListResponse.new
    actual.start       = START_PARAM
    actual.end         = END_PARAM
    actual.developer   = DEVELOPER
    actual.total_count = TOTAL_COUNT
    actual.clients     = CLIENTS
    actual.subject     = SUBJECT

    match(actual)
  end
end
