class AttrValidator::ValidationRules::NumericalityValidationRule
  attr_accessor :greater_than, :greater_than_or_equal_to, :less_than, :less_than_or_equal_to, :even, :odd

  def initialize(attrs)
    AttrValidator::ArgsValidator.is_hash!(attrs, :validation_rule)
    AttrValidator::ArgsValidator.has_only_allowed_keys!(attrs, [
      :greater_than, :greater_than_or_equal_to, :less_than, :less_than_or_equal_to, :even, :odd
    ], :validation_rule)

    self.greater_than             = attrs[:greater_than]             if attrs[:greater_than]
    self.greater_than_or_equal_to = attrs[:greater_than_or_equal_to] if attrs[:greater_than_or_equal_to]
    self.less_than                = attrs[:less_than]                if attrs[:less_than]
    self.less_than_or_equal_to    = attrs[:less_than_or_equal_to]    if attrs[:less_than_or_equal_to]
    self.even                     = attrs[:even]                     if attrs[:even]
    self.odd                      = attrs[:odd]                      if attrs[:odd]
  end

  def greater_than=(number)
    AttrValidator::ArgsValidator.is_integer!(number, :greater_than)
    @greater_than = number
  end

  def greater_than_or_equal_to=(number)
    AttrValidator::ArgsValidator.is_integer!(number, :greater_than_or_equal_to)
    @greater_than_or_equal_to = number
  end

  def less_than=(number)
    AttrValidator::ArgsValidator.is_integer!(number, :less_than)
    @less_than = number
  end

  def less_than_or_equal_to=(number)
    AttrValidator::ArgsValidator.is_integer!(number, :less_than_or_equal_to)
    @less_than_or_equal_to = number
  end

  def even=(flag)
    AttrValidator::ArgsValidator.is_boolean!(flag, :even)
    @even = flag
  end

  def odd=(flag)
    AttrValidator::ArgsValidator.is_boolean!(flag, :odd)
    @odd = flag
  end


  def to_s
    "greater_than: #{greater_than}, greater_than_or_equal_to: #{greater_than_or_equal_to},
    less_than: #{less_than}, less_than_or_equal_to: #{less_than_or_equal_to},
    even: #{even}, odd: #{odd}"
  end
end
