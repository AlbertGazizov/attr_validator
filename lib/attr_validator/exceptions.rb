module AttrValidator::Exceptions
  # Thrown when object has validation errors
  class ValidationError < StandardError
    attr_reader :errors

    def initialize(message, errors)
      @errors = errors
      super(message)
    end
  end


  # Thrown when validator is not defined
  class MissingValidatorError < StandardError; end
end
