module SendGrid4r::CLI
  module Webhooks
    class Webhook < SgThor
      desc('event SUBCOMMAND ...ARGS', 'Manage event webhook settings')
      subcommand('event', Event)

      desc('parse SUBCOMMAND ...ARGS', 'Manage parse webhook settings')
      subcommand('parse', Parse)
    end
  end
end
