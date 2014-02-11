class AttrValidator::Validators::NumericalityValidator

  # Validates that +number+ satisfies all validation rules defined in +options+
  # @param number  [Numeric] number to validate
  # @param options [Hash]    validation rules
  # @return [Array] empty array if number is valid, array of error messages otherwise
  def self.validate(number, options)
    return [] if number.nil?

    errors = []
    if options[:greater_than]
      errors << AttrValidator::I18n.t("should be greater than #{options[:greater_than]}") if number <= options[:greater_than]
    end
    if options[:greater_than_or_equal_to]
      errors << AttrValidator::I18n.t("should be greater than or equal to #{options[:greater_than_or_equal_to]}") if number < options[:greater_than_or_equal_to]
    end
    if options[:less_than]
      errors << AttrValidator::I18n.t("should be less than #{options[:less_than]}") if number >= options[:less_than]
    end
    if options[:less_than_or_equal_to]
      errors << AttrValidator::I18n.t("should be less than or equal to #{options[:less_than_or_equal_to]}") if number > options[:less_than_or_equal_to]
    end
    if options[:even]
      errors << AttrValidator::I18n.t("should be even number") unless number.even?
    end
    if options[:odd]
      errors << AttrValidator::I18n.t("should be odd number") unless number.odd?
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
