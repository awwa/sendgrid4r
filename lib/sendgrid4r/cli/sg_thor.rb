module SendGrid4r::CLI
  #
  # SendGrid Web API v3 SgThor
  #
  class SgThor < Thor
    class_option :api_key, desc: 'API Key'
    class_option :user, desc: 'SendGrid username for Basic Auth'
    class_option :pass, desc: 'SendGrid password for Basic Auth'

    def initialize(*args)
      super
      @client = SendGrid4r::Client.new(
        username: options[:user], password: options[:pass],
        api_key: options[:api_key], raw_response: true
      )
    end

    protected

    def parameterise(options)
      # symbolize keys
      params = options.each_with_object({}) do |(k, v), memo|
        memo[k.to_s.to_sym] = v
      end
      # remove auth info
      params.delete(:api_key)
      params.delete(:user)
      params.delete(:pass)
      # remove empty key and value
      params.delete_if { |_k, v| v.nil? }
      params
    end
  end
end
