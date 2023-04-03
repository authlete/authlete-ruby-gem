# :nodoc:
#
# Copyright (C) 2014-2022 Authlete, Inc.
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


class ClientTest < Minitest::Test
  NUMBER                                           = 100
  SERVICE_NUMBER                                   = 1000
  DEVELOPER                                        = '<developer>'
  CLIENT_ID                                        = 12345
  CLIENT_ID_ALIAS                                  = '<client-id-alias>'
  CLIENT_ID_ALIAS_ENABLED                          = true
  CLIENT_SECRET                                    = '<client-secret>'
  CLIENT_TYPE                                      = 'PUBLIC'
  REDIRECT_URIS                                    = [ '<redirect-uri0>', '<redirect-uri1>' ]
  RESPONSE_TYPES                                   = [ 'NONE', 'CODE', 'TOKEN', 'ID_TOKEN' ]
  GRANT_TYPES                                      = [ 'AUTHORIZATION_CODE', 'REFRESH_TOKEN' ]
  APPLICATION_TYPE                                 = 'WEB'
  CONTACTS                                         = [ '<contact0>', '<contact1>' ]
  CLIENT_NAME                                      = '<client-name>'
  CLIENT_NAME_TAG                                  = '<client-name0-tag>'
  CLIENT_NAME_VALUE                                = '<client-name0-value>'
  CLIENT_NAMES                                     = [ Authlete::Model::TaggedValue.new(tag: CLIENT_NAME_TAG, value: CLIENT_NAME_VALUE) ]
  LOGO_URI                                         = '<logo-uri>'
  LOGO_URI_TAG                                     = '<logo-uri0-tag>'
  LOGO_URI_VALUE                                   = '<logo-uri0-value>'
  LOGO_URIS                                        = [ Authlete::Model::TaggedValue.new(tag: LOGO_URI_TAG, value: LOGO_URI_VALUE) ]
  CLIENT_URI                                       = '<client-uri>'
  CLIENT_URI_TAG                                   = '<client-uri0-tag>'
  CLIENT_URI_VALUE                                 = '<client-uri0-value>'
  CLIENT_URIS                                      = [ Authlete::Model::TaggedValue.new(tag: CLIENT_URI_TAG, value: CLIENT_URI_VALUE) ]
  POLICY_URI                                       = '<policy-uri>'
  POLICY_URI_TAG                                   = '<policy-uri0-tag>'
  POLICY_URI_VALUE                                 = '<policy-uri0-value>'
  POLICY_URIS                                      = [ Authlete::Model::TaggedValue.new(tag: POLICY_URI_TAG, value: POLICY_URI_VALUE) ]
  TOS_URI                                          = '<tos-uri>'
  TOS_URI_TAG                                      = '<tos-uri0-tag>'
  TOS_URI_VALUE                                    = '<tos-uri0-value>'
  TOS_URIS                                         = [ Authlete::Model::TaggedValue.new(tag: TOS_URI_TAG, value: TOS_URI_VALUE) ]
  JWKS_URI                                         = '<jwks-uri>'
  JWKS                                             = '{"keys":[]}'
  DERIVED_SECTOR_IDENTIFIER                        = '<derived-sector-identifier>'
  SECTOR_IDENTIFIER_URI                            = '<sector-identifier-uri>'
  SUBJECT_TYPE                                     = 'PUBLIC'
  ID_TOKEN_SIGN_ALG                                = 'HS256'
  ID_TOKEN_ENCRYPTION_ALG                          = 'PBES2_HS256_A128KW'
  ID_TOKEN_ENCRYPTION_ENC                          = 'A128CBC_HS256'
  USER_INFO_SIGN_ALG                               = 'HS256'
  USER_INFO_ENCRYPTION_ALG                         = 'PBES2_HS256_A128KW'
  USER_INFO_ENCRYPTION_ENC                         = 'A128CBC_HS256'
  REQUEST_SIGN_ALG                                 = 'HS256'
  REQUEST_ENCRYPTION_ALG                           = 'PBES2_HS256_A128KW'
  REQUEST_ENCRYPTION_ENC                           = 'A128CBC_HS256'
  TOKEN_AUTH_METHOD                                = 'CLIENT_SECRET_BASIC'
  TOKEN_AUTH_SIGN_ALG                              = 'HS256'
  DEFAULT_MAX_AGE                                  = 1000
  DEFAULT_ACRS                                     = [ '<default-acr0>', '<default-acr1>' ]
  AUTH_TIME_REQUIRED                               = true
  LOGIN_URI                                        = '<login-uri>'
  REQUEST_URIS                                     = [ '<request-uri0>', '<request-uri1>' ]
  DESCRIPTION                                      = '<description>'
  DESCRIPTION_TAG                                  = '<description0-tag>'
  DESCRIPTION_VALUE                                = '<description0-value>'
  DESCRIPTIONS                                     = [ Authlete::Model::TaggedValue.new(tag: DESCRIPTION_TAG, value: DESCRIPTION_VALUE) ]
  CREATED_AT                                       = 10000
  MODIFIED_AT                                      = 10000
  REQUESTABLE_SCOPES                               = [ '<requestable-scope0>', '<requestable-scope1>' ]
  REQUESTABLE_SCOPES_ENABLED                       = true
  ACCESS_TOKEN_DURATION                            = 10000
  REFRESH_TOKEN_DURATION                           = 10000
  TOKEN_EXCHANGE_PERMITTED                         = false
  EXTENSION                                        = Authlete::Model::ClientExtension.new(
                                                       requestableScopes:        REQUESTABLE_SCOPES,
                                                       requestableScopesEnabled: REQUESTABLE_SCOPES_ENABLED,
                                                       accessTokenDuration:      ACCESS_TOKEN_DURATION,
                                                       refreshTokenDuration:     REFRESH_TOKEN_DURATION,
                                                       tokenExchangePermitted:   TOKEN_EXCHANGE_PERMITTED
                                                     )
  TLS_CLIENT_AUTH_SUBJECT_DN                       = '<tls-client-auth-subject-dn>'
  TLS_CLIENT_AUTH_SAN_DNS                          = '<tls-client-auth-san-dns>'
  TLS_CLIENT_AUTH_SAN_URI                          = '<tls-client-auth-san-uri>'
  TLS_CLIENT_AUTH_SAN_IP                           = '<tls-client-auth-san-ip>'
  TLS_CLIENT_AUTH_SAN_EMAIL                        = '<tls-client-auth-san-email>'
  TLS_CLIENT_CERTIFICATE_BOUND_ACCESS_TOKENS       = false
  SELF_SIGNED_CERTIFICATE_KEY_ID                   = '<self-signed-certificate-key-id>'
  SOFTWARE_ID                                      = '<software-id>'
  SOFTWARE_VERSION                                 = '<software-version>'
  AUTHORIZATION_SIGN_ALG                           = 'HS256'
  AUTHORIZATION_ENCRYPTION_ALG                     = 'PBES2_HS256_A128KW'
  AUTHORIZATION_ENCRYPTION_ENC                     = 'A128CBC_HS256'
  BC_DELIVERY_MODE                                 = 'POLL'
  BC_NOTIFICATION_ENDPOINT                         = '<bc-notification-endpoint>'
  BC_REQUEST_SIGN_ALG                              = 'HS256'
  BC_USER_CODE_REQUIRED                            = true
  DYNAMICALLY_REGISTERED                           = false
  REGISTRATION_ACCESS_TOKEN_HASH                   = '<registration-access-token-hash>'
  AUTHORIZATION_DETAILS_TYPES                      = [ '<authorization-details-type0>', '<authorization-details-type1>' ]
  PAR_REQUIRED                                     = false
  REQUEST_OBJECT_REQUIRED                          = true
  ATTRIBUTE_KEY                                    = '<attribute0-key>'
  ATTRIBUTE_VALUE                                  = '<attribute0-value>'
  ATTRIBUTES                                       = [ Authlete::Model::Pair.new(key: ATTRIBUTE_KEY, value: ATTRIBUTE_VALUE) ]
  CUSTOM_METADATA                                  = '<custom-metadata>'
  FRONT_CHANNEL_REQUEST_OBJECT_ENCRYPTION_REQUIRED = false
  REQUEST_OBJECT_ENCRYPTION_ALG_MATCH_REQUIRED     = false
  REQUEST_OBJECT_ENCRYPTION_ENC_MATCH_REQUIRED     = false
  DIGEST_ALGORITHM                                 = '<digest-algorithm>'
  SINGLE_ACCESS_TOKEN_PER_SUBJECT                  = false
  PKCE_REQUIRED                                    = false
  PKCE_S256_REQUIRED                               = false
  AUTOMATICALLY_REGISTERED                         = false
  EXPLICITLY_REGISTERED                            = false
  DPOP_REQUIRED                                    = false

  def generate_json
    return <<~JSON
      {
        "number":                                      100,
        "serviceNumber":                               1000,
        "developer":                                   "<developer>",
        "clientId":                                    12345,
        "clientIdAlias":                               "<client-id-alias>",
        "clientIdAliasEnabled":                        true,
        "clientSecret":                                "<client-secret>",
        "clientType":                                  "PUBLIC",
        "redirectUris":                                [ "<redirect-uri0>", "<redirect-uri1>" ],
        "responseTypes":                               [ "NONE", "CODE", "TOKEN", "ID_TOKEN" ],
        "grantTypes":                                  [ "AUTHORIZATION_CODE", "REFRESH_TOKEN" ],
        "applicationType":                             "WEB",
        "contacts":                                    [ "<contact0>", "<contact1>" ],
        "clientName":                                  "<client-name>",
        "clientNames":                                 [ { "tag": "<client-name0-tag>", "value": "<client-name0-value>" } ],
        "logoUri":                                     "<logo-uri>",
        "logoUris":                                    [ { "tag": "<logo-uri0-tag>", "value": "<logo-uri0-value>" } ],
        "clientUri":                                   "<client-uri>",
        "clientUris":                                  [ { "tag": "<client-uri0-tag>", "value": "<client-uri0-value>" } ],
        "policyUri":                                   "<policy-uri>",
        "policyUris":                                  [ { "tag": "<policy-uri0-tag>", "value": "<policy-uri0-value>" } ],
        "tosUri":                                      "<tos-uri>",
        "tosUris":                                     [ { "tag": "<tos-uri0-tag>", "value": "<tos-uri0-value>" } ],
        "jwksUri":                                     "<jwks-uri>",
        "jwks":                                        "{\\"keys\\":[]}",
        "derivedSectorIdentifier":                     "<derived-sector-identifier>",
        "sectorIdentifierUri":                         "<sector-identifier-uri>",
        "subjectType":                                 "PUBLIC",
        "idTokenSignAlg":                              "HS256",
        "idTokenEncryptionAlg":                        "PBES2_HS256_A128KW",
        "idTokenEncryptionEnc":                        "A128CBC_HS256",
        "userInfoSignAlg":                             "HS256",
        "userInfoEncryptionAlg":                       "PBES2_HS256_A128KW",
        "userInfoEncryptionEnc":                       "A128CBC_HS256",
        "requestSignAlg":                              "HS256",
        "requestEncryptionAlg":                        "PBES2_HS256_A128KW",
        "requestEncryptionEnc":                        "A128CBC_HS256",
        "tokenAuthMethod":                             "CLIENT_SECRET_BASIC",
        "tokenAuthSignAlg":                            "HS256",
        "defaultMaxAge":                               1000,
        "defaultAcrs":                                 [ "<default-acr0>", "<default-acr1>" ],
        "authTimeRequired":                            true,
        "loginUri":                                    "<login-uri>",
        "requestUris":                                 [ "<request-uri0>", "<request-uri1>" ],
        "description":                                 "<description>",
        "descriptions":                                [ { "tag": "<description0-tag>", "value": "<description0-value>" } ],
        "createdAt":                                   10000,
        "modifiedAt":                                  10000,
        "extension":                                   {
                                                         "requestableScopes":        [ "<requestable-scope0>", "<requestable-scope1>" ],
                                                         "requestableScopesEnabled": true,
                                                         "accessTokenDuration":      10000,
                                                         "refreshTokenDuration":     10000,
                                                         "tokenExchangePermitted":   false
                                                       },
        "tlsClientAuthSubjectDn":                      "<tls-client-auth-subject-dn>",
        "tlsClientAuthSanDns":                         "<tls-client-auth-san-dns>",
        "tlsClientAuthSanUri":                         "<tls-client-auth-san-uri>",
        "tlsClientAuthSanIp":                          "<tls-client-auth-san-ip>",
        "tlsClientAuthSanEmail":                       "<tls-client-auth-san-email>",
        "tlsClientCertificateBoundAccessTokens":       false,
        "selfSignedCertificateKeyId":                  "<self-signed-certificate-key-id>",
        "softwareId":                                  "<software-id>",
        "softwareVersion":                             "<software-version>",
        "authorizationSignAlg":                        "HS256",
        "authorizationEncryptionAlg":                  "PBES2_HS256_A128KW",
        "authorizationEncryptionEnc":                  "A128CBC_HS256",
        "bcDeliveryMode":                              "POLL",
        "bcNotificationEndpoint":                      "<bc-notification-endpoint>",
        "bcRequestSignAlg":                            "HS256",
        "bcUserCodeRequired":                          true,
        "dynamicallyRegistered":                       false,
        "registrationAccessTokenHash":                 "<registration-access-token-hash>",
        "authorizationDetailsTypes":                   [ "<authorization-details-type0>", "<authorization-details-type1>" ],
        "parRequired":                                 false,
        "requestObjectRequired":                       true,
        "attributes":                                  [ { "key": "<attribute0-key>", "value": "<attribute0-value>" } ],
        "customMetadata":                              "<custom-metadata>",
        "frontChannelRequestObjectEncryptionRequired": false,
        "requestObjectEncryptionAlgMatchRequired":     false,
        "requestObjectEncryptionEncMatchRequired":     false,
        "digestAlgorithm":                             "<digest-algorithm>",
        "singleAccessTokenPerSubject":                 false,
        "pkceRequired":                                false,
        "pkceS256Required":                            false,
        "automaticallyRegistered":                     false,
        "explicitlyRegistered":                        false,
        "dpopRequired":                                false
      }
      JSON
  end


  def generate_hash
    {
      number:                                      100,
      serviceNumber:                               1000,
      developer:                                   '<developer>',
      clientId:                                    12345,
      clientIdAlias:                               '<client-id-alias>',
      clientIdAliasEnabled:                        true,
      clientSecret:                                '<client-secret>',
      clientType:                                  'PUBLIC',
      redirectUris:                                [ '<redirect-uri0>', '<redirect-uri1>' ],
      responseTypes:                               [ 'NONE', 'CODE', 'TOKEN', 'ID_TOKEN' ],
      grantTypes:                                  [ 'AUTHORIZATION_CODE', 'REFRESH_TOKEN' ],
      applicationType:                             'WEB',
      contacts:                                    [ '<contact0>', '<contact1>' ],
      clientName:                                  '<client-name>',
      clientNames:                                 [ { tag: '<client-name0-tag>', value: '<client-name0-value>' } ],
      logoUri:                                     '<logo-uri>',
      logoUris:                                    [ { tag: '<logo-uri0-tag>', value: '<logo-uri0-value>' } ],
      clientUri:                                   '<client-uri>',
      clientUris:                                  [ { tag: '<client-uri0-tag>', value: '<client-uri0-value>' } ],
      policyUri:                                   '<policy-uri>',
      policyUris:                                  [ { tag: '<policy-uri0-tag>', value: '<policy-uri0-value>' } ],
      tosUri:                                      '<tos-uri>',
      tosUris:                                     [ { tag: '<tos-uri0-tag>', value: '<tos-uri0-value>' } ],
      jwksUri:                                     '<jwks-uri>',
      jwks:                                        '{"keys":[]}',
      derivedSectorIdentifier:                     '<derived-sector-identifier>',
      sectorIdentifierUri:                         '<sector-identifier-uri>',
      subjectType:                                 'PUBLIC',
      idTokenSignAlg:                              'HS256',
      idTokenEncryptionAlg:                        'PBES2_HS256_A128KW',
      idTokenEncryptionEnc:                        'A128CBC_HS256',
      userInfoSignAlg:                             'HS256',
      userInfoEncryptionAlg:                       'PBES2_HS256_A128KW',
      userInfoEncryptionEnc:                       'A128CBC_HS256',
      requestSignAlg:                              'HS256',
      requestEncryptionAlg:                        'PBES2_HS256_A128KW',
      requestEncryptionEnc:                        'A128CBC_HS256',
      tokenAuthMethod:                             'CLIENT_SECRET_BASIC',
      tokenAuthSignAlg:                            'HS256',
      defaultMaxAge:                               1000,
      defaultAcrs:                                 [ '<default-acr0>', '<default-acr1>' ],
      authTimeRequired:                            true,
      loginUri:                                    '<login-uri>',
      requestUris:                                 [ '<request-uri0>', '<request-uri1>' ],
      description:                                 '<description>',
      descriptions:                                [ { tag: '<description0-tag>', value: '<description0-value>' } ],
      createdAt:                                   10000,
      modifiedAt:                                  10000,
      extension:                                   {
                                                     requestableScopes:        [ '<requestable-scope0>', '<requestable-scope1>' ],
                                                     requestableScopesEnabled: true,
                                                     accessTokenDuration:      10000,
                                                     refreshTokenDuration:     10000,
                                                     tokenExchangePermitted:   false
                                                   },
      tlsClientAuthSubjectDn:                      '<tls-client-auth-subject-dn>',
      tlsClientAuthSanDns:                         '<tls-client-auth-san-dns>',
      tlsClientAuthSanUri:                         '<tls-client-auth-san-uri>',
      tlsClientAuthSanIp:                          '<tls-client-auth-san-ip>',
      tlsClientAuthSanEmail:                       '<tls-client-auth-san-email>',
      tlsClientCertificateBoundAccessTokens:       false,
      selfSignedCertificateKeyId:                  '<self-signed-certificate-key-id>',
      softwareId:                                  '<software-id>',
      softwareVersion:                             '<software-version>',
      authorizationSignAlg:                        'HS256',
      authorizationEncryptionAlg:                  'PBES2_HS256_A128KW',
      authorizationEncryptionEnc:                  'A128CBC_HS256',
      bcDeliveryMode:                              'POLL',
      bcNotificationEndpoint:                      '<bc-notification-endpoint>',
      bcRequestSignAlg:                            'HS256',
      bcUserCodeRequired:                          true,
      dynamicallyRegistered:                       false,
      registrationAccessTokenHash:                 '<registration-access-token-hash>',
      authorizationDetailsTypes:                   [ '<authorization-details-type0>', '<authorization-details-type1>' ],
      parRequired:                                 false,
      requestObjectRequired:                       true,
      attributes:                                  [ { key: '<attribute0-key>', value: '<attribute0-value>' } ],
      customMetadata:                              '<custom-metadata>',
      frontChannelRequestObjectEncryptionRequired: false,
      requestObjectEncryptionAlgMatchRequired:     false,
      requestObjectEncryptionEncMatchRequired:     false,
      digestAlgorithm:                             '<digest-algorithm>',
      singleAccessTokenPerSubject:                 false,
      pkceRequired:                                false,
      pkceS256Required:                            false,
      automaticallyRegistered:                     false,
      explicitlyRegistered:                        false,
      dpopRequired:                                false,
    }
  end

  def set_params(obj)
    obj.number                                      = NUMBER
    obj.service_number                              = SERVICE_NUMBER
    obj.developer                                   = DEVELOPER
    obj.client_id                                   = CLIENT_ID
    obj.client_id_alias                             = CLIENT_ID_ALIAS
    obj.client_id_alias_enabled                     = CLIENT_ID_ALIAS_ENABLED
    obj.client_secret                               = CLIENT_SECRET
    obj.client_type                                 = CLIENT_TYPE
    obj.redirect_uris                               = REDIRECT_URIS
    obj.response_types                              = RESPONSE_TYPES
    obj.grant_types                                 = GRANT_TYPES
    obj.application_type                            = APPLICATION_TYPE
    obj.contacts                                    = CONTACTS
    obj.client_name                                 = CLIENT_NAME
    obj.client_names                                = CLIENT_NAMES
    obj.logo_uri                                    = LOGO_URI
    obj.logo_uris                                   = LOGO_URIS
    obj.client_uri                                  = CLIENT_URI
    obj.client_uris                                 = CLIENT_URIS
    obj.policy_uri                                  = POLICY_URI
    obj.policy_uris                                 = POLICY_URIS
    obj.tos_uri                                     = TOS_URI
    obj.tos_uris                                    = TOS_URIS
    obj.jwks_uri                                    = JWKS_URI
    obj.jwks                                        = JWKS
    obj.derived_sector_identifier                   = DERIVED_SECTOR_IDENTIFIER
    obj.sector_identifier_uri                       = SECTOR_IDENTIFIER_URI
    obj.subject_type                                = SUBJECT_TYPE
    obj.id_token_sign_alg                           = ID_TOKEN_SIGN_ALG
    obj.id_token_encryption_alg                     = ID_TOKEN_ENCRYPTION_ALG
    obj.id_token_encryption_enc                     = ID_TOKEN_ENCRYPTION_ENC
    obj.user_info_sign_alg                          = USER_INFO_SIGN_ALG
    obj.user_info_encryption_alg                    = USER_INFO_ENCRYPTION_ALG
    obj.user_info_encryption_enc                    = USER_INFO_ENCRYPTION_ENC
    obj.request_sign_alg                            = REQUEST_SIGN_ALG
    obj.request_encryption_alg                      = REQUEST_ENCRYPTION_ALG
    obj.request_encryption_enc                      = REQUEST_ENCRYPTION_ENC
    obj.token_auth_method                           = TOKEN_AUTH_METHOD
    obj.token_auth_sign_alg                         = TOKEN_AUTH_SIGN_ALG
    obj.default_max_age                             = DEFAULT_MAX_AGE
    obj.default_acrs                                = DEFAULT_ACRS
    obj.auth_time_required                          = AUTH_TIME_REQUIRED
    obj.login_uri                                   = LOGIN_URI
    obj.request_uris                                = REQUEST_URIS
    obj.description                                 = DESCRIPTION
    obj.descriptions                                = DESCRIPTIONS
    obj.created_at                                  = CREATED_AT
    obj.modified_at                                 = MODIFIED_AT
    obj.extension                                   = EXTENSION
    obj.tls_client_auth_subject_dn                  = TLS_CLIENT_AUTH_SUBJECT_DN
    obj.tls_client_auth_san_dns                     = TLS_CLIENT_AUTH_SAN_DNS
    obj.tls_client_auth_san_uri                     = TLS_CLIENT_AUTH_SAN_URI
    obj.tls_client_auth_san_ip                      = TLS_CLIENT_AUTH_SAN_IP
    obj.tls_client_auth_san_email                   = TLS_CLIENT_AUTH_SAN_EMAIL
    obj.tls_client_certificate_bound_access_tokens  = TLS_CLIENT_CERTIFICATE_BOUND_ACCESS_TOKENS
    obj.self_signed_certificate_key_id              = SELF_SIGNED_CERTIFICATE_KEY_ID
    obj.software_id                                 = SOFTWARE_ID
    obj.software_version                            = SOFTWARE_VERSION
    obj.authorization_sign_alg                      = AUTHORIZATION_SIGN_ALG
    obj.authorization_encryption_alg                = AUTHORIZATION_ENCRYPTION_ALG
    obj.authorization_encryption_enc                = AUTHORIZATION_ENCRYPTION_ENC
    obj.bc_delivery_mode                            = BC_DELIVERY_MODE
    obj.bc_notification_endpoint                    = BC_NOTIFICATION_ENDPOINT
    obj.bc_request_sign_alg                         = BC_REQUEST_SIGN_ALG
    obj.bc_user_code_required                       = BC_USER_CODE_REQUIRED
    obj.dynamically_registered                      = DYNAMICALLY_REGISTERED
    obj.registration_access_token_hash              = REGISTRATION_ACCESS_TOKEN_HASH
    obj.authorization_details_types                 = AUTHORIZATION_DETAILS_TYPES
    obj.par_required                                = PAR_REQUIRED
    obj.request_object_required                     = REQUEST_OBJECT_REQUIRED
    obj.attributes                                  = ATTRIBUTES
    obj.custom_metadata                             = CUSTOM_METADATA
    obj.frontChannelRequestObjectEncryptionRequired = FRONT_CHANNEL_REQUEST_OBJECT_ENCRYPTION_REQUIRED
    obj.requestObjectEncryptionAlgMatchRequired     = REQUEST_OBJECT_ENCRYPTION_ALG_MATCH_REQUIRED
    obj.requestObjectEncryptionEncMatchRequired     = REQUEST_OBJECT_ENCRYPTION_ENC_MATCH_REQUIRED
    obj.digestAlgorithm                             = DIGEST_ALGORITHM
    obj.singleAccessTokenPerSubject                 = SINGLE_ACCESS_TOKEN_PER_SUBJECT
    obj.pkceRequired                                = PKCE_REQUIRED
    obj.pkceS256Required                            = PKCE_S256_REQUIRED
    obj.automaticallyRegistered                     = AUTOMATICALLY_REGISTERED
    obj.explicitlyRegistered                        = EXPLICITLY_REGISTERED
    obj.dpopRequired                                = DPOP_REQUIRED
  end


  def match(obj)
    assert_equal NUMBER,                                           obj.number
    assert_equal SERVICE_NUMBER,                                   obj.serviceNumber
    assert_equal DEVELOPER,                                        obj.developer
    assert_equal CLIENT_ID,                                        obj.clientId
    assert_equal CLIENT_ID_ALIAS,                                  obj.clientIdAlias
    assert_equal CLIENT_ID_ALIAS_ENABLED,                          obj.clientIdAliasEnabled
    assert_equal CLIENT_SECRET,                                    obj.clientSecret
    assert_equal CLIENT_TYPE,                                      obj.clientType
    assert_equal REDIRECT_URIS,                                    obj.redirectUris
    assert_equal RESPONSE_TYPES,                                   obj.responseTypes
    assert_equal GRANT_TYPES,                                      obj.grantTypes
    assert_equal APPLICATION_TYPE,                                 obj.applicationType
    assert_equal CONTACTS,                                         obj.contacts
    assert_equal CLIENT_NAME,                                      obj.clientName
    assert_equal CLIENT_NAME_TAG,                                  obj.clientNames[0].tag
    assert_equal CLIENT_NAME_VALUE,                                obj.clientNames[0].value
    assert_equal LOGO_URI,                                         obj.logoUri
    assert_equal LOGO_URI_TAG,                                     obj.logoUris[0].tag
    assert_equal LOGO_URI_VALUE,                                   obj.logoUris[0].value
    assert_equal CLIENT_URI,                                       obj.clientUri
    assert_equal CLIENT_URI_TAG,                                   obj.clientUris[0].tag
    assert_equal CLIENT_URI_VALUE,                                 obj.clientUris[0].value
    assert_equal POLICY_URI,                                       obj.policyUri
    assert_equal POLICY_URI_TAG,                                   obj.policyUris[0].tag
    assert_equal POLICY_URI_VALUE,                                 obj.policyUris[0].value
    assert_equal TOS_URI,                                          obj.tosUri
    assert_equal TOS_URI_TAG,                                      obj.tosUris[0].tag
    assert_equal TOS_URI_VALUE,                                    obj.tosUris[0].value
    assert_equal JWKS_URI,                                         obj.jwksUri
    assert_equal JWKS,                                             obj.jwks
    assert_equal DERIVED_SECTOR_IDENTIFIER,                        obj.derivedSectorIdentifier
    assert_equal SECTOR_IDENTIFIER_URI,                            obj.sectorIdentifierUri
    assert_equal SUBJECT_TYPE,                                     obj.subjectType
    assert_equal ID_TOKEN_SIGN_ALG,                                obj.idTokenSignAlg
    assert_equal ID_TOKEN_ENCRYPTION_ALG,                          obj.idTokenEncryptionAlg
    assert_equal ID_TOKEN_ENCRYPTION_ENC,                          obj.idTokenEncryptionEnc
    assert_equal USER_INFO_SIGN_ALG,                               obj.userInfoSignAlg
    assert_equal USER_INFO_ENCRYPTION_ALG,                         obj.userInfoEncryptionAlg
    assert_equal USER_INFO_ENCRYPTION_ENC,                         obj.userInfoEncryptionEnc
    assert_equal REQUEST_SIGN_ALG,                                 obj.requestSignAlg
    assert_equal REQUEST_ENCRYPTION_ALG,                           obj.requestEncryptionAlg
    assert_equal REQUEST_ENCRYPTION_ENC,                           obj.requestEncryptionEnc
    assert_equal TOKEN_AUTH_METHOD,                                obj.tokenAuthMethod
    assert_equal TOKEN_AUTH_SIGN_ALG,                              obj.tokenAuthSignAlg
    assert_equal DEFAULT_MAX_AGE,                                  obj.defaultMaxAge
    assert_equal DEFAULT_ACRS,                                     obj.defaultAcrs
    assert_equal AUTH_TIME_REQUIRED,                               obj.authTimeRequired
    assert_equal LOGIN_URI,                                        obj.loginUri
    assert_equal REQUEST_URIS,                                     obj.requestUris
    assert_equal DESCRIPTION,                                      obj.description
    assert_equal DESCRIPTION_TAG,                                  obj.descriptions[0].tag
    assert_equal DESCRIPTION_VALUE,                                obj.descriptions[0].value
    assert_equal CREATED_AT,                                       obj.createdAt
    assert_equal MODIFIED_AT,                                      obj.modifiedAt
    assert_equal REQUESTABLE_SCOPES,                               obj.extension.requestableScopes
    assert_equal REQUESTABLE_SCOPES_ENABLED,                       obj.extension.requestableScopesEnabled
    assert_equal ACCESS_TOKEN_DURATION,                            obj.extension.accessTokenDuration
    assert_equal REFRESH_TOKEN_DURATION,                           obj.extension.refreshTokenDuration
    assert_equal TOKEN_EXCHANGE_PERMITTED,                         obj.extension.tokenExchangePermitted
    assert_equal TLS_CLIENT_AUTH_SUBJECT_DN,                       obj.tlsClientAuthSubjectDn
    assert_equal TLS_CLIENT_AUTH_SAN_DNS,                          obj.tlsClientAuthSanDns
    assert_equal TLS_CLIENT_AUTH_SAN_URI,                          obj.tlsClientAuthSanUri
    assert_equal TLS_CLIENT_AUTH_SAN_IP,                           obj.tlsClientAuthSanIp
    assert_equal TLS_CLIENT_AUTH_SAN_EMAIL,                        obj.tlsClientAuthSanEmail
    assert_equal TLS_CLIENT_CERTIFICATE_BOUND_ACCESS_TOKENS,       obj.tlsClientCertificateBoundAccessTokens
    assert_equal SELF_SIGNED_CERTIFICATE_KEY_ID,                   obj.selfSignedCertificateKeyId
    assert_equal AUTHORIZATION_SIGN_ALG,                           obj.authorizationSignAlg
    assert_equal AUTHORIZATION_ENCRYPTION_ALG,                     obj.authorizationEncryptionAlg
    assert_equal AUTHORIZATION_ENCRYPTION_ENC,                     obj.authorizationEncryptionEnc
    assert_equal BC_DELIVERY_MODE,                                 obj.bcDeliveryMode
    assert_equal BC_NOTIFICATION_ENDPOINT,                         obj.bcNotificationEndpoint
    assert_equal BC_REQUEST_SIGN_ALG,                              obj.bcRequestSignAlg
    assert_equal BC_USER_CODE_REQUIRED,                            obj.bcUserCodeRequired
    assert_equal DYNAMICALLY_REGISTERED,                           obj.dynamicallyRegistered
    assert_equal REGISTRATION_ACCESS_TOKEN_HASH,                   obj.registrationAccessTokenHash
    assert_equal AUTHORIZATION_DETAILS_TYPES,                      obj.authorizationDetailsTypes
    assert_equal PAR_REQUIRED,                                     obj.parRequired
    assert_equal REQUEST_OBJECT_REQUIRED,                          obj.requestObjectRequired
    assert_equal ATTRIBUTE_KEY,                                    obj.attributes[0].key
    assert_equal ATTRIBUTE_VALUE,                                  obj.attributes[0].value
    assert_equal CUSTOM_METADATA,                                  obj.customMetadata
    assert_equal FRONT_CHANNEL_REQUEST_OBJECT_ENCRYPTION_REQUIRED, obj.frontChannelRequestObjectEncryptionRequired
    assert_equal REQUEST_OBJECT_ENCRYPTION_ALG_MATCH_REQUIRED,     obj.requestObjectEncryptionAlgMatchRequired
    assert_equal REQUEST_OBJECT_ENCRYPTION_ENC_MATCH_REQUIRED,     obj.requestObjectEncryptionEncMatchRequired
    assert_equal DIGEST_ALGORITHM,                                 obj.digestAlgorithm
    assert_equal SINGLE_ACCESS_TOKEN_PER_SUBJECT,                  obj.singleAccessTokenPerSubject
    assert_equal PKCE_REQUIRED,                                    obj.pkceRequired
    assert_equal PKCE_S256_REQUIRED,                               obj.pkceS256Required
    assert_equal AUTOMATICALLY_REGISTERED,                         obj.automaticallyRegistered
    assert_equal EXPLICITLY_REGISTERED,                            obj.explicitlyRegistered
    assert_equal DPOP_REQUIRED,                                    obj.dpopRequired
  end


  def test_from_json
    jsn    = generate_json
    hsh    = JSON.parse(jsn)
    actual = Authlete::Model::Client.new(hsh)

    match(actual)
  end


  def test_setters
    actual = Authlete::Model::Client.new
    set_params(actual)

    match(actual)
  end


  def test_to_hash
    obj = Authlete::Model::Client.new
    set_params(obj)
    actual   = obj.to_hash
    expected = generate_hash

    assert_equal expected, actual
  end


  def test_standard_metadata_full
    client = Authlete::Model::Client.new
    set_params(client)

    expected_response_types = ['none', 'code', 'token', 'id_token']
    expected_grant_types    = ['authorization_code', 'refresh_token']
    expected_jwks           = { "keys" => [] }

    metadata = client.standard_metadata(false, false, false)

    assert_equal "#{CLIENT_ID}",                             metadata[:client_id]
    assert_equal REDIRECT_URIS,                              metadata[:redirect_uris]
    assert_equal expected_response_types,                    metadata[:response_types]
    assert_equal expected_grant_types,                       metadata[:grant_types]
    assert_equal 'web',                                      metadata[:application_type]
    assert_equal CONTACTS,                                   metadata[:contacts]
    assert_equal CLIENT_NAME,                                metadata[:client_name]
    assert_equal LOGO_URI,                                   metadata[:logo_uri]
    assert_equal CLIENT_URI,                                 metadata[:client_uri]
    assert_equal POLICY_URI,                                 metadata[:policy_uri]
    assert_equal TOS_URI,                                    metadata[:tos_uri]
    assert_equal JWKS_URI,                                   metadata[:jwks_uri]
    assert_equal expected_jwks,                              metadata[:jwks]
    assert_equal SECTOR_IDENTIFIER_URI,                      metadata[:sector_identifier_uri]
    assert_equal 'public',                                   metadata[:subject_type]
    assert_equal 'HS256',                                    metadata[:id_token_signed_response_alg]
    assert_equal 'PBES2-HS256+A128KW',                       metadata[:id_token_encrypted_response_alg]
    assert_equal 'A128CBC-HS256',                            metadata[:id_token_encrypted_response_enc]
    assert_equal 'HS256',                                    metadata[:userinfo_signed_response_alg]
    assert_equal 'PBES2-HS256+A128KW',                       metadata[:userinfo_encrypted_response_alg]
    assert_equal 'A128CBC-HS256',                            metadata[:userinfo_encrypted_response_enc]
    assert_equal 'HS256',                                    metadata[:request_object_signing_alg]
    assert_equal 'PBES2-HS256+A128KW',                       metadata[:request_object_encryption_alg]
    assert_equal 'A128CBC-HS256',                            metadata[:request_object_encryption_enc]
    assert_equal 'client_secret_basic',                      metadata[:token_endpoint_auth_method]
    assert_equal 'HS256',                                    metadata[:token_endpoint_auth_signing_alg]
    assert_equal DEFAULT_MAX_AGE,                            metadata[:default_max_age]
    assert_equal DEFAULT_ACRS,                               metadata[:default_acr_values]
    assert_equal AUTH_TIME_REQUIRED,                         metadata[:require_auth_time]
    assert_equal LOGIN_URI,                                  metadata[:initiate_login_uri]
    assert_equal REQUEST_URIS,                               metadata[:request_uris]
    assert_equal TLS_CLIENT_AUTH_SUBJECT_DN,                 metadata[:tls_client_auth_subject_dn]
    assert_equal TLS_CLIENT_AUTH_SAN_DNS,                    metadata[:tls_client_auth_san_dns]
    assert_equal TLS_CLIENT_AUTH_SAN_URI,                    metadata[:tls_client_auth_san_uri]
    assert_equal TLS_CLIENT_AUTH_SAN_IP,                     metadata[:tls_client_auth_san_ip]
    assert_equal TLS_CLIENT_AUTH_SAN_EMAIL,                  metadata[:tls_client_auth_san_email]
    assert_equal TLS_CLIENT_CERTIFICATE_BOUND_ACCESS_TOKENS, metadata[:tls_client_certificate_bound_access_tokens]
    assert_equal SOFTWARE_ID,                                metadata[:software_id]
    assert_equal SOFTWARE_VERSION,                           metadata[:software_version]
    assert_equal 'HS256',                                    metadata[:authorization_signed_response_alg]
    assert_equal 'PBES2-HS256+A128KW',                       metadata[:authorization_encrypted_response_alg]
    assert_equal 'A128CBC-HS256',                            metadata[:authorization_encrypted_response_enc]
    assert_equal 'poll',                                     metadata[:backchannel_token_delivery_mode]
    assert_equal BC_NOTIFICATION_ENDPOINT,                   metadata[:backchannel_client_notification_endpoint]
    assert_equal 'HS256',                                    metadata[:backchannel_authentication_request_signing_alg]
    assert_equal BC_USER_CODE_REQUIRED,                      metadata[:backchannel_user_code_parameter]
    assert_equal AUTHORIZATION_DETAILS_TYPES,                metadata[:authorization_details_types]
    assert_equal DIGEST_ALGORITHM,                           metadata[:digest_algorithm]
  end


  def test_standard_metadata_minimum
    client = Authlete::Model::Client.new
    set_params(client)

    client.default_max_age    = 0
    client.auth_time_required = false
    client.login_uri          = nil

    metadata = client.standard_metadata

    assert_nil metadata[:default_max_age]
    assert_nil metadata[:require_auth_time]
    assert_nil metadata[:initiate_login_uri]
  end
end
