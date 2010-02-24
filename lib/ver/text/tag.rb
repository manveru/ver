module VER
  class Text
    # The first form of annotation in text widgets is a tag.
    # A tag is a textual string that is associated with some of the characters
    # in a text.
    # Tags may contain arbitrary characters, but it is probably best to avoid
    # using the characters " " (space), "+" (plus), or "-" (minus): these
    # characters have special meaning in indices, so tags containing them cannot
    # be used as indices.
    # There may be any number of tags associated with characters in a text.
    # Each tag may refer to a single character, a range of characters, or
    # several ranges of characters.
    # An individual character may have any number of tags associated with it.
    #
    # A priority order is defined among tags, and this order is used in
    # implementing some of the tag-related functions described below.
    # When a tag is defined (by associating it with characters or setting its
    # display options or binding commands to it), it is given a priority higher
    # than any existing tag.
    # The priority order of tags may be redefined using the "pathName tag
    # raise" and "pathName tag lower" widget commands.
    #
    # Tags serve three purposes in text widgets.
    # First, they control the way information is displayed on the screen.
    # By default, characters are displayed as determined by the -background,
    # -font, and -foreground options for the text widget.
    # However, display options may be associated with individual tags using the
    # "pathName tag configur" widget command.
    # If a character has been tagged, then the display options associated with
    # the tag override the default display style.
    class Tag < Struct.new(:buffer, :name)
      # FIXME: yes, i know i'm calling `tag add` for every line, which makes
      #        things slower, but it seems like there is a bug in the text widget.
      #        So we aggregate the information into a single eval.
      def add(*indices)
        code = [%(set win "#{buffer.tk_pathname}")]

        indices.each_slice(2) do |first, last|
          code << "$win tag add #{name} #{first} #{last}"
        end

        Tk.execute_only(Tk::TclString.new(code.join("\n")))
      end

      # pathName tag bind tagName ?sequence? ?script? 
      def bind(*args, &block)
        buffer.tag_bind(to_tcl, *args, &block)
      end

      # pathName tag cget tagName option 
      def cget(option)
        buffer.tag_cget(self, option)
      end

      # pathName tag configure tagName ?option? ?value? ?option value ...? 
      def configure(*options)
        buffer.tag_configure(self, *options)
      end

      # pathName tag delete tagName ?tagName ...? 
      def delete
        buffer.tag_delete(self)
      end
      alias tag_delete delete

      # pathName tag lower tagName ?belowThis? 
      def lower(below_this = Tk::None)
        buffer.tag_lower(self, below_this)
      end
      alias tag_lower lower

      # pathName tag nextrange tagName index1 ?index2? 
      def next_range(from_index, to_index = Tk::None)
        buffer.tag_nextrange(self, from_index, to_index)
      end
      alias nextrange next_range

      # pathName tag prevrange tagName index1 ?index2? 
      def prev_range(from_index, to_index = Tk::None)
        buffer.tag_prevrange(self, from_index, to_index)
      end
      alias prevrange prev_range

      # pathName tag raise tagName ?aboveThis? 
      def raise(above_this = Tk::None)
        buffer.tag_raise(above_this)
      end
      alias tag_raise raise

      # pathName tag ranges tagName 
      def ranges
        buffer.tag_ranges(self)
      end

      # pathName tag remove tagName index1 ?index2 index1 index2 ...?
      def remove(index, *indices)
        buffer.tag_remove(self, index, *indices)
      end
      alias tag_remove remove

      def replace(*args)
        buffer.range("#{self}.first", "#{self}.last").replace(*args)
      end

      def get
        values = ranges.map{|range| range.get }
        values.size == 1 ? values.first : values unless values.empty?
      end

      def each_range(&block)
        ranges.each(&block)
      end

      def copy
        chunks = ranges.map{|range| range.get }
        Methods::Clipboard.copy(buffer, chunks.size == 1 ? chunks.first : chunks)
      end

      def kill
        indices = []
        chunks = ranges.map{|range|
          indices << range.first << range.last
          range.get
        }
        Methods::Clipboard.copy(buffer, chunks.size == 1 ? chunks.first : chunks)
        buffer.delete(*indices)
      end

      def to_tcl
        name.to_tcl
      end

      def to_s
        name.to_s
      end

      def inspect
        "#<VER::Text::Tag %p on %p>" % [name, buffer]
      end
    end
  end
end
