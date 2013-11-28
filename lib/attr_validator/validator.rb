require 'active_support/concern.rb'
require 'active_support/core_ext/class/attribute.rb'

module AttrValidator::Validator
  extend ActiveSupport::Concern

  included do
    class_attribute :validations, :custom_validators
  end

  module ClassMethods
    def validates(*args)
      options = args.pop
      AttrValidator::ArgsValidator.is_hash!(options, "last argument")

      self.validations ||= {}
      args.each do |attr_name|
        add_validations(attr_name, options)
      end
    end

    def validate(method_name = nil, &block)
      self.custom_validators ||= []
      if block_given?
        self.custom_validators << block
      elsif method_name
        AttrValidator::ArgsValidator.is_symbol!(method_name, "validate method name")
        self.custom_validators << method_name
      else
        raise ArgumentError, "method name or block should be given for validate"
      end
    end

    private

    def add_validations(attr_name, options)
      self.validations[attr_name] ||= {}
      options.each do |validator_name, validation_rule_attrs|
        validator = AttrValidator::Validators.find_by_name!(validator_name)
        validation_rule = validator.validation_rule_class.new(validation_rule_attrs)
        self.validations[attr_name][validator] = validation_rule
      end
    end
  end

  def validate(entity)
    errors = AttrValidator::Errors.new
    self.validations ||= {}
    self.custom_validators ||= []

    self.validations.each do |attr_name, validators|
      error_messages = validate_attr(attr_name, entity, validators)
      errors.add_all(attr_name, error_messages) unless error_messages.empty?
    end
    self.custom_validators.each do |custom_validator|
      if custom_validator.is_a?(Symbol)
        self.send(custom_validator, entity, errors)
      else
        custom_validator.call(entity, errors)
      end
    end
    errors
  end

  def validate!(entity)
    errors = validate(entity)
    unless errors.empty?
      raise AttrValidator::Exceptions::ValidationError.new("Validation Error", errors)
    end
  end

  private

  def validate_attr(attr_name, entity, validators)
    attr_value = entity.send(attr_name)
    error_messages = []
    validators.each do |validator, validation_rule|
      error_messages = validator.validate(attr_value, validation_rule)
      break unless error_messages.empty?
    end
    error_messages
  end

end
