module Centaman
  class Service::AuthenticateMember < Centaman::Service
    include Centaman::JsonWrapper

    attr_reader :member_number, :last_name, :email, :password

    def after_init(args)
      @member_number = args.fetch(:member_number, nil).try(:to_i)
      @last_name = args.fetch(:last_name, nil)
      @email = args.fetch(:email, nil)
      @password = args.fetch(:password, nil)
    end

    def endpoint
      '/member_services/Authentication'
    end

    def object_class
      Centaman::Object::Member
    end

    def build_object(resp)
      return build_objects(resp) if resp.respond_to?(:map)

      return auth_error(resp) unless resp.respond_to?(:merge)
      @build_object ||= object_class.new(resp.merge(additional_hash_to_serialize_after_response))
    end

    def options_hash
      {
        'MemberNumber' => member_number,
        'Surname' => last_name,
        'Email' => email,
        'Password' => password
      }.to_json
    end

    private

    def auth_error(resp)
      { error: resp.parsed_response || 'Authentication Failed. Invalid login credentials.' }
    end
  end
end
