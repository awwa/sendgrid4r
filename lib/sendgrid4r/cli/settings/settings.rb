module SendGrid4r::CLI
  module Settings
    #
    # SendGrid Web API v3 Settings
    #
    class Settings < SgThor
      desc('enforced_tls SUBCOMMAND ...ARGS', 'Manage enforced TLS settings')
      subcommand('enforced_tls', EnforcedTls)

      desc('mail SUBCOMMAND ...ARGS', 'Manage mail settings')
      subcommand('mail', Mail)

      desc('partner SUBCOMMAND ...ARGS', 'Manage partner settings')
      subcommand('partner', Partner)

      desc('tracking SUBCOMMAND ...ARGS', 'Manage tracking settings')
      subcommand('tracking', Tracking)
    end
  end
end
