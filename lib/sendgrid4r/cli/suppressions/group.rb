module SendGrid4r::CLI
  module Suppressions
    #
    # SendGrid Web API v3 Suppressions Group
    #
    class Group < SgThor
      desc 'create', 'Create a new supression group'
      option :name, require: true
      option :description, require: true
      option :is_default, type: :boolean
      def create
        puts @client.post_group(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'list', 'List supression groups'
      def list
        puts @client.get_groups
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a supression group'
      option :group_id, require: true
      def get
        puts @client.get_group(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Update a supression group'
      option :group_id, require: true
      option :name
      option :description
      def update
        group = parameterise(options)
        group.delete(:group_id)
        puts @client.patch_group(
          group_id: options[:group_id],
          group: group
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete a supression group'
      option :group_id, require: true
      def delete
        puts @client.delete_group(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
