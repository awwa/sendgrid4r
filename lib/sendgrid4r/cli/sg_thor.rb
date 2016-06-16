module SendGrid4r::CLI
  #
  # SendGrid Web API v3 SgThor
  #
  class SgThor < Thor
    class_option :api_key
    class_option :username
    class_option :password

    def initialize(*args)
      super
      @client = SendGrid4r::Client.new(
        username: options[:username], password: options[:password],
        api_key: options[:api_key], raw_response: true
      )
    end
  end
end
