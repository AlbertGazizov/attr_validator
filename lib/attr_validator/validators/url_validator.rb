class AttrValidator::Validators::UrlValidator
  URL_REGEXP = /^(https?:\/\/)?([\w\.]+)\.([a-z]{2,6}\.?)(\/[\w\.]*)*\/?$/

  # Validates that string is a valid url
  # @param value [String] string to validate
  # @param url [Boolean] should given string be url or not
  # @return [Array] empty array if number is valid, array of error messages otherwise
  def self.validate(value, url_flag)
    return [] if value.nil?

    errors = []
    if url_flag
      errors << AttrValidator::I18n.t("invalid url") unless !!URL_REGEXP.match(value)
    else
      errors << AttrValidator::I18n.t("can't be a url") if !!URL_REGEXP.match(value)
    end

    errors
  end

  def self.validate_options(url_flag)
    AttrValidator::ArgsValidator.is_boolean!(url_flag, :validation_rule)
  end

end
