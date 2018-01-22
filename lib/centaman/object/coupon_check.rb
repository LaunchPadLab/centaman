module Centaman
  class Object::CouponCheck < Centaman::Object
    attr_reader :effects

    def after_init(args = {})
      define_effects(args)
    end

    def define_effects(args)
      @effects = args['Effects'].map do |effect_hash|
        Centaman::Object::Effect.new(effect_hash)
      end
    end

    # rubocop:disable Metrics/MethodLength
    def attributes
      [
        Centaman::Attribute.new(
          centaman_key: 'CouponCode',
          app_key: :coupon_code,
          type: :string
        ),

        Centaman::Attribute.new(
          centaman_key: 'LimitedUse',
          app_key: :limited_use,
          type: :boolean
        ),
        Centaman::Attribute.new(
          centaman_key: 'UsesRemaining',
          app_key: :uses_remaining,
          type: :integer
        )
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
