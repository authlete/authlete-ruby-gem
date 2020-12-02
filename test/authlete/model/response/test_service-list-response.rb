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


class ServiceListResponseTest < Minitest::Test
  START_PARAM   = 0
  END_PARAM     = 2
  TOTAL_COUNT   = 2
  SERVICE0_NAME = 'service0'
  SERVICE1_NAME = 'service1'
  SERVICES      = [ Authlete::Model::Service.new(serviceName: SERVICE0_NAME),
                    Authlete::Model::Service.new(serviceName: SERVICE1_NAME) ]


  def generate_json
    return <<~JSON
      {
        "start":      0,
        "end":        2,
        "totalCount": 2,
        "services":    [ { "serviceName": "service0" }, { "serviceName": "service1" } ]
      }
    JSON
  end


  def match(obj)
    assert_equal START_PARAM,   obj.start
    assert_equal END_PARAM,     obj.end
    assert_equal TOTAL_COUNT,   obj.totalCount
    assert_equal SERVICE0_NAME, obj.services[0].serviceName
    assert_equal SERVICE1_NAME, obj.services[1].serviceName
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::ServiceListResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual             = Authlete::Model::Response::ServiceListResponse.new
    actual.start       = START_PARAM
    actual.end         = END_PARAM
    actual.total_count = TOTAL_COUNT
    actual.services    = SERVICES

    match(actual)
  end
end
