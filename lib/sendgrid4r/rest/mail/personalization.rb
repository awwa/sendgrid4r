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
        tap { |s| s[:to] = tos.map(&:to_h) }
      end

      def set_subject(subject)
        tap { |s| s[:subject] = subject }
      end

      def set_ccs(ccs)
        tap { |s| s[:cc] = ccs.map(&:to_h) }
      end

      def set_bccs(bccs)
        tap { |s| s[:bcc] = bccs.map(&:to_h) }
      end

      def set_headers(headers)
        tap { |s| s[:headers] = headers }
      end

      def set_substitutions(substitutions)
        tap { |s| s[:substitutions] = substitutions }
      end

      def set_custom_args(custom_args)
        tap { |s| s[:custom_args] = custom_args }
      end

      def set_send_at(send_at)
        tap { |s| s[:send_at] = send_at.to_i }
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
