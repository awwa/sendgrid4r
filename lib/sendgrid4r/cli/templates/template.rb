module SendGrid4r::CLI
  module Templates
    #
    # SendGrid Web API v3 Templates
    #
    class Template < SgThor
      desc 'create', 'Create a template'
      option :name, require: true
      def create
        puts @client.post_template(name: options[:name])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'list', 'Retrieve all templates'
      def list
        puts @client.get_templates
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a template'
      option :id, require: true
      def get
        puts @client.get_template(template_id: options[:id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Edit a template'
      option :id, require: true
      option :name, require: true
      def update
        puts @client.patch_template(
          template_id: options[:id],
          name: options[:name]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete a template'
      option :id, require: true
      def delete
        puts @client.delete_template(template_id: options[:id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc('version SUBCOMMAND ...ARGS', 'Manage template versions')
      subcommand('version', Version)
    end
  end
end
