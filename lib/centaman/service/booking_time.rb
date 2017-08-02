module Centaman
  class Service::BookingTime < Centaman::Service
    include Centaman::JsonWrapper
    attr_reader :booking_type_id, :start_date, :end_date, :timed_ticket_type_id

    def after_init(args)
      @booking_type_id = args[:booking_type_id]
      @start_date = args[:start_date]
      @end_date = args[:end_date]
      parse_dates
      @timed_ticket_type_id = args[:id] # when finding a particular time
    end

    def object_class
      Centaman::Object::BookingTime
    end

    def self.find(booking_type_id, booking_time_id, date)
      obj = new(
        booking_type_id: booking_type_id,
        booking_time_id: booking_time_id,
        start_date: date,
        end_date: date
      )
      obj.objects.detect {|obj| obj.id == booking_time_id }
    end

    def endpoint
      '/ticket_services/TimedTicketType'
    end

    def options
      super + [
        { key: 'BookingTypeId', value: booking_type_id },
        { key: 'StartDate', value: start_date },
        { key: 'EndDate', value: end_date },
        { key: 'id', value: timed_ticket_type_id },
      ]
    end

    def parse_dates
      @start_date = start_date.present? && start_date.is_a?(Date) ? format_date_to_string(start_date) : start_date
      @end_date = end_date.present? && end_date.is_a?(Date) ? format_date_to_string(end_date) : end_date
    end

    def format_date_to_string(date)
      date.strftime('%Y-%m-%d')
    end
  end
end