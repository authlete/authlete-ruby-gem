module Authlete
  class SensitiveLogger
    SENSITIVE_FIELDS = [
      # OAuth/OIDC related
      'client_secret',
      'access_token',
      'refresh_token',
      'authorization_code',
      'id_token',
      'code',
      
      # Authlete Credentials
      'service_api_key',
      'service_api_secret',
      'service_owner_api_key',
      'service_owner_api_secret',
      
      # authentication & authorization related
      'password',
      'token',
      'authorization',
      
      # JWT/Crypto related
      'jwks',
      'client_secret_expires_at'
    ].freeze

    SENSITIVE_PATTERNS = SENSITIVE_FIELDS.flat_map do |field|
      [
        # JSON format
        /("#{field}"\s*:\s*)"[^"]*"/,
        # URL-encoded format
        /#{field}=([^&\s]+)/
      ]
    end.freeze

    REDACTION_MARK = '***** REDACTED *****'

    def initialize(original_logger)
      @original_logger = original_logger
    end

    def <<(msg)
      redacted_msg = redact_sensitive_data(msg)
      @original_logger << redacted_msg
    end

    private

    def redact_sensitive_data(msg)
      return msg unless msg.is_a?(String)
      
      redacted = msg.dup
      SENSITIVE_PATTERNS.each do |pattern|
        if pattern.to_s.include?('"')
          # JSON format
          redacted.gsub!(pattern, "\\1#{REDACTION_MARK.inspect}")
        else
          # URL-encoded format
          redacted.gsub!(pattern) { "#{$~[0].split('=')[0]}=#{REDACTION_MARK}" }
        end
      end
      redacted
    end
  end
end