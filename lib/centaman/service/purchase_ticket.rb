module Centaman
  class Service::PurchaseTicket < Centaman::Service
    attr_reader :booking_type, :booking_time, :tickets, :payment_reference,
                :contact, :order_info, :checkout_service

    def after_init(args)
      @booking_type = args[:booking_type]
      @booking_time = args[:booking_time]
      @tickets = args[:tickets]
      @payment_reference = args[:payment_reference]
      @contact = args[:contact]
      @order_info = args[:order_info]
      @checkout_service = args[:checkout_service]
    end

    def endpoint
      '/ticket_services/TimedTicketTransaction'
    end

    def tickets_payload
      calculators.map do |calculator|
        ticket_hash = {
          'ItemDescription' => calculator.description,
          'ItemCode' => calculator.id,
          'Quantity' => calculator.quantity,
          'ItemCost' => calculator.price_per_after_online_discount,
          'TotalPaid' => calculator.total_per,
          'TaxPaid' => calculator.taxes_per,
          'AttendeeName' => '',
          # 'Barcode' => nil,
          'IsExtraItem' => calculator.is_extra?,
          'CouponCode' => order_info.coupon_service.centaman_coupon_code || ''
        }
        ticket_hash
      end
    end

    def options_hash_no_json
      [
        {
          "Item" => tickets_payload,
          "TimedTicketTypeId" => booking_time.id,
          "TimedTicketTypeDescription" => "#{contact.last_name}, #{contact.first_name}",
          "BookingTypeId" => booking_type.booking_type_id,
          "StartDate" => booking_time.start_date.strftime('%Y-%m-%d'),
          # "StartTime" => booking_time.start_time,
          "EndTime" => booking_time.end_time,
          "PaymentReference" => payment_reference,
          "BookingCost" => total_after_discounts.round(2),
          "TotalPaid" => total_paid.round(2),
          "TaxPaid" => total_taxes.round(2),
          "TransactionDate" => Date.today.strftime('%Y-%m-%d'),
          "BookingContactID" => contact.member_code,
          "TotalTickets" => total_tickets,
          # "BalanceAmount" => nil,
          # "ReceiptNo" => nil,
          # "BookingId" => nil
        }
      ]
    end

    private

      def options_hash
        options_hash_no_json.to_json
      end

      def total_after_discounts
        checkout_service.total_price_after_discounts
      end

      def total_paid
        checkout_service.total
      end

      def total_taxes
        checkout_service.total_taxes
      end

      def total_tickets
        checkout_service.total_tickets
      end

      def calculators
        checkout_service.ticket_calculators + checkout_service.extra_calculators
      end
  end
end
