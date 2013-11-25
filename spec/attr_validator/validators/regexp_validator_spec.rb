require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::RegexpValidator do
  let(:validation_rule) { AttrValidator::ValidationRules::RegexpValidationRule.new(/#\w{3,6}/) }

  describe "#validate" do
    it "should return empty errors if value is valid" do
      errors = AttrValidator::Validators::RegexpValidator.validate('#aaa', validation_rule)
      errors.should be_empty
    end

    it "should return errors if value is invalid" do
      errors = AttrValidator::Validators::RegexpValidator.validate('asdf', validation_rule)
      errors.should == ["doens't match defined format"]
    end
  end
end
