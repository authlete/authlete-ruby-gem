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
    module JWSAlg
      extend Authlete::Types::ConstantUtility

      NONE   = "none"
      HS256  = "HS256"
      HS384  = "HS384"
      HS512  = "HS512"
      RS256  = "RS256"
      RS384  = "RS384"
      RS512  = "RS512"
      ES256  = "ES256"
      ES384  = "ES384"
      ES512  = "ES512"
      PS256  = "PS256"
      PS384  = "PS384"
      PS512  = "PS512"
      ES256K = "ES256K"
      EdDSA  = "EdDSA"
    end
  end
end
