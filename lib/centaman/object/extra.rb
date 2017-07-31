module Centaman
  class Object::Extra < Centaman::Object
    attr_accessor :quantity

    def after_init(_args = {})
      @quantity = 0
    end

    def price
      @price ||= tax_inclusive ? calculate_price_before_tax : price_including_tax
    end

    def calculate_price_before_tax
      p = price_including_tax / (1 + tax_percentage / 100)
      p.round(2)
    end

    def json
      {
        id: id,
        description: description,
        quantity: quantity,
        price: price,
        deposit_percentage: deposit_percentage,
        tax_inclusive: tax_inclusive,
        tax_percentage: tax_percentage
      }
    end

    def description
      # TODO change description message to just use extra_description attr val?
      @extra_description.gsub!('Bar Package Cocktail Cruises', 'Bar Package')
      @description = @extra_description
    end

    # rubocop:disable Metrics/MethodLength
    def attributes
      [
        Centaman::Attribute.new(
          centaman_key: 'ExtraId',
          app_key: :id,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'ExtraDescription',
          app_key: :extra_description,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'ExtraPrice',
          app_key: :price_including_tax,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: 'DepositPercentage',
          app_key: :deposit_percentage,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: 'IsTaxInclusive',
          app_key: :tax_inclusive,
          type: :boolean
        ),
        Centaman::Attribute.new(
          centaman_key: 'TaxPercentage',
          app_key: :tax_percentage,
          type: :float
        )
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
