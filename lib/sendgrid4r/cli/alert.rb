module SendGrid4r::CLI
  #
  # SendGrid Web API v3 Alert
  #
  class Alert < SgThor
    desc 'list', 'List alerts'
    def list
      puts @client.get_alerts
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end

    desc 'create', 'Create an alert'
    option :type, banner: '[stats_notification|usage_limit]', require: true
    option :email_to, require: true
    option :percentage, type: :numeric
    option :frequency, banner: '[daily|weekly|monthly]'
    def create
      puts @client.post_alert(parameterise(options))
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end

    desc 'get', 'Get an alert'
    option :alert_id, type: :numeric, require: true
    def get
      puts @client.get_alert(parameterise(options))
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end

    desc 'delete', 'Delete an alert'
    option :alert_id, type: :numeric, require: true
    def delete
      puts @client.delete_alert(parameterise(options))
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end

    desc 'update', 'Update an alert'
    option :alert_id, type: :numeric, require: true
    option :email_to, require: true
    option :percentage, type: :numeric
    option :frequency, banner: '[daily|weekly|monthly]'
    def update
      puts @client.patch_alert(parameterise(options))
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end
  end
end
