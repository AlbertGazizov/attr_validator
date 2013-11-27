require 'spec_helper'
require 'attr_validator'

describe AttrValidator::ValidationRules::RegexpValidationRule do

  describe "#new" do
    it "should raise error if validation attributes are invalid" do
      lambda do
        AttrValidator::ValidationRules::RegexpValidationRule.new({})
      end.should raise_error("validation_rule should be a String or Regexp")
    end
  end

end
