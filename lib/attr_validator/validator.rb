require 'active_support/concern.rb'
require 'active_support/core_ext/class/attribute.rb'

module AttrValidator::Validator
  extend ActiveSupport::Concern

  included do
    class_attribute :validations
  end

  module ClassMethods
    def validates(*args)
      options = args.pop
      AttrValidator::ArgsValidator.is_hash!(options, "last argument")

      self.validations ||= {}
      args.each do |attr_name|
        self.validations[attr_name] = options.dup
      end
    end
  end

  def validate(entity)
    errors = AttrValidator::Errors.new
    self.validations.each do |attr_name, options|
      options.each do |validator_name, validation_rule_attrs|
        validator = AttrValidator::Validators.find_by_name!(validator_name)
        validation_rule = validator.validation_rule_class.new(validation_rule_attrs)

        attr_value = entity.send(attr_name)
        error_messages = validator.validate(attr_value, validation_rule)
        unless error_messages.empty?
          errors.add_all(attr_name, error_messages)
          break
        end
      end
    end
    errors
  end

  def validate!(entity)
    errors = validate(entity)
    unless errors.empty?
      raise AttrValidator::Exceptions::ValidationError.new(errors)
    end
  end

end
