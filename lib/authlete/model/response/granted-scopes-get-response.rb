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
    module Response
      class GrantedScopesGetResponse < Authlete::Model::Result

        attr_accessor :serviceApiKey
        alias_method  :service_api_key, :serviceApiKey
        alias_method  :service_api_key=, :serviceApiKey=

        attr_accessor :clientId
        alias_method  :client_id,  :clientId
        alias_method  :client_id=, :clientId=

        attr_accessor :subject

        attr_accessor :latestGrantedScopes
        alias_method  :latest_granted_scopes,  :latestGrantedScopes
        alias_method  :latest_granted_scopes=, :latestGrantedScopes=

        attr_accessor :mergedGrantedScopes
        alias_method  :merged_granted_scopes,  :mergedGrantedScopes
        alias_method  :merged_granted_scopes=, :mergedGrantedScopes=

        attr_accessor :modifiedAt
        alias_method  :modified_at,  :modifiedAt
        alias_method  :modified_at=, :modifiedAt=

        private

        def defaults
          super.merge(
            serviceApiKey:       nil,
            clientId:            0,
            subject:             nil,
            latestGrantedScopes: nil,
            mergedGrantedScopes: nil,
            modifiedAt:          0
          )
        end

        def set_params(hash)
          super(hash)

          @serviceApiKey       = hash[:serviceApiKey]
          @clientId            = hash[:clientId]
          @subject             = hash[:subject]
          @latestGrantedScopes = hash[:latestGrantedScopes]
          @mergedGrantedScopes = hash[:mergedGrantedScopes]
          @modifiedAt          = hash[:modifiedAt]
        end
      end
    end
  end
end
