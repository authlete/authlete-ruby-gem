# :nodoc:
#
# Copyright (C) 2014 Authlete, Inc.
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


require 'json'
require 'rest-client'


module Authlete
  # == Authlete::Client Module
  #
  # A web client that accesses Authlete Web APIs.
  #
  class Client
    include Authlete::Utility

    # The host which provides Authlete Web APIs.
    # For example, <tt>https://evaluation-dot-authlete.appspot.com</tt>
    attr_accessor :host

    # The API key of a service owner.
    attr_accessor :service_owner_api_key

    # The API secret of a service owner.
    attr_accessor :service_owner_api_secret

    # The API key of a service.
    attr_accessor :service_api_key

    # The API secret of a service.
    attr_accessor :service_api_secret

    # The constructor which takes a hash containing configuration
    # parameters. Valid configuration parameter names are as follows.
    #
    # - <tt>:host</tt>
    # - <tt>:service_owner_api_key</tt>
    # - <tt>:service_owner_api_secret</tt>
    # - <tt>:service_api_key</tt>
    # - <tt>:service_api_secret</tt>
    #
    def initialize(config = {})
      @host                     = extract_value(config, :host)
      @service_owner_api_key    = extract_value(config, :service_owner_api_key)
      @service_owner_api_secret = extract_value(config, :service_owner_api_secret)
      @service_api_key          = extract_value(config, :service_api_key)
      @service_api_secret       = extract_value(config, :service_api_secret]
    end

    private

    def call_api(method, path, content_type, payload, user, password)
      response = RestClient::Request.new(
        :method   => :method,
        :url      => @host + path,
        :headers  => { :content_type => content_type },
        :payload  => payload,
        :user     => user,
        :password => password
      ).execute

      JSON.parse(response.to_str, :symbolize_names => true)
    end

    def call_api_json(path, body, user, password)
      call_api(:post, path, 'application/json;charset=UTF-8', JSON.generate(body), user, password)
    end

    def call_api_json_servie_owner(path, body)
      call_api_json(path, body, @service_owner_api_key, @service_owner_api_secret)
    end

    def call_api_json_service(path, body)
      call_api_json(path, body, @service_api_key, @service_api_secret)
    end

    public

    # Call Authlete's {/auth/introspection}
    # [https://www.authlete.com/authlete_web_apis_introspection.html#auth_introspection]
    # API.
    #
    # <tt>token</tt> is an access token presented by a client application.
    # This is a must parameter. In a typical case, a client application uses
    # one of the means listed in {RFC 6750}[https://tools.ietf.org/html/rfc6750]
    # to present an access token to a {protected resource endpoint}
    # [https://tools.ietf.org/html/rfc6749#section-7].
    #
    # <tt>scopes</tt> is an array of scope names. This is an optional parameter.
    # When the specified scopes are not covered by the access token, Authlete
    # prepares the content of the error response.
    #
    # <tt>subject</tt> is a unique identifier of an end-user. This is an optional
    # parameter. When the access token is not associated with the specified
    # subject, Authlete prepares the content of the error response.
    #
    # On success, this method returns an instance of
    # <tt>Authlete::Response::IntrospectionResponse</tt>. On error, this method
    # throws <tt>RestClient::Exception</tt>.
    def introspection(token, scopes = nil, subject = nil)
      hash = call_api_json_service('/api/auth/introspection',
        :token => token, :scopes => scopes, :subject => subject)

      Authlete::Response::IntrospectionResponse.new(hash)
    end
  end
end
