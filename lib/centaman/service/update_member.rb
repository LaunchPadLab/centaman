require 'securerandom'

module Centaman
  class Service::UpdateMember < Centaman::Service
    include Centaman::JsonWrapper

    attr_reader :id, :first_name, :last_name, :address,
                :gender, :phone, :email, :password, :is_primary

    def after_init(args)
      @id = args[:id].try(:to_i)
      @first_name = args[:first_name]
      @last_name = args[:last_name]
      @address = args[:address].try(:symbolize_keys)
      @gender = args[:gender]
      @phone = args[:phone]
      @email = args[:email]
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
        'FirstName' => first_name,
        'LastName' => last_name,
        'homeAddress' => home_address,
        'Gender' => gender,
        'Email' => email,
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
        'street1': address[:street_address],
        'street2': '',
        'suburb': address[:city],
        'city': address[:city],
        'state': address[:state],
        'postcode': address[:zip],
        'country': address[:country],
        'homePhone': phone,
        'workPhone': '',
        'mobilePhone': ''
      }
    end

    def update_error(resp)
      message = { error: resp.parsed_response || 'Unable to update member record.' }
      raise message[:error]
    end
  end
end
