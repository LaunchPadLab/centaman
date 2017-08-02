require 'timeout'

module Centaman
  #:nodoc:
  class Service < Wrapper
    DEFAULT_TIMEOUT_TIME = 15

    def after_init(args)
      # overwritten by subclasses
    end

    def wrap_request_in_case_of_timeout(proc, options = {})
      time = options.fetch(:timeout_time, DEFAULT_TIMEOUT_TIME)
      resp = nil
      begin
        resp = Timeout.timeout(time) do
          proc.call
        end
      rescue Timeout::Error
        raise Exceptions::CentamanTimeout
      end
      resp
    end

    def fetch_all
      @get_request ||= begin
        req = Proc.new do
          self.class.get(endpoint, payload(:get))
        end
        resp = wrap_request_in_case_of_timeout(req, timeout_time: 20)

        raise resp['Message'] if resp.is_a?(Hash)
        resp
      end
    end

    def post
      @post_request ||= begin
        req = Proc.new do
          self.class.post(endpoint, payload(:post))
        end
        resp = wrap_request_in_case_of_timeout(req)
        after_post(resp)
      end
    end

    def after_post(response)
      raise "build_object is required for #{self.class.name} post requests" unless self.respond_to?(:build_object)
      build_object(response)
    end

    def payload(request_type = :get)
      hash = { payload_key(request_type) => options_hash }
      hash.merge(headers: headers)
    end

    def payload_key(request_type)
      request_type == :get ? :query : :body
    end
  end
end