class AttrValidator::Validations::ExclusionValidation
  attr_accessor :in

  def initialize(attrs)
    self.in = attrs[:in]
  end

  def in=(list)
    AttrValidator::ArgsValidator.is_array!(list, :list)
    @in = list
  end

  def to_s
    "in: #{self.in}"
  end
end
