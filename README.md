authlete-ruby-gem
=================

# Overview

Ruby library for [Authlete Web APIs](https://docs.authlete.com/).


# REST Client Logging Configuration

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

# License

Apache License, Version 2.0


# See Also

* [Authlete Website](https://www.authlete.com/)
* [Authlete Facebook](https://www.facebook.com/authlete)
* [Authelte Twitter](https://twitter.com/authlete)
* [Authlete GitHub](https://github.com/authlete)
* [Authlete Email](mailto:support@authlete.com)
