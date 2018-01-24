module Centaman
  class Service::Member < Centaman::Service
    include Centaman::JsonWrapper

    attr_reader :member_code

    def after_init(args)
      @member_code = args.fetch(:member_code, nil).try(:to_i)
    end

    def endpoint
      "/member_services/Member/#{member_code}"
    end

    def object_class
      Centaman::Object::Member
    end

    def build_object(resp)
      return build_objects(resp) if resp.respond_to?(:map)

      return not_found(resp) unless resp.respond_to?(:merge)
      @build_object ||= object_class.new(resp.merge(additional_hash_to_serialize_after_response))
    end

    def self.find(id)
      obj = new(member_code: id)
      obj.objects.detect { |obj| obj.id == id }
    end

    private

    def not_found(resp)
      { error: resp.parsed_response ? resp.parsed_response : 'Member not found' }
    end
  end
end
