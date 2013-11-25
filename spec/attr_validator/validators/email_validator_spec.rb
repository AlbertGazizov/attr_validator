require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::EmailValidator do
  let(:validation_rule) { AttrValidator::ValidationRules::EmailValidationRule.new(true) }

  describe "#validate" do
    it "should return empty errors if email is valid" do
      errors = AttrValidator::Validators::EmailValidator.validate('test@example.com', validation_rule)
      errors.should be_empty
    end

    it "should return errors if value is invalid" do
      errors = AttrValidator::Validators::EmailValidator.validate('test@asdffd', validation_rule)
      errors.should == ["invalid email"]
    end
  end
end
