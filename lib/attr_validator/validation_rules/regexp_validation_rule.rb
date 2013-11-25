class AttrValidator::ValidationRules::RegexpValidationRule
  attr_accessor :regexp

  def initialize(regexp = nil)
    self.regexp = regexp if regexp
  end

  def regexp=(regexp)
    AttrValidator::ArgsValidator.not_nil!(regexp, :regexp)
    @regexp = Regexp.new(regexp)
  end

  def to_s
    "regexp: #{regexp}"
  end
end
