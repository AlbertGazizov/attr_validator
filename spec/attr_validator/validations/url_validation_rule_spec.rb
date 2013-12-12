require 'spec_helper'
require 'attr_validator'

describe AttrValidator::ValidationRules::UrlValidationRule do

  describe "#new" do
    it "should raise error if validation attributes are invalid" do
      lambda do
        AttrValidator::ValidationRules::UrlValidationRule.new("asdf")
      end.should raise_error("validation_rule should be a Boolean")
    end
  end

end
