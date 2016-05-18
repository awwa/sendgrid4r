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
        self.tap { |s| s[:bcc] = {enable: true, email: email} }
      end

      def disable_bcc
        self.tap { |s| s[:bcc] = { enable: false } }
      end

      def enable_bypass_list_management
        self.tap { |s| s[:bypass_list_management] = { enable: true } }
      end

      def disable_bypass_list_management
        self.tap { |s| s[:bypass_list_management] = { enable: false } }
      end

      def enable_footer(text, html)
        self.tap do |s|
          s[:footer] = {enable: true, text: text, html: html}
        end
      end

      def disable_footer
        self.tap { |s| s[:footer] = { enable: false } }
      end

      def enable_sandbox_mode
        self.tap { |s| s[:sandbox_mode] = { enable: true } }
      end

      def disable_sandbox_mode
        self.tap { |s| s[:sandbox_mode] = { enable: false } }
      end

      def enable_spam_check(threshold, post_to_url)
        self.tap do |s|
          s[:spam_check] = {
            enable: true,
            threshold: threshold,
            post_to_url: post_to_url
          }
        end
      end

      def disable_spam_check
        self.tap { |s| s[:spam_check] = { enable: false } }
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
