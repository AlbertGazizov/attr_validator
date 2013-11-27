class AttrValidator::ValidationRules::RegexpValidationRule
  attr_accessor :regexp

  def initialize(regexp)
    AttrValidator::ArgsValidator.is_string_or_regexp!(regexp, :validation_rule)

    self.regexp = regexp
  end

  def regexp=(regexp)
    AttrValidator::ArgsValidator.not_nil!(regexp, :regexp)
    @regexp = Regexp.new(regexp)
  end

  def to_s
    "regexp: #{regexp}"
  end
end
