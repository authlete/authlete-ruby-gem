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


class AuthenticationCallbackRequestTest < Minitest::Test
  SERVICE_API_KEY    = '<service-api-key>'
  CLIENT_ID          = 12345
  ID                 = '<id>'
  PASSWORD           = '<password>'
  CLAIMS             = [ 'claim0', 'claim1' ]
  CLAIMS_LOCALES     = [ 'en', 'ja' ]
  SNS                = 'FACEBOOK'
  ACCESS_TOKEN       = '<access-token>'
  REFRESH_TOKEN      = '<refresh-token>'
  EXPIRES_IN         = 30000
  RAW_TOKEN_RESPONSE = '<raw-token-response>'


  def set_params(obj)
    obj.service_api_key    = SERVICE_API_KEY
    obj.client_id          = CLIENT_ID
    obj.id                 = ID
    obj.password           = PASSWORD
    obj.claims             = CLAIMS
    obj.claims_locales     = CLAIMS_LOCALES
    obj.sns                = SNS
    obj.access_token       = ACCESS_TOKEN
    obj.refresh_token      = REFRESH_TOKEN
    obj.expires_in         = EXPIRES_IN
    obj.raw_token_response = RAW_TOKEN_RESPONSE
  end


  def match(obj)
    assert_equal SERVICE_API_KEY,    obj.serviceApiKey
    assert_equal CLIENT_ID,          obj.clientId
    assert_equal ID,                 obj.id
    assert_equal PASSWORD,           obj.password
    assert_equal CLAIMS,             obj.claims
    assert_equal CLAIMS_LOCALES,     obj.claimsLocales
    assert_equal SNS,                obj.sns
    assert_equal ACCESS_TOKEN,       obj.accessToken
    assert_equal REFRESH_TOKEN,      obj.refreshToken
    assert_equal EXPIRES_IN,         obj.expiresIn
    assert_equal RAW_TOKEN_RESPONSE, obj.rawTokenResponse
  end


  def generate_hash
    {
      serviceApiKey:    '<service-api-key>',
      clientId:         12345,
      id:               '<id>',
      password:         '<password>',
      claims:           [ 'claim0', 'claim1' ],
      claimsLocales:    [ 'en', 'ja' ],
      sns:              'FACEBOOK',
      accessToken:      '<access-token>',
      refreshToken:     '<refresh-token>',
      expiresIn:        30000,
      rawTokenResponse: '<raw-token-response>'
    }
  end


  def test_setters
    actual = Authlete::Model::Request::AuthenticationCallbackRequest.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::Request::AuthenticationCallbackRequest.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end

