module SendGrid4r::CLI
  module Suppressions
    #
    # SendGrid Web API v3 Suppressions Suppression
    #
    class Suppression < SgThor
      desc('block SUBCOMMAND ...ARGS', 'Manage blocks list')
      subcommand('block', Block)

      desc('bounce SUBCOMMAND ...ARGS', 'Manage bounces list')
      subcommand('bounce', Bounce)

      desc('invalid_email SUBCOMMAND ...ARGS', 'Manage invalid emails list')
      subcommand('invalid_email', InvalidEmail)

      desc('spam_report SUBCOMMAND ...ARGS', 'Manage spam reports list')
      subcommand('spam_report', SpamReport)

      desc(
        'global_unsubscribe SUBCOMMAND ...ARGS',
        'Manage global unsubscribe list'
      )
      subcommand('global_unsubscribe', GlobalUnsubscribe)

      desc(
        'group SUBCOMMAND ...ARGS', 'Manage suppression groups'
      )
      subcommand('group', Group)

      desc(
        'group_unsubscribe SUBCOMMAND ...ARGS', 'Manage group unsubscribes'
      )
      subcommand('group_unsubscribe', GroupUnsubscribe)
    end
  end
end
