module SendGrid4r::CLI
  module Supressions
    class Group < SgThor

      desc 'create', 'Create a new supression group'
      option :name, :require => true
      option :description, :require => true
      option :is_default, :type => :boolean
      def create
        puts @client.post_group(
          name: options[:name],
          description: options[:description],
          is_default: options[:is_default]
        )
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
      option :group_id, :require => true
      def get
        puts @client.get_group(group_id: options[:group_id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Update a supression group'
      option :group_id, :require => true
      option :name
      option :description
      def update
        group = {}
        group[:name] = options[:name] unless options[:name].nil?
        group[:description] = options[:description] unless options[:description].nil?
        puts @client.patch_group(
          group_id: options[:group_id],
          group: group
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete a supression group'
      option :group_id, :require => true
      def delete
        puts @client.delete_group(group_id: options[:group_id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
