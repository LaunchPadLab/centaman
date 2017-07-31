module Centaman
  class Service::CouponCheck < Centaman::Service
    attr_reader :coupon_code

    def after_init(args)
      @coupon_code = args[:coupon_code]
      require_args
    end

    def endpoint
      '/coupon_services/check'
    end

    def object_class
      Centaman::Object::CouponCheck
    end

    def options_hash
      {
        'CouponCode' => coupon_code,
        'ProductArea' => 'TimedTickets'
      }.to_json
    end

    def require_args
      raise "coupon_code is required for #{self.class.name}" if coupon_code.nil?
    end
  end
end
