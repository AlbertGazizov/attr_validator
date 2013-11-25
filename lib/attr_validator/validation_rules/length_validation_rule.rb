class AttrValidator::ValidationRules::LengthValidationRule
  attr_accessor :min, :max, :equal_to, :not_equal_to

  def initialize(attrs = {})
    self.min          = attrs[:min] if attrs[:min]
    self.max          = attrs[:max] if attrs[:max]
    self.equal_to     = attrs[:equal_to] if attrs[:equal_to]
    self.not_equal_to = attrs[:not_equal_to] if attrs[:not_equal_to]
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
