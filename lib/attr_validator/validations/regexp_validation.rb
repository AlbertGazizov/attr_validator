class Forms::FieldValidations::RegexpValidation
  attr_accessor :regexp

  def regexp=(regexp)
    @regexp = Regexp.new(regexp)
  end

  def to_s
    "regexp: #{regexp}"
  end
end
