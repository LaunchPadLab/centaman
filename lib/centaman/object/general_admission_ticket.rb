module Centaman
  class Object::GeneralAdmissionTicket < Centaman::Object
    # rubocop:disable Metrics/MethodLength
    def attributes
      [
        Centaman::Attribute.new(
          centaman_key: 'TicketID',
          app_key: :id,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'TicketDescription',
          app_key: :description,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'DepartmentID',
          app_key: :department_id,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'DepartmentName',
          app_key: :department_name,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'TicketMinimumQuantity',
          app_key: :minimum_quantity,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'TicketMaximumQuantity',
          app_key: :maximum_quantity,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'TicketValidity',
          app_key: :validity,
          type: :datetime
        ),
        Centaman::Attribute.new(
          centaman_key: 'TicketNormalPrice',
          app_key: :normal_price,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: 'TicketWebPrice',
          app_key: :web_price,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: 'TaxInclusive',
          app_key: :tax_inclusive,
          type: :boolean
        ),
        Centaman::Attribute.new(
          centaman_key: 'TaxPercentage',
          app_key: :tax_percentage,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: 'CouponRequired',
          app_key: :coupon_required,
          type: :boolean
        ),
        Centaman::Attribute.new(
          centaman_key: 'ShowTicket',
          app_key: :show_ticket,
          type: :boolean
        ),
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end