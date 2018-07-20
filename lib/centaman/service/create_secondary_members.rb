require 'securerandom'

module Centaman
  class Service::CreateSecondaryMembers < Centaman::Service
    include Centaman::JsonWrapper

    attr_reader :primary_member_id, :secondary_members

    def after_init(args)
      @primary_member_id = args.fetch(:primary_member_id, nil)
      @secondary_members = args.fetch(:secondary_members, [])
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
      request_body = secondary_members.map { |m| build_member(m) }
      request_body.to_json
    end

    private

    def build_member(member)
      {
        'FirstName' => member.first_name.try(:squish).try(:upcase),
        'LastName' => member.last_name.try(:squish).try(:upcase),
        'Gender' => member.gender.try(:squish),
        'Title' => member.title.try(:squish).try(:upcase),
        'DateOfBirth' => member.date_of_birth,
        'IsPrimary' => false,
        'PrimaryMemberId' => primary_member_id
      }
    end

    def create_error(resp)
      message = resp.parsed_response || 'Unable to create the member record(s).'
      raise Centaman::Exceptions::CentamanError.new(message)
    end
  end
end
