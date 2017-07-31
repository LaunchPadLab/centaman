module Centaman
  class Object::BookingType < Centaman::Object
    attr_reader :booking_type_mapping

    # TODO Remove all booking type mapping, app specific methods?
    
    def json
      {
        booking_type_id: booking_type_id,
        booking_description: booking_description
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