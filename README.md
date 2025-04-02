# authlete-ruby-gem

Ruby library for [Authlete Web APIs](https://docs.authlete.com/).

## Installation

```bash
$ gem install authlete
```

## Configuration

You can configure the Authlete API client. Here are the available options:

*   `:host` (String, required): The URL of the Authlete API server (e.g., `https://api.authlete.com`).
*   `:api_version` (String, optional): Specifies the Authlete API version to use. Either `'v2'` or `'v3'`. Defaults to `'v2'`.
*   **For API v2:**
    *   `:service_owner_api_key` (String): Your service owner API key.
    *   `:service_owner_api_secret` (String): Your service owner API secret.
    *   `:service_api_key` (String): Your service API key.
    *   `:service_api_secret` (String): Your service API secret.
*   **For API v3:**
    *   `:organization_access_token` (String): Your organization access token.
    *   `:service_access_token` (String): Your service access token.
    *   `:service_id` (String, required for most v3 APIs): The ID of the target service. This will be URL-encoded automatically.
*   `:extra_headers` (Hash, optional): Additional HTTP headers to include in API requests.
*   `:rest_client_logging_level` (Symbol, optional): Controls the logging behavior of the underlying `rest-client`. See the "REST Client Logging Configuration" section below for details.

**Note for API v3:** Most v3 APIs require `:service_id` in the configuration.

## Basic Usage

Start by creating an Authlete::Api instance with your configuration.

### API v2 Example

```ruby
require 'authlete'

# Configure for API v2
config = {
  host: 'https://api.authlete.com',
  service_api_key: 'YOUR_SERVICE_API_KEY',
  service_api_secret: 'YOUR_SERVICE_API_SECRET'
  # Optionally add service_owner keys if needed
  # service_owner_api_key: 'YOUR_SERVICE_OWNER_API_KEY',
  # service_owner_api_secret: 'YOUR_SERVICE_OWNER_API_SECRET'
}

api = Authlete::Api.new(config)

# Example: Call the introspection API
begin
  introspection_request = Authlete::Model::Request::IntrospectionRequest.new(token: 'ACCESS_TOKEN_TO_INTROSPECT')
  response = api.introspection(introspection_request)

  if response.action == 'OK'
    puts "Token is valid."
    puts "Subject: #{response.subject}"
    puts "Scopes: #{response.scopes.join(', ')}"
    # Access other response details like response.clientId, response.expiresAt etc.
  else
    puts "Token introspection failed: #{response.result.resultMessage}"
    # Handle other actions like 'INTERNAL_SERVER_ERROR', 'BAD_REQUEST', 'FORBIDDEN'
  end
rescue Authlete::Exception => e
  puts "Authlete API error: #{e.message}"
  puts "Status Code: #{e.status_code}" if e.status_code
  puts "Result Code: #{e.result.resultCode}" if e.result
  puts "Result Message: #{e.result.resultMessage}" if e.result
end
```

### API v3 Example

```ruby
require 'authlete'

# Configure for API v3
config = {
  host: 'https://api.authlete.com',
  api_version: 'v3',
  service_access_token: 'YOUR_SERVICE_ACCESS_TOKEN',
  service_id: 'YOUR_SERVICE_ID' # Required for most v3 APIs
  # Optionally add organization token if needed
  # organization_access_token: 'YOUR_ORGANIZATION_ACCESS_TOKEN'
}

api = Authlete::Api.new(config)

# Example: Call the introspection API
begin
  introspection_request = Authlete::Model::Request::IntrospectionRequest.new(token: 'ACCESS_TOKEN_TO_INTROSPECT')
  # API calls are the same, the client handles authentication based on config
  response = api.introspection(introspection_request)

  if response.action == 'OK'
    puts "Token is valid."
    # Process response as in the v2 example
  else
    puts "Token introspection failed: #{response.result.resultMessage}"
    # Handle errors as in the v2 example
  end
rescue Authlete::Exception => e
  # Handle errors as in the v2 example
  puts "Authlete API error: #{e.message}"
end
```

## API Versioning

This library supports both Authlete API v2 and v3.

*   **API v2 (Default):** Uses API Key and Secret pairs for authorization (`:service_api_key`, `:service_api_secret`, `:service_owner_api_key`, `:service_owner_api_secret`).
*   **API v3:** Uses Bearer tokens for authorization (`:organization_access_token`, `:service_access_token`). Most v3 APIs also require a `:service_id` to be specified in the configuration.

You can select the API version by setting the `:api_version` key in the configuration hash passed to `Authlete::Api.new`. If omitted, it defaults to `'v2'`. The `Authlete::Api` instance will automatically use the correct authorization method and API paths based on the selected version.

---

## REST Client Logging Configuration

The library provides control over `rest-client` logging behavior through `Authlete::LoggingLevel`:

- `DEFAULT` - Respects the logger set in `RestClient.log` (default behavior)
- `SENSITIVE` - Logs all information but redacts sensitive data (tokens, credentials)
- `NONE` - Disables all logging, useful for handling sensitive PII data

Example configuration:

```ruby
# Default behavior (uses RestClient.log as is)
config = {
  host: 'https://api.authlete.com',
  service_api_key: 'YOUR_KEY',
  service_api_secret: 'YOUR_SECRET',
  rest_client_logging_level: Authlete::LoggingLevel::DEFAULT
}

# Redact sensitive data
config = {
  host: 'https://api.authlete.com',
  service_api_key: 'YOUR_KEY',
  service_api_secret: 'YOUR_SECRET',
  rest_client_logging_level: Authlete::LoggingLevel::SENSITIVE
}

# Disable all RestClient logging
config = {
  host: 'https://api.authlete.com',
  service_api_key: 'YOUR_KEY',
  service_api_secret: 'YOUR_SECRET',
  rest_client_logging_level: Authlete::LoggingLevel::NONE
}

api_client = Authlete::Api.new(config)
```

---

## License

Apache License, Version 2.0

---

## See Also

* [Authlete Website](https://www.authlete.com/)
* [Authlete Facebook](https://www.facebook.com/authlete)
* [Authlete Twitter](https://twitter.com/authlete)
* [Authlete GitHub](https://github.com/authlete)
* [Authlete Email](mailto:support@authlete.com)