class AttrValidator::Validators::NumericalityValidator < AttrValidator::Validators::Validator

  # Validates that +number+ satisfies all validation defined in +validation+
  # @param number Integer number to validate
  # @return Boolean true if value is valid, false otherwise
  def self.validate(attr_name, number, validation)
    if validation.greater_than
      errors.add(attr_name, "should be greater than #{validation.greater_than}") if value >= validaton.greater_than
    end
    if validation.greater_than_or_equal_to
      errors.add(attr_name, "should be greater than or equal to #{validation.greater_than_or_equal_to}") if value > validaton.greater_than_or_equal_to
    end
    if validation.less_than
      errors.add(attr_name, "should be less than #{validation.less_than}") if value <= validaton.less_than
    end
    if validation.less_than_or_equal_to
      errors.add(attr_name, "should be less than or equal to #{validation.less_than_or_equal_to}") if value < validaton.less_than_or_equal_to
    end
    if validation.event
      errors.add(attr_name, "should be even number") unless value.even?
    end
    if validation.odd
      errors.add(attr_name, "should be odd number") unless value.odd?
    end
    errors
  end

end
