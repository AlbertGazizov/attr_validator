class AttrValidator::Validators::RegexpValidator < AttrValidator::Validators::Validator

  # Validates that given value match regexp if regexp validation exists
  # @param value String value to match with regexp
  # @return Boolean true if value is valid, false otherwise
  def self.validate(attr_name, value, validation, errors)
    if validation.regexp
      errors.add(attr_name, "doens't match defined format") unless !!validation.regexp.match(value)
    end
    errors
  end

end
