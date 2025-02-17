module Authlete
  module LoggingLevel
    DEFAULT = :default           # Original logging behavior
    SENSITIVE = :sensitive # Redact sensitive data
    NONE = :none          # No logging
  end

  class NullLogger
    def <<(msg)
      # NOOP
    end
  end
  
  class SensitiveLogger
    SENSITIVE_FIELDS = [
      # OAuth/OIDC related
      'client_secret',
      'access_token',
      'refresh_token',
      'authorization_code',
      'id_token',
      'code',
      # Device flow
      'user_code',              
      'client_notification_token', 

      # Authlete Credentials
      'service_api_key',
      'service_api_secret',
      'service_owner_api_key',
      'service_owner_api_secret',
      'sns_credentials',
      'developer_sns_credentials',
      'ticket',
      'subject',
      
      # Authentication & Authorization
      'password',
      'token',
      'authorization',
      'client_certificate',
      'client_certificate_path',
      
      # JWT/Crypto/Certificate related
      'jwks',
      'federation_jwks',
      'client_secret_expires_at',
      'trusted_root_certificates',
      'encryption_key_id',
      'signature_key_id',
      'access_token_signature_key_id',
      'refresh_token_signature_key_id',
      'id_token_signature_key_id'
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