module Authlete
  module ApiPath
    class V2
      
      def authorization
        "/api/auth/authorization"
      end

      def authorization_issue
        "/api/auth/authorization/issue"
      end

      def authorization_fail
        "/api/auth/authorization/fail"
      end

      def token
        "/api/auth/token"
      end

      def token_issue
        "/api/auth/token/issue"
      end

      def token_fail
        "/api/auth/token/fail"
      end

      def token_revoke
        "/api/auth/token/revoke"
      end

      def service_create
        "/api/service/create"
      end

      def service_delete(api_key)
        "/api/service/delete/#{api_key}"
      end

      def service_get(api_key)
        "/api/service/get/#{api_key}"
      end

      def service_get_list
        "/api/service/get/list"
      end

      def service_update(api_key)
        "/api/service/update/#{api_key}"
      end

      def serviceowner_get_self
        "/api/serviceowner/get/self"
      end

      def client_create
        "/api/client/create"
      end

      def client_delete(client_id)
        "/api/client/delete/#{client_id}"
      end

      def client_get(client_id)
        "/api/client/get/#{client_id}"
      end

      def client_get_list
        "/api/client/get/list"
      end

      def client_update(client_id)
        "/api/client/update/#{client_id}"
      end

      def refresh_client_secret(client_identifier)
        "/api/client/secret/refresh/#{client_identifier}"
      end

      def update_client_secret(client_identifier)
        "/api/client/secret/update/#{client_identifier}"
      end

      def get_client_authorization_list
        "/api/client/authorization/get/list"
      end

      def update_client_authorization(client_id)
        "/api/client/authorization/update/#{client_id}"
      end

      def delete_client_authorization(client_id)
        "/api/client/authorization/delete/#{client_id}"
      end

      def introspection
        "/api/auth/introspection"
      end

      def standard_introspection
        "/api/auth/introspection/standard"
      end

      def revocation
        "/api/auth/revocation"
      end

      def user_info
        "/api/auth/userinfo"
      end

      def user_info_issue
        "/api/auth/userinfo/issue"
      end

      def get_service_jwks
        "/api/service/jwks/get"
      end

      def get_service_configuration
        "/api/service/configuration"
      end

      def token_create
        "/api/auth/token/create"
      end

      def token_update
        "/api/auth/token/update"
      end

      def get_token_list
        "/api/auth/token/get/list"
      end

      def get_granted_scopes(client_id)
        "/api/client/granted_scopes/get/#{client_id}"
      end

      def delete_granted_scopes(client_id)
        "/api/client/granted_scopes/delete/#{client_id}"
      end

      def get_requestable_scopes(client_id)
        "/api/client/extension/requestable_scopes/get/#{client_id}"
      end

      def set_requestable_scopes(client_id)
        "/api/client/extension/requestable_scopes/update/#{client_id}"
      end

      def delete_requestable_scopes(client_id)
        "/api/client/extension/requestable_scopes/delete/#{client_id}"
      end

      def dynamic_client_register
        "/api/client/registration"
      end

      def dynamic_client_get
        "/api/client/registration/get"
      end

      def dynamic_client_update
        "/api/client/registration/update"
      end

      def dynamic_client_delete
        "/api/client/registration/delete"
      end

      def backchannel_authentication
        "/api/backchannel/authentication"
      end

      def backchannel_authentication_issue
        "/api/backchannel/authentication/issue"
      end

      def backchannel_authentication_fail
        "/api/backchannel/authentication/fail"
      end

      def backchannel_authentication_complete
        "/api/backchannel/authentication/complete"
      end

      def device_authorization
        "/api/device/authorization"
      end

      def device_complete
        "/api/device/complete"
      end

      def device_verification
        "/api/device/verification"
      end

      def push_authorization_request
        "/api/pushed_auth_req"
      end
    end
  end
end 