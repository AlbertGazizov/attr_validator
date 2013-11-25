require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::LengthValidator do
  let(:errors) { AttrValidator::Errors.new }

  describe "#validate" do
    it "should return empty errors if text has valid length" do
      validation_rule = AttrValidator::ValidationRules::LengthValidationRule.new(max: 5, min: 3)
      AttrValidator::Validators::LengthValidator.validate(:title, 'home', validation_rule, errors)
      errors[:title].should be_empty
    end

    it "should return errors if value has invalid max length" do
      validation_rule = AttrValidator::ValidationRules::LengthValidationRule.new(max: 5)
      AttrValidator::Validators::LengthValidator.validate(:title, 'long title', validation_rule, errors)
      errors[:title].should == ["can't be more than 5"]
    end

    it "should return errors if value has invalid min length" do
      validation_rule = AttrValidator::ValidationRules::LengthValidationRule.new(min: 3)
      AttrValidator::Validators::LengthValidator.validate(:title, 'ya', validation_rule, errors)
      errors[:title].should == ["can't be less than 3"]
    end

    it "should return errors if value has invalid equal_to length" do
      validation_rule = AttrValidator::ValidationRules::LengthValidationRule.new(equal_to: 3)
      AttrValidator::Validators::LengthValidator.validate(:title, 'ya', validation_rule, errors)
      errors[:title].should == ["should be equal to 3"]
    end

    it "should return errors if value has invalid not_equal_to length" do
      validation_rule = AttrValidator::ValidationRules::LengthValidationRule.new(not_equal_to: 3)
      AttrValidator::Validators::LengthValidator.validate(:title, 'yad', validation_rule, errors)
      errors[:title].should == ["shouldn't be equal to 3"]
    end
  end
end
