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


class AuthorizationResponseTest < Minitest::Test
  RESULT_CODE            = '<result-code>'
  RESULT_MESSAGE         = '<result-message>'
  ACRS                   = [ 'acr0', 'acr1' ]
  ACTION                 = 'FORM'
  CLAIMS_LOCALES         = [ 'en', 'ja' ]
  CLAIMS                 = [ 'claim0', 'claim1' ]
  DISPLAY                = 'PAGE'
  ID_TOKEN_CLAIMS        = '<id-token-claims>'
  LOGIN_HINT             = '<login-hint>'
  MAX_AGE                = 100
  PROMPTS                = [ 'CONSENT', 'LOGIN' ]
  PURPOSE                = '<purpose>'
  REQUEST_OBJECT_PAYLOAD = '<request-object-payload>'
  RESOURCES              = [ 'resource0', 'resource1' ]
  RESPONSE_CONTENT       = '<response-content>'
  SERVICE_NAME           = '<service-name>'
  SERVICE                = Authlete::Model::Service.new({serviceName: SERVICE_NAME})
  SCOPE_NAME             = 'scope0'
  SCOPE_DESCRIPTION      = '<scope0-description>'
  SCOPES                 = [ Authlete::Model::Scope.new({ name: SCOPE_NAME, description: SCOPE_DESCRIPTION }) ]
  SUBJECT                = '<subject>'
  TICKET                 = '<ticket>'
  UI_LOCALES             = [ 'de', 'fr' ]
  USER_INFO_CLAIMS       = '<user-info-claims>'


  def generate_json
    return <<~JSON
      {
        "resultCode":           "<result-code>",
        "resultMessage":        "<result-message>",
        "acrs":                 [ "acr0", "acr1" ],
        "action":               "FORM",
        "claimsLocales":        [ "en", "ja" ],
        "claims":               [ "claim0", "claim1" ],
        "display":              "PAGE",
        "idTokenClaims":        "<id-token-claims>",
        "loginHint":            "<login-hint>",
        "maxAge":               100,
        "prompts":              [ "CONSENT", "LOGIN" ],
        "purpose":              "<purpose>",
        "requestObjectPayload": "<request-object-payload>",
        "resources":            [ "resource0", "resource1" ],
        "responseContent":      "<response-content>",
        "service": {
          "serviceName":        "<service-name>"
        },
        "scopes": [
          {
            "name":             "scope0",
            "description":      "<scope0-description>"
          }
        ],
        "subject":              "<subject>",
        "ticket":               "<ticket>",
        "uiLocales":            [ "de", "fr" ],
        "userInfoClaims":       "<user-info-claims>"
      }
    JSON
  end


  def match(obj)
    assert_equal RESULT_CODE,            obj.resultCode
    assert_equal RESULT_MESSAGE,         obj.resultMessage
    assert_equal ACTION,                 obj.action
    assert_equal ACRS,                   obj.acrs
    assert_equal CLAIMS_LOCALES,         obj.claimsLocales
    assert_equal CLAIMS,                 obj.claims
    assert_equal DISPLAY,                obj.display
    assert_equal ID_TOKEN_CLAIMS,        obj.idTokenClaims
    assert_equal MAX_AGE,                obj.maxAge
    assert_equal PROMPTS,                obj.prompts
    assert_equal PURPOSE,                obj.purpose
    assert_equal REQUEST_OBJECT_PAYLOAD, obj.requestObjectPayload
    assert_equal RESOURCES,              obj.resources
    assert_equal RESPONSE_CONTENT,       obj.responseContent
    assert_equal SERVICE_NAME,           obj.service.serviceName
    assert_equal SCOPE_NAME,             obj.scopes[0].name
    assert_equal SCOPE_DESCRIPTION,      obj.scopes[0].description
    assert_equal SUBJECT,                obj.subject
    assert_equal TICKET,                 obj.ticket
    assert_equal UI_LOCALES,             obj.uiLocales
    assert_equal USER_INFO_CLAIMS,       obj.userInfoClaims
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Response::AuthorizationResponse.new(hsh)

    match(actual)
  end


  def test_setters
    actual                        = Authlete::Model::Response::AuthorizationResponse.new
    actual.result_code            = RESULT_CODE
    actual.result_message         = RESULT_MESSAGE
    actual.acrs                   = ACRS
    actual.action                 = ACTION
    actual.claims_locales         = CLAIMS_LOCALES
    actual.claims                 = CLAIMS
    actual.display                = DISPLAY
    actual.id_token_claims        = ID_TOKEN_CLAIMS
    actual.max_age                = MAX_AGE
    actual.prompts                = PROMPTS
    actual.purpose                = PURPOSE
    actual.request_object_payload = REQUEST_OBJECT_PAYLOAD
    actual.resources              = RESOURCES
    actual.response_content       = RESPONSE_CONTENT
    actual.service                = SERVICE
    actual.scopes                 = SCOPES
    actual.subject                = SUBJECT
    actual.ticket                 = TICKET
    actual.ui_locales             = UI_LOCALES
    actual.user_info_claims       = USER_INFO_CLAIMS

    match(actual)
  end
end
