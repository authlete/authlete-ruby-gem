# :nodoc:
#
# Copyright (C) 2014-2015 Authlete, Inc.
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
      # == Authlete::Model::Response::GrantedScopesGetResponse class
      #
      # A class that represents a response from Authlete's
      # /api/client/granted_scopes/get/{clientId} API.
      class GrantedScopesGetResponse < Authlete::Model::Result
        # Service API key. (Integer)
        attr_accessor :serviceApiKey
        alias_method  :service_api_key, :serviceApiKey
        alias_method  :service_api_key=, :serviceApiKey=

        # Client ID.. (Integer)
        attr_accessor :clientId
        alias_method  :client_id,  :clientId
        alias_method  :client_id=, :clientId=

        # Unique User ID. (String)
        attr_accessor :subject

        # Scopes granted by the last authorization process. (String array)
        attr_accessor :latestGrantedScopes
        alias_method  :latest_granted_scopes,  :latestGrantedScopes
        alias_method  :latest_granted_scopes=, :latestGrantedScopes=

        # All scopes granted so far. (String array)
        attr_accessor :mergedGrantedScopes
        alias_method  :merged_granted_scopes,  :mergedGrantedScopes
        alias_method  :merged_granted_scopes=, :mergedGrantedScopes=

        # The constructor which takes a hash that represents a JSON response
        # from /api/client/granted_scopes/get/{clientId} API.
        def initialize(hash = {})
          super(hash)

          @serviceApiKey       = extract_integer_value(hash, :serviceApiKey)
          @clientId            = extract_integer_value(hash, :clientId)
          @subject             = extract_value(hash, :subject)
          @latestGrantedScopes = extract_value(hash, :latestGrantedScopes)
          @mergedGrantedScopes = extract_value(hash, :mergedGrantedScopes)
        end
      end
    end
  end
end