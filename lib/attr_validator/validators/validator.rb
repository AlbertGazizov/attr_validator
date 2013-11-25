class AttrValidator::Validators::Validator
  def self.validate(attr_name, value, validation, errors)
    raise NotImplementedError, "Should be implemented in derived class"
  end

  def self.validate!(attr_name, value, validation, errors)
    if errors = validate(attr_name, value, validation, errors)
      raise ValidationError.new(errors)
    end
  end
end
