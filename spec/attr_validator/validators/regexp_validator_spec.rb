require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::RegexpValidator do
  let(:validation_rule) { AttrValidator::ValidationRules::RegexpValidationRule.new(regexp: /#\w{3,6}/) }
  let(:errors)     { AttrValidator::Errors.new }

  describe "#validate" do
    it "should return empty errors if value is valid" do
      AttrValidator::Validators::RegexpValidator.validate(:color, '#aaa', validation_rule, errors)
      errors[:color].should be_empty
    end

    it "should return errors if value is invalid" do
      AttrValidator::Validators::RegexpValidator.validate(:color, 'asdf', validation_rule, errors)
      errors[:color].should == ["doens't match defined format"]
    end
  end
end
