module Centaman
  class Service::PurchaseMembership < Centaman::Service
    attr_reader :payment_reference, :order_info, :checkout_service, :coupon_service,
                :members, :memberships, :add_ons, :membership_type_id,
                :is_new, :purchaser_renewal, :is_new, :coupon, :has_card_discount

    def after_init(args)
      @payment_reference = args[:payment_reference]
      @order_info = args[:order_info]
      @purchaser_renewal = @order_info.is_renewal
      @is_new = !@order_info.is_renewal
      @has_card_discount = @order_info.fnbo_discount
      @checkout_service = args[:checkout_service]
      @coupon_service = args[:coupon_service]
      @membership_type_id = @order_info.membership_type_id
      @members = @order_info.members
      @add_ons = @checkout_service.add_ons
      @memberships = []
      @coupon = @coupon_service.valid_coupon
      build_membership_request
    end

    def endpoint
      "/member_services/Membership?isNew=#{is_new}"
    end

    def membership_payload(member_id, add_on)
      payload = {
        'MemberCode': member_id,
        'TypeCode': add_on.id,
        'Cost': add_on.cost,
        'Tax': checkout_service.add_on_tax(add_on),
        'Paid': add_on.pay_price,
        'PackageID': membership_type_id,
        'PurchaserRenewal': purchaser_renewal,
        'PaymentGatewayReference': payment_reference
      }
      payload = coupon.present? ? payload.merge(coupon_args(add_on)) : payload
      payload = has_card_discount ? payload.merge(card_discount_args) : payload
    end

    def coupon_args(add_on)
      return empty_coupon_args unless coupon_service.coupon_applies(add_on)
      {
        'Coupon': {
          "CouponCode": coupon.code,
          "DiscountAmount": coupon_service.amount_saved(add_on),
          "StockID": coupon.stock_code
        }
      }
    end

    def card_discount_args
      return empty_card_args unless has_card_discount
      {
        'CardDiscount': {
          'DiscountAmount': checkout_service.fnbo_amount,
          'StockID': checkout_service.fnbo_stock_id
        }
      }
    end

    def empty_coupon_args
      {
        'Coupon': {
          "CouponCode": nil,
          "DiscountAmount": 0,
          "StockID": nil
        }
      }
    end

    def empty_card_args
      {
        'CardDiscount': {
          'DiscountAmount': 0,
          'StockID': nil
        }
      }
    end

    def build_membership_request
      members.map do |m|
        order_info.add_ons_for_member(add_ons, m.member_type).each do |ao|
          @memberships << membership_payload(m.id, ao)
        end
      end
    end

    def options_hash
      p "PAYLOAD"
      p @memberships
      memberships.to_json
    end
  end
end
