class AttrValidator::Validators::UrlValidator < AttrValidator::Validators::Validator

  URL_REGEXP = /^(https?:\/\/)?([\w\.]+)\.([a-z]{2,6}\.?)(\/[\w\.]*)*\/?$/

  # Validates that value actually is valid url
  # @param value String object to validate
  # @return Boolean true if object is url, false otherwise
  def self.validate(value, validation)
    errors = []
    if validation.url
      errors << "invalid url" unless !!URL_REGEXP.match(value)
    end
    errors
  end

  def self.validation_rule_class
    AttrValidator::ValidationRules::UrlValidationRule
  end

end
