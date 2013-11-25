class AttrValidator::Validators::InclusionValidator < AttrValidator::Validators::Validator

  # Validates that value inscludes in specified validation.inclusion
  # @param value Object object to validate inclusion
  # @return Boolean true if object is included, false otherwise
  def self.validate(value, validation)
    errors = []
    if validation.in
      errors << "should be included in #{validation.in}" unless validation.in.include?(value)
    end
    errors
  end

  def self.validation_rule_class
    AttrValidator::ValidationRules::InclusionValidationRule
  end

end
