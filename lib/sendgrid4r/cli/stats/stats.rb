module SendGrid4r::CLI
  module Stats
    class Stats < SgThor
      desc('advanced SUBCOMMAND ...ARGS', 'Get advanced stats')
      subcommand('advanced', Advanced)

      desc('category SUBCOMMAND ...ARGS', 'Get category stats')
      subcommand('category', Category)

      desc('global SUBCOMMAND ...ARGS', 'Get global stats')
      subcommand('global', Global)

      desc('parse SUBCOMMAND ...ARGS', 'Get parse stats')
      subcommand('parse', Parse)

      desc('subuser SUBCOMMAND ...ARGS', 'Get subuser stats')
      subcommand('subuser', Subuser)
    end
  end
end