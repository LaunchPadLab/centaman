require 'timeout'

module Centaman
  #:nodoc:
  class Wrapper
    DEFAULT_TIMEOUT_TIME = 15
    include HTTParty

    attr_reader :api_username, :api_password, :api_token, :api_url,
                :proxie_host, :proxie_port, :proxie_user, :proxie_password

    def initialize(args = {})
      # required
      @api_username = args.fetch(:api_username) { ENV['CENTAMAN_API_USERNAME'] }
      @api_password = args.fetch(:api_password) { ENV['CENTAMAN_API_PASSWORD'] }
      @api_url = args.fetch(:api_url) { ENV['CENTAMAN_API_URL'] }
      
      # optional
      @api_token = args.fetch(:api_token) { ENV['CENTAMAN_API_TOKEN'] || generate_token }      
      fixie_url = args.fetch(:fixie_url) { ENV['FIXIE_URL'] }
      fixie = fixie_url ? URI.parse(fixie_url) : nil
      @proxie_host = args.fetch(:proxie_host) { fixie.try(:host) }
      @proxie_port = args.fetch(:proxie_port) { fixie.try(:port) }
      @proxie_user = args.fetch(:proxie_user) { fixie.try(:user) }
      @proxie_password = args.fetch(:proxie_password) { fixie.try(:password) }
      after_init(args)
    end

    def headers
      { 'authorization' => "Basic #{api_token}", 'Content-Type' => 'application/json' }
    end

    def generate_token
      Base64.encode64("#{api_username}:#{api_password}")
    end

    def options
      [] # overwritten by children
    end

    def options_hash
      hash = {}
      options.each do |option_hash|
        next unless option_hash[:value].present?
        hash[option_hash[:key]] = option_hash[:value]
      end
      hash
    end

    def after_init(args = {})
      # hook method for subclasses
    end

    def payload(request_type = :get)
      hash = { payload_key(request_type) => options_hash }
      hash.merge(headers: headers).merge(proxy_hash)
    end

    def payload_key(request_type)
      request_type == :get ? :query : :body
    end

    def proxy_hash
      return {} unless proxie_host
      {
        http_proxyaddr: proxie_host,
        http_proxyport: proxie_port,
        http_proxyuser: proxie_user,
        http_proxypass: proxie_password,
      }
    end
    
    def wrap_request_in_case_of_timeout(proc, options = {})
      time = options.fetch(:timeout_time, DEFAULT_TIMEOUT_TIME)
      resp = nil
      begin
        resp = Timeout.timeout(time) do
          proc.call
        end
      rescue Timeout::Error
        p "*** CENTAMAN GEM TIMEOUT ***"
        raise Exceptions::CentamanTimeout
      end
      resp
    end    
  end
end
