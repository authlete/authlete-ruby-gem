module Authlete
  module ApiPath
    class V3
      attr_reader :service_id

      def initialize(service_id = nil)
        @service_id = service_id
      end

      def authorization
        "/api/#{@service_id}/auth/authorization"
      end

      def authorization_issue
        "/api/#{@service_id}/auth/authorization/issue"
      end

      def authorization_fail
        "/api/#{@service_id}/auth/authorization/fail"
      end

      def token
        "/api/#{@service_id}/auth/token"
      end

      def token_issue
        "/api/#{@service_id}/auth/token/issue"
      end

      def token_fail
        "/api/#{@service_id}/auth/token/fail"
      end

      def token_revoke
        "/api/#{@service_id}/auth/token/revoke"
      end

      def service_create
        "/api/service/create"
      end

      def service_delete(service_id)
        "/api/#{service_id}/service/delete"
      end

      def service_get(service_id)
        "/api/#{service_id}/service/get"
      end

      def service_get_list
        "/api/service/get/list"
      end

      def service_update(service_id)
        "/api/#{service_id}/service/update"
      end

      def serviceowner_get_self
        raise NoMethodError, 'This API does not exist in Authlete v3.'
      end

      def client_create
        "/api/#{@service_id}/client/create"
      end

      def client_delete(client_id)
        "/api/#{@service_id}/client/delete/#{client_id}"
      end

      def client_get(client_id)
        "/api/#{@service_id}/client/get/#{client_id}"
      end

      def client_get_list
        "/api/#{@service_id}/client/get/list"
      end

      def client_update(client_id)
        "/api/#{@service_id}/client/update/#{client_id}"
      end

      def refresh_client_secret(client_identifier)
        "/api/#{@service_id}/client/secret/refresh/#{client_identifier}"
      end

      def update_client_secret(client_identifier)
        "/api/#{@service_id}/client/secret/update/#{client_identifier}"
      end

      def get_client_authorization_list
        "/api/#{@service_id}/client/authorization/get/list"
      end

      def update_client_authorization(client_id)
        "/api/#{@service_id}/client/authorization/update/#{client_id}"
      end

      def delete_client_authorization(client_id)
        "/api/#{@service_id}/client/authorization/delete/#{client_id}"
      end

      def introspection
        "/api/#{@service_id}/auth/introspection"
      end

      def standard_introspection
        "/api/#{@service_id}/auth/introspection/standard"
      end

      def revocation
        "/api/#{@service_id}/auth/revocation"
      end

      def user_info
        "/api/#{@service_id}/auth/userinfo"
      end

      def user_info_issue
        "/api/#{@service_id}/auth/userinfo/issue"
      end

      def get_service_jwks
        "/api/#{@service_id}/service/jwks/get"
      end

      def get_service_configuration
        "/api/#{@service_id}/service/configuration"
      end

      def token_create
        "/api/#{@service_id}/auth/token/create"
      end

      def token_update
        "/api/#{@service_id}/auth/token/update"
      end

      def get_token_list
        "/api/#{@service_id}/auth/token/get/list"
      end

      def get_granted_scopes(client_id)
        "/api/#{@service_id}/client/granted_scopes/get/#{client_id}"
      end

      def delete_granted_scopes(client_id)
        "/api/#{@service_id}/client/granted_scopes/delete/#{client_id}"
      end

      def get_requestable_scopes(client_id)
        "/api/#{@service_id}/client/extension/requestable_scopes/get/#{client_id}"
      end

      def set_requestable_scopes(client_id)
        "/api/#{@service_id}/client/extension/requestable_scopes/update/#{client_id}"
      end

      def delete_requestable_scopes(client_id)
        "/api/#{@service_id}/client/extension/requestable_scopes/delete/#{client_id}"
      end

      def dynamic_client_register
        "/api/#{@service_id}/client/registration"
      end

      def dynamic_client_get
        "/api/#{@service_id}/client/registration/get"
      end

      def dynamic_client_update
        "/api/#{@service_id}/client/registration/update"
      end

      def dynamic_client_delete
        "/api/#{@service_id}/client/registration/delete"
      end

      def backchannel_authentication
        "/api/#{@service_id}/backchannel/authentication"
      end

      def backchannel_authentication_issue
        "/api/#{@service_id}/backchannel/authentication/issue"
      end

      def backchannel_authentication_fail
        "/api/#{@service_id}/backchannel/authentication/fail"
      end

      def backchannel_authentication_complete
        "/api/#{@service_id}/backchannel/authentication/complete"
      end

      def device_authorization
        "/api/#{@service_id}/device/authorization"
      end

      def device_complete
        "/api/#{@service_id}/device/complete"
      end

      def device_verification
        "/api/#{@service_id}/device/verification"
      end

      def push_authorization_request
        "/api/#{@service_id}/pushed_auth_req"
      end
    end
  end
end 