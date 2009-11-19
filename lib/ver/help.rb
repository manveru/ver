module VER
  module Help
    autoload :HelpForHelp, 'ver/help/help_for_help'
    autoload :DescribeKey, 'ver/help/describe_key'

    module Methods
      def help_for_help
        VER::Help::HelpForHelp.new(self)
      end

      def describe_key
        VER::Help::DescribeKey.new(self)
      end
    end
  end
end
