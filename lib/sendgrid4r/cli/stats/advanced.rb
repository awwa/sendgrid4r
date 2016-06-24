module SendGrid4r::CLI
  module Stats
    #
    # SendGrid Web API v3 Stats Advanced
    #
    class Advanced < SgThor
      desc 'geo', 'Gets email statistics by country and state/province'
      option :start_date, banner: SgThor::ISO, require: true
      option :end_date, banner: SgThor::ISO
      option :aggregated_by, banner: SgThor::AGG
      option :country, banner: '[US|CA]'
      def geo
        puts @client.get_geo_stats(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'device', 'Gets email statistics by device type'
      option :start_date, banner: SgThor::ISO, require: true
      option :end_date, banner: SgThor::ISO
      option :aggregated_by, banner: SgThor::AGG
      def device
        puts @client.get_devices_stats(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'client', 'Gets email statistics by client type'
      option :start_date, banner: SgThor::ISO, require: true
      option :end_date, banner: SgThor::ISO
      option :aggregated_by, banner: SgThor::AGG
      def client
        puts @client.get_clients_stats(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'client_type', 'Gets email statistics for a single client type'
      option :start_date, banner: SgThor::ISO, require: true
      option :end_date, banner: SgThor::ISO
      option :aggregated_by, banner: SgThor::AGG
      option(
        :client_type, banner: '[phone|tablet|webmail|desktop]', require: true
      )
      def client_type
        puts @client.get_clients_type_stats(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'mailbox_provider', 'Gets email statistics by mailbox provider'
      option :start_date, banner: SgThor::ISO, require: true
      option :end_date, banner: SgThor::ISO
      option :aggregated_by, banner: SgThor::AGG
      option :mailbox_providers
      def mailbox_provider
        puts @client.get_mailbox_providers_stats(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'browser', 'Gets email statistics by browser'
      option :start_date, banner: SgThor::ISO, require: true
      option :end_date, banner: SgThor::ISO
      option :aggregated_by, banner: SgThor::AGG
      option :browsers
      def browser
        puts @client.get_browsers_stats(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
