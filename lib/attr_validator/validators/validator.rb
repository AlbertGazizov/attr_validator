class AttrValidator::Validators::Validator
  def self.name
    class_name = self.to_s
    if i = class_name.rindex('::')
      class_name = class_name[(i+2)..-1]
    end
    class_name.gsub('Validator', '').downcase
  end

  def self.validate(attr_name, value, validation, errors)
    raise NotImplementedError, "Should be implemented in derived class"
  end

  def self.validation_rule_class
    raise NotImplementedError, "Should be implemented in derived class"
  end
end
