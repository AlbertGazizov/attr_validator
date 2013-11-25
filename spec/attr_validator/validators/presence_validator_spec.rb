require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::PresenceValidator do
  describe "#validate" do
    it "should return empty errors if text is not blank" do
      validation_rule = AttrValidator::ValidationRules::PresenceValidationRule.new(true)
      errors = AttrValidator::Validators::PresenceValidator.validate('home', validation_rule)
      errors.should be_empty
    end

    it "should return errors if text is not specified" do
      validation_rule = AttrValidator::ValidationRules::PresenceValidationRule.new(true)
      errors = AttrValidator::Validators::PresenceValidator.validate(" ", validation_rule)
      errors.should == ["can't be blank"]
    end
  end
end
