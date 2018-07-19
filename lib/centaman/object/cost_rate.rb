module Centaman
  class Object::CostRate < Centaman::Object
    def attributes
      [
        Centaman::Attribute.new(
          centaman_key: 'FirstName',
          app_key: :first_name,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'LastName',
          app_key: :last_name,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'Email',
          app_key: :email,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'ContactID',
          app_key: :contact_id,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'ContactCostRateID',
          app_key: :cost_rate_id,
          type: :integer
        )
      ]
    end
  end
end
