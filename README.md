authlete-ruby-gem
=================

# Overview

Ruby library for [Authlete Web APIs](https://docs.authlete.com/).


# Logging Configuration

The library supports different logging levels that can be configured when initializing the API client. The logging levels are defined in `Authlete::LoggingLevel`:

- `NONE` - Disables all logging
- `SENSITIVE` - Masks sensitive information in logs (e.g. credentials, tokens)
- `FULL` - Full logging with all details (default)

Example configuration:

```ruby
# Full logging (default)
config = {
  host: 'https://api.authlete.com',
  service_api_key: 'YOUR_KEY',
  service_api_secret: 'YOUR_SECRET',
  logging_level: Authlete::LoggingLevel::FULL
}

# Redact sensitive data
config = {
  host: 'https://api.authlete.com',
  service_api_key: 'YOUR_KEY',
  service_api_secret: 'YOUR_SECRET',
  logging_level: Authlete::LoggingLevel::SENSITIVE
}

# Disable all logging
config = {
  host: 'https://api.authlete.com',
  service_api_key: 'YOUR_KEY',
  service_api_secret: 'YOUR_SECRET',
  logging_level: Authlete::LoggingLevel::NONE
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
