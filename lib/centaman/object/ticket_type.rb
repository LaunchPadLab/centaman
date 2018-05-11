module Centaman
  class Object::TicketType < Centaman::Object
    attr_reader :price, :discount
    attr_accessor :quantity

    def price
      @price ||= begin
        p = price_including_tax / (1 + tax_percentage / 100)
        p = p + discount
        p.round(2)
      end
    end

    def discount
      @discount ||= Centaman::Service::TicketType::DISCOUNT
    end

    def adult?
      age_group == 'adult'
    end

    def youth?
      age_group == 'youth'
    end

    def child?
      age_group == 'child'
    end

    def senior?
      age_group == 'senior'
    end

    # rubocop:disable Metrics/MethodLength
    def attributes
      [
        Centaman::Attribute.new(
          centaman_key: "TicketId",
          app_key: :id,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: "TicketDescription",
          app_key: :description,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: "TicketPrice",
          app_key: :price_including_tax,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: "TicketBookingFee",
          app_key: :booking_fee,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: "TicketFeeItemId",
          app_key: :fee_item_id,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: "DepositPercentage",
          app_key: :deposit_percentage,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: "IsTaxInclusive",
          app_key: :is_tax_inclusive,
          type: :boolean
        ),
        Centaman::Attribute.new(
          centaman_key: "TaxPercentage",
          app_key: :tax_percentage,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: "TicketDescription",
          app_key: :age_group,
          type: :age_group
        ),
        Centaman::Attribute.new(
          centaman_key: "TicketDescription",
          app_key: :display_age_group,
          type: :display_age_group
        ),
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
