module Centaman
  #:nodoc:
  class Service::CreateCustomer < Centaman::Service
    attr_reader :first_name, :last_name, :email, :phone

    def after_init(args)
      super
      @first_name = args[:first_name]
      @last_name = args[:last_name]
      @email = args[:email]
      @phone = args[:phone]
    end

    def endpoint
      '/ticket_services/TimedTicket'
    end

    def default_object_class
      Centaman::Object::Customer
    end

    # rubocop:disable Metrics/MethodLength
    def address
      {
        'Street1' => '',
        'Street2' => '',
        'City' => '',
        'State' => '',
        'Postalcode' => '',
        'Country' => '',
        'HomePhone' => phone,
        'WorkPhone' => '',
        'MobilePhone' => ''
      }
    end
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    def options_hash
      {
        'FirstName' => first_name,
        'LastName' => last_name,
        'Email' => email,
        'Address' => address
      }.to_json
    end
  end
end
