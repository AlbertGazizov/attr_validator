require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::LengthValidator do
  describe "#validate" do
    it "should return empty errors if text has valid length" do
      validation_rule = AttrValidator::ValidationRules::LengthValidationRule.new(max: 5, min: 3)
      errors = AttrValidator::Validators::LengthValidator.validate('home', validation_rule)
      errors.should be_empty
    end

    it "should return errors if value has invalid max length" do
      validation_rule = AttrValidator::ValidationRules::LengthValidationRule.new(max: 5)
      errors = AttrValidator::Validators::LengthValidator.validate('long title', validation_rule)
      errors.should == ["can't be more than 5"]
    end

    it "should return errors if value has invalid min length" do
      validation_rule = AttrValidator::ValidationRules::LengthValidationRule.new(min: 3)
      errors = AttrValidator::Validators::LengthValidator.validate('ya', validation_rule)
      errors.should == ["can't be less than 3"]
    end

    it "should return errors if value has invalid equal_to length" do
      validation_rule = AttrValidator::ValidationRules::LengthValidationRule.new(equal_to: 3)
      errors = AttrValidator::Validators::LengthValidator.validate('ya', validation_rule)
      errors.should == ["should be equal to 3"]
    end

    it "should return errors if value has invalid not_equal_to length" do
      validation_rule = AttrValidator::ValidationRules::LengthValidationRule.new(not_equal_to: 3)
      errors = AttrValidator::Validators::LengthValidator.validate('yad', validation_rule)
      errors.should == ["shouldn't be equal to 3"]
    end
  end
end
