# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Mail
  #
  module Mail
    Params = Struct.new(
      :personalizations, :from, :content, :reply_to, :attachments,
      :template_id, :sections, :headers, :categories, :custom_args,
      :send_at, :batch_id, :asm, :ip_pool_name, :mail_settings,
      :tracking_settings, :subject
    ) do
      def personalizations=(personalizations)
        tap do |s|
          s[:personalizations] = personalizations.map(&:to_h)
        end
      end

      def from=(from)
        tap { |s| s[:from] = from.to_h }
      end

      def content=(content)
        tap { |s| s[:content] = content.map(&:to_h) }
      end

      def reply_to=(reply_to)
        tap { |s| s[:reply_to] = reply_to.to_h }
      end

      def attachments=(attachments)
        tap { |s| s[:attachments] = attachments.map(&:to_h) }
      end

      def send_at=(send_at)
        tap { |s| s[:send_at] = send_at.to_i }
      end

      def asm=(asm)
        if asm.is_a?(Fixnum)
          tap { |s| s[:asm] = { group_id: asm } }
        elsif asm.is_a?(Array)
          tap do |s|
            s[:asm] = { group_id: asm[0] }
            s[:asm][:groups_to_display] = asm[1]
          end
        end
      end

      def mail_settings=(mail_settings)
        tap { |s| s[:mail_settings] = mail_settings.to_h }
      end

      def tracking_settings=(tracking_settings)
        tap { |s| s[:tracking_settings] = tracking_settings.to_h }
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
