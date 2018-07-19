module Centaman
  class Service::CostRate < Centaman::Service
    include Centaman::JsonWrapper
    attr_reader :first_name, :last_name, :email, :primary_member_id

    def after_init(args={})
      @first_name = args.fetch(:first_name, nil)
      @last_name = args.fetch(:last_name, nil)
      @email = args.fetch(:email, nil)
      @primary_member_id = args.fetch(:primary_member_id, nil)
    end

    def object_class
      Centaman::Object::CostRate
    end

    def endpoint
      '/ticket_services/TimedTicket'
    end

    def options
      super + [
        { key: 'FirstName', value: first_name },
        { key: 'LastName', value: last_name },
        { key: 'Email', value: email }
      ]
    end

    def build_objects(resp)
      return [] unless resp.respond_to?(:map)
      return build_object(resp) if resp.respond_to?(:merge)
      @tickets = resp.map do |ticket_hash|
        object_class.new(ticket_hash.merge(additional_hash_to_serialize_after_response))
      end
    end
  end
end
