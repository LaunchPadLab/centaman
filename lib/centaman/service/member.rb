module Centaman
  class Service::Member < Centaman::Service
    include Centaman::JsonWrapper

    attr_reader :member_code, :email

    def after_init(args)
      @member_code = args.fetch(:member_code, nil).try(:to_i)
      @email = args.fetch(:email, nil)
      required_args
    end

    def endpoint
      member_code ? member_endpoint(:member_code) : member_endpoint(:email)
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

    def member_endpoint(attr_key)
      attr_val = self.send(attr_key)
      endpoint_url(attr_key, attr_val)
    end

    def endpoint_url(key, val)
      endpoint_options = {
        member_code: "/member_services/Member/#{val}",
        email: "/member_services/Member?email=#{val}"
      }
      endpoint_options[key]
    end

    def args_missing
      arg_missing = [member_code, email].compact.empty?
    end

    def required_args
      raise "missing required arguments. #{self.class} must be instantiated with a :member_code or :email" if args_missing
    end

    def not_found(resp)
      { error: resp.parsed_response ? resp.parsed_response : 'Member not found' }
    end
  end
end
