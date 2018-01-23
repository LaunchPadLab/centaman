module Centaman
  class Service::Package < Centaman::Service
    include Centaman::JsonWrapper

    attr_reader :membership_type_id

    def after_init(args)
      @membership_type_id = args.fetch(:membership_type_id, nil).try(:to_i)
    end

    def endpoint
      "/member_services/MembershipType?PackageID=#{membership_type_id}"
    end

    def object_class
      Centaman::Object::Package
    end

    def find(id)
      objects.detect {|obj| obj.id == id }
    end

    def additional_hash_to_serialize_after_response
      { membership_type_id: membership_type_id }
    end

    # def options_hash
    #   {
    #     'PackageID' => membership_type_id
    #   }.to_json
    # end
  end
end
