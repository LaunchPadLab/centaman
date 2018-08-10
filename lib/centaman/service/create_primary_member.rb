require 'securerandom'

module Centaman
  class Service::CreatePrimaryMember < Centaman::Service
    include Centaman::JsonWrapper

    attr_reader :first_name, :last_name, :address, :gender, :title,
                :date_of_birth, :email, :password, :phone

    def after_init(args)
      @first_name = args[:first_name].try(:squish)
      @last_name = args[:last_name].try(:squish)
      @address = args[:address].try(:symbolize_keys)
      @gender = args[:gender].try(:squish)
      @title = args[:title].try(:squish)
      @date_of_birth = args[:date_of_birth]
      @email = args[:email].try(:squish)
      @phone = args[:phone]
      @password = args[:password] || SecureRandom.hex
    end

    def endpoint
      '/member_services/Member'
    end

    def object_class
      Centaman::Object::Member
    end

    def build_object(resp)
      return build_objects(resp) if resp.respond_to?(:map)
      return create_error(resp) unless resp.respond_to?(:merge)
      @build_object ||= object_class.new(resp.merge(additional_hash_to_serialize_after_response))
    end

    def options_hash
      [
        {
          'FirstName' => first_name.try(:upcase),
          'LastName' => last_name.try(:upcase),
          'HomeAddress' => home_address,
          'Gender' => gender,
          'Title' => title.try(:upcase),
          'DateOfBirth' => date_of_birth,
          'Email' => email.try(:upcase),
          'Password' => password,
          'IsPrimary' => true
        }
      ].to_json
    end

    def home_address
      return if !address
      {
        'street1': address[:street_address].try(:squish).try(:upcase),
        'street2': address[:street_address_two].try(:squish).try(:upcase),
        'suburb': address[:suburb].try(:squish).try(:upcase),
        'city': address[:city].try(:squish).try(:upcase),
        'state': address[:state].try(:squish).try(:upcase),
        'postcode': address[:zip].try(:squish).try(:upcase),
        'country': address[:country].try(:squish).try(:upcase),
        'homePhone': phone.try(:delete, "^0-9"),
        'workPhone': address[:work_phone].try(:delete, "^0-9"),
        'mobilePhone': address[:mobile_phone].try(:delete, "^0-9")
      }
    end

    private

    def create_error(resp)
      message = resp.parsed_response || 'Unable to create primary member record.'
      raise Centaman::Exceptions::CentamanError.new(message)
    end
  end
end
