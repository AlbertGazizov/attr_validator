# Helper class for arguments validation
module AttrValidator::ArgsValidator
  class << self

    # Checks that specifid +obj+ is a symbol
    # @param obj some object
    # @param obj_name object's name, used to clarify error causer in exception
    def is_symbol!(obj, obj_name)
      unless obj.is_a?(Symbol)
        raise ArgumentError, "#{obj_name} should be a Symbol"
      end
    end

    # Checks that specifid +obj+ is a boolean
    # @param obj some object
    # @param obj_name object's name, used to clarify error causer in exception
    def is_boolean!(obj, obj_name)
      if !obj.is_a?(TrueClass) && !obj.is_a?(FalseClass)
        raise ArgumentError, "#{obj_name} should be a Boolean"
      end
    end

    # Checks that specifid +obj+ is an integer
    # @param obj some object
    # @param obj_name object's name, used to clarify error causer in exception
    def is_integer!(obj, obj_name)
      unless obj.is_a?(Integer)
        raise ArgumentError, "#{obj_name} should be an Integer"
      end
    end

    # Checks that specifid +obj+ is an Array
    # @param obj some object
    # @param obj_name object's name, used to clarify error causer in exception
    def is_array!(obj, obj_name)
      unless obj.is_a?(Array)
        raise ArgumentError, "#{obj_name} should be an Array"
      end
    end

    # Checks that specifid +obj+ is a Hash
    # @param obj some object
    # @param obj_name object's name, used to clarify error causer in exception
    def is_hash!(obj, obj_name)
      unless obj.is_a?(Hash)
        raise ArgumentError, "#{obj_name} should be a Hash"
      end
    end

    # Checks that specifid +hash+ has a specified +key+
    # @param hash some hash
    # @param key hash's key
    def has_key!(hash, key)
      unless hash.has_key?(key)
        raise ArgumentError, "#{hash} should has #{key} key"
      end
    end

    def not_nil!(obj, obj_name)
      if obj.nil?
        raise ArgumentError, "#{obj_name} can't be nil"
      end
    end

    # Checks that specified +block+ is given
    # @param block some block
    def block_given!(block)
      unless block
        raise ArgumentError, "Block should be given"
      end
    end
  end
end
