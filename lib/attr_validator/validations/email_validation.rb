class Forms::FieldValidations::EmailValidation
  attr_accessor :email

  def email=(flag)
    AttrValidator::ArgsValidator.is_boolean(flag)
    @email = flag
  end

  def from_hash(hash)
  end

  def to_s
    "email: #{email}"
  end
end
