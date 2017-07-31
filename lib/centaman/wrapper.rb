module Centaman
  #:nodoc:
  class Wrapper
    # FIXIE = URI.parse(ENV['FIXIE_URL'])

    include HTTParty    
    # http_proxy FIXIE.host, FIXIE.port, FIXIE.user, FIXIE.password

    attr_reader :api_username, :api_password

    def initialize(args = {})
      @api_username = ENV['API_USERNAME']
      @api_password = ENV['API_PASSWORD']
      self.class.base_uri ENV['CENTAMAN_API']
      after_init(args)
    end

    def headers
      { 'authorization' => "Basic #{encoded_string}", 'Content-Type' => 'application/json' }
    end

    def encoded_string
      @encoded_string ||= Base64.encode64("#{api_username}:#{api_password}")
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
  end
end
