module Centaman
  class Object::BookingType < Centaman::Object
    attr_reader :booking_type_mapping

    def display_name
      booking_type_mapping.description || booking_description
    end

    def image
      booking_type_mapping.image.icon.url
    end

    def vessel_type
      booking_type_mapping.vessel_type
    end

    def service_details
      booking_type_mapping.service_details
    end

    def active
      booking_type_mapping.active
    end

    def position
      booking_type_mapping.position
    end

    def json
      {
        display_name: display_name,
        booking_type_id: booking_type_id,
        booking_description: booking_description,
        image: image,
        service_details: service_details,
        vessel_type: vessel_type,
        active: active,
        position: position,
        booking_type_mapping_id: booking_type_mapping.id
      }
    end

    # rubocop:disable Metrics/MethodLength
    def attributes
      [
        Centaman::Attribute.new(
          centaman_key: 'BookingTypeId',
          app_key: :booking_type_id,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'BookingDescription',
          app_key: :booking_description,
          type: :string
        ),
      ]
    end
    # rubocop:enable Metrics/MethodLength
    def after_init(args)
      @booking_type_mapping = args[:booking_type_mapping] || BookingTypeMapping.new
    end
  end
end