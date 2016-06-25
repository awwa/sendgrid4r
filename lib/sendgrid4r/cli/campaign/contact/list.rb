module SendGrid4r::CLI
  module Campaign
    module Contact
      #
      # SendGrid Web API v3 Marketing Campaigns - List
      #
      class List < SgThor
        desc 'create', 'Create a list'
        option :name, require: true
        def create
          puts @client.post_list(parameterise(options))
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'list', 'List lists'
        def list
          puts @client.get_lists
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'get', 'Get a list'
        option :list_id, type: :numeric, require: true
        def get
          puts @client.get_list(parameterise(options))
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'rename', 'Rename a list'
        option :list_id, type: :numeric, require: true
        option :name
        def rename
          puts @client.patch_list(parameterise(options))
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'delete', 'Delete lists'
        option :list_ids, type: :array, require: true
        def delete
          puts @client.delete_lists(parameterise(options))
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'recipient [add|remove|list]', 'Add, Remove, List a recipient'
        option :list_id, type: :numeric, require: true
        option :recipients, type: :array, desc: 'for add action'
        option :recipient_id, desc: 'for remove action'
        option :page, type: :numeric, desc: 'for list action'
        option :page_size, type: :numeric, desc: 'for list action'
        def recipient(action)
          case action
          when 'add'
            puts @client.post_recipients_to_list(parameterise(options))
          when 'remove'
            puts @client.delete_recipient_from_list(parameterise(options))
          when 'list'
            puts @client.get_recipients_from_list(parameterise(options))
          else
            puts "error: #{action} is not supported in action parameter"
          end
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end
      end
    end
  end
end
