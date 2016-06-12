module SendGrid4r::CLI
  module Supressions
    class Supressions < SgThor
      desc('blocks SUBCOMMAND ...ARGS', 'Manage blocks list')
      subcommand('blocks', Blocks)

      desc("bounces SUBCOMMAND ...ARGS", "Manage bounces list")
      subcommand("bounces", Bounces)

      desc('invalid_emails SUBCOMMAND ...ARGS', 'Manage invalid emails list')
      subcommand('invalid_emails', InvalidEmails)

      desc('spam_reports SUBCOMMAND ...ARGS', 'Manage spam reports list')
      subcommand('spam_reports', SpamReports)

      desc(
        'global_unsubscribes SUBCOMMAND ...ARGS',
        'Manage global unsubscribe list'
      )
      subcommand('global_unsubscribes', GlobalUnsubscribes)

      desc(
        'groups SUBCOMMAND ...ARGS', 'Manage suppression groups'
      )
      subcommand('groups', Groups)

      desc(
        'group_unsubscribes SUBCOMMAND ...ARGS', 'Manage group unsubscribes'
      )
      subcommand('group_unsubscribes', GroupUnsubscribes)
    end
  end
end
