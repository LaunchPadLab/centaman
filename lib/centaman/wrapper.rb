module Centaman
  #:nodoc:
  class Wrapper
    include HTTParty

    if ENV['FIXIE_URL']
      FIXIE = URI.parse(ENV['FIXIE_URL'])
      http_proxy FIXIE.host, FIXIE.port, FIXIE.user, FIXIE.password
    end

    attr_reader :api_username, :api_password, :api_token

    def initialize(args = {})
      @api_username = ENV['CENTAMAN_API_USERNAME']
      @api_password = ENV['CENTAMAN_API_PASSWORD']
      @api_token = ENV.fetch('CENTAMAN_API_TOKEN', generate_token)
      self.class.base_uri ENV['CENTAMAN_API_URL']
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
  end
end
