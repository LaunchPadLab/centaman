module Centaman
  class Object::BookingType < Centaman::Object
    attr_reader :booking_type_mapping

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
  end
end