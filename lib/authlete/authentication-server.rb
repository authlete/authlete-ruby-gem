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


require 'rack'


module Authlete
  # == Authlete::AuthenticationServer class
  #
  # This class is a base class for an authentication server based on Rack.
  # Some method must/should be overridden by subclasses.
  #
  # 1. <tt>authenticate_api_call</tt>
  # 2. <tt>authenticate_user</tt>
  # 3. <tt>collect_claims</tt>
  # 4. <tt>authentication_callback_endpoint_path</tt>
  class AuthenticationServer
    def initialize(app = nil)
      # Accept 'app' so that this class can work as a Rack middleware
      # as well as a Rack application.
      @app = app
    end

    def call(env)
      # Request
      request = Rack::Request.new(env)

      # If the request is not an authentication callback request.
      if match_authentication_callback_request(request) == false
        # If this class is used as a Rack middleware.
        if @app && @app.respond_to?(:call)
          # Call chain to the next Rack middleware.
          return @app.call(env)
        else
          # 404 Not Found
          return generate_not_found(request)
        end
      end

      # Basic Authentication for the API call.
      authenticated = do_authenticate_api_call(env)
      if authenticated == false
        # 401 Unauthorized
        return generate_api_call_authentication_failure()
      end

      begin
        # Parse the request body as AuthenticationCallbackRequest.
        req = parse_authentication_callback_request(request)
      rescue => e
        # 400 Bad Request
        return generate_authentication_callback_request_format_error(e)
      end

      # Prepare an empty response.
      res = Authlete::Model::Response::AuthenticationCallbackResponse.new

      # Let the subclass authenticate the end-user.
      # When authenticated successfully, a non-nil value is returned.
      subject = authenticate_user(req)
      if subject.nil?
        # End-user authentication failed.
        # Return {"authenticated": false} to Authlete.
        res.authenticated = false
        return res.to_rack_response
      end

      # The end-user has been authenticated successfully.
      res.authenticated = true
      res.subject       = subject

      if req.claims.nil? == false && req.claims.length != 0
        # Make the subclass collect values of the requested claims.
        res.claims = collect_claims(req, subject)
      end

      # Return {"authenticated": true, ...} to Authlete.
      return res.to_rack_response
    end

    private

    def match_authentication_callback_request(request)
      request.post? &&
      request.path_info == authentication_callback_endpoint_path() &&
      %r{^application/json}i === request.content_type
    end

    def do_authenticate_api_call(env)
      # API key and secret for the API call to the authentication endpoint.
      api_key, api_secret = nil, nil

      # Basic Authentication for the API call.
      auth = Rack::Auth::Basic::Request.new(env)

      if auth.provided? && auth.basic?
        api_key, api_secret = *auth.credentials
      end

      # Let the subclass authenticate the API call.
      authenticate_api_call(api_key, api_secret)
    end

    # 404 Not Found
    def generate_not_found(request)
      [
        404,
        {
          'Content-Type' => 'text/plain'
        },
        [
          "Not Found: #{request.request_method} #{request.path_info} (#{request.content_type})"
        ]
      ]
    end

    # 401 Unauthorized
    def generate_api_call_authentication_failure
      [
        401,
        {
          'Content-Type'     => 'text/plain',
          'WWW-Authenticate' => 'Basic realm="Authentication Callback Endpoint"'
        },
        [
          'Authentication of the API call to the authentication callback endpoint failed.'
        ]
      ]
    end

    # 400 Bad Request
    def generate_authentication_callback_request_format_error(exception)
      [
        400,
        {
          'Content-Type' => 'text/plain',
        },
        [
          "The format of the authentication callback request was wrong: #{exception.to_s}"
        ]
      ]
    end

    def parse_authentication_callback_request(request)
      # In case someone has already read it.
      request.body.rewind

      # JSON
      json = request.body.read

      # Parse the authentication callback request.
      Authlete::Model::Request::AuthenticationCallbackRequest.parse(json)
    end

    protected

    # Authenticate the API call to the authentication callback endpoint
    # from Authlete. Subclasses must override this method. This default
    # implementation returns false, meaning 'unauthorized API call'.
    #
    # The argument of this method is the API key and the API secret that
    # the caller has presented. When the pair of the API credentials is
    # valid, return true. Otherwise, return false.
    def authenticate_api_call(api_key, api_secret)
      # Unauthorized API call.
      false
    end

    # Authenticate the end-user. Subclasses must override this method.
    # This default implementation returns nil, meaning 'invalid end-user'.
    #
    # The argument of this method is an instance of
    # <tt>Authlete::Model::Request::AuthenticationCallbackRequest</tt>.
    # When the end-user is successfully authenticated, this method must
    # return a unique identifier (= subject) of the end-user. Otherwise,
    # nil must be returned to indicate authentication failure.
    def authenticate_user(req)
      # Invalid end-user.
      nil
    end

    # Collect claim values of the end-user. Subclasses should override this
    # method. This default implementation returns nil, meaning 'no claim values'.
    #
    # The argument of this method is an instance of
    # <tt>Authlete::Model::Request::AuthenticationCallbackRequest</tt> and the subject
    # which has been returned from the preceding call of <tt>authenticate_user</tt>
    # method.
    #
    # 'Claim' is a piece of information about an end-user. A subclass should
    # collect values of requested claims (<tt>req.claims</tt>) as many as
    # possible and format them in JSON format like below.
    #
    #   {
    #     "name": "Takahiko Kawasaki",
    #     "gender": "male"
    #   }
    #
    # Collected claim values are used to generate an {ID token}
    # [http://openid.net/specs/openid-connect-core-1_0.html#IDToken].
    #
    # If no claim values are available, or if you don't want to provide any
    # claim value, return nil.
    def collect_claims(req, subject)
      # No claim values.
      nil
    end

    # Get the path of the authentication callback endpoint. This default
    # implementation returns '/authentication'. Subclasses may override
    # this method to change the path.
    def authentication_callback_endpoint_path
      '/authentication'
    end
  end
end