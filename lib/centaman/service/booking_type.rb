module Centaman
  class Service::BookingType < Centaman::Service
    def endpoint
      '/ticket_services/TimedTicket'
    end

    def default_object_class
      Centaman::Object::BookingType
    end

    def all_booking_type
      Centaman::Object::BookingType.new({
        'BookingTypeId' => 0,
        'BookingDescription' => 'All Booking Types'
      })
    end

    def self.find(booking_type_id, date)
      obj = new(
        start_date: date,
        end_date: date
      )
      obj.objects.detect {|obj| obj.booking_type_id == booking_type_id }
    end
  end
end
