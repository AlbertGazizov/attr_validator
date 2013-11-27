class AttrValidator::ValidationRules::InclusionValidationRule
  attr_accessor :in

  def initialize(attrs)
    AttrValidator::ArgsValidator.is_hash!(attrs, :validation_rule)
    self.in = attrs.delete(:in) if attrs[:in]
    AttrValidator::ArgsValidator.is_empty!(attrs, :validation_rule, "validation rule has invalid options: #{attrs}")
  end

  def in=(list)
    AttrValidator::ArgsValidator.is_array!(list, :list)
    @in = list
  end

  def to_s
    "in: #{self.in}"
  end
end
