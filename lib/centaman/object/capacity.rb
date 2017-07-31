module Centaman
  class Object::Capacity < Centaman::Object
    attr_accessor :sold_out

    # rubocop:disable Metrics/MethodLength
    def attributes
      [
        Centaman::Attribute.new(
          centaman_key: 'TimedTicketTypeId',
          app_key: :booking_time_id,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'TimedTicketTypeDescription',
          app_key: :booking_time_description,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'Capacity',
          app_key: :capacity,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'vacancy',
          app_key: :vacancy,
          type: :integer
        )
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
