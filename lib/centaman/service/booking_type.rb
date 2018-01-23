module Centaman
  class Service::BookingType < Centaman::Service
    include Centaman::JsonWrapper

    def endpoint
      '/ticket_services/TimedTicket'
    end

    def object_class
      Centaman::Object::BookingType
    end

    def all_booking_type
      object_class.new({
        'BookingTypeId' => 0,
        'BookingDescription' => 'All Booking Types'
      })
    end

    def self.find(booking_type_id, date)
      new.objects.detect {|obj| obj.booking_type_id == booking_type_id }
    end
  end
end
