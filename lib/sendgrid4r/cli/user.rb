module SendGrid4r::CLI
  #
  # SendGrid Web API v3 User
  #
  class User < SgThor
    desc 'profile', 'Get or Update user Profile'
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
        params = {
          address: options[:address],       city: options[:city],
          company: options[:company],       country: options[:country],
          first_name: options[:first_name], last_name: options[:last_name],
          phone: options[:phone],           state: options[:state],
          website: options[:website],       zip: options[:zip]
        }
        params.delete_if { |_k, v| v.nil? }
        puts @client.patch_user_profile(params: params)
      else
        puts "error: #{action} is not supported in action parameter"
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end

    desc 'account', 'Get user account'
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

    desc 'email', 'Get or update user email'
    option :email
    def email(action)
      case action
      when 'get'
        puts @client.get_user_email
      when 'update'
        puts @client.put_user_email(email: options[:email])
      else
        puts "error: #{action} is not supported in action parameter"
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end

    desc 'username', 'Get or update username'
    option :username
    def username(action)
      case action
      when 'get'
        puts @client.get_user_username
      when 'update'
        puts @client.put_user_username(username: options[:username])
      else
        puts "error: #{action} is not supported in action parameter"
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end

    desc('password', 'Update password')
    option :new_password, require: true
    option :old_password, require: true
    def password(action)
      case action
      when 'update'
        puts @client.put_user_password(
          new_password: options[:new_password],
          old_password: options[:old_password]
        )
      else
        puts "error: #{action} is not supported in action parameter"
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.inspect
    end
  end
end
