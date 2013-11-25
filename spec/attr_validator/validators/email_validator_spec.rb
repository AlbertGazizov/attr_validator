require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::EmailValidator do
  let(:validation_rule) { AttrValidator::ValidationRules::EmailValidationRule.new(email: true) }
  let(:errors)     { AttrValidator::Errors.new }

  describe "#validate" do
    it "should return empty errors if email is valid" do
      AttrValidator::Validators::EmailValidator.validate(:home_email, 'test@example.com', validation_rule, errors)
      errors[:home_email].should be_empty
    end

    it "should return errors if value is invalid" do
      AttrValidator::Validators::EmailValidator.validate(:home_email, 'test@asdffd', validation_rule, errors)
      errors[:home_email].should == ["invalid email"]
    end
  end
end
