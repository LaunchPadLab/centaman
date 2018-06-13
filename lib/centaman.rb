require 'httparty'
require 'centaman/version'
require 'centaman/exceptions'
require 'centaman/wrapper'
require 'centaman/service'
require 'centaman/json_wrapper'
require 'centaman/object'
require 'centaman/filter'
require 'centaman/attribute'
require 'centaman/service/add_on'
require 'centaman/service/authenticate_member'
require 'centaman/service/booking_time'
require 'centaman/service/booking_type'
require 'centaman/service/capacity'
require 'centaman/service/coupon_check'
require 'centaman/service/create_customer'
require 'centaman/service/create_primary_member'
require 'centaman/service/create_secondary_member'
require 'centaman/service/create_udf'
require 'centaman/service/extra'
require 'centaman/service/gift_ticket'
require 'centaman/service/general_admission_ticket'
require 'centaman/service/hold_ticket'
require 'centaman/service/membership_type'
require 'centaman/service/member'
require 'centaman/service/purchase_membership'
require 'centaman/service/purchase_ticket'
require 'centaman/service/update_member'
require 'centaman/service/ticket_type'
require 'centaman/object/booking_time'
require 'centaman/object/booking_type'
require 'centaman/object/capacity'
require 'centaman/object/coupon_check'
require 'centaman/object/customer'
require 'centaman/object/effect'
require 'centaman/object/extra'
require 'centaman/object/gift_ticket'
require 'centaman/object/general_admission_ticket'
require 'centaman/object/member'
require 'centaman/object/membership_type'
require 'centaman/object/add_on'
require 'centaman/object/purchased_ticket'
require 'centaman/object/ticket_type'
require 'centaman/configuration'

module Centaman
  class << self  
    def configuration
      @config ||= Centaman::Configuration.new
    end

    def config
      yield configuration
    end
  end
end
