module Centaman
  class Service::TicketType < Centaman::Service
    DISCOUNT = 0.0

    attr_reader :booking_time_id

    def after_init(args)
      @booking_time_id = args[:booking_time_id]
      require_args
    end

    def endpoint
      '/ticket_services/TimedTicket'
    end

    def build_objects(resp)
      ticket_types = super(resp)
      # need to trigger the price method to have it returned in json
      ticket_types.each(&:price)
      ticket_types
    end

    def default_object_class
      Centaman::Object::TicketType
    end

    def options
      super + [
        { key: "TimedTicketTypeId", value: booking_time_id }
      ]
    end

    def objects
      Rails.env.test? ? build_objects(sample_response) : super
    end

    # rubocop:disable Metrics/MethodLength
    def sample_response
      # when passing a timed_booking_time_id
      [
        {
          'TicketId'=>504,
          'TicketDescription'=>' Adult 19 64yrs online w tax 42 56 90m',
          'TicketPrice'=>42.56,
          'TicketBookingFee'=>0.0,
          'TicketFeeItemId'=>501,
          'DepositPercentage'=>100.0,
          'IsTaxInclusive'=>true,
          'TaxPercentage'=>12.0
        },
        {
          'TicketId'=>505,
          'TicketDescription'=>' Senior 65yrs online w tax 35 84 90m',
          'TicketPrice'=>35.84,
          'TicketBookingFee'=>0.0,
          'TicketFeeItemId'=>501,
          'DepositPercentage'=>100.0,
          'IsTaxInclusive'=>true,
          'TaxPercentage'=>12.0},
        {
          'TicketId'=>506,
          'TicketDescription'=>' Youth 7 18yrs online w tax 17 92 90m',
          'TicketPrice'=>17.92,
          'TicketBookingFee'=>0.0,
          'TicketFeeItemId'=>501,
          'DepositPercentage'=>100.0,
          'IsTaxInclusive'=>true,
          'TaxPercentage'=>12.0},
        {
          'TicketId'=>524,
          'TicketDescription'=>' Child 7years accompanying booking ',
          'TicketPrice'=>0.0,
          'TicketBookingFee'=>0.0,
          'TicketFeeItemId'=>501,
          'DepositPercentage'=>100.0,
          'IsTaxInclusive'=>true,
          'TaxPercentage'=>12.0},
        {
          'TicketId'=>630,
          'TicketDescription'=>'Percent Pound Two Adult Ticket Groupon Special ',
          'TicketPrice'=>85.12,
          'TicketBookingFee'=>0.0,
          'TicketFeeItemId'=>0,
          'DepositPercentage'=>100.0,
          'IsTaxInclusive'=>true,
          'TaxPercentage'=>12.0
        }
      ]
    end
    # rubocop:enable Metrics/MethodLength

    def require_args
      raise "booking_time_id is required for #{self.class.name}" if booking_time_id.nil?
    end
  end
end
