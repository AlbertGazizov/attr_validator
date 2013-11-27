require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validators::Validator do
  describe ".name" do
    it "should return correct validator name" do
      AttrValidator::Validators::PresenceValidator.name.should == 'presence'
    end
  end
end
