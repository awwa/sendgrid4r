module SendGrid4r::CLI
  #
  # SendGrid Web API v3 SgThor
  #
  class SgThor < Thor
    ISO = 'YYYY-MM-DD'
    UTS = 'UNIX TIMESTAMP'
    AGG = '[day|week|month]'
    DIR = '[desc|asc]'
    TYP = '[date|text|number]'

    class_option :api_key, aliases: '-k', desc: 'API Key for APIKey Auth'
    class_option :user, aliases: '-u', desc: 'Username for Basic Auth'
    class_option :pass, aliases: '-p', desc: 'Password for Basic Auth'
    class_option(
      :envkey,
      aliases: '-e',
      desc: 'Load API Key from environment variable "SG_API_KEY"',
      banner: ''
    )

    def initialize(*args)
      super
      api_key = options[:api_key]
      api_key = ENV['SG_API_KEY'] if options[:envkey]
      @client = SendGrid4r::Client.new(
        username: options[:user], password: options[:pass],
        api_key: api_key, raw_response: true
      )
    end

    protected

    def parameterise(options)
      # symbolize keys
      params = options.each_with_object({}) do |(k, v), memo|
        memo[k.to_s.to_sym] = v
      end
      params.tap do |p|
        # remove auth info
        p.delete(:api_key)
        p.delete(:user)
        p.delete(:pass)
        p.delete(:e)
        # remove empty key and value
        p.delete_if { |_k, v| v.nil? }
      end
    end
  end
end
