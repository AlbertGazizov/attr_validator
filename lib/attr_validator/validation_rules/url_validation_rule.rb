class AttrValidator::ValidationRules::UrlValidationRule
  attr_accessor :url

  def initialize(url_flag)
    AttrValidator::ArgsValidator.is_boolean!(url_flag, :validation_rule)

    self.url = url_flag
  end

  def url=(flag)
    AttrValidator::ArgsValidator.is_boolean!(flag, :url)
    @url = flag
  end

  def to_s
    "url: #{url}"
  end
end
