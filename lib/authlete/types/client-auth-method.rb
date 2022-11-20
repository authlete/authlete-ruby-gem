# :nodoc:
#
# Copyright (C) 2022 Authlete, Inc.
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
  module Types
    module ClientAuthMethod
      extend Authlete::Types::ConstantUtility

      NONE                        = "none"
      CLIENT_SECRET_BASIC         = "client_secret_basic"
      CLIENT_SECRET_POST          = "client_secret_post"
      CLIENT_SECRET_JWT           = "client_secret_jwt"
      PRIVATE_KEY_JWT             = "private_key_jwt"
      TLS_CLIENT_AUTH             = "tls_client_auth"
      SELF_SIGNED_TLS_CLIENT_AUTH = "self_signed_tls_client_auth"
    end
  end
end
