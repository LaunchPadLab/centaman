module Centaman
  class Service::PurchaseMembership < Centaman::Service
    attr_reader :payment_reference, :order_info, :checkout_service, :coupon_service,
                :members, :add_ons, :membership_type_id, :memberships,
                :is_new, :coupon, :has_card_discount, :join_date, :expiry_date, :purchaser_renewal

    def after_init(args={})
      @payment_reference = args[:payment_reference]
      @order_info = args[:order_info]
      @is_new = args.fetch(:is_new, false)
      @has_card_discount = @order_info.fnbo_discount
      @checkout_service = args[:checkout_service]
      @coupon_service = args[:coupon_service]
      @membership_type_id = @order_info.membership_type_id
      @members = args.fetch(:members, [])
      @add_ons = @checkout_service.add_ons
      @memberships = []
      @coupon = @coupon_service.valid_coupon
      @join_date = args.fetch(:join_date, nil)
      @expiry_date = args.fetch(:expiry_date, nil)
      @purchaser_renewal = args.fetch(:purchaser_renewal, false)
      # build_membership_request
    end

    def endpoint
      "/member_services/Membership?isNew=#{is_new}"
    end

    def membership_payload(member, add_on)
      p 'dates'
      p join_date, expiry_date
      payload = {
        'MemberCode': member.id,
        'TypeCode': add_on.id,
        'Cost': add_on.cost,
        'Tax': checkout_service.add_on_tax(add_on),
        'Paid': add_on.pay_price,
        'PackageID': membership_type_id,
        'PurchaserRenewal': purchaser_renewal,
        'PaymentGatewayReference': payment_reference,
        'JoinDate': join_date,
        'ExpiryDate': expiry_date
      }.compact
      payload = coupon.present? ? payload.merge(coupon_args(add_on)) : payload
      payload = has_card_discount ? payload.merge(card_discount_args(add_on)) : payload
    end

    def coupon_args(add_on)
      return {} unless coupon_service.coupon_applies(add_on)
      {
        'Coupon': {
          "CouponCode": coupon.code,
          "DiscountAmount": coupon_service.amount_saved(add_on),
          "StockID": coupon.stock_code
        }
      }
    end

    def card_discount_args(add_on)
      return {} unless add_on.add_on_type == 'primary'
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

    # def renewal_request
    #   p "build renewal_request"
    #   renewal_members.map do |m|
    #     order_info.add_ons_for_member(add_ons, m.member_type).each do |ao|
    #       @renewal_memberships << membership_payload(m, ao)
    #     end
    #   end
    #   @renewal_memberships = @renewal_memberships.uniq
    # end

    # def new_membership_request
    #   p "building new_membership_request"
    #   new_members.map do |m|
    #     order_info.add_ons_for_member(add_ons, m.member_type).each do |ao|
    #       @new_memberships << membership_payload(m, ao)
    #     end
    #   end
    #   @new_memberships = @new_memberships.uniq
    # end

    def build_membership_request
      p "build request"
      members.map do |m|
        order_info.add_ons_for_member(add_ons, m.member_type).each do |ao|
          @memberships << membership_payload(m, ao)
        end
      end
      @memberships
    end

    def options_hash
      p "*** PAYLOAD ***"
      p build_membership_request
      memberships.to_json
      # p @new_memberships if is_new
      # p @renewal_memberships if !is_new
    end
  end
end
