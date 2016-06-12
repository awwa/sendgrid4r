module SendGrid4r::CLI
  module Whitelabel
    class Whitelabel < SgThor
      desc('domain SUBCOMMAND ...ARGS', 'Manage domain whitelabel settings')
      subcommand('domain', Domain)

      desc('link SUBCOMMAND ...ARGS', 'Manage link whitelabel settings')
      subcommand('link', Link)

      desc('ip SUBCOMMAND ...ARGS', 'Manage IP whitelabel settings')
      subcommand('ip', Ip)
    end
  end
end
