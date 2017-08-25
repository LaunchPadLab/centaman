module Centaman
  class Service::HoldTicket < Centaman::Service
    attr_reader :timed_ticket_type_id, :timed_ticket_id, :quantity

    def after_init(args)
      @timed_ticket_type_id = args[:timed_ticket_type_id]
      @timed_ticket_id = args[:timed_ticket_id]
      @quantity = args[:quantity]
    end

    def after_post(response)
      response.parsed_response
    end

    def endpoint
      '/ticket_services/TimedTicketType'
    end

    def object_class
      Centaman::Object::BookingTime
    end

    def options_hash
      [
        {
          'TimedTicketTypeId' => timed_ticket_type_id.to_i,
          'TimedTicketId' => timed_ticket_id,
          'NumberOfTickets' => quantity
        }
      ].to_json
    end

    def options
      super + [
        { key: 'TimedTicketTypeId', value: timed_ticket_type_id.to_i },
        { key: 'TimedTicketId', value: timed_ticket_id },
        { key: 'NumberOfTickets', value: quantity }
      ]
    end
  end
end