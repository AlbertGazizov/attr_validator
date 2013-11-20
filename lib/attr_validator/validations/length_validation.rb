class Forms::FieldValidations::LengthValidation
  attr_accessor :min, :max, :equal_to, :not_equal_to

  def min=(number)
    ArgsValidator.is_integer(number, :max)
    @min = number
  end

  def max=(number)
    ArgsValidator.is_integer(number, :max)
    @max = number
  end

  def equal_to(number)
    ArgsValidator.is_integer(number, :equal_to)
    @equal_to = number
  end

  def not_equal_to(number)
    ArgsValidator.is_integer(number, :not_equal_to)
    @not_equal_to = number
  end

  def to_s
    "min: #{min}, max: #{max}, equal_to: #{equal_to}, not_equal_to: #{not_equal_to}"
  end
end
