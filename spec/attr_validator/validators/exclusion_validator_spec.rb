require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::ExclusionValidator do
  let(:validation) { AttrValidator::Validations::ExclusionValidation.new(in: [:new, :old, :medium]) }
  let(:errors)     { AttrValidator::Errors.new }

  describe "#validate" do
    it "should return empty errors if value is valid" do

      AttrValidator::Validators::ExclusionValidator.validate(:type, :wrong_type, validation, errors)
      errors[:type].should be_empty
    end

    it "should return errors if value is invalid" do
      AttrValidator::Validators::ExclusionValidator.validate(:type, :new, validation, errors)
      errors[:type].should == ["shouldn't be included in [:new, :old, :medium]"]
    end
  end
end
