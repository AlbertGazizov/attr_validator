class AttrValidator::Validators::ExclusionValidator < AttrValidator::Validators::Validator

  # Validates that value isn't in the specified list validation.in
  # @param value Object object to validate exclusion
  # @return Boolean true if object is excluded, false otherwise
  def self.validate(attr_name, value, validation, errors)
    if validation.in
      errors.add(attr_name, "shouldn't be included in #{validation.in}") if validation.in.include?(value)
    end
    errors
  end

end
