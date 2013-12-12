module AttrValidator::ValidationRules
  require 'attr_validator/validation_rules/exclusion_validation_rule'
  require 'attr_validator/validation_rules/inclusion_validation_rule'
  require 'attr_validator/validation_rules/email_validation_rule'
  require 'attr_validator/validation_rules/url_validation_rule'
  require 'attr_validator/validation_rules/length_validation_rule'
  require 'attr_validator/validation_rules/presence_validation_rule'
  require 'attr_validator/validation_rules/length_validation_rule'
  require 'attr_validator/validation_rules/numericality_validation_rule'
  require 'attr_validator/validation_rules/regexp_validation_rule'

  def self.find_by_validator_name(validator_name)
    validator = AttrValidator::Validators.find_by_name!(validator_name)
    validator.validation_rule_class
  end
end
