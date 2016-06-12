module SendGrid4r::CLI
  module Settings
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
        puts @client.patch_enforced_tls(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
