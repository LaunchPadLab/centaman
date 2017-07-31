module Centaman
  class Service::GiftTicket < Centaman::Service
    attr_reader :department_id

    def after_init(args)
      super
      @department_id = args[:department_id] || 100067
    end

    def endpoint
      '/ticket_services/Ticket'
    end

    def default_object_class
      Centaman::Object::GiftTicket
    end

    def options
      super + [
        { key: 'DepartmentID', value: department_id }
      ]
    end
  end
end
