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
