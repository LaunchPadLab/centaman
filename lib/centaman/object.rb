module Centaman
  #:nodoc:
  class Object
    def initialize(args = {})
      define_variables(args)
      after_init(args)
    end

    def define_variables(args)
      attributes.each do |attribute|
        val = args[attribute.centaman_key]
        attribute.value = val
        attribute.parse_value
        self.class.__send__(:attr_accessor, attribute.app_key)
        instance_variable_set("@#{attribute.app_key}", attribute.value)
      end
    end

    def attributes
      [] # overwritten by subclasses
    end

    def after_init(args)
      # hook for subclasses
    end
  end
end
