class AttrValidator::Errors
  attr_reader :messages

   def initialize
      @messages = {}
   end

   # Clear the error messages.
   #
   #   errors.full_messages # => ["name can not be nil"]
   #   errors.clear
   #   errors.full_messages # => []
   def clear
     messages.clear
   end

    # Returns +true+ if the error messages include an error for the given key
    # +attribute+, +false+ otherwise.
    #
    #   errors.messages        # => {:name=>["can not be nil"]}
    #   errors.include?(:name) # => true
    #   errors.include?(:age)  # => false
    def include?(attribute)
      (v = messages[attribute]) && v.any?
    end
    # aliases include?
    alias :has_key? :include?

    # Get messages for +key+.
    #
    #   errors.messages   # => {:name=>["can not be nil"]}
    #   errors.get(:name) # => ["can not be nil"]
    #   errors.get(:age)  # => nil
    def get(key)
      messages[key]
    end

    # Set messages for +key+ to +value+.
    #
    #   errors.get(:name) # => ["can not be nil"]
    #   errors.set(:name, ["can't be nil"])
    #   errors.get(:name) # => ["can't be nil"]
    def set(key, value)
      messages[key] = value
    end

    # Delete messages for +key+. Returns the deleted messages.
    #
    #   errors.get(:name)    # => ["can not be nil"]
    #   errors.delete(:name) # => ["can not be nil"]
    #   errors.get(:name)    # => nil
    def delete(key)
      messages.delete(key)
    end

    # When passed a symbol or a name of a method, returns an array of errors
    # for the method.
    #
    #   errors[:name]  # => ["can not be nil"]
    #   errors['name'] # => ["can not be nil"]
    def [](attribute)
      get(attribute.to_sym) || set(attribute.to_sym, [])
    end

    # Adds to the supplied attribute the supplied error message.
    #
    #   errors[:name] = "must be set"
    #   errors[:name] # => ['must be set']
    def []=(attribute, error)
      self[attribute] << error
    end

    # Iterates through each error key, value pair in the error messages hash.
    # Yields the attribute and the error for that attribute. If the attribute
    # has more than one error message, yields once for each error message.
    #
    #   errors.add(:name, "can't be blank")
    #   errors.each do |attribute, error|
    #     # Will yield :name and "can't be blank"
    #   end
    #
    #   errors.add(:name, "must be specified")
    #   errors.each do |attribute, error|
    #     # Will yield :name and "can't be blank"
    #     # then yield :name and "must be specified"
    #   end
    def each
      messages.each_key do |attribute|
        self[attribute].each { |error| yield attribute, error }
      end
    end

    # Returns the number of error messages.
    #
    #   errors.add(:name, "can't be blank")
    #   errors.size # => 1
    #   errors.add(:name, "must be specified")
    #   errors.size # => 2
    def size
      values.flatten.size
    end

    # Returns all message values.
    #
    #   errors.messages # => {:name=>["can not be nil", "must be specified"]}
    #   errors.values   # => [["can not be nil", "must be specified"]]
    def values
      messages.values
    end

    # Returns all message keys.
    #
    #   errors.messages # => {:name=>["can not be nil", "must be specified"]}
    #   errors.keys     # => [:name]
    def keys
      messages.keys
    end

    # Returns an array of error messages, with the attribute name included.
    #
    #   errors.add(:name, "can't be blank")
    #   errors.add(:name, "must be specified")
    #   errors.to_a # => ["name can't be blank", "name must be specified"]
    def to_a
      full_messages
    end

    # Returns the number of error messages.
    #
    #   errors.add(:name, "can't be blank")
    #   errors.count # => 1
    #   errors.add(:name, "must be specified")
    #   errors.count # => 2
    def count
      to_a.size
    end

    # Returns +true+ if no errors are found, +false+ otherwise.
    # If the error message is a string it can be empty.
    #
    #   errors.full_messages # => ["name can not be nil"]
    #   errors.empty?        # => false
    def empty?
      all? { |k, v| v && v.empty? && !v.is_a?(String) }
    end
    # aliases empty?
    alias_method :blank?, :empty?

    # Returns a Hash of attributes with their error messages. If +full_messages+
    # is +true+, it will contain full messages (see +full_message+).
    #
    #   errors.to_hash       # => {:name=>["can not be nil"]}
    #   errors.to_hash(true) # => {:name=>["name can not be nil"]}
    def to_hash(full_messages = false)
      if full_messages
        messages = {}
        self.messages.each do |attribute, array|
          messages[attribute] = array.map { |message| full_message(attribute, message) }
        end
        messages
      else
        self.messages.dup
      end
    end

    # Adds +message+ to the error messages on +attribute+. More than one error
    # can be added to the same +attribute+. If no +message+ is supplied,
    # <tt>:invalid</tt> is assumed.
    #
    #   errors.add(:name)
    #   # => ["is invalid"]
    #   errors.add(:name, 'must be implemented')
    #   # => ["is invalid", "must be implemented"]
    #
    #   errors.messages
    #   # => {:name=>["must be implemented", "is invalid"]}
    #
    # If +message+ is a symbol, it will be translated using the appropriate
    # scope (see +generate_message+).
    #
    # If +message+ is a proc, it will be called, allowing for things like
    # <tt>Time.now</tt> to be used within an error.
    #
    #   errors.messages # => {}
    def add(attribute, message = :invalid, options = {})
      message = normalize_message(attribute, message, options)

      self[attribute] << message
    end

    # Returns +true+ if an error on the attribute with the given message is
    # present, +false+ otherwise. +message+ is treated the same as for +add+.
    #
    #   errors.add :name, :blank
    #   errors.added? :name, :blank # => true
    def added?(attribute, message = :invalid, options = {})
      message = normalize_message(attribute, message, options)
      self[attribute].include? message
    end

    # Returns all the full error messages in an array.
    #
    #   class PersonValidator
    #     validates :name, :address, :email, presence: true
    #     validates :name, length: { min: 5, max: 30 }
    #   end
    #
    #   = create(address: '123 First St.')
    #   errors.full_messages
    #   # => ["Name is too short (minimum is 5 characters)", "Name can't be blank", "Email can't be blank"]
    def full_messages
      map { |attribute, message| full_message(attribute, message) }
    end

    # Returns all the full error messages for a given attribute in an array.
    #
    #   class PersonValidator
    #     validates :name, :address, :email, presence: true
    #     validates :name, length: { min: 5, max: 30 }
    #   end
    #
    #   = create()
    #   errors.full_messages_for(:name)
    #   # => ["Name is too short (minimum is 5 characters)", "Name can't be blank"]
    def full_messages_for(attribute)
      (get(attribute) || []).map { |message| full_message(attribute, message) }
    end

    # Returns a full message for a given attribute.
    #
    #   errors.full_message(:name, 'is invalid') # => "Name is invalid"
    def full_message(attribute, message)
      return message if attribute == :base
      attr_name = attribute.to_s.tr('.', '_').humanize
      attr_name = @base.class.human_attribute_name(attribute, default: attr_name)
      I18n.t(:"errors.format", {
        default:  "%{attribute} %{message}",
        attribute: attr_name,
        message:   message
      })
    end

    # Translates an error message in its default scope
    # (<tt>activemodel.errors.messages</tt>).
    #
    # Error messages are first looked up in <tt>models.MODEL.attributes.ATTRIBUTE.MESSAGE</tt>,
    # if it's not there, it's looked up in <tt>models.MODEL.MESSAGE</tt> and if
    # that is not there also, it returns the translation of the default message
    # (e.g. <tt>activemodel.errors.messages.MESSAGE</tt>). The translated model
    # name, translated attribute name and the value are available for
    # interpolation.
    #
    # When using inheritance in your models, it will check all the inherited
    # models too, but only if the model itself hasn't been found. Say you have
    # <tt>class Admin < User; end</tt> and you wanted the translation for
    # the <tt>:blank</tt> error message for the <tt>title</tt> attribute,
    # it looks for these translations:
    #
    # * <tt>activemodel.errors.models.admin.attributes.title.blank</tt>
    # * <tt>activemodel.errors.models.admin.blank</tt>
    # * <tt>activemodel.errors.models.user.attributes.title.blank</tt>
    # * <tt>activemodel.errors.models.user.blank</tt>
    # * any default you provided through the +options+ hash (in the <tt>activemodel.errors</tt> scope)
    # * <tt>activemodel.errors.messages.blank</tt>
    # * <tt>errors.attributes.title.blank</tt>
    # * <tt>errors.messages.blank</tt>
    def generate_message(attribute, type = :invalid, options = {})
      type = options.delete(:message) if options[:message].is_a?(Symbol)

      if @base.class.respond_to?(:i18n_scope)
        defaults = @base.class.lookup_ancestors.map do |klass|
          [ :"#{@base.class.i18n_scope}.errors.models.#{klass.model_name.i18n_key}.attributes.#{attribute}.#{type}",
            :"#{@base.class.i18n_scope}.errors.models.#{klass.model_name.i18n_key}.#{type}" ]
        end
      else
        defaults = []
      end

      defaults << options.delete(:message)
      defaults << :"#{@base.class.i18n_scope}.errors.messages.#{type}" if @base.class.respond_to?(:i18n_scope)
      defaults << :"errors.attributes.#{attribute}.#{type}"
      defaults << :"errors.messages.#{type}"

      defaults.compact!
      defaults.flatten!

      key = defaults.shift
      value = (attribute != :base ? @base.send(:read_attribute_for_validation, attribute) : nil)

      options = {
        default: defaults,
        model: @base.class.model_name.human,
        attribute: @base.class.human_attribute_name(attribute),
        value: value
      }.merge!(options)

      I18n.translate(key, options)
    end

  private

  def normalize_message(attribute, message, options)
    case message
    when Symbol
      generate_message(attribute, message, options.except(*CALLBACKS_OPTIONS))
    when Proc
      message.call
    else
      message
    end
  end

end
