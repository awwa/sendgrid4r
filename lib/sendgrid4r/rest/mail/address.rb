# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Mail
  #
  module Mail
    Address = Struct.new(:email, :name) do
      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
