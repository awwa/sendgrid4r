module SendGrid4r::CLI
  #
  # SendGrid Web API v3 User
  #
  class User < SgThor
    desc 'profile [get|update]', 'Get or Update user Profile'
    option :address
    option :city
    option :company
    option :country
    option :first_name
    option :last_name
    option :phone
    option :state
    option :website
    option :zip
    def profile(action)
      case action
      when 'get'
        puts @client.get_user_profile
      when 'update'
        puts @client.patch_user_profile(params: parameterise(options))
      else
        puts "error: #{action} is not supported in action parameter"
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end

    desc 'account [get]', 'Get user account'
    def account(action)
      case action
      when 'get'
        puts @client.get_user_account
      else
        puts "error: #{action} is not supported in action parameter"
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end

    desc 'email [get|update]', 'Get or update user email'
    option :email
    def email(action)
      case action
      when 'get'
        puts @client.get_user_email
      when 'update'
        puts @client.put_user_email(parameterise(options))
      else
        puts "error: #{action} is not supported in action parameter"
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end

    desc 'username [get|update]', 'Get or update username'
    option :username
    def username(action)
      case action
      when 'get'
        puts @client.get_user_username
      when 'update'
        puts @client.put_user_username(parameterise(options))
      else
        puts "error: #{action} is not supported in action parameter"
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end

    desc('password [update]', 'Update password')
    option :new_password, require: true
    option :old_password, require: true
    def password(action)
      case action
      when 'update'
        puts @client.put_user_password(parameterise(options))
      else
        puts "error: #{action} is not supported in action parameter"
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end
  end
end
