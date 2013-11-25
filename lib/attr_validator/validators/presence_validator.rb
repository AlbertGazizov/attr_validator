class AttrValidator::Validators::PresenceValidator < AttrValidator::Validators::Validator

  # Validates that given string present if presence validation is enabled
  # @param value Object value to validate
  # @return Boolean true if value is valid, false otherwise
  def self.validate(value, validation)
    errors = []
    if validation.presence
      errors << "can't be blank" if value.nil? || (value.is_a?(String) && value.strip.length == 0)
    end
    errors
  end

  def self.validation_rule_class
    AttrValidator::ValidationRules::PresenceValidationRule
  end

end
