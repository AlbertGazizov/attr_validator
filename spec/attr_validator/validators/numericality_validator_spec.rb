require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::NumericalityValidator do
  describe "#validate" do
    it "should return empty errors if number is valid" do
      validation_rule = AttrValidator::ValidationRules::NumericalityValidationRule.new(less_than: 5, greater_than: 3)
      errors = AttrValidator::Validators::NumericalityValidator.validate(4, validation_rule)
      errors.should be_empty
    end

    it "should return errors if value is less than needed" do
      validation_rule = AttrValidator::ValidationRules::NumericalityValidationRule.new(greater_than: 5)
      errors = AttrValidator::Validators::NumericalityValidator.validate(5, validation_rule)
      errors.should == ["should be greater than 5"]
    end

    it "should return errors if value is less than or equal to what needed" do
      validation_rule = AttrValidator::ValidationRules::NumericalityValidationRule.new(greater_than_or_equal_to: 5)
      errors = AttrValidator::Validators::NumericalityValidator.validate(4, validation_rule)
      errors.should == ["should be greater than or equal to 5"]
    end

    it "should return errors if value is greater than needed" do
      validation_rule = AttrValidator::ValidationRules::NumericalityValidationRule.new(less_than: 5)
      errors = AttrValidator::Validators::NumericalityValidator.validate(5, validation_rule)
      errors.should == ["should be less than 5"]
    end

    it "should return errors if value is greater than or equal to what needed" do
      validation_rule = AttrValidator::ValidationRules::NumericalityValidationRule.new(less_than_or_equal_to: 5)
      errors = AttrValidator::Validators::NumericalityValidator.validate(6, validation_rule)
      errors.should == ["should be less than or equal to 5"]
    end

    it "should return errors if value is not even" do
      validation_rule = AttrValidator::ValidationRules::NumericalityValidationRule.new(even: true)
      errors = AttrValidator::Validators::NumericalityValidator.validate(7, validation_rule)
      errors.should == ["should be even number"]
    end

    it "should return errors if value is not odd" do
      validation_rule = AttrValidator::ValidationRules::NumericalityValidationRule.new(odd: true)
      errors = AttrValidator::Validators::NumericalityValidator.validate(6, validation_rule)
      errors.should == ["should be odd number"]
    end

  end
end
