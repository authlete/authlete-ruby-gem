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
      # == Authlete::Model::Response::AuthenticationCallbackResponse class
      #
      # This class represents a response from an authentication callback endpoint.
      class AuthenticationCallbackResponse
        include Authlete::Utility
        # True when the end-user has been authenticated (= is a valid user).
        attr_accessor :authenticated

        # The unique identifier of the end-user.
        attr_accessor :subject

        # Pieces of information about the end-user in JSON format.
        attr_accessor :claims

        # True to indicate that the authentication endpoint is mock.
        attr_accessor :mock

        # The constructor which takes a hash that represents a JSON response
        # from an authentication callback endpoint.
        def initialize(hash = {})
          @authenticated = extract_boolean_value(hash, :authenticated)
          @subject       = extract_value(hash, :subject)
          @claims        = extract_value(hash, :claims)
          @mock          = extract_boolean_value(hash, :mock)
        end

        # Generate an array which is usable as a Rack response from this instance.
        def to_rack_response
          to_rack_response_json(200, JSON.generate(
            :authenticated => @authenticated,
            :subject       => @subject,
            :claims        => @claims,
            :mock          => @mock
          ))
        end
      end
    end
  end
end