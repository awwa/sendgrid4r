module SendGrid4r::CLI
  #
  # SendGrid Web API v3 Category
  #
  class Category < SgThor
    desc 'list', 'List categories'
    option :category
    option :limit, type: :numeric
    option :offset, type: :numeric
    def list
      puts @client.get_categories(parameterise(options))
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end
  end
end
