class AttrValidator::ValidationRules::PresenceValidationRule
  attr_accessor :presence

  def initialize(presence_flag = false)
    self.presence = presence_flag
  end

  def presence=(flag)
    AttrValidator::ArgsValidator.is_boolean!(flag, :presence)
    @presence = flag
  end

  def to_s
    "presence: #{presence}"
  end
end
