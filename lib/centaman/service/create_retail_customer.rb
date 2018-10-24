module Centaman
  #:nodoc:
  class Service::CreateRetailCustomer < Centaman::Service::CreateCustomer
    def endpoint
      '/retail_services/RetailContact'
    end
  end
end
