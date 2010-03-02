module VER
  module Methods
    module Help
      module_function

      def help_for_help
        VER::Help::HelpForHelp.new(self)
      end

      def describe_key(buffer)
        VER::Help::DescribeKey.new(buffer)
      end
    end
  end
end
