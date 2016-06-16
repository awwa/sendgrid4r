module SendGrid4r::CLI
  module Ipam
    class Ipam < SgThor
      desc('activity SUBCOMMAND ...ARGS', 'Manage IP access activity')
      subcommand('activity', Activity)

      desc('whitelist SUBCOMMAND ...ARGS', 'Manage IP access whitelist')
      subcommand('whitelist', Whitelist)
    end
  end
end