module Centaman
  class Service::BookingType < Centaman::Service
    def endpoint
      '/ticket_services/TimedTicket'
    end

    def object_class
      Centaman::Object::BookingType
    end

    def build_objects(resp)
      create_mappings(resp)
      booking_type_mappings = BookingTypeMapping.all
      booking_types = resp.map do |ticket_hash|
        booking_type_mapping = booking_type_mappings.detect { |btm| btm.booking_type_id == ticket_hash['BookingTypeId'] }
        args = ticket_hash.merge(additional_hash_to_serialize_after_response)
        args = args.merge(booking_type_mapping: booking_type_mapping)
        object_class.new(args)
      end
      active_booking_types = booking_types.find_all { |bt| bt.active }
      active_booking_types.unshift(all_booking_type)
    end

    def all_booking_type
      Centaman::Object::BookingType.new({
        'BookingTypeId' => 0,
        'BookingDescription' => 'All Booking Types'
      })
    end

    def create_mappings(resp)
      response_ids = resp.map { |hash| hash['BookingTypeId'] }
      already_mapped_ids = BookingTypeMapping.pluck(:booking_type_id)
      unmapped_ids = response_ids - already_mapped_ids
      unmapped_hashes = resp.find_all { |hash| unmapped_ids.include?(hash['BookingTypeId']) }
      unmapped_hashes.each do |hash|
        BookingTypeMapping.create(
          booking_type_id: hash['BookingTypeId'], 
          booking_description: hash['BookingDescription'],
          display_name: hash['BookingDescription']
        )
      end
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
