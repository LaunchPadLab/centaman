class Centaman::Object::PurchasedGeneralAdmissionTicket < Centaman::Object
  attr_accessor :id

  def define_variables(args = {})
    super
    @id = ticket_id
  end

  def item_code
    ticket_id
  end

  def description
    ticket_description
  end

  def attributes
    [
      Centaman::Attribute.new(
        centaman_key: 'TicketID',
        app_key: :ticket_id,
        type: :integer
      ),
      Centaman::Attribute.new(
        centaman_key: 'Quantity',
        app_key: :quantity,
        type: :integer
      ),
      Centaman::Attribute.new(
        centaman_key: 'userid',
        app_key: :user_id,
        type: :integer
      ),
      Centaman::Attribute.new(
        centaman_key: 'TicketDescription',
        app_key: :ticket_description,
        type: :string
      ),
      Centaman::Attribute.new(
        centaman_key: 'BarCode',
        app_key: :barcode,
        type: :string
      ),
      Centaman::Attribute.new(
        centaman_key: 'ReceiptNumber',
        app_key: :receipt,
        type: :string
      ),
      Centaman::Attribute.new(
        centaman_key: 'ExpiryDate',
        app_key: :expiry_date,
        type: :datetime
      ),
    ]
  end
end
