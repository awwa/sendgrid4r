module SendGrid4r
  class VersionFactory

    def create(name, subject = "<%subject%>", html_content = "<%body%>", plain_content = "<%body%>", active = 1)
      SendGrid4r::REST::Templates::Version.new(
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
