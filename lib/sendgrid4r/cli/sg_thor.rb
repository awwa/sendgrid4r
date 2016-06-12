module SendGrid4r::CLI
  class SgThor < Thor
    class_option :apikey
    class_option :username
    class_option :password

    def initialize(*args)
      super
      @client = SendGrid4r::Client.new(
        username: options[:username], password: options[:password],
        api_key: options[:apikey], raw_response: true
      )
    end
  end
end
