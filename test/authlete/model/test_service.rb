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


class ServiceTest < Minitest::Test
  NUMBER                                           = 1000
  SERVICE_OWNER_NUMBER                             = 12345
  SERVICE_NAME                                     = '<service-name>'
  API_KEY                                          = '<api-key>'
  API_SECRET                                       = '<api-secret>'
  ISSUER                                           = '<issuer>'
  AUTHORIZATION_ENDPOINT                           = '<authorization-endpoint>'
  TOKEN_ENDPOINT                                   = '<token-endpoint>'
  REVOCATION_ENDPOINT                              = '<revocation-endpoint>'
  SUPPORTED_REVOCATION_AUTH_METHODS                = [ 'NONE', 'CLIENT_SECRET_BASIC' ]
  USER_INFO_ENDPOINT                               = '<user-info-endpoint>'
  JWKS_URI                                         = '<jwks-uri>'
  JWKS                                             = '<jwks>'
  REGISTRATION_ENDPOINT                            = '<registration-endpoint>'
  REGISTRATION_MANAGEMENT_ENDPOINT                 = '<registration-management-endpoint>'
  SUPPORTED_SCOPE_NAME                             = 'scope0'
  SUPPORTED_SCOPE_DESCRIPTION                      = '<scope0-description>'
  SUPPORTED_SCOPES                                 = [ Authlete::Model::Scope.new(name: SUPPORTED_SCOPE_NAME, description: SUPPORTED_SCOPE_DESCRIPTION) ]
  SUPPORTED_RESPONSE_TYPES                         = [ 'NONE', 'CODE', 'TOKEN', 'ID_TOKEN' ]
  SUPPORTED_GRANT_TYPES                            = [ 'AUTHORIZATION_CODE', 'REFRESH_TOKEN' ]
  SUPPORTED_ACRS                                   = [ '<supported-acr0>', '<supported-acr1>' ]
  SUPPORTED_TOKEN_AUTH_METHODS                     = [ 'NONE', 'CLIENT_SECRET_BASIC' ]
  SUPPORTED_DISPLAYS                               = [ 'PAGE', 'POPUP', 'TOUCH', 'WAP' ]
  SUPPORTED_CLAIM_TYPES                            = [ 'NORMAL' ]
  SUPPORTED_CLAIMS                                 = [ '<supported-claim0>', '<supported-claim1>' ]
  SERVICE_DOCUMENTATION                            = '<service-documentation>'
  SUPPORTED_CLAIM_LOCALES                          = [ 'en-US' ]
  SUPPORTED_UI_LOCALES                             = [ 'en-US' ]
  POLICY_URI                                       = '<policy-uri>'
  TOS_URI                                          = '<tos-uri>'
  AUTHENTICATION_CALLBACK_ENDPOINT                 = '<authentication-callback-endpoint>'
  AUTHENTICATION_CALLBACK_API_KEY                  = '<authentication-callback-api-key>'
  AUTHENTICATION_CALLBACK_API_SECRET               = '<authentication-callback-api-secret>'
  SUPPORTED_SNSES                                  = [ 'FACEBOOK' ]
  SNS_CREDENTIALS_SNS                              = 'FACEBOOK'
  SNS_CREDENTIALS_API_KEY                          = '<sns-credentials0-api-key>'
  SNS_CREDENTIALS_API_SECRET                       = '<sns-credentials0-api-secret>'
  SNS_CREDENTIALS                                  = [ Authlete::Model::SnsCredentials.new(sns: SNS_CREDENTIALS_SNS, apiKey: SNS_CREDENTIALS_API_KEY, apiSecret: SNS_CREDENTIALS_API_SECRET) ]
  CREATED_AT                                       = 10000
  MODIFIED_AT                                      = 10000
  DEVELOPER_AUTHENTICATION_CALLBACK_ENDPOINT       = '<developer-authentication-callback-endpoint>'
  DEVELOPER_AUTHENTICATION_CALLBACK_API_KEY        = '<developer-authentication-callback-api-key>'
  DEVELOPER_AUTHENTICATION_CALLBACK_API_SECRET     = '<developer-authentication-callback-api-secret>'
  SUPPORTED_DEVELOPER_SNSES                        = [ 'FACEBOOK' ]
  DEVELOPER_SNS_CREDENTIALS_SNS                    = 'FACEBOOK'
  DEVELOPER_SNS_CREDENTIALS_API_KEY                = '<developer-sns-credentials0-api-key>'
  DEVELOPER_SNS_CREDENTIALS_API_SECRET             = '<developer-sns-credentials0-api-secret>'
  DEVELOPER_SNS_CREDENTIALS                        = [ Authlete::Model::SnsCredentials.new(sns: DEVELOPER_SNS_CREDENTIALS_SNS, apiKey: DEVELOPER_SNS_CREDENTIALS_API_KEY, apiSecret: DEVELOPER_SNS_CREDENTIALS_API_SECRET) ]
  CLIENTS_PER_DEVELOPER                            = 10
  DIRECT_AUTHORIZATION_ENDPOINT_ENABLED            = true
  DIRECT_TOKEN_ENDPOINT_ENABLED                    = true
  DIRECT_REVOCATION_ENDPOINT_ENABLED               = true
  DIRECT_USER_INFO_ENDPOINT_ENABLED                = true
  DIRECT_JWKS_ENDPOINT_ENABLED                     = true
  DIRECT_INTROSPECTION_ENDPOINT_ENABLED            = true
  SINGLE_ACCESS_TOKEN_PER_SUBJECT                  = false
  PKCE_REQUIRED                                    = true
  PKCE_S256_REQUIRED                               = true
  REFRESH_TOKEN_KEPT                               = true
  REFRESH_TOKEN_DURATION_KEPT                      = true
  ERROR_DESCRIPTION_OMITTED                        = false
  ERROR_URI_OMITTED                                = false
  CLIENT_ID_ALIAS_ENABLED                          = true
  SUPPORTED_SERVICE_PROFILES                       = [ 'FAPI', 'OPEN_BANKING' ]
  TLS_CLIENT_CERTIFICATE_BOUND_ACCESS_TOKENS       = true
  INTROSPECTION_ENDPOINT                           = '<introspection-endpoint>'
  SUPPORTED_INTROSPECTION_AUTH_METHODS             = [ 'NONE', 'CLIENT_SECRET_BASIC' ]
  MUTUAL_TLS_VALIDATE_PKI_CERT_CHAIN               = true
  TRUSTED_ROOT_CERTIFICATES                        = [ '<trusted-root-certificate0>', '<trusted-root-certificate1>' ]
  DYNAMIC_REGISTRATION_SUPPORTED                   = true
  END_SESSION_ENDPOINT                             = '<end-session-endpoint>'
  DESCRIPTION                                      = '<description>'
  ACCESS_TOKEN_TYPE                                = 'Bearer'
  ACCESS_TOKEN_SIGN_ALG                            = 'HS256'
  ACCESS_TOKEN_DURATION                            = 300
  REFRESH_TOKEN_DURATION                           = 300
  ID_TOKEN_DURATION                                = 300
  AUTHORIZATION_RESPONSE_DURATION                  = 300
  PUSHED_AUTH_REQ_DURATION                         = 300
  METADATA_KEY                                     = '<metadata0-key>'
  METADATA_VALUE                                   = '<metadata0-value>'
  METADATA                                         = [ Authlete::Model::Pair.new(key: METADATA_KEY, value: METADATA_VALUE) ]
  ACCESS_TOKEN_SIGNATURE_KEY_ID                    = '<access-token-signature-key-id>'
  AUTHORIZATION_SIGNATURE_KEY_ID                   = '<authorization-signature-key-id>'
  ID_TOKEN_SIGNATURE_KEY_ID                        = '<id-token-signature-key-id>'
  USER_INFO_SIGNATURE_KEY_ID                       = '<user-info-signature-key-id>'
  SUPPORTED_BACKCHANNEL_TOKEN_DELIVERY_MODES       = [ 'POLL', 'PING', 'PUSH' ]
  BACKCHANNEL_AUTHENTICATION_ENDPOINT              = '<backchannel-authentication-endpoint>'
  BACKCHANNEL_USER_CODE_PARAMETER_SUPPORTED        = true
  BACKCHANNEL_AUTH_REQ_ID_DURATION                 = 300
  BACKCHANNEL_POLLING_INTERVAL                     = 10
  BACKCHANNEL_BINDING_MESSAGE_REQUIRED_IN_FAPI     = true
  ALLOWABLE_CLOCK_SKEW                             = 100
  DEVICE_AUTHORIZATION_ENDPOINT                    = '<device-authorization-endpoint>'
  DEVICE_VERIFICATION_URI                          = '<device-verification-uri>'
  DEVICE_VERIFICATION_URI_COMPLETE                 = '<device-verification-uri-complete>'
  DEVICE_FLOW_CODE_DURATION                        = 300
  DEVICE_FLOW_POLLING_INTERVAL                     = 10
  USER_CODE_CHARSET                                = 'BASE20'
  USER_CODE_LENGTH                                 = 100
  PUSHED_AUTH_REQ_ENDPOINT                         = '<pushed-auth-req-endpoint>'
  MTLS_ENDPOINT_ALIAS_NAME                         = '<mtls-endpoint-alias0-name>'
  MTLS_ENDPOINT_ALIAS_URI                          = '<mtls-endpoint-alias0-uri>'
  MTLS_ENDPOINT_ALIASES                            = [ Authlete::Model::NamedUri.new(name: MTLS_ENDPOINT_ALIAS_NAME, uri: MTLS_ENDPOINT_ALIAS_URI) ]
  SUPPORTED_AUTHORIZATION_DETAILS_TYPES            = [ '<supported-authorization-details-type0>', '<supported-authorization-details-type1>' ]
  SUPPORTED_TRUST_FRAMEWORKS                       = [ '<supported-trust-framework0>', '<supported-trust-framework1>' ]
  SUPPORTED_EVIDENCE                               = [ '<supported-evidence0>', '<supported-evidence1>' ]
  SUPPORTED_IDENTITY_DOCUMENTS                     = [ '<supported-identity-document0>', '<supported-identity-document1>' ]
  SUPPORTED_VERIFICATION_METHODS                   = [ '<supported-verification-method0>', '<supported-verification-method1>' ]
  SUPPORTED_VERIFIED_CLAIMS                        = [ '<supported-verified-claim0>', '<supported-verified-claim1>' ]
  MISSING_CLIENT_ID_ALLOWED                        = false
  PAR_REQUIRED                                     = false
  REQUEST_OBJECT_REQUIRED                          = true
  TRADITIONAL_REQUEST_OBJECT_PROCESSING_APPLIED    = false
  CLAIM_SHORTCUT_RESTRICTIVE                       = false
  SCOPE_REQUIRED                                   = true
  NBF_OPTIONAL                                     = true
  ISS_SUPPRESSED                                   = false
  ATTRIBUTE_KEY                                    = '<attribute0-key>'
  ATTRIBUTE_VALUE                                  = '<attribute0-value>'
  ATTRIBUTES                                       = [ Authlete::Model::Pair.new(key: ATTRIBUTE_KEY, value: ATTRIBUTE_VALUE) ]
  SUPPORTED_CUSTOM_CLIENT_METADATA                 = [ '<supported-custom-client-metadata0>', '<supported-custom-client-metadata1>' ]
  TOKEN_EXPIRATION_LINKED                          = false
  FRONT_CHANNEL_REQUEST_OBJECT_ENCRYPTION_REQUIRED = false
  REQUEST_OBJECT_ENCRYPTION_ALG_MATCH_REQUIRED     = false
  REQUEST_OBJECT_ENCRYPTION_ENC_MATCH_REQUIRED     = false
  HSKS_KTY                                         = 'EC'
  HSKS_USE                                         = 'sig'
  HSKS_ALG                                         = 'ES256'
  HSKS_KID                                         = 'jane'
  HSKS_HSMNAME                                     = 'google'
  HSKS_HANDLE                                      = '<handle>'
  HSKS_PUBLICKEY                                   = '<public-key>'
  HSKS                                             = [ Authlete::Model::Hsk.new(kty: HSKS_KTY, use: HSKS_USE, alg: HSKS_ALG, kid: HSKS_KID, hsmName: HSKS_HSMNAME, handle: HSKS_HANDLE, publicKey: HSKS_PUBLICKEY) ]
  HSM_ENABLED                                      = false
  REFRESH_TOKEN_DURATION_RESET                     = false
  GRANT_MANAGEMENT_ENDPOINT                        = '<grant-management-endpoint>'
  GRANT_MANAGEMENT_ACTION_REQUIRED                 = false

  def generate_json
    return <<~JSON
      {
        "number":                                      1000,
        "serviceOwnerNumber":                          12345,
        "serviceName":                                 "<service-name>",
        "apiKey":                                      "<api-key>",
        "apiSecret":                                   "<api-secret>",
        "issuer":                                      "<issuer>",
        "authorizationEndpoint":                       "<authorization-endpoint>",
        "tokenEndpoint":                               "<token-endpoint>",
        "revocationEndpoint":                          "<revocation-endpoint>",
        "supportedRevocationAuthMethods":              [ "NONE", "CLIENT_SECRET_BASIC" ],
        "userInfoEndpoint":                            "<user-info-endpoint>",
        "jwksUri":                                     "<jwks-uri>",
        "jwks":                                        "<jwks>",
        "hsks":                                        [ { "kty": "EC", "use": "sig", "alg": "ES256", "kid": "jane", "hsmName": "google", "handle": "<handle>", "publicKey": "<public-key>" } ],
        "hsmEnabled":                                  false,
        "registrationEndpoint":                        "<registration-endpoint>",
        "registrationManagementEndpoint":              "<registration-management-endpoint>",
        "supportedScopes":                             [ { "name": "scope0", "description": "<scope0-description>" } ],
        "supportedResponseTypes":                      [ "NONE", "CODE", "TOKEN", "ID_TOKEN" ],
        "supportedGrantTypes":                         [ "AUTHORIZATION_CODE", "REFRESH_TOKEN" ],
        "supportedAcrs":                               [ "<supported-acr0>", "<supported-acr1>" ],
        "supportedTokenAuthMethods":                   [ "NONE", "CLIENT_SECRET_BASIC" ],
        "supportedDisplays":                           [ "PAGE", "POPUP", "TOUCH", "WAP" ],
        "supportedClaimTypes":                         [ "NORMAL" ],
        "supportedClaims":                             [ "<supported-claim0>", "<supported-claim1>" ],
        "serviceDocumentation":                        "<service-documentation>",
        "supportedClaimLocales":                       [ "en-US" ],
        "supportedUiLocales":                          [ "en-US" ],
        "policyUri":                                   "<policy-uri>",
        "tosUri":                                      "<tos-uri>",
        "authenticationCallbackEndpoint":              "<authentication-callback-endpoint>",
        "authenticationCallbackApiKey":                "<authentication-callback-api-key>",
        "authenticationCallbackApiSecret":             "<authentication-callback-api-secret>",
        "supportedSnses":                              [ "FACEBOOK" ],
        "snsCredentials":                              [ { "sns": "FACEBOOK", "apiKey": "<sns-credentials0-api-key>", "apiSecret": "<sns-credentials0-api-secret>" } ],
        "createdAt":                                   10000,
        "modifiedAt":                                  10000,
        "developerAuthenticationCallbackEndpoint":     "<developer-authentication-callback-endpoint>",
        "developerAuthenticationCallbackApiKey":       "<developer-authentication-callback-api-key>",
        "developerAuthenticationCallbackApiSecret":    "<developer-authentication-callback-api-secret>",
        "supportedDeveloperSnses":                     [ "FACEBOOK" ],
        "developerSnsCredentials":                     [ { "sns": "FACEBOOK", "apiKey": "<developer-sns-credentials0-api-key>", "apiSecret": "<developer-sns-credentials0-api-secret>" } ],
        "clientsPerDeveloper":                         10,
        "directAuthorizationEndpointEnabled":          true,
        "directTokenEndpointEnabled":                  true,
        "directRevocationEndpointEnabled":             true,
        "directUserInfoEndpointEnabled":               true,
        "directJwksEndpointEnabled":                   true,
        "directIntrospectionEndpointEnabled":          true,
        "singleAccessTokenPerSubject":                 false,
        "pkceRequired":                                true,
        "pkceS256Required":                            true,
        "refreshTokenKept":                            true,
        "refreshTokenDurationKept":                    true,
        "errorDescriptionOmitted":                     false,
        "errorUriOmitted":                             false,
        "clientIdAliasEnabled":                        true,
        "supportedServiceProfiles":                    [ "FAPI", "OPEN_BANKING" ],
        "tlsClientCertificateBoundAccessTokens":       true,
        "introspectionEndpoint":                      "<introspection-endpoint>",
        "supportedIntrospectionAuthMethods":           [ "NONE", "CLIENT_SECRET_BASIC" ],
        "mutualTlsValidatePkiCertChain":               true,
        "trustedRootCertificates":                     [ "<trusted-root-certificate0>", "<trusted-root-certificate1>" ],
        "dynamicRegistrationSupported":                true,
        "endSessionEndpoint":                          "<end-session-endpoint>",
        "description":                                 "<description>",
        "accessTokenType":                             "Bearer",
        "accessTokenSignAlg":                          "HS256",
        "accessTokenDuration":                         300,
        "refreshTokenDuration":                        300,
        "idTokenDuration":                             300,
        "authorizationResponseDuration":               300,
        "pushedAuthReqDuration":                       300,
        "metadata":                                    [ { "key": "<metadata0-key>", "value": "<metadata0-value>" } ],
        "accessTokenSignatureKeyId":                   "<access-token-signature-key-id>",
        "authorizationSignatureKeyId":                 "<authorization-signature-key-id>",
        "idTokenSignatureKeyId":                       "<id-token-signature-key-id>",
        "userInfoSignatureKeyId":                      "<user-info-signature-key-id>",
        "supportedBackchannelTokenDeliveryModes":      [ "POLL", "PING", "PUSH" ],
        "backchannelAuthenticationEndpoint":           "<backchannel-authentication-endpoint>",
        "backchannelUserCodeParameterSupported":       true,
        "backchannelAuthReqIdDuration":                300,
        "backchannelPollingInterval":                  10,
        "backchannelBindingMessageRequiredInFapi":     true,
        "allowableClockSkew":                          100,
        "deviceAuthorizationEndpoint":                 "<device-authorization-endpoint>",
        "deviceVerificationUri":                       "<device-verification-uri>",
        "deviceVerificationUriComplete":               "<device-verification-uri-complete>",
        "deviceFlowCodeDuration":                      300,
        "deviceFlowPollingInterval":                   10,
        "userCodeCharset":                             "BASE20",
        "userCodeLength":                              100,
        "pushedAuthReqEndpoint":                       "<pushed-auth-req-endpoint>",
        "mtlsEndpointAliases":                         [ { "name": "<mtls-endpoint-alias0-name>", "uri": "<mtls-endpoint-alias0-uri>" } ],
        "supportedAuthorizationDetailsTypes":          [ "<supported-authorization-details-type0>", "<supported-authorization-details-type1>" ],
        "supportedTrustFrameworks":                    [ "<supported-trust-framework0>", "<supported-trust-framework1>" ],
        "supportedEvidence":                           [ "<supported-evidence0>", "<supported-evidence1>" ],
        "supportedIdentityDocuments":                  [ "<supported-identity-document0>", "<supported-identity-document1>" ],
        "supportedVerificationMethods":                [ "<supported-verification-method0>", "<supported-verification-method1>" ],
        "supportedVerifiedClaims":                     [ "<supported-verified-claim0>", "<supported-verified-claim1>" ],
        "missingClientIdAllowed":                      false,
        "parRequired":                                 false,
        "requestObjectRequired":                       true,
        "traditionalRequestObjectProcessingApplied":   false,
        "claimShortcutRestrictive":                    false,
        "scopeRequired":                               true,
        "nbfOptional":                                 true,
        "issSuppressed":                               false,
        "attributes":                                  [{ "key": "<attribute0-key>", "value": "<attribute0-value>" }],
        "supportedCustomClientMetadata":               [ "<supported-custom-client-metadata0>", "<supported-custom-client-metadata1>" ],
        "tokenExpirationLinked":                       false,
        "frontChannelRequestObjectEncryptionRequired": false,
        "requestObjectEncryptionAlgMatchRequired":     false,
        "requestObjectEncryptionEncMatchRequired":     false,
        "refreshTokenDurationReset":                   false,
        "grantManagementEndpoint":                     "<grant-management-endpoint>",
        "grantManagementActionRequired":               false
      }
    JSON
  end


  def generate_hash
    {
      number:                                      1000,
      serviceOwnerNumber:                          12345,
      serviceName:                                 '<service-name>',
      apiKey:                                      '<api-key>',
      apiSecret:                                   '<api-secret>',
      issuer:                                      '<issuer>',
      authorizationEndpoint:                       '<authorization-endpoint>',
      tokenEndpoint:                               '<token-endpoint>',
      revocationEndpoint:                          '<revocation-endpoint>',
      supportedRevocationAuthMethods:              [ 'NONE', 'CLIENT_SECRET_BASIC' ],
      userInfoEndpoint:                            '<user-info-endpoint>',
      jwksUri:                                     '<jwks-uri>',
      jwks:                                        '<jwks>',
      registrationEndpoint:                        '<registration-endpoint>',
      registrationManagementEndpoint:              '<registration-management-endpoint>',
      supportedScopes:                             [ { name: 'scope0', description: '<scope0-description>', defaultEntry: false, descriptions: nil, attributes: nil } ],
      supportedResponseTypes:                      [ 'NONE', 'CODE', 'TOKEN', 'ID_TOKEN' ],
      supportedGrantTypes:                         [ 'AUTHORIZATION_CODE', 'REFRESH_TOKEN' ],
      supportedAcrs:                               [ '<supported-acr0>', '<supported-acr1>' ],
      supportedTokenAuthMethods:                   [ 'NONE', 'CLIENT_SECRET_BASIC' ],
      supportedDisplays:                           [ 'PAGE', 'POPUP', 'TOUCH', 'WAP' ],
      supportedClaimTypes:                         [ 'NORMAL' ],
      supportedClaims:                             [ '<supported-claim0>', '<supported-claim1>' ],
      serviceDocumentation:                        '<service-documentation>',
      supportedClaimLocales:                       [ 'en-US' ],
      supportedUiLocales:                          [ 'en-US' ],
      policyUri:                                   '<policy-uri>',
      tosUri:                                      '<tos-uri>',
      authenticationCallbackEndpoint:              '<authentication-callback-endpoint>',
      authenticationCallbackApiKey:                '<authentication-callback-api-key>',
      authenticationCallbackApiSecret:             '<authentication-callback-api-secret>',
      supportedSnses:                              [ 'FACEBOOK' ],
      snsCredentials:                              [ { sns: 'FACEBOOK', apiKey: '<sns-credentials0-api-key>', apiSecret: '<sns-credentials0-api-secret>' } ],
      createdAt:                                   10000,
      modifiedAt:                                  10000,
      developerAuthenticationCallbackEndpoint:     '<developer-authentication-callback-endpoint>',
      developerAuthenticationCallbackApiKey:       '<developer-authentication-callback-api-key>',
      developerAuthenticationCallbackApiSecret:    '<developer-authentication-callback-api-secret>',
      supportedDeveloperSnses:                     [ 'FACEBOOK' ],
      developerSnsCredentials:                     [ { sns: 'FACEBOOK', apiKey: '<developer-sns-credentials0-api-key>', apiSecret: '<developer-sns-credentials0-api-secret>' } ],
      clientsPerDeveloper:                         10,
      directAuthorizationEndpointEnabled:          true,
      directTokenEndpointEnabled:                  true,
      directRevocationEndpointEnabled:             true,
      directUserInfoEndpointEnabled:               true,
      directJwksEndpointEnabled:                   true,
      directIntrospectionEndpointEnabled:          true,
      singleAccessTokenPerSubject:                 false,
      pkceRequired:                                true,
      pkceS256Required:                            true,
      refreshTokenKept:                            true,
      refreshTokenDurationKept:                    true,
      errorDescriptionOmitted:                     false,
      errorUriOmitted:                             false,
      clientIdAliasEnabled:                        true,
      supportedServiceProfiles:                    [ 'FAPI', 'OPEN_BANKING' ],
      tlsClientCertificateBoundAccessTokens:       true,
      introspectionEndpoint:                       '<introspection-endpoint>',
      supportedIntrospectionAuthMethods:           [ 'NONE', 'CLIENT_SECRET_BASIC' ],
      mutualTlsValidatePkiCertChain:               true,
      trustedRootCertificates:                     [ '<trusted-root-certificate0>', '<trusted-root-certificate1>' ],
      dynamicRegistrationSupported:                true,
      endSessionEndpoint:                          '<end-session-endpoint>',
      description:                                 '<description>',
      accessTokenType:                             'Bearer',
      accessTokenSignAlg:                          'HS256',
      accessTokenDuration:                         300,
      refreshTokenDuration:                        300,
      idTokenDuration:                             300,
      authorizationResponseDuration:               300,
      pushedAuthReqDuration:                       300,
      metadata:                                    [ { key: '<metadata0-key>', value: '<metadata0-value>' } ],
      accessTokenSignatureKeyId:                   '<access-token-signature-key-id>',
      authorizationSignatureKeyId:                 '<authorization-signature-key-id>',
      idTokenSignatureKeyId:                       '<id-token-signature-key-id>',
      userInfoSignatureKeyId:                      '<user-info-signature-key-id>',
      supportedBackchannelTokenDeliveryModes:      [ 'POLL', 'PING', 'PUSH' ],
      backchannelAuthenticationEndpoint:           '<backchannel-authentication-endpoint>',
      backchannelUserCodeParameterSupported:       true,
      backchannelAuthReqIdDuration:                300,
      backchannelPollingInterval:                  10,
      backchannelBindingMessageRequiredInFapi:     true,
      allowableClockSkew:                          100,
      deviceAuthorizationEndpoint:                 '<device-authorization-endpoint>',
      deviceVerificationUri:                       '<device-verification-uri>',
      deviceVerificationUriComplete:               '<device-verification-uri-complete>',
      deviceFlowCodeDuration:                      300,
      deviceFlowPollingInterval:                   10,
      userCodeCharset:                             'BASE20',
      userCodeLength:                              100,
      pushedAuthReqEndpoint:                       '<pushed-auth-req-endpoint>',
      mtlsEndpointAliases:                         [ { name: '<mtls-endpoint-alias0-name>', uri: '<mtls-endpoint-alias0-uri>' } ],
      supportedAuthorizationDetailsTypes:          [ '<supported-authorization-details-type0>', '<supported-authorization-details-type1>' ],
      supportedTrustFrameworks:                    [ '<supported-trust-framework0>', '<supported-trust-framework1>' ],
      supportedEvidence:                           [ '<supported-evidence0>', '<supported-evidence1>' ],
      supportedIdentityDocuments:                  [ '<supported-identity-document0>', '<supported-identity-document1>' ],
      supportedVerificationMethods:                [ '<supported-verification-method0>', '<supported-verification-method1>' ],
      supportedVerifiedClaims:                     [ '<supported-verified-claim0>', '<supported-verified-claim1>' ],
      missingClientIdAllowed:                      false,
      parRequired:                                 false,
      requestObjectRequired:                       true,
      traditionalRequestObjectProcessingApplied:   false,
      claimShortcutRestrictive:                    false,
      scopeRequired:                               true,
      nbfOptional:                                 true,
      issSuppressed:                               false,
      attributes:                                  [{ key: '<attribute0-key>', value: '<attribute0-value>' }],
      supportedCustomClientMetadata:               [ '<supported-custom-client-metadata0>', '<supported-custom-client-metadata1>' ],
      tokenExpirationLinked:                       false,
      frontChannelRequestObjectEncryptionRequired: false,
      requestObjectEncryptionAlgMatchRequired:     false,
      requestObjectEncryptionEncMatchRequired:     false,
      hsks:                                        [ { kty: 'EC', use: 'sig', alg: 'ES256', kid: 'jane', hsmName: 'google', handle: '<handle>', publicKey: '<public-key>' } ],
      hsmEnabled:                                  false,
      refreshTokenDurationReset:                   false,
      grantManagementEndpoint:                     '<grant-management-endpoint>',
      grantManagementActionRequired:               false,
    }
  end


  def set_params(obj)
    obj.number                                        = NUMBER
    obj.service_owner_number                          = SERVICE_OWNER_NUMBER
    obj.service_name                                  = SERVICE_NAME
    obj.api_key                                       = API_KEY
    obj.api_secret                                    = API_SECRET
    obj.issuer                                        = ISSUER
    obj.authorization_endpoint                        = AUTHORIZATION_ENDPOINT
    obj.token_endpoint                                = TOKEN_ENDPOINT
    obj.revocation_endpoint                           = REVOCATION_ENDPOINT
    obj.supported_revocation_auth_methods             = SUPPORTED_REVOCATION_AUTH_METHODS
    obj.user_info_endpoint                            = USER_INFO_ENDPOINT
    obj.jwks_uri                                      = JWKS_URI
    obj.jwks                                          = JWKS
    obj.registration_endpoint                         = REGISTRATION_ENDPOINT
    obj.registration_management_endpoint              = REGISTRATION_MANAGEMENT_ENDPOINT
    obj.supported_scopes                              = SUPPORTED_SCOPES
    obj.supported_response_types                      = SUPPORTED_RESPONSE_TYPES
    obj.supported_grant_types                         = SUPPORTED_GRANT_TYPES
    obj.supported_acrs                                = SUPPORTED_ACRS
    obj.supported_token_auth_methods                  = SUPPORTED_TOKEN_AUTH_METHODS
    obj.supported_displays                            = SUPPORTED_DISPLAYS
    obj.supported_claim_types                         = SUPPORTED_CLAIM_TYPES
    obj.supported_claims                              = SUPPORTED_CLAIMS
    obj.service_documentation                         = SERVICE_DOCUMENTATION
    obj.supported_claim_locales                       = SUPPORTED_CLAIM_LOCALES
    obj.supported_ui_locales                          = SUPPORTED_UI_LOCALES
    obj.policy_uri                                    = POLICY_URI
    obj.tos_uri                                       = TOS_URI
    obj.authentication_callback_endpoint              = AUTHENTICATION_CALLBACK_ENDPOINT
    obj.authentication_callback_api_key               = AUTHENTICATION_CALLBACK_API_KEY
    obj.authentication_callback_api_secret            = AUTHENTICATION_CALLBACK_API_SECRET
    obj.supported_snses                               = SUPPORTED_SNSES
    obj.sns_credentials                               = SNS_CREDENTIALS
    obj.created_at                                    = CREATED_AT
    obj.modified_at                                   = MODIFIED_AT
    obj.developer_authentication_callback_endpoint    = DEVELOPER_AUTHENTICATION_CALLBACK_ENDPOINT
    obj.developer_authentication_callback_api_key     = DEVELOPER_AUTHENTICATION_CALLBACK_API_KEY
    obj.developer_authentication_callback_api_secret  = DEVELOPER_AUTHENTICATION_CALLBACK_API_SECRET
    obj.supported_developer_snses                     = SUPPORTED_DEVELOPER_SNSES
    obj.developer_sns_credentials                     = DEVELOPER_SNS_CREDENTIALS
    obj.clients_per_developer                         = CLIENTS_PER_DEVELOPER
    obj.direct_authorization_endpoint_enabled         = DIRECT_AUTHORIZATION_ENDPOINT_ENABLED
    obj.direct_token_endpoint_enabled                 = DIRECT_TOKEN_ENDPOINT_ENABLED
    obj.direct_revocation_endpoint_enabled            = DIRECT_REVOCATION_ENDPOINT_ENABLED
    obj.direct_user_info_endpoint_enabled             = DIRECT_USER_INFO_ENDPOINT_ENABLED
    obj.direct_jwks_endpoint_enabled                  = DIRECT_JWKS_ENDPOINT_ENABLED
    obj.direct_introspection_endpoint_enabled         = DIRECT_INTROSPECTION_ENDPOINT_ENABLED
    obj.single_access_token_per_subject               = SINGLE_ACCESS_TOKEN_PER_SUBJECT
    obj.pkce_required                                 = PKCE_REQUIRED
    obj.pkce_s256_required                            = PKCE_S256_REQUIRED
    obj.refresh_token_kept                            = REFRESH_TOKEN_KEPT
    obj.refresh_token_duration_kept                   = REFRESH_TOKEN_DURATION_KEPT
    obj.error_description_omitted                     = ERROR_DESCRIPTION_OMITTED
    obj.error_uri_omitted                             = ERROR_URI_OMITTED
    obj.client_id_alias_enabled                       = CLIENT_ID_ALIAS_ENABLED
    obj.supported_service_profiles                    = SUPPORTED_SERVICE_PROFILES
    obj.tls_client_certificate_bound_access_tokens    = TLS_CLIENT_CERTIFICATE_BOUND_ACCESS_TOKENS
    obj.introspection_endpoint                        = INTROSPECTION_ENDPOINT
    obj.supported_introspection_auth_methods          = SUPPORTED_INTROSPECTION_AUTH_METHODS
    obj.mutual_tls_validate_pki_cert_chain            = MUTUAL_TLS_VALIDATE_PKI_CERT_CHAIN
    obj.trusted_root_certificates                     = TRUSTED_ROOT_CERTIFICATES
    obj.dynamic_registration_supported                = DYNAMIC_REGISTRATION_SUPPORTED
    obj.end_session_endpoint                          = END_SESSION_ENDPOINT
    obj.description                                   = DESCRIPTION
    obj.access_token_type                             = ACCESS_TOKEN_TYPE
    obj.access_token_sign_alg                         = ACCESS_TOKEN_SIGN_ALG
    obj.access_token_duration                         = ACCESS_TOKEN_DURATION
    obj.refresh_token_duration                        = REFRESH_TOKEN_DURATION
    obj.id_token_duration                             = ID_TOKEN_DURATION
    obj.authorization_response_duration               = AUTHORIZATION_RESPONSE_DURATION
    obj.pushed_auth_req_duration                      = PUSHED_AUTH_REQ_DURATION
    obj.metadata                                      = METADATA
    obj.access_token_signature_key_id                 = ACCESS_TOKEN_SIGNATURE_KEY_ID
    obj.authorization_signature_key_id                = AUTHORIZATION_SIGNATURE_KEY_ID
    obj.id_token_signature_key_id                     = ID_TOKEN_SIGNATURE_KEY_ID
    obj.user_info_signature_key_id                    = USER_INFO_SIGNATURE_KEY_ID
    obj.supported_backchannel_token_delivery_modes    = SUPPORTED_BACKCHANNEL_TOKEN_DELIVERY_MODES
    obj.backchannel_authentication_endpoint           = BACKCHANNEL_AUTHENTICATION_ENDPOINT
    obj.backchannel_user_code_parameter_supported     = BACKCHANNEL_USER_CODE_PARAMETER_SUPPORTED
    obj.backchannel_auth_req_id_duration              = BACKCHANNEL_AUTH_REQ_ID_DURATION
    obj.backchannel_polling_interval                  = BACKCHANNEL_POLLING_INTERVAL
    obj.backchannel_binding_message_required_in_fapi  = BACKCHANNEL_BINDING_MESSAGE_REQUIRED_IN_FAPI
    obj.allowable_clock_skew                          = ALLOWABLE_CLOCK_SKEW
    obj.device_authorization_endpoint                 = DEVICE_AUTHORIZATION_ENDPOINT
    obj.device_verification_uri                       = DEVICE_VERIFICATION_URI
    obj.device_verification_uri_complete              = DEVICE_VERIFICATION_URI_COMPLETE
    obj.device_flow_code_duration                     = DEVICE_FLOW_CODE_DURATION
    obj.device_flow_polling_interval                  = DEVICE_FLOW_POLLING_INTERVAL
    obj.user_code_charset                             = USER_CODE_CHARSET
    obj.user_code_length                              = USER_CODE_LENGTH
    obj.pushed_auth_req_endpoint                      = PUSHED_AUTH_REQ_ENDPOINT
    obj.mtls_endpoint_aliases                         = MTLS_ENDPOINT_ALIASES
    obj.supported_authorization_details_types         = SUPPORTED_AUTHORIZATION_DETAILS_TYPES
    obj.supported_trust_frameworks                    = SUPPORTED_TRUST_FRAMEWORKS
    obj.supported_evidence                            = SUPPORTED_EVIDENCE
    obj.supported_identity_documents                  = SUPPORTED_IDENTITY_DOCUMENTS
    obj.supported_verification_methods                = SUPPORTED_VERIFICATION_METHODS
    obj.supported_verified_claims                     = SUPPORTED_VERIFIED_CLAIMS
    obj.missing_client_id_allowed                     = MISSING_CLIENT_ID_ALLOWED
    obj.par_required                                  = PAR_REQUIRED
    obj.request_object_required                       = REQUEST_OBJECT_REQUIRED
    obj.traditional_request_object_processing_applied = TRADITIONAL_REQUEST_OBJECT_PROCESSING_APPLIED
    obj.claim_shortcut_restrictive                    = CLAIM_SHORTCUT_RESTRICTIVE
    obj.scope_required                                = SCOPE_REQUIRED
    obj.nbf_optional                                  = NBF_OPTIONAL
    obj.iss_suppressed                                = ISS_SUPPRESSED
    obj.attributes                                    = ATTRIBUTES
    obj.supported_custom_client_metadata              = SUPPORTED_CUSTOM_CLIENT_METADATA
    obj.token_expiration_linked                       = TOKEN_EXPIRATION_LINKED
    obj.frontChannelRequestObjectEncryptionRequired   = FRONT_CHANNEL_REQUEST_OBJECT_ENCRYPTION_REQUIRED
    obj.requestObjectEncryptionAlgMatchRequired       = REQUEST_OBJECT_ENCRYPTION_ALG_MATCH_REQUIRED
    obj.requestObjectEncryptionEncMatchRequired       = REQUEST_OBJECT_ENCRYPTION_ENC_MATCH_REQUIRED
    obj.hsks                                          = HSKS
    obj.hsm_enabled                                   = HSM_ENABLED
    obj.refresh_token_duration_reset                  = REFRESH_TOKEN_DURATION_RESET
    obj.grant_management_endpoint                     = GRANT_MANAGEMENT_ENDPOINT
    obj.grant_management_action_required              = GRANT_MANAGEMENT_ACTION_REQUIRED
  end


  def match(obj)
    assert_equal NUMBER,                                           obj.number
    assert_equal SERVICE_OWNER_NUMBER,                             obj.serviceOwnerNumber
    assert_equal SERVICE_NAME,                                     obj.serviceName
    assert_equal API_KEY,                                          obj.apiKey
    assert_equal API_SECRET,                                       obj.apiSecret
    assert_equal ISSUER,                                           obj.issuer
    assert_equal AUTHORIZATION_ENDPOINT,                           obj.authorizationEndpoint
    assert_equal TOKEN_ENDPOINT,                                   obj.tokenEndpoint
    assert_equal REVOCATION_ENDPOINT,                              obj.revocationEndpoint
    assert_equal SUPPORTED_REVOCATION_AUTH_METHODS,                obj.supportedRevocationAuthMethods
    assert_equal USER_INFO_ENDPOINT,                               obj.userInfoEndpoint
    assert_equal JWKS_URI,                                         obj.jwksUri
    assert_equal JWKS,                                             obj.jwks
    assert_equal REGISTRATION_ENDPOINT,                            obj.registrationEndpoint
    assert_equal REGISTRATION_MANAGEMENT_ENDPOINT,                 obj.registrationManagementEndpoint
    assert_equal SUPPORTED_SCOPE_NAME,                             obj.supportedScopes[0].name
    assert_equal SUPPORTED_SCOPE_DESCRIPTION,                      obj.supportedScopes[0].description
    assert_equal SUPPORTED_RESPONSE_TYPES,                         obj.supportedResponseTypes
    assert_equal SUPPORTED_GRANT_TYPES,                            obj.supportedGrantTypes
    assert_equal SUPPORTED_ACRS,                                   obj.supportedAcrs
    assert_equal SUPPORTED_TOKEN_AUTH_METHODS,                     obj.supportedTokenAuthMethods
    assert_equal SUPPORTED_DISPLAYS,                               obj.supportedDisplays
    assert_equal SUPPORTED_CLAIM_TYPES,                            obj.supportedClaimTypes
    assert_equal SUPPORTED_CLAIMS,                                 obj.supportedClaims
    assert_equal SERVICE_DOCUMENTATION,                            obj.serviceDocumentation
    assert_equal SUPPORTED_CLAIM_LOCALES,                          obj.supportedClaimLocales
    assert_equal SUPPORTED_UI_LOCALES,                             obj.supportedUiLocales
    assert_equal POLICY_URI,                                       obj.policyUri
    assert_equal TOS_URI,                                          obj.tosUri
    assert_equal AUTHENTICATION_CALLBACK_ENDPOINT,                 obj.authenticationCallbackEndpoint
    assert_equal AUTHENTICATION_CALLBACK_API_KEY,                  obj.authenticationCallbackApiKey
    assert_equal AUTHENTICATION_CALLBACK_API_SECRET,               obj.authenticationCallbackApiSecret
    assert_equal SUPPORTED_SNSES,                                  obj.supportedSnses
    assert_equal SNS_CREDENTIALS_SNS,                              obj.snsCredentials[0].sns
    assert_equal SNS_CREDENTIALS_API_KEY,                          obj.snsCredentials[0].apiKey
    assert_equal SNS_CREDENTIALS_API_SECRET,                       obj.snsCredentials[0].apiSecret
    assert_equal CREATED_AT,                                       obj.createdAt
    assert_equal MODIFIED_AT,                                      obj.modifiedAt
    assert_equal DEVELOPER_AUTHENTICATION_CALLBACK_ENDPOINT,       obj.developerAuthenticationCallbackEndpoint
    assert_equal DEVELOPER_AUTHENTICATION_CALLBACK_API_KEY,        obj.developerAuthenticationCallbackApiKey
    assert_equal DEVELOPER_AUTHENTICATION_CALLBACK_API_SECRET,     obj.developerAuthenticationCallbackApiSecret
    assert_equal SUPPORTED_DEVELOPER_SNSES,                        obj.supportedDeveloperSnses
    assert_equal DEVELOPER_SNS_CREDENTIALS_SNS,                    obj.developerSnsCredentials[0].sns
    assert_equal DEVELOPER_SNS_CREDENTIALS_API_KEY,                obj.developerSnsCredentials[0].apiKey
    assert_equal DEVELOPER_SNS_CREDENTIALS_API_SECRET,             obj.developerSnsCredentials[0].apiSecret
    assert_equal CLIENTS_PER_DEVELOPER,                            obj.clientsPerDeveloper
    assert_equal DIRECT_AUTHORIZATION_ENDPOINT_ENABLED,            obj.directAuthorizationEndpointEnabled
    assert_equal DIRECT_TOKEN_ENDPOINT_ENABLED,                    obj.directTokenEndpointEnabled
    assert_equal DIRECT_REVOCATION_ENDPOINT_ENABLED,               obj.directRevocationEndpointEnabled
    assert_equal DIRECT_USER_INFO_ENDPOINT_ENABLED,                obj.directUserInfoEndpointEnabled
    assert_equal DIRECT_JWKS_ENDPOINT_ENABLED,                     obj.directJwksEndpointEnabled
    assert_equal DIRECT_INTROSPECTION_ENDPOINT_ENABLED,            obj.directIntrospectionEndpointEnabled
    assert_equal SINGLE_ACCESS_TOKEN_PER_SUBJECT,                  obj.singleAccessTokenPerSubject
    assert_equal PKCE_REQUIRED,                                    obj.pkceRequired
    assert_equal PKCE_S256_REQUIRED,                               obj.pkceS256Required
    assert_equal REFRESH_TOKEN_KEPT,                               obj.refreshTokenKept
    assert_equal REFRESH_TOKEN_DURATION_KEPT,                      obj.refreshTokenDurationKept
    assert_equal ERROR_DESCRIPTION_OMITTED,                        obj.errorDescriptionOmitted
    assert_equal ERROR_URI_OMITTED,                                obj.errorUriOmitted
    assert_equal CLIENT_ID_ALIAS_ENABLED,                          obj.clientIdAliasEnabled
    assert_equal SUPPORTED_SERVICE_PROFILES,                       obj.supportedServiceProfiles
    assert_equal TLS_CLIENT_CERTIFICATE_BOUND_ACCESS_TOKENS,       obj.tlsClientCertificateBoundAccessTokens
    assert_equal INTROSPECTION_ENDPOINT,                           obj.introspectionEndpoint
    assert_equal SUPPORTED_INTROSPECTION_AUTH_METHODS,             obj.supportedIntrospectionAuthMethods
    assert_equal MUTUAL_TLS_VALIDATE_PKI_CERT_CHAIN,               obj.mutualTlsValidatePkiCertChain
    assert_equal TRUSTED_ROOT_CERTIFICATES,                        obj.trustedRootCertificates
    assert_equal DYNAMIC_REGISTRATION_SUPPORTED,                   obj.dynamicRegistrationSupported
    assert_equal END_SESSION_ENDPOINT,                             obj.endSessionEndpoint
    assert_equal DESCRIPTION,                                      obj.description
    assert_equal ACCESS_TOKEN_TYPE,                                obj.accessTokenType
    assert_equal ACCESS_TOKEN_SIGN_ALG,                            obj.accessTokenSignAlg
    assert_equal ACCESS_TOKEN_DURATION,                            obj.accessTokenDuration
    assert_equal REFRESH_TOKEN_DURATION,                           obj.refreshTokenDuration
    assert_equal ID_TOKEN_DURATION,                                obj.idTokenDuration
    assert_equal AUTHORIZATION_RESPONSE_DURATION,                  obj.authorizationResponseDuration
    assert_equal PUSHED_AUTH_REQ_DURATION,                         obj.pushedAuthReqDuration
    assert_equal METADATA_KEY,                                     obj.metadata[0].key
    assert_equal METADATA_VALUE,                                   obj.metadata[0].value
    assert_equal ACCESS_TOKEN_SIGNATURE_KEY_ID,                    obj.accessTokenSignatureKeyId
    assert_equal AUTHORIZATION_SIGNATURE_KEY_ID,                   obj.authorizationSignatureKeyId
    assert_equal ID_TOKEN_SIGNATURE_KEY_ID,                        obj.idTokenSignatureKeyId
    assert_equal USER_INFO_SIGNATURE_KEY_ID,                       obj.userInfoSignatureKeyId
    assert_equal SUPPORTED_BACKCHANNEL_TOKEN_DELIVERY_MODES,       obj.supportedBackchannelTokenDeliveryModes
    assert_equal BACKCHANNEL_AUTHENTICATION_ENDPOINT,              obj.backchannelAuthenticationEndpoint
    assert_equal BACKCHANNEL_USER_CODE_PARAMETER_SUPPORTED,        obj.backchannelUserCodeParameterSupported
    assert_equal BACKCHANNEL_AUTH_REQ_ID_DURATION,                 obj.backchannelAuthReqIdDuration
    assert_equal BACKCHANNEL_POLLING_INTERVAL,                     obj.backchannelPollingInterval
    assert_equal BACKCHANNEL_BINDING_MESSAGE_REQUIRED_IN_FAPI,     obj.backchannelBindingMessageRequiredInFapi
    assert_equal ALLOWABLE_CLOCK_SKEW,                             obj.allowableClockSkew
    assert_equal DEVICE_AUTHORIZATION_ENDPOINT,                    obj.deviceAuthorizationEndpoint
    assert_equal DEVICE_VERIFICATION_URI,                          obj.deviceVerificationUri
    assert_equal DEVICE_VERIFICATION_URI_COMPLETE,                 obj.deviceVerificationUriComplete
    assert_equal DEVICE_FLOW_CODE_DURATION,                        obj.deviceFlowCodeDuration
    assert_equal DEVICE_FLOW_POLLING_INTERVAL,                     obj.deviceFlowPollingInterval
    assert_equal USER_CODE_CHARSET,                                obj.userCodeCharset
    assert_equal USER_CODE_LENGTH,                                 obj.userCodeLength
    assert_equal PUSHED_AUTH_REQ_ENDPOINT,                         obj.pushedAuthReqEndpoint
    assert_equal MTLS_ENDPOINT_ALIAS_NAME,                         obj.mtlsEndpointAliases[0].name
    assert_equal MTLS_ENDPOINT_ALIAS_URI,                          obj.mtlsEndpointAliases[0].uri
    assert_equal SUPPORTED_AUTHORIZATION_DETAILS_TYPES,            obj.supportedAuthorizationDetailsTypes
    assert_equal SUPPORTED_TRUST_FRAMEWORKS,                       obj.supportedTrustFrameworks
    assert_equal SUPPORTED_EVIDENCE,                               obj.supportedEvidence
    assert_equal SUPPORTED_IDENTITY_DOCUMENTS,                     obj.supportedIdentityDocuments
    assert_equal SUPPORTED_VERIFICATION_METHODS,                   obj.supportedVerificationMethods
    assert_equal SUPPORTED_VERIFIED_CLAIMS,                        obj.supportedVerifiedClaims
    assert_equal MISSING_CLIENT_ID_ALLOWED,                        obj.missingClientIdAllowed
    assert_equal PAR_REQUIRED,                                     obj.parRequired
    assert_equal REQUEST_OBJECT_REQUIRED,                          obj.requestObjectRequired
    assert_equal TRADITIONAL_REQUEST_OBJECT_PROCESSING_APPLIED,    obj.traditionalRequestObjectProcessingApplied
    assert_equal CLAIM_SHORTCUT_RESTRICTIVE,                       obj.claimShortcutRestrictive
    assert_equal SCOPE_REQUIRED,                                   obj.scopeRequired
    assert_equal NBF_OPTIONAL,                                     obj.nbfOptional
    assert_equal ISS_SUPPRESSED,                                   obj.issSuppressed
    assert_equal ATTRIBUTE_KEY,                                    obj.attributes[0].key
    assert_equal ATTRIBUTE_VALUE,                                  obj.attributes[0].value
    assert_equal SUPPORTED_CUSTOM_CLIENT_METADATA,                 obj.supportedCustomClientMetadata
    assert_equal TOKEN_EXPIRATION_LINKED,                          obj.tokenExpirationLinked
    assert_equal FRONT_CHANNEL_REQUEST_OBJECT_ENCRYPTION_REQUIRED, obj.frontChannelRequestObjectEncryptionRequired
    assert_equal REQUEST_OBJECT_ENCRYPTION_ALG_MATCH_REQUIRED,     obj.requestObjectEncryptionAlgMatchRequired
    assert_equal REQUEST_OBJECT_ENCRYPTION_ENC_MATCH_REQUIRED,     obj.requestObjectEncryptionEncMatchRequired
    assert_equal HSKS_KTY,                                         obj.hsks[0].kty
    assert_equal HSKS_USE,                                         obj.hsks[0].use
    assert_equal HSKS_ALG,                                         obj.hsks[0].alg
    assert_equal HSKS_KID,                                         obj.hsks[0].kid
    assert_equal HSKS_HSMNAME,                                     obj.hsks[0].hsmName
    assert_equal HSKS_HANDLE,                                      obj.hsks[0].handle
    assert_equal HSKS_PUBLICKEY,                                   obj.hsks[0].publicKey
    assert_equal HSM_ENABLED,                                      obj.hsmEnabled
    assert_equal REFRESH_TOKEN_DURATION_RESET,                     obj.refreshTokenDurationReset
    assert_equal GRANT_MANAGEMENT_ENDPOINT,                        obj.grantManagementEndpoint
    assert_equal GRANT_MANAGEMENT_ACTION_REQUIRED,                 obj.grantManagementActionRequired
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Service.new(hsh)

    match(actual)
  end


  def test_setters
    actual = Authlete::Model::Service.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::Service.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end
end
