module Centaman
  #:nodoc:
  class Filter
    attr_reader :booking_type_id, :booking_time_id, :start_date, :end_date

    def initialize(args = {})
      @booking_type_id = args[:booking_type_id].try(:to_i)
      @booking_time_id = args[:booking_time_id].try(:to_i)
      @start_date = args[:start_date]
      @end_date = args[:end_date]
    end

    def find_booking_type(booking_type_id)
      booking_types.detect { |c| c.booking_type_id == booking_type_id }
    end

    def find_booking_time(booking_time_id)
      raise "booking_time_id is required for find_booking_time method of #{self.class.name} class" if booking_time_id.nil?
      booking_times.detect { |c| c.id.to_s == booking_time_id.to_s }
    end

    def booking_types
      @booking_types ||= Centaman::Service::BookingType.new.objects
    end

    def tickets
      @tickets ||= Centaman::Service::TicketType.new(booking_time_id: booking_time_id).objects
    end

    def booking_times
      @booking_times ||= Centaman::Service::BookingTime.new(
        booking_type_id: booking_type_id,
        start_date: start_date,
        end_date: end_date
      ).objects
    end

    def gift_tickets
      @gift_tickets ||= Centaman::Service::GiftTicket.new.objects
    end

    def capacity
      @capacity ||= Centaman::Service::Capacity.new(booking_time_id: booking_time_id, start_date: start_date).objects.first
    end
  end
end
