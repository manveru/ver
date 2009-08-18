module VER
  class Theme
    # Ported from VIMs murphy theme
    Murphy = Theme.new{|s|
      on :default, '90ee90'

      on /comment/, 'ffa500'
      on /string/, 'ff00ff'
      on /numeric/, 'ffffff'
      on /constant\.language/, 'bebebe'
      on /constant\.numeric/, 'ffffff'
      on /constant\.other\.symbol/, 'ffff00'
      on /support\.class/, 'bebebe'
      on /keyword\.other\.special-method/, 'f5deb3'
      on /keyword\.control/, 'ffff00'
      on /variable/, '00ffff'
      on /punctuation\.section\.embedded/, '0000ff'
    }
  end
end

__END__
These stay here for future reference, for most of them I have no idea what
they're supposed to match.

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
