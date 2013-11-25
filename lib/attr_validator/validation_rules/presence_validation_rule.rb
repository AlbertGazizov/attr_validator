class AttrValidator::ValidationRules::PresenceValidationRule
  attr_accessor :presence

  def initialize(attrs = {})
    self.presence = attrs[:presence] if attrs[:presence]
  end

  def presence=(flag)
    AttrValidator::ArgsValidator.is_boolean!(flag, :flag)
    @presence = flag
  end

  def to_s
    "presence: #{presence}"
  end
end
