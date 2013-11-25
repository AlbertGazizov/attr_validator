class AttrValidator::ValidationRules::RegexpValidationRule
  attr_accessor :regexp

  def initialize(attrs = {})
    self.regexp = attrs[:regexp] if attrs[:regexp]
  end

  def regexp=(regexp)
    @regexp = Regexp.new(regexp)
  end

  def to_s
    "regexp: #{regexp}"
  end
end
