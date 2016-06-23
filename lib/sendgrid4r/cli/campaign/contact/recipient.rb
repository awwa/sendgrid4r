module SendGrid4r::CLI
  module Campaign
    module Contact
      #
      # SendGrid Web API v3 Marketing Campaigns - Recipient
      #
      class Recipient < SgThor
        desc 'create', 'Create a recipient'
        option :params, type: :hash, require: true
        def create
          puts @client.post_recipients(
            params: [parameterise(options[:params])]
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'update', 'Update a recipient'
        option :params, type: :hash, require: true
        def update
          puts @client.patch_recipients(
            params: [parameterise(options[:params])]
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'delete', 'Delete recipients'
        option :recipient_ids, type: :array, require: true
        def delete
          puts @client.delete_recipients(parameterise(options))
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'list', 'List recipients'
        option :page
        option :page_size
        def list
          puts @client.get_recipients(parameterise(options))
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'get', 'Get a recipient'
        option :recipient_id, require: true
        def get
          puts @client.get_recipient(parameterise(options))
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'count', 'Get recipients count'
        def count
          puts @client.get_recipients_count
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'search', 'Search recipients'
        option :params, type: :hash, require: true
        def search
          puts @client.search_recipients(params: options[:params])
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'belong', 'List lists a recipient belongs to'
        option :recipient_id, require: true
        def belong
          puts @client.get_lists_recipient_belong(parameterise(options))
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end
      end
    end
  end
end
