class AttrValidator::Validators::LengthValidator < AttrValidator::Validators::Validator

  # Validates the given string
  # @param string String string to validate
  # @return Boolean true if string is valid, false otherwise
  def self.validate(string, validation)
    errors = []
    if validation.min
      errors << "can't be less than #{validation.min}" if string.length < validation.min
    end
    if validation.max
      errors << "can't be more than #{validation.max}" if string.length > validation.max
    end
    if validation.equal_to
      errors << "should be equal to #{validation.equal_to}" if string.length != validation.equal_to
    end
    if validation.not_equal_to
      errors << "shouldn't be equal to #{validation.not_equal_to}" if string.length == validation.not_equal_to
    end
    errors
  end

  def self.validation_rule_class
    AttrValidator::ValidationRules::LengthValidationRule
  end

end
