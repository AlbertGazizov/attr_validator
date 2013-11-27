require 'spec_helper'
require 'attr_validator'

describe AttrValidator::ValidationRules::LengthValidationRule do

  describe "#new" do
    it "should raise error if validation attributes are invalid" do
      lambda do
        AttrValidator::ValidationRules::LengthValidationRule.new(max: 5, wrong_attr: 3)
      end.should raise_error("validation_rule has unacceptable options [:wrong_attr]")
    end
  end

end