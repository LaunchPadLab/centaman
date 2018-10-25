module Centaman
  class Object::Udf < Centaman::Object
    attr_accessor :value, :field_name, :field_type, :field_length, :tab_name,
                  :options, :is_member_waiver, :is_booking_waiver, :is_attendee_udf,
                  :is_email

    def after_init(args)
      @value = args[:value]
      @field_name = args[:field_name]
      @field_type = args[:field_type]
      @field_length = args[:field_length]
      @is_member_waiver = args[:is_member_waiver]
      @is_booking_waiver = args[:is_booking_waiver]
      @is_attendee_udf = args[:is_attendee_udf]
      @tab_name = args[:tab_name]
      @options = args[:options]
      @is_email = args[:is_email]
    end
  end
end
