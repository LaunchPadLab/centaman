class Centaman::Object::PurchasedTicket < Centaman::Object
  attr_accessor :id

  def define_variables(args = {})
    super
    @id = item_code
  end

  def attributes
    [
      Centaman::Attribute.new(
        centaman_key: "ItemDescription",
        app_key: :item_description,
        type: :string
      ),
      Centaman::Attribute.new(
        centaman_key: "ItemDescription",
        app_key: :display_age_group,
        type: :display_age_group
      ),
      Centaman::Attribute.new(
        centaman_key: "ItemCode",
        app_key: :item_code,
        type: :string
      ),
      Centaman::Attribute.new(
        centaman_key: "Quantity",
        app_key: :quantity,
        type: :integer
      ),
      Centaman::Attribute.new(
        centaman_key: "ItemCost",
        app_key: :item_cost,
        type: :float
      ),
      Centaman::Attribute.new(
        centaman_key: "TotalPaid",
        app_key: :total_paid,
        type: :float
      ),
      Centaman::Attribute.new(
        centaman_key: "TaxPaid",
        app_key: :tax_paid,
        type: :float
      ),
      Centaman::Attribute.new(
        centaman_key: "Barcode",
        app_key: :barcode,
        type: :string
      ),
      Centaman::Attribute.new(
        centaman_key: "AttendeeName",
        app_key: :attendee_name,
        type: :string
      ),
      Centaman::Attribute.new(
        centaman_key: "IsExtraItem",
        app_key: :is_extra_item,
        type: :boolean
      ),
      Centaman::Attribute.new(
        centaman_key: "CouponCode",
        app_key: :coupon_code,
        type: :string
      ),
      Centaman::Attribute.new(
        centaman_key: "CostRateId",
        app_key: :cost_rate_id,
        type: :string
      ),
    ]
  end
end
