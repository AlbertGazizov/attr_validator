class AttrValidator::Validators::RegexpValidator

  # Validates that given value match regexp if regexp validation exists
  # @param value String value to match with regexp
  # @param regexp [Regexp] regexp to match
  # @return [Array] empty array if number is valid, array of error messages otherwise
  def self.validate(value, regexp)
    return [] if value.nil?

    errors = []
    unless !!regexp.match(value)
      errors << AttrValidator::I18n.t("doens't match defined format")
    end
    errors
  end

  def self.validate_options(regexp)
    AttrValidator::ArgsValidator.is_string_or_regexp!(regexp, :validation_rule)
  end

end
