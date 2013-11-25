require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::InclusionValidator do
  let(:validation_rule) { AttrValidator::ValidationRules::InclusionValidationRule.new(in: [:new, :old, :medium]) }

  describe "#validate" do
    it "should return empty errors if value is valid" do
      errors = AttrValidator::Validators::InclusionValidator.validate(:old, validation_rule)
      errors.should be_empty
    end

    it "should return errors if value is invalid" do
      errors = AttrValidator::Validators::InclusionValidator.validate(:wrong_type, validation_rule)
      errors.should == ["should be included in [:new, :old, :medium]"]
    end
  end
end
