module SendGrid4r::CLI
  #
  # SendGrid Web API v3 Mail
  #
  class Mail < SgThor
    desc 'send', 'Send mail'
    option :to, type: :hash
    option :from, type: :hash, require: true
    option :content, type: :array, require: true
    option :subject, require: true
    def send
      to = SendGrid4r::Factory::MailFactory.create_address(
        parameterise(options[:to])
      )
      from = SendGrid4r::Factory::MailFactory.create_address(
        parameterise(options[:from])
      )
      per = SendGrid4r::Factory::MailFactory.create_personalization(to: [to])
      cont = options[:content].map do |c|
        hash = c.split(/[:,]/).each_slice(2).map do |k, v|
          [k.to_sym, v.nil? ? '' : v]
        end.to_h
        SendGrid4r::Factory::MailFactory.create_content(hash)
      end
      params = SendGrid4r::Factory::MailFactory.create_params(
        personalizations: [per], from: from, content: cont,
        subject: options[:subject]
      )
      puts @client.send(params: params)
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end
  end
end
