class AttrValidator::ValidationRules::EmailValidationRule
  attr_accessor :email

  def initialize(attrs = {})
    self.email = attrs[:email]
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
