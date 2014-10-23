module SendGrid4r
  class Auth

    def initialize(username, password)
      @username = username
      @password = password
    end

    def get_username
      @username
    end

    def get_password
      @password
    end

  end
end
