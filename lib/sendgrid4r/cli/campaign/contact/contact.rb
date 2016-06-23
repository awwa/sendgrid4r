module SendGrid4r::CLI
  module Campaign
    module Contact
      #
      # SendGrid Web API v3 Marketing Campaigns - Contact
      #
      class Contact < SgThor
        desc('custom SUBCOMMAND ...ARGS', 'Manage custom fields')
        subcommand('custom', CustomField)

        desc('list SUBCOMMAND ...ARGS', 'Manage lists')
        subcommand('list', List)

        desc('recipient SUBCOMMAND ...ARGS', 'Manage recipients')
        subcommand('recipint', Recipient)

        desc('reserved SUBCOMMAND ...ARGS', 'Manage reserved fields')
        subcommand('reserved', ReservedField)

        desc('segment SUBCOMMAND ...ARGS', 'Manage segments')
        subcommand('segment', Segment)
      end
    end
  end
end
