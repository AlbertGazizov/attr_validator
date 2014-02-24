class AttrValidator::Validators::NotNilValidator

  # Validates that given object not nil
  # @param value    [Object] object to validate
  # @param presence [Boolean] validation options, check presence or not
  # @return [Array] empty array if object is valid, array of error messages otherwise
  def self.validate(value, presence)
    errors = []
    if presence
      if value.nil?
        errors << AttrValidator::I18n.t('errors.can_not_be_nil')
      end
    else
      if value
        errors << AttrValidator::I18n.t('errors.should_be_nil')
      end
    end
    errors
  end

  def self.validate_options(presence_flag)
    AttrValidator::ArgsValidator.is_boolean!(presence_flag, :validation_rule)
  end

end
