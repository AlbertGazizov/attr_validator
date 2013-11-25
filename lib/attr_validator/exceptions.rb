module AttrValidator::Exceptions
  # Thrown when object has validation errors
  class ValidationError < StandardError; end

  # Thrown when validator is not defined
  class MissingValidatorError < StandardError; end
end
