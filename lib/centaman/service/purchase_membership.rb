module Centaman
  class Service::PurchaseMembership < Centaman::Service
    attr_reader :payment_reference, :order_info, :checkout_service,
                :members, :memberships, :add_ons, :membership_type_id,
                :is_new, :purchaser_renewal

    def after_init(args)
      @payment_reference = args[:payment_reference]
      @is_new = args.fetch(:is_new, true)
      @order_info = args[:order_info]
      @purchaser_renewal = order_info.is_renewal
      @checkout_service = args[:checkout_service]
      @membership_type_id = @order_info.membership_type_id
      @members = @order_info.members
      @add_ons = @checkout_service.add_ons
      @memberships = []
      build_membership_request
    end

    def endpoint
      "/member_services/Membership?isNew=#{is_new}"
    end

    def membership_payload(member_id, add_on)
      {
        'MemberCode': member_id,
        'TypeCode': add_on.id,
        'Cost': add_on.cost,
        'Tax': 0,
        'Paid': add_on.pay_price,
        'PackageID': membership_type_id,
        'PurchaserRenewal': purchaser_renewal
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
      memberships.to_json
    end
  end
end
