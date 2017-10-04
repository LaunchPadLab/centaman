module Centaman
  class Service::CouponCheck < Centaman::Service
    include Centaman::JsonWrapper
    attr_reader :coupon_code, :product_area

    def after_init(args)
      @coupon_code = args[:coupon_code]
      @product_area = args[:product_area]
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
        'ProductArea' => product_area
      }.to_json
    end

    def required_fields
      [coupon_code, product_area]
    end

    def require_args
      raise "coupon_code and product_area required for #{self.class.name}" if required_fields.include?(nil)
    end
  end
end
