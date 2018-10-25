module Centaman
  class Object::Customer < Centaman::Object
    attr_reader :address, :phone, :attendees
    # rubocop:disable Metrics/MethodLength

    def after_init(args)
      @address = args["Address"]
      @phone = args["Address"]["HomePhone"]
      @attendees = build_booking_attendees(args["BookingAttendee"])
    end

    def build_booking_attendees(booking_attendees = [])
      booking_attendees.map { |a| Centaman::Object::AttendeeDetail.new(a) }
    end

    def attributes
      [
        Centaman::Attribute.new(
          centaman_key: 'MemberCode',
          app_key: :member_code,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'FirstName',
          app_key: :first_name,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'LastName',
          app_key: :last_name,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'Email',
          app_key: :email,
          type: :string
        ),
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
