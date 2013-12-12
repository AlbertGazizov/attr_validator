require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::UrlValidator do
  let(:validation_rule) { AttrValidator::ValidationRules::UrlValidationRule.new(true) }

  describe "#validate" do
    it "should return empty errors if email is valid" do
      errors = AttrValidator::Validators::UrlValidator.validate('example.com', validation_rule)
      errors.should be_empty
    end

    it "should return errors if value is invalid" do
      errors = AttrValidator::Validators::UrlValidator.validate(':123asdffd.com', validation_rule)
      errors.should == ["invalid url"]
    end
  end
end
