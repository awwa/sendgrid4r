module SendGrid4r
  class VersionFactory

    def create(name, subject = "<%subject%>", html_content = "<%body%>", plain_content = "<%body%>", active = 1)
      ver = SendGrid4r::REST::Templates::Version.new()
      ver.name = name
      ver.subject = subject
      ver.html_content = html_content
      ver.plain_content = plain_content
      ver.active = active
      ver
    end

  end
end
