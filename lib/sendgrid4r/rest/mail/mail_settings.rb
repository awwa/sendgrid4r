# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Mail
  #
  module Mail
    MailSettings = Struct.new(
      :bcc, :bypass_list_management, :footer, :sandbox_mode, :spam_check
    ) do
      def enable_bcc(email)
        self[:bcc] = {enable: true, email: email}
        self
      end

      def disable_bcc
        self[:bcc] = { enable: false }
        self
      end

      def enable_bypass_list_management
        self[:bypass_list_management] = { enable: true }
        self
      end

      def disable_bypass_list_management
        self[:bypass_list_management] = { enable: false }
        self
      end

      def enable_footer(text, html)
        self[:footer] = {enable: true, text: text, html: html}
        self
      end

      def disable_footer
        self[:footer] = { enable: false }
        self
      end

      def enable_sandbox_mode
        self[:sandbox_mode] = { enable: true }
        self
      end

      def disable_sandbox_mode
        self[:sandbox_mode] = { enable: false }
        self
      end

      def enable_spam_check(threshold, post_to_url)
        self[:spam_check] = {
          enable: true,
          threshold: threshold,
          post_to_url: post_to_url
        }
        self
      end

      def disable_spam_check
        self[:spam_check] = { enable: false }
        self
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
