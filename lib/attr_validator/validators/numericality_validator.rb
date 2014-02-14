class AttrValidator::Validators::NumericalityValidator

  # Validates that +number+ satisfies all validation rules defined in +options+
  # @param number  [Numeric] number to validate
  # @param options [Hash]    validation rules
  # @return [Array] empty array if number is valid, array of error messages otherwise
  def self.validate(number, options)
    return [] if number.nil?

    errors = []
    if options[:greater_than]
      errors << AttrValidator::I18n.t('errors.should_be_greater_than', number: options[:greater_than]) if number <= options[:greater_than]
    end
    if options[:greater_than_or_equal_to]
      errors << AttrValidator::I18n.t('errors.should_be_greater_than_or_equal_to', number: options[:greater_than_or_equal_to]) if number < options[:greater_than_or_equal_to]
    end
    if options[:less_than]
      errors << AttrValidator::I18n.t('errors.should_be_less_than', number: options[:less_than]) if number >= options[:less_than]
    end
    if options[:less_than_or_equal_to]
      errors << AttrValidator::I18n.t('errors.should_be_less_than_or_equal_to', number: options[:less_than_or_equal_to]) if number > options[:less_than_or_equal_to]
    end
    if options[:even]
      errors << AttrValidator::I18n.t('errors.should_be_even') unless number.even?
    end
    if options[:odd]
      errors << AttrValidator::I18n.t('errors.should_be_odd') unless number.odd?
    end
    errors
  end

  def self.validate_options(options)
    AttrValidator::ArgsValidator.is_hash!(options, :validation_rule)
    AttrValidator::ArgsValidator.has_only_allowed_keys!(options, [
      :greater_than, :greater_than_or_equal_to, :less_than, :less_than_or_equal_to, :even, :odd
    ], :validation_rule)
  end

end
