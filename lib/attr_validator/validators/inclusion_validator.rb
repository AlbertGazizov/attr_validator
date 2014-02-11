class AttrValidator::Validators::InclusionValidator

  # Validates that value inscludes in specified validation.inclusion
  # @param value Object object to validate inclusion
  # @return Boolean true if object is included, false otherwise
  def self.validate(value, options)
    return [] if value.nil?

    errors = []
    if options[:in]
      unless options[:in].include?(value)
        errors << (options[:message] || AttrValidator::I18n.t("should be included in #{options[:in]}"))
      end
    end
    errors
  end

  def self.validate_options(options)
    AttrValidator::ArgsValidator.is_hash!(options, :validation_rule)
    AttrValidator::ArgsValidator.has_only_allowed_keys!(options, [:in, :message], :validation_rule)
  end

end
