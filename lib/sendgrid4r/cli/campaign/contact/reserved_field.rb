module SendGrid4r::CLI
  module Campaign
    module Contact
      #
      # SendGrid Web API v3 Marketing Campaigns - Reserved Field
      #
      class ReservedField < SgThor
        desc 'list', 'List reserved fields'
        def list
          puts @client.get_reserved_fields
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end
      end
    end
  end
end
