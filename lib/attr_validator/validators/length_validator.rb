class AttrValidator::Validators::LengthValidator

  # Validates that given object has correct length
  # @param object [#length] object to validate
  # @param options [Hash] validation options, e.g. { min: 2, max: 4, equal_to: 3, not_equal_to: 6 }
  # @return [Array] empty array if object is valid, array of error messages otherwise
  def self.validate(object, options)
    return [] if object.nil?

    errors = []
    if options[:min]
      errors << AttrValidator::I18n.t('errors.can_not_be_less_than', length: options[:min]) if object.length < options[:min]
    end
    if options[:max]
      errors << AttrValidator::I18n.t('errors.can_not_be_more_than', length: options[:max]) if object.length > options[:max]
    end
    if options[:equal_to]
      errors << AttrValidator::I18n.t('errors.should_be_equal_to', length: options[:equal_to]) if object.length != options[:equal_to]
    end
    if options[:not_equal_to]
      errors << AttrValidator::I18n.t('errors.should_not_be_equal_to', length: options[:not_equal_to]) if object.length == options[:not_equal_to]
    end

    errors
  end

  def self.validate_options(options)
    AttrValidator::ArgsValidator.is_hash!(options, :validation_rule)
    AttrValidator::ArgsValidator.has_only_allowed_keys!(options, [:min, :max, :equal_to, :not_equal_to], :validation_rule)
  end

end
