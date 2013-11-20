class AttrValidator::Validators::InclusionValidator < AttrValidator::Validators::Validator

  # Validates that value inscludes in specified validation.inclusion
  # @param value Object object to validate inclusion
  # @return Boolean true if object is included, false otherwise
  def self.validate(attr_name, value, validation)
    if validation.in
      errors.add(attr_name, "should be included in the list #{validation.in}") unless validation.in.includes?(value)
    end
    errors
  end

end
