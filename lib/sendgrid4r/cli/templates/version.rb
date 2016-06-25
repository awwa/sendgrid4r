module SendGrid4r::CLI
  module Templates
    #
    # SendGrid Web API v3 Templates Version
    #
    class Version < SgThor
      desc 'create', 'Create a version'
      option :template_id, require: true
      option :name, require: true
      option :subject, require: true
      option :html_content, require: true
      option :plain_content, require: true
      option :active, type: :numeric, banner: '[0|1]'
      def create
        factory = SendGrid4r::Factory::VersionFactory.new
        params = parameterise(options)
        params.delete(:template_id)
        version = factory.create(params)
        puts @client.post_version(
          template_id: options[:template_id],
          version: version
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'activate', 'Activate a version'
      option :template_id, require: true
      option :version_id, require: true
      def activate
        puts @client.activate_version(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a version'
      option :template_id, require: true
      option :version_id, require: true
      def get
        puts @client.get_version(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Edit a version'
      option :template_id, require: true
      option :version_id, require: true
      option :name
      option :subject
      option :html_content
      option :plain_content
      option :active, type: :numeric, banner: '[0|1]'
      def update
        factory = SendGrid4r::Factory::VersionFactory.new
        params = parameterise(options)
        params.delete(:template_id)
        params.delete(:version_id)
        version = factory.create(params)
        puts @client.patch_version(
          template_id: options[:template_id],
          version_id: options[:version_id],
          version: version
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete a version'
      option :template_id, require: true
      option :version_id, require: true
      def delete
        puts @client.delete_version(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
