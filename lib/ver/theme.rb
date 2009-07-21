module VER
  class Theme < Struct.new(:colors)
    def initialize(colors = {}, &block)
      self.colors = colors
      instance_eval(&block) if block_given?
    end

    def on(match, color)
      colors[match] = Color[color]
    end
    alias []= on

    def [](name)
      colors.each do |match, color|
        case match
        when Symbol
          return color if match == name
        else
          return color if match =~ name
        end
      end

      colors[:default]
    end
  end
end

__END__
/comment\.line\.number-sign/
/constant\.language/
/constant\.numeric/
/constant\.other\.symbol/
/entity\.name\.function/
/entity\.name\.type\.module/
/keyword\.control\.def/
/keyword\.control/
/keyword\.control\.start-block/
/keyword\.operator\.arithmetic/
/keyword\.operator\.assignment\.augmented/
/keyword\.operator\.assignment/
/keyword\.other\.special-method/
/meta\.function-call\.method\.with-arguments/
/meta\.function-call\.method\.without-arguments/
/meta\.function-call/
/meta\.function\.method\.with-arguments/
/meta\.function\.method\.without-arguments/
/meta\.require/
/meta\.module/
/punctuation\.definition\.comment/
/punctuation\.definition\.constant/
/punctuation\.definition\.parameters/
/punctuation\.definition\.string\.begin/
/punctuation\.definition\.string\.end/
/punctuation\.definition\.variable/
/punctuation\.section\.array/
/punctuation\.section\.embedded/
/punctuation\.section\.function/
/punctuation\.section\.scope/
/punctuation\.separator\.key-value/
/punctuation\.separator\.method/
/punctuation\.separator\.object/
/punctuation\.separator\.variable/
/punctuation\.separator\.statement/
/source\.embedded\.source/
/source\..+\.embedded\.source/
/string\.quoted\.double/
/string\.quoted\.single/
/support\.class/
/variable\.language/
/variable\.other\.block/
/variable\.other\.constant/
/variable\.other\.readwrite\.global/
/variable\.other\.readwrite\.instance/
/variable\.parameter\.function/
