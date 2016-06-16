module SendGrid4r::CLI
  #
  # SendGrid Web API v3 ClI
  #
  class SG < Thor
    map %w(--version -v) => :print_version

    desc '--version, -v', 'print the version'
    def print_version
      puts SendGrid4r::VERSION
    end

    desc('api_key SUBCOMMAND ...ARGS', 'Manage API keys')
    subcommand('api_key', ApiKeys::ApiKey)

    desc('cancel_schedule SUBCOMMAND ...ARGS', 'Manage canceling schedule send')
    subcommand('cancel_schedule', CancelSchedules::CancelSchedule)

    desc('ip SUBCOMMAND ...ARGS', 'Manage ips')
    subcommand('ip', Ips::Ip)

    desc('ipam SUBCOMMAND ...ARGS', 'Manage ip access')
    subcommand('ipam', Ipam::Ipam)

    desc('settings SUBCOMMAND ...ARGS', 'Manage settings')
    subcommand('settings', Settings::Settings)

    desc('subuser SUBCOMMAND ...ARGS', 'Manage subuser')
    subcommand('subuser', Subusers::Subuser)

    desc('suppression SUBCOMMAND ...ARGS', 'Manage suppressions')
    subcommand('suppressions', Suppressions::Suppression)

    desc('template SUBCOMMAND ...ARGS', 'Manage templates')
    subcommand('template', Templates::Template)

    desc('webhook SUBCOMMAND ...ARGS', 'Manage webhook settings')
    subcommand('webhook', Webhooks::Webhook)

    desc('whitelabel SUBCOMMAND ...ARGS', 'Manage whitelabel settings')
    subcommand('whitelabel', Whitelabel::Whitelabel)

    desc('category SUBCOMMAND ...ARGS', 'Manage categories')
    subcommand('category', Category)

    desc('user SUBCOMMAND ...ARGS', 'Manage user')
    subcommand('user', User)
  end
end
