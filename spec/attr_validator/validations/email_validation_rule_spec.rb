require 'spec_helper'
require 'attr_validator'

describe AttrValidator::ValidationRules::EmailValidationRule do

  describe "#new" do
    it "should raise error if validation attributes are invalid" do
      lambda do
        AttrValidator::ValidationRules::EmailValidationRule.new("asdf")
      end.should raise_error("validation_rule should be a Boolean")
    end
  end

end
