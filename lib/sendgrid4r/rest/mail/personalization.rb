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
      def to=(to)
        tap { |s| s[:to] = to.map(&:to_h) }
      end

      def cc=(cc)
        tap { |s| s[:cc] = cc.map(&:to_h) }
      end

      def bcc=(bcc)
        tap { |s| s[:bcc] = bcc.map(&:to_h) }
      end

      def send_at=(send_at)
        tap { |s| s[:send_at] = send_at.to_i }
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
