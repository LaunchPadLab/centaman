module Centaman
  class Object::Package < Centaman::Object
    attr_reader :id, :membership_type_id

    def define_variables(args)
      super
      @id = membership_code
      @membership_type_id = args.fetch(:membership_type_id, nil)
    end

    def json
      {
        id: id,
        membership_type_id: membership_type_id,
        membership_code: membership_code,
        membership_class: membership_class,
        cost: cost,
        minimum_age: minimum_age,
        maximum_age: maximum_age,
        membership_description: membership_description,
        sale_price: sale_price,
        is_tax_inclusive: is_tax_inclusive,
        tax_percentage: tax_percentage,
        package_only: package_only
      }
    end

    # rubocop:disable Metrics/MethodLength
    def attributes
      [
        Centaman::Attribute.new(
          centaman_key: 'MembershipCode',
          app_key: :membership_code,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'MembershipClass',
          app_key: :membership_class,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'Cost',
          app_key: :cost,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: 'MinimumAgeRequired',
          app_key: :minimum_age,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'MaximumAgeRequirement',
          app_key: :maximum_age,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'MembershipDescription',
          app_key: :membership_description,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'IsMembershipAgeBased',
          app_key: :is_age_based,
          type: :boolean
        ),
        Centaman::Attribute.new(
          centaman_key: 'SalePrice',
          app_key: :sale_price,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: 'IsPriceTaxInclusive',
          app_key: :is_tax_inclusive,
          type: :boolean
        ),
        Centaman::Attribute.new(
          centaman_key: 'TaxPercentage',
          app_key: :tax_percentage,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: 'PackageOnly',
          app_key: :package_only,
          type: :boolean
        )
      ]
    end
  end
end
