module Centaman
  class Service::AddOn < Centaman::Service
    include Centaman::JsonWrapper

    attr_reader :membership_type_id

    def after_init(args)
      @membership_type_id = args.fetch(:membership_type_id, nil).try(:to_i)
    end

    def endpoint
      "/member_services/MembershipType?PackageID=#{membership_type_id}"
    end

    def object_class
      Centaman::Object::AddOn
    end

    def self.find(membership_type_id, id)
      obj = new(membership_type_id: membership_type_id)
      obj.objects.detect { |obj| obj.id == id }
    end

    def additional_hash_to_serialize_after_response
      { membership_type_id: membership_type_id }
    end
  end
end
