# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Suppression Management
  #
  module Sm
    include Request

    RecipientEmails = Struct.new(:recipient_emails)
    RecipientEmail = Struct.new(:recipient_email)

    def self.create_recipient_emails(resp)
      return resp if resp.nil?
      RecipientEmails.new(resp['recipient_emails'])
    end

    def self.create_recipient_email(resp)
      return resp if resp.nil?
      RecipientEmail.new(resp['recipient_email'])
    end
  end
end
