module Centaman
  class Service::GeneralAdmissionTicket < Centaman::Service
    include Centaman::JsonWrapper
    attr_reader :department_id

    def after_init(args)
      @department_id = args[:department_id]
    end

    def endpoint
      '/ticket_services/Ticket'
    end

    def object_class
      Centaman::Object::GeneralAdmissionTicket
    end

    def options
      super + [
        { key: 'DepartmentID', value: department_id }
      ]
    end
  end
end
