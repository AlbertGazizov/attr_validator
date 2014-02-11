require 'active_support/core_ext/string/inflections'

module AttrValidator::Validators
  require 'attr_validator/validators/validator'
  require 'attr_validator/validators/exclusion_validator'
  require 'attr_validator/validators/inclusion_validator'
  require 'attr_validator/validators/email_validator'
  require 'attr_validator/validators/url_validator'
  require 'attr_validator/validators/length_validator'
  require 'attr_validator/validators/numericality_validator'
  require 'attr_validator/validators/presence_validator'
  require 'attr_validator/validators/regexp_validator'

  def self.find_by_name!(validator_name)
    validator_class_name = "#{validator_name.to_s.classify}Validator"
    AttrValidator::Validators.const_get(validator_class_name)
  rescue NameError => e
    raise AttrValidator::Errors::MissingValidatorError, "Validator AttrValidator::Validators::#{validator_class_name} doesn't exist"
  end
end
