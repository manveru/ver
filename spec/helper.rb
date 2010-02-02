require 'bacon'
Bacon.summary_at_exit

$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))
require 'lib/ver'

module VER
  class Spec
    def initialize(&block)
      @contexts = []
      instance_eval(&block)
    end

    def run
      @contexts.each do |spec|
        Tk::After.idle{
          spec.run
        }
      end
    end

    def describe(*args, &block)
      @contexts << Bacon::Context.new(args.join(' '), &block)
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

      Tk::After.idle do
        Bacon.handle_summary
        Tk.exit
      end
    end
  end
end
