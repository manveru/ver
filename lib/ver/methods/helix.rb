module VER
  module Methods
    module Helix
      TEXT_OBJECT_BRACKETS = Text::Mark::MATCHING_BRACE_RIGHT.merge(
        '‘' => '’', '“' => '”', '«' => '»', '「' => '」', '（' => '）'
      ).freeze
      CLOSEST_BRACKETS = TEXT_OBJECT_BRACKETS.reject { |opening, _| opening == '<' }.freeze
      TEXT_OBJECT_WORD = /[[:alnum:]_]/
      TEXT_OBJECT_PUNCTUATION = /[\p{P}\p{Sm}\p{Sc}\p{Sk}]/
      TEXT_OBJECT_SPACE = /[[:space:]]/
      GRAPHEME_WINDOW = 32

      module_function

      def selection(buffer)
        buffer.at_sel.ranges.first ||
          Text::Range.new(buffer, buffer.at_insert.index, next_grapheme(buffer.at_insert.index))
      end

      def select(buffer, first, last, cursor = [first, previous_grapheme(last)].max)
        buffer.at_sel.clear
        buffer.at_sel.add(first, last)
        buffer.insert = cursor
      end

      def collapse(buffer)
        buffer.prefix_count
        buffer.at_sel.clear
      end

      def extend_from(buffer, anchor, cursor)
        first, last = [anchor, cursor].minmax
        select(buffer, first, next_grapheme(last), cursor)
      end

      def anchor(buffer)
        range = selection(buffer)
        backward?(buffer, range) ? previous_grapheme(range.last) : range.first
      end

      # True when the cursor sits on the first of several selected characters.
      def backward?(buffer, range)
        buffer.at_insert == range.first && buffer.at_insert < range.last - 1
      end

      def reselect(buffer, first, last, backward)
        backward ? select(buffer, first, last, first) : select(buffer, first, last)
      end

      def next_grapheme(index)
        ahead = index.buffer.get(index, "#{index} + #{GRAPHEME_WINDOW} chars").partition("\n").first
        index + (ahead[/\A\X/]&.length || 1)
      end

      def previous_grapheme(index)
        behind = index.buffer.get("#{index} - #{GRAPHEME_WINDOW} chars", index).rpartition("\n").last
        index - (behind[/\X\z/]&.length || 1)
      end

      def move(buffer, motion)
        move_selection(buffer) { move_insert(buffer, motion) }
      end

      def goto_line(buffer, default = nil)
        line = buffer.prefix_count(default)
        move_selection(buffer) { buffer.insert = "#{line}.0" } if line
      end

      def move_selection(buffer)
        extending = buffer.minor_mode?(:select_char)
        start = anchor(buffer) if extending
        yield
        if extending
          extend_from(buffer, start, buffer.at_insert.index)
        else
          collapse(buffer)
        end
      end

      def move_insert(buffer, motion)
        insert = buffer.at_insert
        case motion
        when :left then insert.set(insert - buffer.prefix_count)
        when :right then insert.set([insert + buffer.prefix_count, buffer.index('end - 1 chars')].min)
        when :last_char
          buffer.prefix_count
          insert.set([insert.linestart, previous_grapheme(insert.lineend)].max)
        when :home_of_line, :start_of_line
          buffer.prefix_count
          insert.public_send(motion)
        else
          insert.public_send(motion)
        end
      end

      def word(buffer, target, long = false)
        origin = buffer.at_insert.index
        backward = target == :previous
        start, head = backward ? [next_grapheme(origin), origin] : [origin, next_grapheme(origin)]
        limit = buffer.index(backward ? '1.0' : 'end')
        step = backward ? -1 : 1
        buffer.prefix_count.times do
          break if head == limit

          start, head = word_step(start, head, limit, step, target, long)
        end
        cursor = backward ? head : previous_grapheme(head)
        if buffer.minor_mode?(:select_char)
          extend_from(buffer, anchor(buffer), cursor)
        else
          select(buffer, *[start, head].minmax, cursor)
        end
      end

      def word_step(start, head, limit, step, target, long)
        # The index is a boundary. Read the character on the side we're moving into.
        offset = step.negative? ? -1 : 0
        previous = word_category((head - offset - 1).get, long)
        current = word_category((head + offset).get, long)
        while head != limit && current == :newline
          previous = current
          head += step
          current = word_category((head + offset).get, long)
        end
        start = head if previous == :newline
        initial = head
        until head == limit
          boundary = previous != current && (current == :newline ||
            (target == :next_start ? current != :space : previous != :space && previous != :newline))
          if boundary
            break if head != initial

            start = head
          end
          previous = current
          head += step
          current = word_category((head + offset).get, long)
        end
        [start, head]
      end

      def word_category(character, long = false)
        case character
        when "\n", "\r" then :newline
        when TEXT_OBJECT_SPACE then :space
        when TEXT_OBJECT_WORD then :word
        when TEXT_OBJECT_PUNCTUATION then long ? :word : :punctuation
        else :other
        end
      end

      def find_character(buffer, direction, till = false)
        count = buffer.prefix_count
        buffer.major_mode.read(1) do |event|
          character = typed_character(event)
          next unless character

          origin = buffer.at_insert.index
          step = direction == :forward ? 1 : -1
          adjacent = (origin + step).get == character
          cursor = nth_character(buffer, character, origin, direction, count + (till && adjacent ? 1 : 0))
          next unless cursor

          cursor -= step if till
          start = buffer.minor_mode?(:select_char) ? anchor(buffer) : origin
          extend_from(buffer, start, cursor)
        end
      end

      def nth_character(buffer, character, origin, direction, count)
        pattern = Regexp.new(Regexp.escape(character))
        method, from = direction == :forward ? [:search_all, origin + 1] : [:rsearch_all, origin]
        buffer.public_send(method, pattern, from) do |_, first, _last|
          count -= 1
          break first if count.zero?
        end
      end

      def text_object(buffer, bounds)
        count = buffer.prefix_count
        buffer.message "Match #{bounds}  w Word  W WORD  p Paragraph  m Closest brackets  or type a delimiter"
        buffer.major_mode.read(1) do |event|
          buffer.message ''
          character = typed_character(event)
          next unless character&.match?(/\A[[:print:]]\z/)

          origin = buffer.at_insert.index
          case character
          when 'w', 'W'
            select(buffer, *word_bounds(buffer, origin, bounds, character == 'W'))
          when 'p'
            select(buffer, *paragraph_bounds(buffer, origin, bounds, count))
          when 'm'
            range = selection(buffer)
            pair = closest_bracket_pair(buffer, range, count)
            select_pair(buffer, origin, bounds, *pair) if pair
          when 't', 'f', 'a', 'c', 'T', 'e', 'g', 'x'
            buffer.warn "Text object #{character.inspect} is unavailable"
          else
            pair = delimiter_pair(buffer, origin, character, count)
            select_pair(buffer, origin, bounds, *pair) if pair
          end
        end
      end

      def word_bounds(buffer, origin, bounds, long)
        character = origin.get
        return [origin, origin] if character.empty? || TEXT_OBJECT_SPACE.match?(character)

        unit = if long
                 /[^[:space:]]/
               elsif TEXT_OBJECT_WORD.match?(character)
                 TEXT_OBJECT_WORD
               elsif TEXT_OBJECT_PUNCTUATION.match?(character)
                 TEXT_OBJECT_PUNCTUATION
               else
                 /[^[:alnum:]_[:space:]\p{P}\p{Sm}\p{Sc}\p{Sk}]/
               end
        left = buffer.get(origin.linestart, origin)
        right = buffer.get(origin, origin.lineend)
        first = origin - left[/#{unit}+\z/].to_s.length
        last = origin + right[/\A#{unit}+/].length

        if bounds == :around
          trailing = buffer.get(last, origin.lineend)[/\A#{TEXT_OBJECT_SPACE}*/].length
          if trailing.positive?
            last += trailing
          else
            first -= buffer.get(origin.linestart, first)[/#{TEXT_OBJECT_SPACE}*\z/].length
          end
        end
        [first, last]
      end

      def paragraph_bounds(buffer, origin, bounds, count)
        blank = buffer.value.lines.map { |line| line == "\n" || line == "\r\n" }
        last = origin.line - 1
        if blank[last] && last.positive? && !blank[last - 1]
          last += 1
          first = last
        else
          first = paragraph_start(blank, blank[last] ? last : last + 1)
        end

        while count.positive? && last < blank.length
          start = last
          last += 1 while last < blank.length && !blank[last]
          count -= 1 if last > start
          last += 1 while blank[last]
        end

        first = paragraph_start(blank, first) if count.positive?
        last -= 1 while bounds == :inside && last.positive? && blank[last - 1]
        [buffer.index("#{first + 1}.0"), buffer.index("#{last + 1}.0")]
      end

      def paragraph_start(blank, line)
        line -= 1 while line.positive? && blank[line - 1]
        line -= 1 while line.positive? && !blank[line - 1]
        line
      end

      def delimiter_pair(buffer, origin, delimiter, count)
        left = TEXT_OBJECT_BRACKETS.key(delimiter) || delimiter
        if right = TEXT_OBJECT_BRACKETS[left]
          opening = bracket_boundary(buffer, origin, :rsearch_all, left, right, count)
          closing = bracket_boundary(buffer, origin, :search_all, right, left, count) if opening
        elsif origin.get == delimiter
          return pair_at_delimiter(buffer, origin, delimiter, count)
        else
          opening = nth_character(buffer, delimiter, origin, :backward, count)
          closing = nth_character(buffer, delimiter, origin, :forward, count) if opening
        end
        [opening, closing] if closing
      end

      def pair_at_delimiter(buffer, origin, delimiter, count)
        line_start = origin.linestart
        line = buffer.get(line_start, origin.lineend)
        offsets = []
        line.scan(/\\.|#{Regexp.escape(delimiter)}/) do |token|
          offsets << Regexp.last_match.begin(0) if token == delimiter
        end
        index = offsets.index(buffer.get(line_start, origin).length)
        return unless index

        opening = index.even? ? index : index - 1
        first = opening - (count - 1)
        last = opening + count
        return if first.negative? || last >= offsets.length

        [line_start + offsets.fetch(first), line_start + offsets.fetch(last)]
      end

      def bracket_boundary(buffer, origin, search, target, opposite, count)
        if origin.get == target
          count -= 1
          return origin if count.zero?
        end

        start = search == :search_all ? origin + 1 : origin
        depth = 0
        buffer.public_send(search, Regexp.union(target, opposite), start) do |character, index, _|
          if character == opposite
            depth += 1
          elsif depth.positive?
            depth -= 1
          elsif (count -= 1).zero?
            break index
          end
        end
      end

      def closest_bracket_pair(buffer, range, count)
        pairs = CLOSEST_BRACKETS
        stacks = pairs.values.to_h { |closing| [closing, []] }
        first = range.first
        last = range.last - 1
        buffer.search_all(Regexp.union(pairs.keys + pairs.values)) do |character, index, _|
          if closing = pairs[character]
            stacks.fetch(closing) << index
          elsif (opening = stacks.fetch(character).pop) && opening <= first && index >= last
            next if opening == first && index == last

            count -= 1
            break [opening, index] if count.zero?
          end
        end
      end

      def select_pair(buffer, origin, bounds, opening, closing)
        first, last = bounds == :inside ? [opening + 1, closing] : [opening, closing + 1]
        reselect(buffer, first, last, backward?(buffer, selection(buffer)))
      end

      def typed_character(event)
        case event.keysym
        when 'Return', 'KP_Enter' then "\n"
        when 'Tab' then "\t"
        else
          character = event.unicode
          character if character&.match?(/\A[[:print:]]\z/)
        end
      end

      def select_all(buffer)
        buffer.prefix_count
        select(buffer, buffer.index('1.0'), buffer.index('end'))
      end

      def select_lines(buffer, extend = true)
        selected = buffer.at_sel.ranges.first
        range = selected || selection(buffer)
        first = range.first.linestart
        end_of_line = (range.last - 1).lineend
        count = buffer.prefix_count
        full_lines = extend && selected && first == range.first && end_of_line + 1 == range.last
        offset = extend ? count - (full_lines ? 0 : 1) : 0
        last = buffer.index("#{end_of_line} + #{offset} lines lineend + 1 chars")
        select(buffer, first, last)
      end

      def yank(buffer)
        buffer.prefix_count
        selection(buffer).copy
        exit_select_mode(buffer)
      end

      def delete(buffer, yank = true)
        with_edit_group(buffer) { delete_selection(buffer, yank) }
        exit_select_mode(buffer)
      end

      def delete_selection(buffer, yank, keep_line: false)
        range = selection(buffer)
        collapse(buffer)
        first = range.first
        last = range.last
        if first == first.linestart && last == (last - 1).lineend + 1
          if keep_line
            last -= 1
          elsif last == buffer.index('end') && first > buffer.index('1.0')
            first -= 1
          end
        end
        last = [last, buffer.index('end - 1 chars')].min
        # Always enter with_register: it consumes a pending named register even when nothing is yanked.
        buffer.with_register do |register|
          register.value = range.get if yank && first < last
        end
        if first < last
          buffer.delete(first, last)
          buffer.insert = first
        end
      end

      def change(buffer, yank = true)
        with_edit_group(buffer) do
          delete_selection(buffer, yank, keep_line: true)
          enter_insert(buffer)
        end
      end

      def exit_select_mode(buffer)
        buffer.minor_mode(:select_char, :control) if buffer.minor_mode?(:select_char)
      end

      def insert_at(buffer, edge)
        range = selection(buffer)
        if edge == :last
          start = buffer.mark(:helix_append_anchor, range.first, :left)
          buffer.store(self, :append_anchor, start)
        end
        buffer.insert = range.public_send(edge)
        enter_insert(buffer)
      end

      def line_edge(buffer, edge)
        range = selection(buffer)
        edge == :first ? range.first : range.last - 1
      end

      def insert_on_line(buffer, edge, boundary)
        buffer.insert = line_edge(buffer, edge).public_send(boundary)
        enter_insert(buffer)
      end

      def enter_insert(buffer)
        collapse(buffer)
        buffer.minor_mode(buffer.minor_mode?(:select_char) || :control, :insert)
      end

      def open_line(buffer, edge, action)
        buffer.insert = line_edge(buffer, edge).linestart
        collapse(buffer)
        exit_select_mode(buffer)
        with_edit_group(buffer) { buffer.at_insert.public_send(action) }
      end

      def with_edit_group(buffer)
        undoer = buffer.undoer
        undoer&.begin_group
        yield
      ensure
        undoer&.end_group unless buffer.minor_mode?(:insert)
      end

      def start_insert_undo(buffer, _old_mode, _new_mode)
        buffer.undoer&.begin_group
      end

      def finish_insert(buffer, _old_mode, _new_mode)
        buffer.undoer&.end_group
        return unless start = buffer.store(self, :append_anchor)

        first, last = [start.index, buffer.at_insert.index].minmax
        select(buffer, first, last)
        start.unset
        buffer.store(self, :append_anchor, nil)
      end

      def insert_delete(buffer, direction)
        from, to = if direction == :left
                     [buffer.at_insert - 1, buffer.at_insert.index]
                   else
                     [buffer.at_insert.index, buffer.at_insert + 1]
                   end
        buffer.delete(from, to) if from < to && from < buffer.index('end - 1 chars')
      end

      def paste(buffer, edge)
        range = selection(buffer)
        count = buffer.prefix_count
        buffer.with_register do |register|
          if register.value.respond_to?(:to_str)
            with_edit_group(buffer) do
              paste_text(buffer, range, edge, register.value.to_str * count)
            end
          else
            buffer.warn 'No text to paste'
          end
        end
        exit_select_mode(buffer)
      end

      def paste_text(buffer, range, edge, text)
        keep_selection = buffer.minor_mode?(:select_char)
        backward = backward?(buffer, range)
        index = range.public_send(edge)
        if text.end_with?("\n")
          index = edge == :first ? range.first.linestart : (range.last - 1).lineend + 1
          if index == buffer.index('end')
            index -= 1
            text = "\n#{text.chomp}"
          end
        end

        buffer.at_sel.clear
        buffer.insert = index
        first = buffer.at_insert.index
        buffer.at_insert.insert(text)
        if keep_selection
          offset = first <= range.first ? text.length : 0
          reselect(buffer, range.first + offset, range.last + offset, backward)
        else
          select(buffer, first, buffer.at_insert.index)
        end
      end

      def replace_character(buffer)
        buffer.prefix_count
        buffer.major_mode.read(1) do |event|
          character = typed_character(event)
          next unless character

          range = selection(buffer)
          range.last = [range.last, buffer.index('end - 1 chars')].min
          replace(buffer, range, range.get.gsub(/\X/) { character }) if range.first < range.last
          exit_select_mode(buffer)
        end
      end

      def replace_with_yanked(buffer)
        buffer.prefix_count
        buffer.with_register do |register|
          if register.value.respond_to?(:to_str)
            replace(buffer, selection(buffer), register.value.to_str)
          else
            buffer.warn 'No yanked text'
          end
        end
        exit_select_mode(buffer)
      end

      def replace(buffer, range, text)
        if range.last == buffer.index('end')
          range.last -= 1
          text = text.delete_suffix("\n")
        end
        buffer.at_sel.clear
        buffer.insert = range.first
        with_edit_group(buffer) { range.replace(text) }
        select(buffer, range.first, buffer.at_insert.index)
      end

      def history(buffer, action)
        buffer.at_sel.clear
        Undo.public_send(action, buffer)
      end

      def search(buffer, direction)
        buffer.ask(direction == :forward ? '/' : '?') do |answer, action|
          next unless action == :attempt

          unless answer.empty?
            Search.incremental(buffer, answer, true)
            buffer.look_at(nil)
          end
          search_match(buffer, direction)
          :abort
        end
      end

      def search_match(buffer, direction)
        count = buffer.prefix_count
        pattern = buffer.store(Search, :last)
        return buffer.warn('No previous search') unless pattern

        matches = []
        buffer.search_all(pattern) { |_, first, last| matches << [first, last] }
        return buffer.warn('No matches found') if matches.empty?

        range = selection(buffer)
        if direction == :forward
          index = matches.index { |first, _| first >= range.last } || 0
          match = matches[(index + count - 1) % matches.length]
        else
          index = matches.rindex { |_, last| last <= range.first } || -1
          match = matches[(index - count + 1) % matches.length]
        end
        select(buffer, *match)
      end

      def command_prompt(buffer)
        buffer.prefix_count
        buffer.ask(':') do |answer, action|
          next unless action == :attempt

          command, argument = answer.split(' ', 2)
          next :abort unless command

          case command
          when 'w', 'write'
            Tk::After.idle { argument ? buffer.save(Pathname(argument).expand_path) : buffer.save }
          when 'q', 'quit'
            Tk::After.idle { buffer.close }
          when 'o', 'open'
            Tk::After.idle do
              argument ? VER.find_or_create_buffer(argument) : Open.file_open_ask(buffer)
            end
          else
            buffer.warn "Unknown command: #{command}"
            next
          end
          :abort
        end
      end
    end
  end
end
