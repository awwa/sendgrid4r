module SendGrid4r::CLI
  module Ips
    #
    # SendGrid Web API v3 Ips Ip
    #
    class Ip < SgThor
      desc('address SUBCOMMAND ...ARGS', 'Manage IP addresses')
      subcommand('address', Address)

      desc('pool SUBCOMMAND ...ARGS', 'Manage IP pools')
      subcommand('pool', Pool)

      desc('warmup SUBCOMMAND ...ARGS', 'Manage IP warmup')
      subcommand('warmup', Warmup)
    end
  end
end
