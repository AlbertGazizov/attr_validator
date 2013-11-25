require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::InclusionValidator do
  let(:validation_rule) { AttrValidator::ValidationRules::InclusionValidationRule.new(in: [:new, :old, :medium]) }
  let(:errors)     { AttrValidator::Errors.new }

  describe "#validate" do
    it "should return empty errors if value is valid" do

      AttrValidator::Validators::InclusionValidator.validate(:type, :old, validation_rule, errors)
      errors[:type].should be_empty
    end

    it "should return errors if value is invalid" do
      AttrValidator::Validators::InclusionValidator.validate(:type, :wrong_type, validation_rule, errors)
      errors[:type].should == ["should be included in [:new, :old, :medium]"]
    end
  end
end
