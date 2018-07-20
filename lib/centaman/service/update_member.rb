require 'securerandom'

module Centaman
  class Service::UpdateMember < Centaman::Service
    include Centaman::JsonWrapper

    attr_reader :id, :first_name, :last_name, :address,
                :gender, :phone, :email, :password, :is_primary

    def after_init(args)
      @id = args[:id].try(:to_i)
      @first_name = args[:first_name].try(:squish)
      @last_name = args[:last_name].try(:squish)
      @address = args[:address].try(:symbolize_keys)
      @gender = args[:gender]
      @phone = args[:phone]
      @email = args[:email].try(:squish)
      @password = args[:password]
      @is_primary = args[:is_primary]
    end

    def endpoint
      "/member_services/Member/#{id}"
    end

    def object_class
      Centaman::Object::Member
    end

    def build_object(resp)
      return update_error(resp) unless resp.respond_to?(:merge)
      @build_object ||= object_class.new(resp.merge(additional_hash_to_serialize_after_response))
    end

    def options_hash_no_json
      {
        'FirstName' => first_name.try(:upcase),
        'LastName' => last_name.try(:upcase),
        'HomeAddress' => home_address,
        'Gender' => gender,
        'Email' => email.try(:upcase),
        'Password' => password,
        'IsPrimary' => is_primary
      }
    end

    def options_hash
      options_hash_no_json.compact.to_json
    end

    private

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

    def update_error(resp)
      message = resp.parsed_response || 'Unable to update member record.'
      raise Centaman::Exceptions::CentamanError.new(message)
    end
  end
end
