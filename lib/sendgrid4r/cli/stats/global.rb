module SendGrid4r::CLI
  module Stats
    #
    # SendGrid Web API v3 Stats Global
    #
    class Global < SgThor
      desc 'get', 'Gets all of your user’s email statistics.'
      option :start_date, banner: SgThor::ISO, require: true
      option :end_date, banner: SgThor::ISO
      option :aggregated_by, banner: SgThor::AGG
      def get
        puts @client.get_global_stats(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
