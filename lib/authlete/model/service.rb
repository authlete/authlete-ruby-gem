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


module Authlete
  module Model
    class Service < Authlete::Model::Base
      include Authlete::Model::Hashable
      include Authlete::Utility

      attr_accessor :number

      attr_accessor :serviceOwnerNumber
      alias_method  :service_owner_number,  :serviceOwnerNumber
      alias_method  :service_owner_number=, :serviceOwnerNumber=

      attr_accessor :serviceName
      alias_method  :service_name,  :serviceName
      alias_method  :service_name=, :serviceName=

      attr_accessor :apiKey
      alias_method  :api_key,  :apiKey
      alias_method  :api_key=, :apiKey=

      attr_accessor :apiSecret
      alias_method  :api_secret,  :apiSecret
      alias_method  :api_secret=, :apiSecret=

      attr_accessor :issuer

      attr_accessor :authorizationEndpoint
      alias_method  :authorization_endpoint,  :authorizationEndpoint
      alias_method  :authorization_endpoint=, :authorizationEndpoint=

      attr_accessor :tokenEndpoint
      alias_method  :token_endpoint,  :tokenEndpoint
      alias_method  :token_endpoint=, :tokenEndpoint=

      attr_accessor :revocationEndpoint
      alias_method  :revocation_endpoint,  :revocationEndpoint
      alias_method  :revocation_endpoint=, :revocationEndpoint=

      attr_accessor :supportedRevocationAuthMethods
      alias_method  :supported_revocation_auth_methods,  :supportedRevocationAuthMethods
      alias_method  :supported_revocation_auth_methods=, :supportedRevocationAuthMethods=

      attr_accessor :userInfoEndpoint
      alias_method  :user_info_endpoint,  :userInfoEndpoint
      alias_method  :user_info_endpoint=, :userInfoEndpoint=

      attr_accessor :jwksUri
      alias_method  :jwks_uri,  :jwksUri
      alias_method  :jwks_uri=, :jwksUri=

      attr_accessor :jwks

      attr_accessor :registrationEndpoint
      alias_method  :registration_endpoint,  :registrationEndpoint
      alias_method  :registration_endpoint=, :registrationEndpoint=

      attr_accessor :registrationManagementEndpoint
      alias_method  :registration_management_endpoint,  :registrationManagementEndpoint
      alias_method  :registration_management_endpoint=, :registrationManagementEndpoint=

      attr_accessor :supportedScopes
      alias_method  :supported_scopes,  :supportedScopes
      alias_method  :supported_scopes=, :supportedScopes=

      attr_accessor :supportedResponseTypes
      alias_method  :supported_response_types,  :supportedResponseTypes
      alias_method  :supported_response_types=, :supportedResponseTypes=

      attr_accessor :supportedGrantTypes
      alias_method  :supported_grant_types,  :supportedGrantTypes
      alias_method  :supported_grant_types=, :supportedGrantTypes=

      attr_accessor :supportedAcrs
      alias_method  :supported_acrs,  :supportedAcrs
      alias_method  :supported_acrs=, :supportedAcrs=

      attr_accessor :supportedTokenAuthMethods
      alias_method  :supported_token_auth_methods,  :supportedTokenAuthMethods
      alias_method  :supported_token_auth_methods=, :supportedTokenAuthMethods=

      attr_accessor :supportedDisplays
      alias_method  :supported_displays,  :supportedDisplays
      alias_method  :supported_displays=, :supportedDisplays=

      attr_accessor :supportedClaimTypes
      alias_method  :supported_claim_types,  :supportedClaimTypes
      alias_method  :supported_claim_types=, :supportedClaimTypes=

      attr_accessor :supportedClaims
      alias_method  :supported_claims,  :supportedClaims
      alias_method  :supported_claims=, :supportedClaims=

      attr_accessor :serviceDocumentation
      alias_method  :service_documentation,  :serviceDocumentation
      alias_method  :service_documentation=, :serviceDocumentation=

      attr_accessor :supportedClaimLocales
      alias_method  :supported_claim_locales,  :supportedClaimLocales
      alias_method  :supported_claim_locales=, :supportedClaimLocales=

      attr_accessor :supportedUiLocales
      alias_method  :supported_ui_locales,  :supportedUiLocales
      alias_method  :supported_ui_locales=, :supportedUiLocales=

      attr_accessor :policyUri
      alias_method  :policy_uri,  :policyUri
      alias_method  :policy_uri=, :policyUri=

      attr_accessor :tosUri
      alias_method  :tos_uri,  :tosUri
      alias_method  :tos_uri=, :tosUri=

      attr_accessor :authenticationCallbackEndpoint
      alias_method  :authentication_callback_endpoint,  :authenticationCallbackEndpoint
      alias_method  :authentication_callback_endpoint=, :authenticationCallbackEndpoint=

      attr_accessor :authenticationCallbackApiKey
      alias_method  :authentication_callback_api_key,  :authenticationCallbackApiKey
      alias_method  :authentication_callback_api_key=, :authenticationCallbackApiKey=

      attr_accessor :authenticationCallbackApiSecret
      alias_method  :authentication_callback_api_secret,  :authenticationCallbackApiSecret
      alias_method  :authentication_callback_api_secret=, :authenticationCallbackApiSecret=

      attr_accessor :supportedSnses
      alias_method  :supported_snses,  :supportedSnses
      alias_method  :supported_snses=, :supportedSnses=

      attr_accessor :snsCredentials
      alias_method  :sns_credentials,  :snsCredentials
      alias_method  :sns_credentials=, :snsCredentials=

      attr_accessor :createdAt
      alias_method  :created_at,  :createdAt
      alias_method  :created_at=, :createdAt=

      attr_accessor :modifiedAt
      alias_method  :modified_at,  :modifiedAt
      alias_method  :modified_at=, :modifiedAt=

      attr_accessor :developerAuthenticationCallbackEndpoint
      alias_method  :developer_authentication_callback_endpoint,  :developerAuthenticationCallbackEndpoint
      alias_method  :developer_authentication_callback_endpoint=, :developerAuthenticationCallbackEndpoint=

      attr_accessor :developerAuthenticationCallbackApiKey
      alias_method  :developer_authentication_callback_api_key,  :developerAuthenticationCallbackApiKey
      alias_method  :developer_authentication_callback_api_key=, :developerAuthenticationCallbackApiKey=

      attr_accessor :developerAuthenticationCallbackApiSecret
      alias_method  :developer_authentication_callback_api_secret,  :developerAuthenticationCallbackApiSecret
      alias_method  :developer_authentication_callback_api_secret=, :developerAuthenticationCallbackApiSecret=

      attr_accessor :supportedDeveloperSnses
      alias_method  :supported_developer_snses,  :supportedDeveloperSnses
      alias_method  :supported_developer_snses=, :supportedDeveloperSnses=

      attr_accessor :developerSnsCredentials
      alias_method  :developer_sns_credentials,  :developerSnsCredentials
      alias_method  :developer_sns_credentials=, :developerSnsCredentials=

      attr_accessor :clientsPerDeveloper
      alias_method  :clients_per_developer,  :clientsPerDeveloper
      alias_method  :clients_per_developer=, :clientsPerDeveloper=

      attr_accessor :directAuthorizationEndpointEnabled
      alias_method  :direct_authorization_endpoint_enabled,  :directAuthorizationEndpointEnabled
      alias_method  :direct_authorization_endpoint_enabled=, :directAuthorizationEndpointEnabled=

      attr_accessor :directTokenEndpointEnabled
      alias_method  :direct_token_endpoint_enabled,  :directTokenEndpointEnabled
      alias_method  :direct_token_endpoint_enabled=, :directTokenEndpointEnabled=

      attr_accessor :directRevocationEndpointEnabled
      alias_method  :direct_revocation_endpoint_enabled,  :directRevocationEndpointEnabled
      alias_method  :direct_revocation_endpoint_enabled=, :directRevocationEndpointEnabled=

      attr_accessor :directUserInfoEndpointEnabled
      alias_method  :direct_user_info_endpoint_enabled,  :directUserInfoEndpointEnabled
      alias_method  :direct_user_info_endpoint_enabled=, :directUserInfoEndpointEnabled=

      attr_accessor :directJwksEndpointEnabled
      alias_method  :direct_jwks_endpoint_enabled,  :directJwksEndpointEnabled
      alias_method  :direct_jwks_endpoint_enabled=, :directJwksEndpointEnabled=

      attr_accessor :directIntrospectionEndpointEnabled
      alias_method  :direct_introspection_endpoint_enabled,  :directIntrospectionEndpointEnabled
      alias_method  :direct_introspection_endpoint_enabled=, :directIntrospectionEndpointEnabled=

      attr_accessor :singleAccessTokenPerSubject
      alias_method  :single_access_token_per_subject,  :singleAccessTokenPerSubject
      alias_method  :single_access_token_per_subject=, :singleAccessTokenPerSubject=

      attr_accessor :pkceRequired
      alias_method  :pkce_required,  :pkceRequired
      alias_method  :pkce_required=, :pkceRequired=

      attr_accessor :pkceS256Required
      alias_method  :pkce_s256_required,  :pkceS256Required
      alias_method  :pkce_s256_required=, :pkceS256Required=

      attr_accessor :refreshTokenKept
      alias_method  :refresh_token_kept,  :refreshTokenKept
      alias_method  :refresh_token_kept=, :refreshTokenKept=

      attr_accessor :refreshTokenDurationKept
      alias_method  :refresh_token_duration_kept,  :refreshTokenDurationKept
      alias_method  :refresh_token_duration_kept=, :refreshTokenDurationKept=

      attr_accessor :errorDescriptionOmitted
      alias_method  :error_description_omitted,  :errorDescriptionOmitted
      alias_method  :error_description_omitted=, :errorDescriptionOmitted=

      attr_accessor :errorUriOmitted
      alias_method  :error_uri_omitted,  :errorUriOmitted
      alias_method  :error_uri_omitted=, :errorUriOmitted=

      attr_accessor :clientIdAliasEnabled
      alias_method  :client_id_alias_enabled,  :clientIdAliasEnabled
      alias_method  :client_id_alias_enabled=, :clientIdAliasEnabled=

      attr_accessor :supportedServiceProfiles
      alias_method  :supported_service_profiles,  :supportedServiceProfiles
      alias_method  :supported_service_profiles=, :supportedServiceProfiles=

      attr_accessor :tlsClientCertificateBoundAccessTokens
      alias_method  :tls_client_certificate_bound_access_tokens,  :tlsClientCertificateBoundAccessTokens
      alias_method  :tls_client_certificate_bound_access_tokens=, :tlsClientCertificateBoundAccessTokens=

      attr_accessor :introspectionEndpoint
      alias_method  :introspection_endpoint,  :introspectionEndpoint
      alias_method  :introspection_endpoint=, :introspectionEndpoint=

      attr_accessor :supportedIntrospectionAuthMethods
      alias_method  :supported_introspection_auth_methods,  :supportedIntrospectionAuthMethods
      alias_method  :supported_introspection_auth_methods=, :supportedIntrospectionAuthMethods=

      attr_accessor :mutualTlsValidatePkiCertChain
      alias_method  :mutual_tls_validate_pki_cert_chain,  :mutualTlsValidatePkiCertChain
      alias_method  :mutual_tls_validate_pki_cert_chain=, :mutualTlsValidatePkiCertChain=

      attr_accessor :trustedRootCertificates
      alias_method  :trusted_root_certificates,  :trustedRootCertificates
      alias_method  :trusted_root_certificates=, :trustedRootCertificates=

      attr_accessor :dynamicRegistrationSupported
      alias_method  :dynamic_registration_supported,  :dynamicRegistrationSupported
      alias_method  :dynamic_registration_supported=, :dynamicRegistrationSupported=

      attr_accessor :endSessionEndpoint
      alias_method  :end_session_endpoint,  :endSessionEndpoint
      alias_method  :end_session_endpoint=, :endSessionEndpoint=

      attr_accessor :description

      attr_accessor :accessTokenType
      alias_method  :access_token_type,  :accessTokenType
      alias_method  :access_token_type=, :accessTokenType=

      attr_accessor :accessTokenSignAlg
      alias_method  :access_token_sign_alg,  :accessTokenSignAlg
      alias_method  :access_token_sign_alg=, :accessTokenSignAlg=

      attr_accessor :accessTokenDuration
      alias_method  :access_token_duration,  :accessTokenDuration
      alias_method  :access_token_duration=, :accessTokenDuration=

      attr_accessor :refreshTokenDuration
      alias_method  :refresh_token_duration,  :refreshTokenDuration
      alias_method  :refresh_token_duration=, :refreshTokenDuration=

      attr_accessor :idTokenDuration
      alias_method  :id_token_duration,  :idTokenDuration
      alias_method  :id_token_duration=, :idTokenDuration=

      attr_accessor :authorizationResponseDuration
      alias_method  :authorization_response_duration,  :authorizationResponseDuration
      alias_method  :authorization_response_duration=, :authorizationResponseDuration=

      attr_accessor :pushedAuthReqDuration
      alias_method  :pushed_auth_req_duration,  :pushedAuthReqDuration
      alias_method  :pushed_auth_req_duration=, :pushedAuthReqDuration=

      attr_accessor :metadata

      attr_accessor :accessTokenSignatureKeyId
      alias_method  :access_token_signature_key_id,  :accessTokenSignatureKeyId
      alias_method  :access_token_signature_key_id=, :accessTokenSignatureKeyId=

      attr_accessor :authorizationSignatureKeyId
      alias_method  :authorization_signature_key_id,  :authorizationSignatureKeyId
      alias_method  :authorization_signature_key_id=, :authorizationSignatureKeyId=

      attr_accessor :idTokenSignatureKeyId
      alias_method  :id_token_signature_key_id,  :idTokenSignatureKeyId
      alias_method  :id_token_signature_key_id=, :idTokenSignatureKeyId=

      attr_accessor :userInfoSignatureKeyId
      alias_method  :user_info_signature_key_id,  :userInfoSignatureKeyId
      alias_method  :user_info_signature_key_id=, :userInfoSignatureKeyId=

      attr_accessor :supportedBackchannelTokenDeliveryModes
      alias_method  :supported_backchannel_token_delivery_modes,  :supportedBackchannelTokenDeliveryModes
      alias_method  :supported_backchannel_token_delivery_modes=, :supportedBackchannelTokenDeliveryModes=

      attr_accessor :backchannelAuthenticationEndpoint
      alias_method  :backchannel_authentication_endpoint,  :backchannelAuthenticationEndpoint
      alias_method  :backchannel_authentication_endpoint=, :backchannelAuthenticationEndpoint=

      attr_accessor :backchannelUserCodeParameterSupported
      alias_method  :backchannel_user_code_parameter_supported,  :backchannelUserCodeParameterSupported
      alias_method  :backchannel_user_code_parameter_supported=, :backchannelUserCodeParameterSupported=

      attr_accessor :backchannelAuthReqIdDuration
      alias_method  :backchannel_auth_req_id_duration,  :backchannelAuthReqIdDuration
      alias_method  :backchannel_auth_req_id_duration=, :backchannelAuthReqIdDuration=

      attr_accessor :backchannelPollingInterval
      alias_method  :backchannel_polling_interval,  :backchannelPollingInterval
      alias_method  :backchannel_polling_interval=, :backchannelPollingInterval=

      attr_accessor :backchannelBindingMessageRequiredInFapi
      alias_method  :backchannel_binding_message_required_in_fapi,  :backchannelBindingMessageRequiredInFapi
      alias_method  :backchannel_binding_message_required_in_fapi=, :backchannelBindingMessageRequiredInFapi=

      attr_accessor :allowableClockSkew
      alias_method  :allowable_clock_skew,  :allowableClockSkew
      alias_method  :allowable_clock_skew=, :allowableClockSkew=

      attr_accessor :deviceAuthorizationEndpoint
      alias_method  :device_authorization_endpoint,  :deviceAuthorizationEndpoint
      alias_method  :device_authorization_endpoint=, :deviceAuthorizationEndpoint=

      attr_accessor :deviceVerificationUri
      alias_method  :device_verification_uri,  :deviceVerificationUri
      alias_method  :device_verification_uri=, :deviceVerificationUri=

      attr_accessor :deviceVerificationUriComplete
      alias_method  :device_verification_uri_complete,  :deviceVerificationUriComplete
      alias_method  :device_verification_uri_complete=, :deviceVerificationUriComplete=

      attr_accessor :deviceFlowCodeDuration
      alias_method  :device_flow_code_duration,  :deviceFlowCodeDuration
      alias_method  :device_flow_code_duration=, :deviceFlowCodeDuration=

      attr_accessor :deviceFlowPollingInterval
      alias_method  :device_flow_polling_interval,  :deviceFlowPollingInterval
      alias_method  :device_flow_polling_interval=, :deviceFlowPollingInterval=

      attr_accessor :userCodeCharset
      alias_method  :user_code_charset,  :userCodeCharset
      alias_method  :user_code_charset=, :userCodeCharset=

      attr_accessor :userCodeLength
      alias_method  :user_code_length,  :userCodeLength
      alias_method  :user_code_length=, :userCodeLength=

      attr_accessor :pushedAuthReqEndpoint
      alias_method  :pushed_auth_req_endpoint,  :pushedAuthReqEndpoint
      alias_method  :pushed_auth_req_endpoint=, :pushedAuthReqEndpoint=

      attr_accessor :mtlsEndpointAliases
      alias_method  :mtls_endpoint_aliases,  :mtlsEndpointAliases
      alias_method  :mtls_endpoint_aliases=, :mtlsEndpointAliases=

      attr_accessor :supportedAuthorizationDetailsTypes
      alias_method  :supported_authorization_details_types,  :supportedAuthorizationDetailsTypes
      alias_method  :supported_authorization_details_types=, :supportedAuthorizationDetailsTypes=

      attr_accessor :supportedTrustFrameworks
      alias_method  :supported_trust_frameworks,  :supportedTrustFrameworks
      alias_method  :supported_trust_frameworks=, :supportedTrustFrameworks=

      attr_accessor :supportedEvidence
      alias_method  :supported_evidence,  :supportedEvidence
      alias_method  :supported_evidence=, :supportedEvidence=

      attr_accessor :supportedIdentityDocuments
      alias_method  :supported_identity_documents,  :supportedIdentityDocuments
      alias_method  :supported_identity_documents=, :supportedIdentityDocuments=

      attr_accessor :supportedVerificationMethods
      alias_method  :supported_verification_methods,  :supportedVerificationMethods
      alias_method  :supported_verification_methods=, :supportedVerificationMethods=

      attr_accessor :supportedVerifiedClaims
      alias_method  :supported_verified_claims,  :supportedVerifiedClaims
      alias_method  :supported_verified_claims=, :supportedVerifiedClaims=

      attr_accessor :missingClientIdAllowed
      alias_method  :missing_client_id_allowed,  :missingClientIdAllowed
      alias_method  :missing_client_id_allowed=, :missingClientIdAllowed=

      attr_accessor :parRequired
      alias_method  :par_required,  :parRequired
      alias_method  :par_required=, :parRequired=

      attr_accessor :requestObjectRequired
      alias_method  :request_object_required,  :requestObjectRequired
      alias_method  :request_object_required=, :requestObjectRequired=

      attr_accessor :traditionalRequestObjectProcessingApplied
      alias_method  :traditional_request_object_processing_applied,  :traditionalRequestObjectProcessingApplied
      alias_method  :traditional_request_object_processing_applied=, :traditionalRequestObjectProcessingApplied=

      attr_accessor :claimShortcutRestrictive
      alias_method  :claim_shortcut_restrictive,  :claimShortcutRestrictive
      alias_method  :claim_shortcut_restrictive=, :claimShortcutRestrictive=

      attr_accessor :scopeRequired
      alias_method  :scope_required,  :scopeRequired
      alias_method  :scope_required=, :scopeRequired=

      attr_accessor :nbfOptional
      alias_method  :nbf_optional,  :nbfOptional
      alias_method  :nbf_optional=, :nbfOptional=

      attr_accessor :issSuppressed
      alias_method  :iss_suppressed,  :issSuppressed
      alias_method  :iss_suppressed=, :issSuppressed=

      attr_accessor :attributes

      attr_accessor :supportedCustomClientMetadata
      alias_method  :supported_custom_client_metadata,  :supportedCustomClientMetadata
      alias_method  :supported_custom_client_metadata=, :supportedCustomClientMetadata=

      attr_accessor :tokenExpirationLinked
      alias_method  :token_expiration_linked,  :tokenExpirationLinked
      alias_method  :token_expiration_linked=, :tokenExpirationLinked=

      attr_accessor :frontChannelRequestObjectEncryptionRequired
      alias_method  :front_channel_request_object_encryption_required,  :frontChannelRequestObjectEncryptionRequired
      alias_method  :front_channel_request_object_encryption_required=, :frontChannelRequestObjectEncryptionRequired=

      attr_accessor :requestObjectEncryptionAlgMatchRequired
      alias_method  :request_object_encryption_alg_match_required,  :requestObjectEncryptionAlgMatchRequired
      alias_method  :request_object_encryption_alg_match_required=, :requestObjectEncryptionAlgMatchRequired=

      attr_accessor :requestObjectEncryptionEncMatchRequired
      alias_method  :request_object_encryption_enc_match_required,  :requestObjectEncryptionEncMatchRequired
      alias_method  :request_object_encryption_enc_match_required=, :requestObjectEncryptionEncMatchRequired=

      attr_accessor :hsks

      attr_accessor :hsmEnabled
      alias_method  :hsm_enabled,  :hsmEnabled
      alias_method  :hsm_enabled=, :hsmEnabled=

      private

      def defaults
        {
          number:                                      0,
          serviceOwnerNumber:                          0,
          serviceName:                                 nil,
          apiKey:                                      0,
          apiSecret:                                   nil,
          issuer:                                      nil,
          authorizationEndpoint:                       nil,
          tokenEndpoint:                               nil,
          revocationEndpoint:                          nil,
          supportedRevocationAuthMethods:              nil,
          userInfoEndpoint:                            nil,
          jwksUri:                                     nil,
          jwks:                                        nil,
          registrationEndpoint:                        nil,
          registrationManagementEndpoint:              nil,
          supportedScopes:                             nil,
          supportedResponseTypes:                      nil,
          supportedGrantTypes:                         nil,
          supportedAcrs:                               nil,
          supportedTokenAuthMethods:                   nil,
          supportedDisplays:                           nil,
          supportedClaimTypes:                         nil,
          supportedClaims:                             nil,
          serviceDocumentation:                        nil,
          supportedClaimLocales:                       nil,
          supportedUiLocales:                          nil,
          policyUri:                                   nil,
          tosUri:                                      nil,
          authenticationCallbackEndpoint:              nil,
          authenticationCallbackApiKey:                nil,
          authenticationCallbackApiSecret:             nil,
          supportedSnses:                              nil,
          snsCredentials:                              nil,
          createdAt:                                   0,
          modifiedAt:                                  0,
          developerAuthenticationCallbackEndpoint:     nil,
          developerAuthenticationCallbackApiKey:       nil,
          developerAuthenticationCallbackApiSecret:    nil,
          supportedDeveloperSnses:                     nil,
          developerSnsCredentials:                     nil,
          clientsPerDeveloper:                         0,
          directAuthorizationEndpointEnabled:          false,
          directTokenEndpointEnabled:                  false,
          directRevocationEndpointEnabled:             false,
          directUserInfoEndpointEnabled:               false,
          directJwksEndpointEnabled:                   false,
          directIntrospectionEndpointEnabled:          false,
          singleAccessTokenPerSubject:                 false,
          pkceRequired:                                false,
          pkceS256Required:                            false,
          refreshTokenKept:                            false,
          refreshTokenDurationKept:                    false,
          errorDescriptionOmitted:                     false,
          errorUriOmitted:                             false,
          clientIdAliasEnabled:                        false,
          supportedServiceProfiles:                    nil,
          tlsClientCertificateBoundAccessTokens:       false,
          introspectionEndpoint:                       nil,
          supportedIntrospectionAuthMethods:           nil,
          mutualTlsValidatePkiCertChain:               false,
          trustedRootCertificates:                     nil,
          dynamicRegistrationSupported:                false,
          endSessionEndpoint:                          nil,
          description:                                 nil,
          accessTokenType:                             nil,
          accessTokenSignAlg:                          nil,
          accessTokenDuration:                         0,
          refreshTokenDuration:                        0,
          idTokenDuration:                             0,
          authorizationResponseDuration:               0,
          pushedAuthReqDuration:                       0,
          metadata:                                    nil,
          accessTokenSignatureKeyId:                   nil,
          authorizationSignatureKeyId:                 nil,
          idTokenSignatureKeyId:                       nil,
          userInfoSignatureKeyId:                      nil,
          supportedBackchannelTokenDeliveryModes:      nil,
          backchannelAuthenticationEndpoint:           nil,
          backchannelUserCodeParameterSupported:       false,
          backchannelAuthReqIdDuration:                0,
          backchannelPollingInterval:                  0,
          backchannelBindingMessageRequiredInFapi:     false,
          allowableClockSkew:                          0,
          deviceAuthorizationEndpoint:                 nil,
          deviceVerificationUri:                       nil,
          deviceVerificationUriComplete:               nil,
          deviceFlowCodeDuration:                      0,
          deviceFlowPollingInterval:                   0,
          userCodeCharset:                             nil,
          userCodeLength:                              0,
          pushedAuthReqEndpoint:                       nil,
          mtlsEndpointAliases:                         nil,
          supportedAuthorizationDetailsTypes:          nil,
          supportedTrustFrameworks:                    nil,
          supportedEvidence:                           nil,
          supportedIdentityDocuments:                  nil,
          supportedVerificationMethods:                nil,
          supportedVerifiedClaims:                     nil,
          missingClientIdAllowed:                      false,
          parRequired:                                 false,
          requestObjectRequired:                       false,
          traditionalRequestObjectProcessingApplied:   false,
          claimShortcutRestrictive:                    false,
          scopeRequired:                               false,
          nbfOptional:                                 false,
          issSuppressed:                               false,
          attributes:                                  nil,
          supportedCustomClientMetadata:               nil,
          tokenExpirationLinked:                       false,
          frontChannelRequestObjectEncryptionRequired: false,
          requestObjectEncryptionAlgMatchRequired:     false,
          requestObjectEncryptionEncMatchRequired:     false,
          hsks:                                        nil,
          hsmEnabled:                                  false
        }
      end

      def set_params(hash)
        @number                                      = hash[:number]
        @serviceOwnerNumber                          = hash[:serviceOwnerNumber]
        @serviceName                                 = hash[:serviceName]
        @apiKey                                      = hash[:apiKey]
        @apiSecret                                   = hash[:apiSecret]
        @issuer                                      = hash[:issuer]
        @authorizationEndpoint                       = hash[:authorizationEndpoint]
        @tokenEndpoint                               = hash[:tokenEndpoint]
        @revocationEndpoint                          = hash[:revocationEndpoint]
        @supportedRevocationAuthMethods              = hash[:supportedRevocationAuthMethods]
        @userInfoEndpoint                            = hash[:userInfoEndpoint]
        @jwksUri                                     = hash[:jwksUri]
        @jwks                                        = hash[:jwks]
        @registrationEndpoint                        = hash[:registrationEndpoint]
        @registrationManagementEndpoint              = hash[:registrationManagementEndpoint]
        @supportedScopes                             = get_parsed_array(hash[:supportedScopes]) { |e| Authlete::Model::Scope.parse(e) }
        @supportedResponseTypes                      = hash[:supportedResponseTypes]
        @supportedGrantTypes                         = hash[:supportedGrantTypes]
        @supportedAcrs                               = hash[:supportedAcrs]
        @supportedTokenAuthMethods                   = hash[:supportedTokenAuthMethods]
        @supportedDisplays                           = hash[:supportedDisplays]
        @supportedClaimTypes                         = hash[:supportedClaimTypes]
        @supportedClaims                             = hash[:supportedClaims]
        @serviceDocumentation                        = hash[:serviceDocumentation]
        @supportedClaimLocales                       = hash[:supportedClaimLocales]
        @supportedUiLocales                          = hash[:supportedUiLocales]
        @policyUri                                   = hash[:policyUri]
        @tosUri                                      = hash[:tosUri]
        @authenticationCallbackEndpoint              = hash[:authenticationCallbackEndpoint]
        @authenticationCallbackApiKey                = hash[:authenticationCallbackApiKey]
        @authenticationCallbackApiSecret             = hash[:authenticationCallbackApiSecret]
        @supportedSnses                              = hash[:supportedSnses]
        @snsCredentials                              = get_parsed_array(hash[:snsCredentials]) { |e| Authlete::Model::SnsCredentials.parse(e) }
        @createdAt                                   = hash[:createdAt]
        @modifiedAt                                  = hash[:modifiedAt]
        @developerAuthenticationCallbackEndpoint     = hash[:developerAuthenticationCallbackEndpoint]
        @developerAuthenticationCallbackApiKey       = hash[:developerAuthenticationCallbackApiKey]
        @developerAuthenticationCallbackApiSecret    = hash[:developerAuthenticationCallbackApiSecret]
        @supportedDeveloperSnses                     = hash[:supportedDeveloperSnses]
        @developerSnsCredentials                     = get_parsed_array(hash[:developerSnsCredentials]) { |e| Authlete::Model::SnsCredentials.parse(e) }
        @clientsPerDeveloper                         = hash[:clientsPerDeveloper]
        @directAuthorizationEndpointEnabled          = hash[:directAuthorizationEndpointEnabled]
        @directTokenEndpointEnabled                  = hash[:directTokenEndpointEnabled]
        @directRevocationEndpointEnabled             = hash[:directRevocationEndpointEnabled]
        @directUserInfoEndpointEnabled               = hash[:directUserInfoEndpointEnabled]
        @directJwksEndpointEnabled                   = hash[:directJwksEndpointEnabled]
        @directIntrospectionEndpointEnabled          = hash[:directIntrospectionEndpointEnabled]
        @singleAccessTokenPerSubject                 = hash[:singleAccessTokenPerSubject]
        @pkceRequired                                = hash[:pkceRequired]
        @pkceS256Required                            = hash[:pkceS256Required]
        @refreshTokenKept                            = hash[:refreshTokenKept]
        @refreshTokenDurationKept                    = hash[:refreshTokenDurationKept]
        @errorDescriptionOmitted                     = hash[:errorDescriptionOmitted]
        @errorUriOmitted                             = hash[:errorUriOmitted]
        @clientIdAliasEnabled                        = hash[:clientIdAliasEnabled]
        @supportedServiceProfiles                    = hash[:supportedServiceProfiles]
        @tlsClientCertificateBoundAccessTokens       = hash[:tlsClientCertificateBoundAccessTokens]
        @introspectionEndpoint                       = hash[:introspectionEndpoint]
        @supportedIntrospectionAuthMethods           = hash[:supportedIntrospectionAuthMethods]
        @mutualTlsValidatePkiCertChain               = hash[:mutualTlsValidatePkiCertChain]
        @trustedRootCertificates                     = hash[:trustedRootCertificates]
        @dynamicRegistrationSupported                = hash[:dynamicRegistrationSupported]
        @endSessionEndpoint                          = hash[:endSessionEndpoint]
        @description                                 = hash[:description]
        @accessTokenType                             = hash[:accessTokenType]
        @accessTokenSignAlg                          = hash[:accessTokenSignAlg]
        @accessTokenDuration                         = hash[:accessTokenDuration]
        @refreshTokenDuration                        = hash[:refreshTokenDuration]
        @idTokenDuration                             = hash[:idTokenDuration]
        @authorizationResponseDuration               = hash[:authorizationResponseDuration]
        @pushedAuthReqDuration                       = hash[:pushedAuthReqDuration]
        @metadata                                    = get_parsed_array(hash[:metadata]) { |e| Authlete::Model::Pair.parse(e) }
        @accessTokenSignatureKeyId                   = hash[:accessTokenSignatureKeyId]
        @authorizationSignatureKeyId                 = hash[:authorizationSignatureKeyId]
        @idTokenSignatureKeyId                       = hash[:idTokenSignatureKeyId]
        @userInfoSignatureKeyId                      = hash[:userInfoSignatureKeyId]
        @supportedBackchannelTokenDeliveryModes      = hash[:supportedBackchannelTokenDeliveryModes]
        @backchannelAuthenticationEndpoint           = hash[:backchannelAuthenticationEndpoint]
        @backchannelUserCodeParameterSupported       = hash[:backchannelUserCodeParameterSupported]
        @backchannelAuthReqIdDuration                = hash[:backchannelAuthReqIdDuration]
        @backchannelPollingInterval                  = hash[:backchannelPollingInterval]
        @backchannelBindingMessageRequiredInFapi     = hash[:backchannelBindingMessageRequiredInFapi]
        @allowableClockSkew                          = hash[:allowableClockSkew]
        @deviceAuthorizationEndpoint                 = hash[:deviceAuthorizationEndpoint]
        @deviceVerificationUri                       = hash[:deviceVerificationUri]
        @deviceVerificationUriComplete               = hash[:deviceVerificationUriComplete]
        @deviceFlowCodeDuration                      = hash[:deviceFlowCodeDuration]
        @deviceFlowPollingInterval                   = hash[:deviceFlowPollingInterval]
        @userCodeCharset                             = hash[:userCodeCharset]
        @userCodeLength                              = hash[:userCodeLength]
        @pushedAuthReqEndpoint                       = hash[:pushedAuthReqEndpoint]
        @mtlsEndpointAliases                         = get_parsed_array(hash[:mtlsEndpointAliases]) { |e| Authlete::Model::NamedUri.parse(e) }
        @supportedAuthorizationDetailsTypes          = hash[:supportedAuthorizationDetailsTypes]
        @supportedTrustFrameworks                    = hash[:supportedTrustFrameworks]
        @supportedEvidence                           = hash[:supportedEvidence]
        @supportedIdentityDocuments                  = hash[:supportedIdentityDocuments]
        @supportedVerificationMethods                = hash[:supportedVerificationMethods]
        @supportedVerifiedClaims                     = hash[:supportedVerifiedClaims]
        @missingClientIdAllowed                      = hash[:missingClientIdAllowed]
        @parRequired                                 = hash[:parRequired]
        @requestObjectRequired                       = hash[:requestObjectRequired]
        @traditionalRequestObjectProcessingApplied   = hash[:traditionalRequestObjectProcessingApplied]
        @claimShortcutRestrictive                    = hash[:claimShortcutRestrictive]
        @scopeRequired                               = hash[:scopeRequired]
        @nbfOptional                                 = hash[:nbfOptional]
        @issSuppressed                               = hash[:issSuppressed]
        @attributes                                  = get_parsed_array(hash[:attributes]) { |e| Authlete::Model::Pair.parse(e) }
        @supportedCustomClientMetadata               = hash[:supportedCustomClientMetadata]
        @tokenExpirationLinked                       = hash[:tokenExpirationLinked]
        @frontChannelRequestObjectEncryptionRequired = hash[:frontChannelRequestObjectEncryptionRequired]
        @requestObjectEncryptionAlgMatchRequired     = hash[:requestObjectEncryptionAlgMatchRequired]
        @requestObjectEncryptionEncMatchRequired     = hash[:requestObjectEncryptionEncMatchRequired]
        @hsks                                        = get_parsed_array(hash[:hsks]) { |e| Authlete::Model::Hsk.parse(e) }
        @hsmEnabled                                  = hash[:hsmEnabled]
      end

      def to_hash_value(key, var)
        raw_val = instance_variable_get(var)

        case key
          when :snsCredentials, :developerSnsCredentials, :supportedScopes,
               :metadata, :mtlsEndpointAliases, :attributes, :hsks
            raw_val&.map { |e| e.to_hash }
          else
            raw_val
        end
      end
    end
  end
end
