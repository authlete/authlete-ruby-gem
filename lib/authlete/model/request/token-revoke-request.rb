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
    module Request
      class TokenRevokeRequest < Authlete::Model::Request::Base

        attr_accessor :accessTokenIdentifier
        alias_method  :access_token_identifier, :accessTokenIdentifier
        alias_method  :access_token_identifier=, :accessTokenIdentifier=

        attr_accessor :clientIdentifier
        alias_method  :client_identifier, :clientIdentifier
        alias_method  :client_identifier=, :clientIdentifier=

        attr_accessor :refreshTokenIdentifier
        alias_method  :refresh_token_identifier, :refreshTokenIdentifier
        alias_method  :refresh_token_identifier=, :refreshTokenIdentifier=

        attr_accessor :subject

        private

        def defaults
          {
            accessTokenIdentifier: nil,
            clientIdentifier: nil,
            refreshTokenIdentifier: nil,
            subject: nil
          }
        end

        def set_params(hash)
          @accessTokenIdentifier = hash[:accessTokenIdentifier]
          @clientIdentifier = hash[:clientIdentifier]
          @refreshTokenIdentifier = hash[:refreshTokenIdentifier]
          @subject = hash[:subject]
        end
      end
    end
  end
end
