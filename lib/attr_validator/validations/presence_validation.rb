class Forms::FieldValidations::PresenceValidation
  attr_accessor :presence

  def presence=(flag)
    ArgsValidator.is_boolean(flag, :flag)
    @presence = flag
  end

  def to_s
    "presence: #{presence}"
  end
end
