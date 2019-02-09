module Centaman
  #:nodoc:
  class Service::CreateCustomer < Centaman::Service
    include Centaman::JsonWrapper
    attr_accessor :first_name, :last_name, :email, :phone, :address, :attendees

    def after_init(args)
      @first_name = args.fetch(:first_name, nil)
      @last_name = args.fetch(:last_name, nil)
      @email = args.fetch(:email, nil)
      @phone = args.fetch(:phone, nil)
      @address = args.fetch(:address, nil) || {}
      @attendees = args.fetch(:attendees, nil) || []
    end

    def endpoint
      '/ticket_services/TimedTicket'
    end

    def object_class
      Centaman::Object::Customer
    end

    def build_address
      {
        'Street1' => address[:street_address1] || '',
        'Street2' => address[:street_address2] || '',
        'City' => address[:city] || '',
        'State' => address[:state] || '',
        'Postalcode' => address[:zip] || '',
        'Country' => address[:country] || '',
        'HomePhone' => phone || '',
        'WorkPhone' => '',
        'MobilePhone' => ''
      }
    end

    def build_booking_attendees
      attendees.map do |attendee|
        udfs = attendee.try(:attendee_udfs)
        attendee_email = udfs && udfs.detect { |u| u.try(:is_email) && u.try(:value).present? }.try(:value)
        {
          'FirstName': attendee.first_name,
          'LastName': attendee.last_name,
          'Email': attendee.email.present? ? attendee.email : (attendee_email || random_email(attendee))
        }
      end
    end

    def random_email(attendee)
      # force creation of new member by setting new email
      [attendee.first_name.try(:squish), attendee.last_name.try(:squish), SecureRandom.hex(2)]
        .reject { |obj| obj.blank? }
        .join('.') + '@example.com'
        .squish
    end

    def options_hash
      {
        'FirstName' => first_name || '',
        'LastName' => last_name || '',
        'Email' => email,
        'Address' => build_address,
        'BookingAttendee': build_booking_attendees
      }.compact.to_json
    end
  end
end
