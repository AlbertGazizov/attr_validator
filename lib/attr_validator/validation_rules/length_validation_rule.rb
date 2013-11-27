class AttrValidator::ValidationRules::LengthValidationRule
  attr_accessor :min, :max, :equal_to, :not_equal_to

  def initialize(attrs)
    AttrValidator::ArgsValidator.is_hash!(attrs, :validation_rule)
    self.min          = attrs.delete(:min) if attrs[:min]
    self.max          = attrs.delete(:max) if attrs[:max]
    self.equal_to     = attrs.delete(:equal_to) if attrs[:equal_to]
    self.not_equal_to = attrs.delete(:not_equal_to) if attrs[:not_equal_to]
    AttrValidator::ArgsValidator.is_empty!(attrs, :validation_rule, "validation rule has invalid options: #{attrs}")
  end

  def min=(number)
    AttrValidator::ArgsValidator.is_integer!(number, :max)
    @min = number
  end

  def max=(number)
    AttrValidator::ArgsValidator.is_integer!(number, :max)
    @max = number
  end

  def equal_to=(number)
    AttrValidator::ArgsValidator.is_integer!(number, :equal_to)
    @equal_to = number
  end

  def not_equal_to=(number)
    AttrValidator::ArgsValidator.is_integer!(number, :not_equal_to)
    @not_equal_to = number
  end

  def to_s
    "min: #{min}, max: #{max}, equal_to: #{equal_to}, not_equal_to: #{not_equal_to}"
  end
end
