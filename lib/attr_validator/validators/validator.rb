class AttrValidator::Validators::Validator
  def self.validate(attr_name, value, validation, errors)
    raise NotImplementedError, "Should be implemented in derived class"
  end

  def self.validation_rule_class
    raise NotImplementedError, "Should be implemented in derived class"
  end
end
