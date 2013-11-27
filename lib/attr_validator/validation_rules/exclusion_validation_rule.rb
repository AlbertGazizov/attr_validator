class AttrValidator::ValidationRules::ExclusionValidationRule
  attr_accessor :in

  def initialize(attrs)
    AttrValidator::ArgsValidator.is_hash!(attrs, :validation_rule)
    AttrValidator::ArgsValidator.has_only_allowed_keys!(attrs, [:in], :validation_rule)

    self.in = attrs[:in] if attrs[:in]
  end

  def in=(list)
    AttrValidator::ArgsValidator.is_array!(list, :list)
    @in = list
  end

  def to_s
    "in: #{self.in}"
  end
end
