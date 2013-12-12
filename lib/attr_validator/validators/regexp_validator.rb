class AttrValidator::Validators::RegexpValidator < AttrValidator::Validators::Validator

  # Validates that given value match regexp if regexp validation exists
  # @param value String value to match with regexp
  # @return Boolean true if value is valid, false otherwise
  def self.validate(value, validation)
    return [] if valid.nil?

    errors = []
    if validation.regexp
      errors << "doens't match defined format" unless !!validation.regexp.match(value)
    end
    errors
  end

  def self.validation_rule_class
    AttrValidator::ValidationRules::RegexpValidationRule
  end

end
