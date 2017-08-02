module Centaman
  #:nodoc:
  class Attribute
    attr_reader :centaman_key, :app_key, :type
    attr_accessor :value

    def initialize(args = {})
      @centaman_key = args[:centaman_key]
      @app_key = args[:app_key]
      @type = args.fetch(:type, :string)
    end

    def parse_value
      parsed_value = send(type)
      @value = parsed_value
    end

    def string
      value
    end

    def float
      value
    end

    def integer
      value.try(:to_i)
    end

    def boolean
      value
    end

    def datetime
      DateTime.parse(value)
    end

    def centaman_description
      value
    end

    def display_time      
      array = value.split(":")
      hour = array[0].try(:to_i)
      minute = array[1].try(:to_i)
      period = hour >= 12 ? 'pm' : 'am'
      hour = hour > 12 ? hour - 12 : hour
      return "#{hour}#{period}" if minute == 0
      "#{hour}:#{minute}#{period}"
      # return [array.first, array[1]].join(":")
    end

    def age_group
      return 'adult' if value.downcase.include?("adult")
      return 'child' if value.downcase.include?("child")
      return 'adult'
    end

    def display_age_group
      age_group.capitalize
    end
  end
end
