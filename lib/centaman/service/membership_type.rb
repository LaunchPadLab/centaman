module Centaman
  class Service::MembershipType < Centaman::Service
    include Centaman::JsonWrapper

    def endpoint
      '/member_services/MembershipType'
    end

    def object_class
      Centaman::Object::MembershipType
    end

    def self.find(id)
      new.objects.detect {|obj| obj.id == id }
    end
  end
end
