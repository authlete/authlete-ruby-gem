# :nodoc:
#
# Copyright (C) 2014-2018 Authlete, Inc.
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
  module Utility
    def extract_value(hash, key)
      if hash.has_key?(key)
        hash[key]
      else
        hash[key.to_s]
      end
    end

    def extract_integer_value(hash, key)
      extract_value(hash, key).to_i
    end

    def extract_boolean_value(hash, key)
      value = extract_value(hash, key)
      (value == true || value == 'true')
    end

    def extract_array_value(hash, key)
      array = extract_value(hash, key)

      # Parse each of the elements in the array.
      # Then, put them into an array.
      get_parsed_array(array) do |element|
        yield(element)
      end
    end

    # Extract an access token (RFC 6750)
    def extract_access_token(request)
      header = request.env['HTTP_AUTHORIZATION']

      if /^Bearer[ ]+(.+)/i =~ header
        return $1
      end

      request['access_token']
    end

    def get_parsed_array(array)
      if array.nil? or (array.kind_of?(Array) == false) or (array.empty?)
        return nil
      end

      elements = []

      array.each do |element|
        parsed_element = yield(element)
        elements.push(parsed_element) unless parsed_element.nil?
      end

      elements.empty? ? nil : elements
    end

    def to_rack_response_json(status_code, content)
      [
        status_code,
        {
          'Content-Type'  => 'application/json;charset=UTF-8',
          'Cache-Control' => 'no-store',
          'Pragma'        => 'no-cache'
        },
        [
          content
        ]
      ]
    end

    def to_rack_response_www_authenticate(status_code, content)
      [
        status_code,
        {
          'WWW-Authenticate' => content,
          'Cache-Control'    => 'no-store',
          'Pragma'           => 'no-cache'
        },
        nil
      ]
    end
  end
end