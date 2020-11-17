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
  module ParamInitializer

    private

    def initialize(hash = {})
      set_params( merge_hash(hash) )
    end

    def merge_hash(hash)
      hash.kind_of?(Hash) ? defaults.merge( normalize_hash_key(hash) ) : defaults
    end

    def normalize_hash_key(hash)
      Hash[ hash.map{ |(k, v)| [ k.to_sym, v ] } ]
    end

    #
    # Override this method.
    #
    def set_params(hash); end

    #
    # Override this method.
    #
    def defaults; end
  end
end
