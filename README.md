# AttrValidator [![Build Status](https://travis-ci.org/AlbertGazizov/attr_validator.png)](https://travis-ci.org/AlbertGazizov/attr_validator) [![Code Climate](https://codeclimate.com/github/AlbertGazizov/attr_validator.png)](https://codeclimate.com/github/AlbertGazizov/attr_validator)


AttrValidator is simple library for validating ruby objects.
The main idea of the gem is separate all object validation logic from the object itself

## Usage
Lets say you have the following class and you wan to validate objects of this class
```ruby
class Contact
  attr_accessor :first_name, :last_name, :position, :age, :type, :email, :color, :status, :stage, :description, :companies
end
```
To validate objects of the Contact class define a validator:
```ruby
class ContactValidator
  include AttrValidator::Validator

  validates :first_name, presence: true, length: { min: 4, max: 7 }
  validates :last_name,  length: { equal_to: 5 }
  validates :position,   length: { not_equal_to: 5 }
  validates :age,        numericality: { greater_than: 0, less_than: 150 }
  validates :type,       numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :email,      email: true
  validates :color,      regexp: /#\w{6}/
  validates :status,     inclusion: { in: [:new, :lead] }
  validates :stage,      exclusion: { in: [:wrong, :bad] }

  validate_associated :companies, validator: CompanyValidator

  validate :check_description

  def check_description(entity, errors)
    if entity.description.nil?
      errors.add(:description, "can't be empty")
    end
  end
end
```

Instantiate the validator and pass a contact object inside:
```ruby
errors = ContactValidator.new.validate(contact)
```
errors is an object which contains all validation errors
if object is valid then errors.empty? will be true
if object is invalid then errors.to_hash will return all validation errors

## Installation

Add this line to your application's Gemfile:

    gem 'attr_validator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attr_validator

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# TODO
2. Document methods
3. Write doc in readme
