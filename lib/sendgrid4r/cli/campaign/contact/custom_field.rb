module SendGrid4r::CLI
  module Campaign
    module Contact
      #
      # SendGrid Web API v3 Marketing Campaigns
      #
      class CustomField < SgThor
        desc 'create', 'Create a custom field'
        option :name, require: true
        option :type, require: true
        def create
          puts @client.post_custom_field(parameterise(options))
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'list', 'List custom fields'
        def list
          puts @client.get_custom_fields
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'get', 'Get a custom field'
        option :custom_field_id, require: true
        def get
          puts @client.get_custom_field(parameterise(options))
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'delete', 'Delete a custom field'
        option :custom_field_id, require: true
        def delete
          puts @client.delete_custom_field(parameterise(options))
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end
      end
    end
  end
end
