module SendGrid4r::CLI
  class Category < SgThor
    desc 'list', 'List categories'
    option :category
    option :limit, :type => :numeric
    option :offset, :type => :numeric
    def list
      puts @client.get_categories(
        category: options[:category], limit: options[:limit],
        offset: options[:offset]
      )
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end
  end
end
