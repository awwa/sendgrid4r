module SendGrid4r::CLI
  module Settings
    #
    # SendGrid Web API v3 Settings EnforcedTls
    #
    class EnforcedTls < SgThor
      desc 'get', 'Get the current Enforced TLS settings'
      def get
        puts @client.get_enforced_tls
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Change the Enforced TLS settings'
      option :require_tls
      option :require_valid_cert
      def update
        params = {
          require_tls: options[:require_tls],
          require_valid_cert: options[:require_valid_cert]
        }
        puts @client.patch_enforced_tls(params: params)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
