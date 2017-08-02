module Centaman
  class Object::Effect < Centaman::Object
    # rubocop:disable Metrics/MethodLength
    def attributes
      [
        Centaman::Attribute.new(
          centaman_key: 'Valid',
          app_key: :valid,
          type: :boolean
        ),
        Centaman::Attribute.new(
          centaman_key: 'ProductType',
          app_key: :product_type,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'ProductCode',
          app_key: :product_code,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'EffectType',
          app_key: :effect_type,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'Amount',
          app_key: :amount,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: 'ReasonInvalid',
          app_key: :reason_invalid,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'ValidFrom',
          app_key: :valid_from,
          type: :datetime
        ),
        Centaman::Attribute.new(
          centaman_key: 'ValidUntil',
          app_key: :valid_until,
          type: :datetime
        ),
        Centaman::Attribute.new(
          centaman_key: 'WaiveTicketFee',
          app_key: :waive_ticket_fee,
          type: :boolean
        )
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
