# -*- encoding: utf-8 -*-

module SendGrid4r
  module Factory
    #
    # SendGrid Web API v3 Factory Class implementation
    #
    class VersionFactory
      def create(
        name:, subject: '<%subject%>',
        html_content: '<%body%>', plain_content: '<%body%>', active: 1)
        REST::TransactionalTemplates::Versions::Version.new(
          nil,
          nil,
          nil,
          active,
          name,
          html_content,
          plain_content,
          subject,
          nil
        )
      end
    end
  end
end
