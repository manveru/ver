require 'bacon'
# Bacon.summary_at_exit

$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))
require 'lib/ver'

module VER
  class Spec
    def initialize(&block)
      @contexts = []
      instance_eval(&block)
    end

    def run
      if context = @contexts.shift
        Tk::After.idle do
          context.run
          run
        end
      else
        Tk::After.idle{ bacon_summary }
      end
    end

    def describe(*args, &block)
      @contexts << Bacon::Context.new(args.join(' '), &block)
    end

    def bacon_summary
      Bacon.handle_summary

      if $!
        Kernel.raise $!
      elsif Bacon::Counter[:errors] + Bacon::Counter[:failed] > 0
        Kernel.exit 1
      else
        Kernel.exit 0
      end
    ensure
      $stdout.flush
      Tk.exit
    end
  end


  # Schedule all describe blocks in a 'after idle' block that is scheduled by tcl.
  # The last 'after idle' will output the bacon summary and call [Tk.exit].
  # Not sure how well this handles nested describe blocks, but it might just work?
  #
  # @example usgage
  #   VER.spec do
  #     describe 'number of open buffers' do
  #       it 'should open one buffer by default' do
  #         VER.buffers.size.should == 1
  #       end
  #     end
  #   end
  def self.spec(&block)
    specs = Spec.new(&block)

    VER.run fork: false do
      specs.run
    end
  end
end
