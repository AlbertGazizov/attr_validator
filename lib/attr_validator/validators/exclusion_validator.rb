class AttrValidator::Validators::ExclusionValidator < AttrValidator::Validators::Validator

  # Validates that value isn't in the specified list validation.in
  # @param value Object object to validate exclusion
  # @return Boolean true if object is excluded, false otherwise
  def self.validate(value, validation)
    errors = []
    if validation.in
      errors << "shouldn't be included in #{validation.in}" if validation.in.include?(value)
    end
    errors
  end

  def self.validation_rule_class
    AttrValidator::ValidationRules::ExclusionValidationRule
  end

end
