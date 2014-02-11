class AttrValidator::Validators::PresenceValidator

  # Validates that given object not nil and not empty
  # if string is given strips it before validating
  # @param value   [Object] object to validate
  # @param presence [Boolean] check presence or not
  # @return [Array] empty array if number is valid, array of error messages otherwise
  def self.validate(value, presence)
    errors = []
    if presence
      if value.nil? || (value.is_a?(String) && value.strip.length == 0)
        errors << AttrValidator::I18n.t("can't be blank")
      end
    else
      if value
        errors << AttrValidator::I18n.t("can't be not blank")
      end
    end
    errors
  end

  def self.validate_options(presence_flag)
    AttrValidator::ArgsValidator.is_boolean!(presence_flag, :validation_rule)
  end

end
