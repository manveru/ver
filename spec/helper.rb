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

BUFFER_VALUE = <<'VALUE'.chomp.freeze
Inventore voluptatibus dolorem assumenda.
Voluptates officiis quidem nemo est.
Qui similique quia voluptatem.
Sit pariatur vel aperiam et ab.
Quam dolorem dignissimos perferendis.
Nostrum cumque quaerat nobis ut repudiandae vitae autem perferendis.
Quasi beatae sunt est et quo.
Et eum qui perferendis excepturi molestias reiciendis.
Sed voluptatum quis eaque vitae sed a et.
Velit earum eius cupiditate saepe blanditiis aspernatur dolorem voluptas.
In quam quo repellat.
Iusto repudiandae delectus omnis ut autem.
Fugiat tempore officiis ab.
  Aut culpa accusantium consequatur laboriosam pariatur.
    Cum autem explicabo dignissimos nemo.
      Omnis vero rerum et in fugiat et eos.
Ipsum commodi beatae maxime deserunt aut.
Maxime earum harum officiis libero laborum.
Aut et porro nam voluptas praesentium quaerat.
Enim blanditiis delectus voluptate aliquid placeat.
Repudiandae quae corrupti quaerat quisquam omnis ratione.
Tempore dicta rem maxime nam aperiam consequatur nobis.
Aut nam omnis ullam.
Quia at quas minima quis.
Numquam dolore similique et autem porro alias asperiores.
Culpa neque qui unde voluptas.
Sed id minus ut consequatur nihil aut itaque dolore.
Alias maiores officiis quasi facilis dolor inventore.
Omnis provident itaque neque.
Rerum vel tenetur qui dicta sit omnis modi aut.
Rerum laudantium et ipsa id natus dolores qui.
Nulla est nihil eius et.
Sint quibusdam est molestiae.
Praesentium non quo omnis aliquam eaque est.
Culpa sunt voluptatem ut dolores porro eius molestias esse.
Nesciunt quo dignissimos debitis illo est omnis maiores.
Sint cupiditate quo id perspiciatis voluptas qui quo.
Suscipit ut incidunt atque animi minus optio esse harum.
Molestiae sint iusto quasi.
Quo delectus ipsa quia iste ullam corporis.
Perferendis ut dolores error voluptatem.
VALUE

shared :with_buffer do
  before do
    create_buffer
    buffer.insert = '1.0'
    buffer.major_mode = VER::MajorMode[:Fundamental]
    @insert = buffer.at_insert
    Tk.update
  end

  def create_buffer
    return if $ver_spec_buffer
    $ver_spec_buffer = VER.layout.create_buffer
    VER.layout.add_buffer(buffer)
    buffer.value = BUFFER_VALUE
  end

  def buffer
    $ver_spec_buffer
  end

  def insert
    @insert
  end

  def reset
    buffer.value = BUFFER_VALUE
  end

  def type(*keys)
    Tk.update
    buffer.type(keys.join)
    Tk.update
  end

  def minibuf
    buffer.minibuf
  end

  def range(*args)
    buffer.range(*args)
  end

  def clipboard
    VER::Clipboard.dwim
  end

  def clipboard_set(string)
    VER::Clipboard.dwim = string
  end
end

shared :destructive_mode do
  behaves_like :with_buffer

  before do
    buffer.value = BUFFER_VALUE
    buffer.insert = '1.0'
    VER::Clipboard.clear
  end
end
