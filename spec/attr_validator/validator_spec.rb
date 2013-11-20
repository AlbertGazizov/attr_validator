require 'spec_helper'
require 'attr_validator'

describe AttrValidator::Validator do
  describe "#validate" do
    class Contact
      attr_accessor :first_name, :last_name, :position
    end

    class ContactValidator
      include AttrValidator::Validator

      validates :first_name, presence: true, length: { min: 5, max: 7 }
      validates :last_name,  length: { equal_to: 5 }
      validates :position,   length: { not_equal_to: 5 }
      validates :age,        numericality: { greater_than: 0, less_than: 150 }
      validates :type,       numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
      validates :email,      email: true
      validates :color,      regexp: /#\w{6}/
      validates :status,     inclusion: { in: [:new, :lead] }
      validates :stage,      exclusion: { in: [:wrong, :bad] }
    end

    it "should return empty errors if object is valid" do
      contact = Contact.new
      contact.first_name = "John"
      contact.last_name  = "Smith"
      contact.position   = "Team Lead"
      contact.age        = 35
      contact.type       = 2
      contact.email      = "johh.smith@example.com"
      contact.color      = "#DDD333"
      contact.status     = :lead
      contact.stage      = :good

      errors = ContactValidator.new.validate(contact)
      errors.should be_empty
    end

    it "should return validation errors if object is invalid" do
      contact = Contact.new
      contact.first_name = nil
      contact.last_name  = "Sm"
      contact.position   = "develp"
      contact.age        = -1
      contact.type       = 7
      contact.email      = "johh.com"
      contact.color      = "DDD333"
      contact.status     = :left
      contact.stage      = :bad

      errors = ContactValidator.new.validate(contact)
      errors.to_hash.should == {
        first_name: ["can't be blank"],
      }
    end
  end

end
