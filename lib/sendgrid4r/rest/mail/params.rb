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
        self[:personalizations] = personalizations.map(&:to_h)
        self
      end

      def set_from(from)
        self[:from] = from.to_h
        self
      end

      def set_contents(contents)
        self[:content] = contents.map(&:to_h)
        self
      end

      def set_reply_to(reply_to)
        self[:reply_to] = reply_to.to_h
        self
      end

      def set_attachments(attachments)
        self[:attachments] = attachments.map(&:to_h)
        self
      end

      def set_template_id(template_id)
        self[:template_id] = template_id
        self
      end

      def set_sections(sections)
        self[:sections] = sections
        self
      end

      def set_headers(headers)
        self[:headers] = headers
        self
      end

      def set_categories(categories)
        self[:categories] = categories
        self
      end

      def set_custom_args(custom_args)
        self[:custom_args] = custom_args
        self
      end

      def set_send_at(send_at)
        self[:send_at] = send_at.to_i
        self
      end

      def set_batch_id(batch_id)
        self[:batch_id] = batch_id
        self
      end

      def set_asm(group_id, groups_to_display = nil)
        self[:asm] = { group_id: group_id }
        unless groups_to_display.nil?
          self[:asm][:groups_to_display] = groups_to_display
        end
        self
      end

      def set_ip_pool_name(ip_pool_name)
        self[:ip_pool_name] = ip_pool_name
        self
      end

      def set_mail_settings(mail_settings)
        self[:mail_settings] = mail_settings.to_h
        self
      end

      def set_tracking_settings(tracking_settings)
        self[:tracking_settings] = tracking_settings.to_h
        self
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
