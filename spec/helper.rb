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

    def run(options = {})
      if context = @contexts.shift
        Tk::After.idle do
          context.run
          run(options)
        end
      else
        bacon_summary
      end
    end

    def describe(*args, &block)
      @contexts << Bacon::Context.new(args.join(' '), &block)
    end

    def bacon_summary
      Tk.update # finish all pending events first
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
      $stderr.flush
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
  def self.spec(options = {}, &block)
    options = {
      fork:    false,
      hidden:  true,
      load_rc: false,
      welcome: false
    }.merge(options)

    VER.run(options){ Spec.new(&block).run(options) }
  end

  # this is called when no buffers are left, make sure we finish all pending
  # events and output the summary first.
  def self.exit
    Tk.update
  end
end
