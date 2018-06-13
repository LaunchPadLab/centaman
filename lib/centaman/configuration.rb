module Centaman
  class Configuration
    attr_accessor :object_overrides

    def initialize
      @object_overrides = {}
    end
  end
end
