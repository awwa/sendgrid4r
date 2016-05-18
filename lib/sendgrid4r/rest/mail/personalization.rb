# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Mail
  #
  module Mail
    Personalization = Struct.new(
      :to, :subject, :cc, :bcc, :headers, :substitutions, :custom_args,
      :send_at
    ) do
      def set_tos(tos)
        self[:to] = tos.map(&:to_h)
        self
      end

      def set_subject(subject)
        self[:subject] = subject
        self
      end

      def set_ccs(ccs)
        self[:cc] = ccs.map(&:to_h)
        self
      end

      def set_bccs(bccs)
        self[:bcc] = bccs.map(&:to_h)
        self
      end

      def set_headers(headers)
        self[:headers] = headers
        self
      end

      def set_substitutions(substitutions)
        self[:substitutions] = substitutions
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

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
