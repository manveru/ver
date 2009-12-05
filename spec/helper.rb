require 'bacon'
Bacon.summary_at_exit

require 'pathname'

# annoying fixes
class Pathname
  alias / join

  def cp(dest)
    FileUtils.copy_file(expand_path.to_s, dest.to_s, preserve = true)
  end

  def =~(regexp)
    to_s =~ regexp
  end
end

require 'lib/ver'

VER.run fork: false do
  Tk::After.idle do
    describe 'startup' do
      text = VER.layout.views.first.text

      should 'start with welcome buffer' do
        text.filename.to_s.should.end_with '.config/ver/welcome'
      end

      should 'be at start of buffer' do
        text.index(:insert).to_s.should == "1.0"
      end
    end
  end

  Tk::After.idle do
    describe VER::Methods::Move do
      text = VER.layout.views.first.text

      moving = lambda{|from, to, *args|
        from, to = text.index(from), text.index(to)
        $DEBUG = true
        text.mark_set(:insert, from)
        text.send(*args)
        text.index(:insert).should == to
        $DEBUG = false
      }

      should 'go a char forward' do
        moving['1.0', '1.1', :forward_char]
        moving['1.1', '1.2', :forward_char]
      end

      should 'go multiple chars forward' do
        moving['1.0', '1.10', :forward_char, 10]
      end

      should 'go a char backward' do
        moving['1.2', '1.1', :backward_char]
        moving['1.1', '1.0', :backward_char]
      end

      should 'go multiple chars backward' do
        moving['1.11', '1.1', :backward_char, 10]
      end

      should 'go to the beginning of a lines' do
        moving['2.20', '2.0', :beginning_of_line]
      end

      should 'go to the end of a line' do
        moving['2.0', '2.0 lineend', :end_of_line]
      end

      should 'go to a line number' do
        moving['2.0', '10.0', :go_line, 10]
      end

      should 'go to the end of a file' do
        moving['2.0', 'end - 1 chars', :end_of_file]
      end

      should 'go a page down' do
        moving['2.0', '2.1', :page_down]
      end

      should 'go a page up' do
        moving['2.0', '1.51', :page_up]
      end
    end

    EM.stop
  end
end
