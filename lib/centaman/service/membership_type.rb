module Centaman
  class Service::MembershipType < Centaman::Service
    include Centaman::JsonWrapper
    def endpoint
      '/member_services/MembershipType'
    end

    def object_class
      Centaman::Object::MembershipType
    end
  end
end
