require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::RegexpValidator do
  describe ".validate" do
    it "should return empty errors if value is valid" do
      errors = AttrValidator::Validators::RegexpValidator.validate('#aaa', /#\w{3,6}/)
      errors.should be_empty
    end

    it "should return errors if value is invalid" do
      errors = AttrValidator::Validators::RegexpValidator.validate('asdf', /#\w{3,6}/)
      errors.should == ["doens't match defined format"]
    end
  end

  describe ".validate_options" do
    it "should raise error if validation attributes are invalid" do
      lambda do
        AttrValidator::Validators::RegexpValidator.validate_options({})
      end.should raise_error("validation_rule should be a String or Regexp")
    end
  end
end
