require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::PresenceValidator do
  let(:errors) { AttrValidator::Errors.new }

  describe "#validate" do
    it "should return empty errors if text is not blank" do
      validation_rule = AttrValidator::ValidationRules::PresenceValidationRule.new(presence: true)
      AttrValidator::Validators::PresenceValidator.validate(:title, 'home', validation_rule, errors)
      errors[:title].should be_empty
    end

    it "should return errors if text is not specified" do
      validation_rule = AttrValidator::ValidationRules::PresenceValidationRule.new(presence: true)
      AttrValidator::Validators::PresenceValidator.validate(:title, " ", validation_rule, errors)
      errors[:title].should == ["can't be blank"]
    end
  end
end
