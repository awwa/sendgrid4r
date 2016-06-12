module SendGrid4r::CLI
  module Templates
    class Version < SgThor

      desc 'create', 'Create a version'
      option :template_id, :require => true
      option :name, :require => true
      option :subject, :require => true
      option :html_content, :require => true
      option :plain_content, :require => true
      option :active, :type => :numeric
      def create
        factory = SendGrid4r::Factory::VersionFactory.new
        version = factory.create(
          name: options[:name],
          subject: options[:subject],
          html_content: options[:html_content],
          plain_content: options[:plain_content],
          active: options[:active]
        )
        puts @client.post_version(
          template_id: options[:template_id],
          version: version
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'activate', 'Activate a version'
      option :template_id, :require => true
      option :version_id, :require => true
      def activate
        puts @client.activate_version(
          template_id: options[:template_id],
          version_id: options[:version_id]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a version'
      option :template_id, :require => true
      option :version_id, :require => true
      def get
        puts @client.get_version(
          template_id: options[:template_id],
          version_id: options[:version_id]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Edit a version'
      option :template_id, :require => true
      option :version_id, :require => true
      option :name
      option :subject
      option :html_content
      option :plain_content
      option :active
      def update
        factory = SendGrid4r::Factory::VersionFactory.new
        version = factory.create(
          name: options[:name],
          subject: options[:subject],
          html_content: options[:html_content],
          plain_content: options[:plain_content],
          active: options[:active]
        )
        puts @client.patch_version(
          template_id: options[:template_id],
          version_id: options[:version_id],
          version: version
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete a version'
      option :template_id, :require => true
      option :version_id, :require => true
      def delete
        puts @client.delete_version(
          template_id: options[:template_id],
          version_id: options[:version_id]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
