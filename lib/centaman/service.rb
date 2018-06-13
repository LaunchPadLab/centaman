module Centaman
  #:nodoc:
  class Service < Wrapper
    def after_init(args)
      # overwritten by subclasses
    end

    def fetch_all
      @get_request ||= begin
        req = Proc.new do
          self.class.get("#{api_url}#{endpoint}", payload(:get))
        end
        resp = wrap_request_in_case_of_timeout(req, timeout_time: 20)

        raise resp['Message'] if resp && resp.is_a?(Hash)
        raise Exceptions::CentamanTimeout unless resp && resp.success?
        resp
      end
    end

    def post
      @post_request ||= begin
        req = Proc.new do
          self.class.post("#{api_url}#{endpoint}", payload(:post))
        end
        resp = wrap_request_in_case_of_timeout(req)
        self.respond_to?(:build_object) ? after_post(resp) : resp
      end
    end

    def put
      @put_request ||= begin
        req = Proc.new do
          self.class.put("#{api_url}#{endpoint}", payload(:put))
        end
        resp = wrap_request_in_case_of_timeout(req)
        self.respond_to?(:build_object) ? after_post(resp) : resp
      end
    end

    def after_post(response)
      build_object(response)
    end
  end
end
