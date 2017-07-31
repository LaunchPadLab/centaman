module Centaman
  #:nodoc:
  # TODO move centaman::order out of gem
  class Order
    attr_reader :receipt, :booking_id, :stored_order, :booking_time, 
                :contact, :order_info, :payment_reference

    def initialize(response, booking_time, contact, order_info, payment_reference)
      @receipt = response.first['ReceiptNo']
      @booking_id = response.first['BookingId']
      @booking_time = booking_time
      @contact = contact
      @order_info = order_info
      @payment_reference = payment_reference    
    end

    def create_tickets(response)      
      order_info.coupon_service.use_coupon!(stored_order)

      response.first['Item'].uniq.map do |ticket_hash|
        create_ticket(ticket_hash)
      end
    end

    # rubocop:disable Metrics/MethodLength
    def create_ticket(ticket_hash)
      parsed_ticket = Centaman::Object::PurchasedTicket.new(ticket_hash)
      Ticket.create(
        order: @stored_order,
        display_age_group: parsed_ticket.display_age_group,
        item_code: parsed_ticket.item_code,
        quantity: parsed_ticket.quantity,
        item_cost: parsed_ticket.item_cost,
        total_paid: parsed_ticket.total_paid,
        tax_paid: parsed_ticket.tax_paid,
        barcode: parsed_ticket.barcode,
        attendee_name: parsed_ticket.attendee_name,
        is_extra_item: parsed_ticket.is_extra_item,
        coupon_code: order_info.coupon,
        cost_rate_id: parsed_ticket.cost_rate_id
      )
    end
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def create_order
      buyer_name = [contact.first_name, contact.last_name].compact.join(" ")
      @stored_order = ::Order.create(
        receipt: receipt,
        booking_id: booking_id,
        booking_type_name: booking_time.description,
        email: contact.email,
        phone: contact.phone,
        buyer_name: buyer_name,
        date: Date.today,
        booking_type_start_date: booking_time.start_date,
        booking_type_start_time: booking_time.display_start_time,
        booking_type_id: booking_time.booking_type_id,
        booking_time_id: booking_time.id,
        coupon: order_info.coupon,
        payment_reference: payment_reference
      )
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
  end
end
