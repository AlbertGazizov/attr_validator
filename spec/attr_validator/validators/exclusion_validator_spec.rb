require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::ExclusionValidator do
  let(:validation_rule) { AttrValidator::ValidationRules::ExclusionValidationRule.new(in: [:new, :old, :medium]) }

  describe "#validate" do
    it "should return empty errors if value is valid" do
      errors = AttrValidator::Validators::ExclusionValidator.validate(:wrong_type, validation_rule)
      errors.should be_empty
    end

    it "should return errors if value is invalid" do
      errors = AttrValidator::Validators::ExclusionValidator.validate(:new, validation_rule)
      errors.should == ["shouldn't be included in [:new, :old, :medium]"]
    end
  end
end
