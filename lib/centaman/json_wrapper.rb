module Centaman
  #:nodoc:
  module JsonWrapper
    def objects
      @all ||= build_objects(self.fetch_all)
    end

    # i.e. from GET of an index
    def build_objects(resp)
      return [] unless resp.respond_to?(:map)
      @tickets = resp.map do |ticket_hash|
        object_class.new(ticket_hash.merge(additional_hash_to_serialize_after_response))
      end
    end

    # i.e. from GET of a show or POST
    def build_object(resp)
      return resp unless resp.respond_to?(:merge)
      @build_object ||= object_class.new(resp.merge(additional_hash_to_serialize_after_response))
    end

    def additional_hash_to_serialize_after_response
      {}
    end

    def object_class
      raise "object_class is required for #{self.class.name}"
    end
  end
end