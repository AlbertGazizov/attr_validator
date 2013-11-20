class AttrValidator::Validators::Validator
  def self.validate(attr_name, value, validation)
    raise NotImplementedError, "Should be implemented in derived class"
  end

  def self.validate!(attr_name, value, validation)
    if errors = validate(attr_name, value, validation)
      raise ValidationError.new(errors)
    end
  end
end
