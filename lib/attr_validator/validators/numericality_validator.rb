class AttrValidator::Validators::NumericalityValidator < AttrValidator::Validators::Validator

  # Validates that +number+ satisfies all validation_rule defined in +validation_rule+
  # @param number Integer number to validate
  # @return Boolean true if number is valid, false otherwise
  def self.validate(number, validation_rule)
    errors = []
    if validation_rule.greater_than
      errors << "should be greater than #{validation_rule.greater_than}" if number <= validation_rule.greater_than
    end
    if validation_rule.greater_than_or_equal_to
      errors << "should be greater than or equal to #{validation_rule.greater_than_or_equal_to}" if number < validation_rule.greater_than_or_equal_to
    end
    if validation_rule.less_than
      errors << "should be less than #{validation_rule.less_than}" if number >= validation_rule.less_than
    end
    if validation_rule.less_than_or_equal_to
      errors << "should be less than or equal to #{validation_rule.less_than_or_equal_to}" if number > validation_rule.less_than_or_equal_to
    end
    if validation_rule.even
      errors << "should be even number" unless number.even?
    end
    if validation_rule.odd
      errors << "should be odd number" unless number.odd?
    end
    errors
  end

  def self.validation_rule_class
    AttrValidator::ValidationRules::NumericalityValidationRule
  end

end
