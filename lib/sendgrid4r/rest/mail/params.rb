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
      :tracking_settings
    ) do
      def set_personalizations(personalizations)
        tap do |s|
          s[:personalizations] = personalizations.map(&:to_h)
        end
      end

      def set_from(from)
        tap { |s| s[:from] = from.to_h }
      end

      def set_contents(contents)
        tap { |s| s[:content] = contents.map(&:to_h) }
      end

      def set_reply_to(reply_to)
        tap { |s| s[:reply_to] = reply_to.to_h }
      end

      def set_attachments(attachments)
        tap { |s| s[:attachments] = attachments.map(&:to_h) }
      end

      def set_template_id(template_id)
        tap { |s| s[:template_id] = template_id }
      end

      def set_sections(sections)
        tap { |s| s[:sections] = sections }
      end

      def set_headers(headers)
        tap { |s| s[:headers] = headers }
      end

      def set_categories(categories)
        tap { |s| s[:categories] = categories }
      end

      def set_custom_args(custom_args)
        tap { |s| s[:custom_args] = custom_args }
      end

      def set_send_at(send_at)
        tap { |s| s[:send_at] = send_at.to_i }
      end

      def set_batch_id(batch_id)
        tap { |s| s[:batch_id] = batch_id }
      end

      def set_asm(group_id, groups_to_display = nil)
        tap do |s|
          s[:asm] = { group_id: group_id }
          unless groups_to_display.nil?
            s[:asm][:groups_to_display] = groups_to_display
          end
        end
      end

      def set_ip_pool_name(ip_pool_name)
        tap { |s| s[:ip_pool_name] = ip_pool_name }
      end

      def set_mail_settings(mail_settings)
        tap { |s| s[:mail_settings] = mail_settings.to_h }
      end

      def set_tracking_settings(tracking_settings)
        tap { |s| s[:tracking_settings] = tracking_settings.to_h }
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
