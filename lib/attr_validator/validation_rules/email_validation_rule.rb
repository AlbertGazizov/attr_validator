class AttrValidator::ValidationRules::EmailValidationRule
  attr_accessor :email

  def initialize(email_flag = false)
    self.email = email_flag
  end

  def email=(flag)
    AttrValidator::ArgsValidator.is_boolean!(flag, :email)
    @email = flag
  end

  def from_hash(hash)
  end

  def to_s
    "email: #{email}"
  end
end
