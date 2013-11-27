require 'spec_helper'
require 'attr_validator'

describe AttrValidator::ValidationRules::InclusionValidationRule do

  describe "#new" do
    it "should raise error if validation attributes are invalid" do
      lambda do
        AttrValidator::ValidationRules::InclusionValidationRule.new(wrong_option: false)
      end.should raise_error("validation_rule has unacceptable options [:wrong_option]")
    end
  end

end
