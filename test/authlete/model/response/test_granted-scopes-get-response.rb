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


class GrantedScopesGetResponseTest < Minitest::Test
  RESULT_CODE           = '<result-code>'
  RESULT_MESSAGE        = '<result-message>'
  SERVICE_API_KEY       = '<service-api-key>'
  CLIENT_ID             = 12345
  SUBJECT               = '<subject>'
  LATEST_GRANTED_SCOPES = [ 'latest-granted-scope0' ]
  MERGED_GRANTED_SCOPES = [ 'merged-granted-scope0' ]
  MODIFIED_AT           = 1000


  def generate_json
    return <<~JSON
      {
        "resultCode":          "<result-code>",
        "resultMessage":       "<result-message>",
        "serviceApiKey":       "<service-api-key>",
        "clientId":            12345,
        "subject":             "<subject>",
        "latestGrantedScopes": [ "latest-granted-scope0" ],
        "mergedGrantedScopes": [ "merged-granted-scope0" ],
        "modifiedAt":          1000
      }
    JSON
  end


  def match(obj)
    assert_equal RESULT_CODE,           obj.resultCode
    assert_equal RESULT_MESSAGE,        obj.resultMessage
    assert_equal SERVICE_API_KEY,       obj.serviceApiKey
    assert_equal CLIENT_ID,             obj.clientId
    assert_equal SUBJECT,               obj.subject
    assert_equal LATEST_GRANTED_SCOPES, obj.latestGrantedScopes
    assert_equal MERGED_GRANTED_SCOPES, obj.mergedGrantedScopes
    assert_equal MODIFIED_AT,           obj.modifiedAt
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::GrantedScopesGetResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual                       = Authlete::Model::Response::GrantedScopesGetResponse.new
    actual.result_code           = RESULT_CODE
    actual.result_message        = RESULT_MESSAGE
    actual.service_api_key       = SERVICE_API_KEY
    actual.client_id             = CLIENT_ID
    actual.subject               = SUBJECT
    actual.latest_granted_scopes = LATEST_GRANTED_SCOPES
    actual.merged_granted_scopes = MERGED_GRANTED_SCOPES
    actual.modified_at           = MODIFIED_AT

    match(actual)
  end
end
