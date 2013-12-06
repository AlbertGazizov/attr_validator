module AttrValidator::ValidateAssociated
  extend ActiveSupport::Concern

  included do
    class_attribute :associated_validations
  end

  module ClassMethods
    def validate_associated(association_name, options)
      Utils::ArgsValidator.not_nil(options[:validator], :validator)
      Utils::ArgsValidator.is_class(options[:validator], :validator)
      Utils::ArgsValidator.is_symbol_or_block(options[:if], :if) if options[:if]
      Utils::ArgsValidator.is_symbol_or_block(options[:unless], :unless) if options[:unless]

      self.associated_validations ||= {}
      self.associated_validations[association_name] = options
    end
  end

  private

  def validate_associations
    self.associated_validations ||= {}
    self.associated_validations.each do |association_name, options|
      next if skip_validation?(options)

      validator = options[:validator].new
      children = @entity.send(association_name)
      if children.is_a?(Array)
        validate_children(validator, children)
      elsif children
        validate_child(validator, children)
      end
    end
  end

  def skip_validation?(options)
    if options[:if]
      if options[:if].is_a?(Symbol)
        true unless self.send(options[:if])
      elsif options[:if].is_a?(Proc)
        true unless self.instance_exec(&options[:if])
      else
        false
      end
    elsif options[:unless]
      if options[:unless].is_a?(Symbol)
        true if self.send(options[:unless])
      elsif options[:unless].is_a?(Proc)
        true if self.instance_exec(&options[:unless])
      else
        false
      end
    end
  end

  def validate_children(validator, children)
    children_errors = []
    children.each do |child|
      children_errors << validator.validate(child).to_hash
    end
    unless children_errors.all?(&:empty?)
      errors.messages["#{association_name}_errors".to_sym] ||= []
      errors.messages["#{association_name}_errors".to_sym] += children_errors
    end
  end

  def validate_child(validator, child)
    child_errors = validator.validate(child).to_hash
    unless child_errors.empty?
      errors.messages["#{association_name}_errors".to_sym] = child_errors
    end
  end

end
