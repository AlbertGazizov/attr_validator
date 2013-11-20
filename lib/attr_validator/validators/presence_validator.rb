class AttrValidator::Validators::PresenceValidator < AttrValidator::Validators::Validator

  # Validates that given string present if presence validation is enabled
  # @param value Object value to validate
  # @return Boolean true if value is valid, false otherwise
  def self.validate(attr_name, value, validation)
    if validation.presence
      errors.add(attr_name, "can't be blank") unless value.present?
    end
    errors
  end

end
