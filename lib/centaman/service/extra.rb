module Centaman
  class Service::Extra < Centaman::Service
    attr_reader :booking_time_id

    def after_init(args)
      @booking_time_id = args[:booking_time_id]
      require_args
    end

    def default_object_class
      Centaman::Object::Extra
    end

    def endpoint
      '/ticket_services/TimedTicketExtra'
    end

    def options
      super + [
        { key: 'TimedTicketTypeId', value: booking_time_id }
      ]
    end

    def require_args
      raise "booking_time_id is required for #{self.class.name}" if booking_time_id.nil?
    end

    def sample_response
      [{
        'ExtraId' => 581,
        'ExtraDescription' => 'Bar Package Cocktail Cruises',
        'ExtraPrice' => 22.05,
        'DepositPercentage' => 100.0,
        'IsTaxInclusive' => true, 'TaxPercentage' => 10.25
      }]
    end

    def objects
      Rails.env.test? ? build_objects(sample_response) : super
    end
  end
end
