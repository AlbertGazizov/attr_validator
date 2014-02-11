class AttrValidator::Validators::ExclusionValidator

  # Validates that value isn't in the specified list validation.in
  # @param value Object object to validate exclusion
  # @return Boolean true if object is excluded, false otherwise
  def self.validate(value, options)
    return [] if value.nil?

    errors = []
    if options[:in]
      if options[:in].include?(value)
        errors << (options[:message] || AttrValidator::I18n.t("shouldn't be included in #{options[:in]}"))
      end
    end
    errors
  end

  def self.validate_options(options)
    AttrValidator::ArgsValidator.is_hash!(options, :validation_rule)
    AttrValidator::ArgsValidator.has_only_allowed_keys!(options, [:in, :message], :validation_rule)
  end

end
