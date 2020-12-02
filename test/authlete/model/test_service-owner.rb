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


class ServiceOwnerTest < Minitest::Test
  NUMBER     = 12345
  NAME       = '<name>'
  EMAIL      = '<email>'
  LOGIN_ID   = '<login-id>'
  API_KEY    = '<api-key>'
  API_SECRET = '<api-secret>'
  PLAN       = 'FREE'


  def generate_json
    return <<~JSON
      {
        "number":    12345,
        "name":      "<name>",
        "email":     "<email>",
        "loginId":   "<login-id>",
        "apiKey":    "<api-key>",
        "apiSecret": "<api-secret>",
        "plan":      "FREE"
      }
    JSON
  end


  def match(obj)
    assert_equal NUMBER,     obj.number
    assert_equal NAME,       obj.name
    assert_equal EMAIL,      obj.email
    assert_equal LOGIN_ID,   obj.loginId
    assert_equal API_KEY,    obj.apiKey
    assert_equal API_SECRET, obj.apiSecret
    assert_equal PLAN,       obj.plan
  end


  def test_from_json
    jsn = generate_json
    hsh = JSON.parse(jsn)
    obj = Authlete::Model::ServiceOwner.new(hsh)

    match(obj)
  end


  def test_setters
    actual            = Authlete::Model::ServiceOwner.new
    actual.number     = NUMBER
    actual.name       = NAME
    actual.email      = EMAIL
    actual.login_id   = LOGIN_ID
    actual.api_key    = API_KEY
    actual.api_secret = API_SECRET
    actual.plan       = PLAN

    match(actual)
  end
end
