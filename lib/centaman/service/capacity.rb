module Centaman
  class Service::Capacity < Centaman::Service
    attr_reader :booking_time_id, :start_date

    def after_init(args)
      @booking_time_id = args[:booking_time_id]
      @start_date = args[:start_date]
      require_args
    end

    def endpoint
      '/ticket_services/TimedTicketType'
    end

    def default_object_class
      Centaman::Object::Capacity
    end

    def objects
      capacities = super
      capacities.each do |capacity|
        capacity.sold_out = capacity.vacancy <= 0
      end
      capacities
    end

    def options
      super + [
        { key: 'TimedTicketTypeId', value: booking_time_id },
        { key: 'StartDate', value: start_date }
      ]
    end

    def require_args
      raise "booking_time_id is required for #{self.class.name}" if booking_time_id.nil?
      raise "start_date is required for #{self.class.name}" if start_date.nil?
    end
  end
end
