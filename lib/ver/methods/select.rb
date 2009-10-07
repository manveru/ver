module VER
  module Methods
    module Select
      def start_selection_mode(name)
        self.mode = name
        @selection_start = index(:insert).split('.').map(&:to_i)
        refresh_selection
      end

      def switch_selection_mode(name)
        self.mode = name
        refresh_selection
      end

      %w[char line block].each do |suffix|
        name = "select_#{suffix}"
        define_method "start_#{name}_mode" do
          start_selection_mode name
        end

        define_method "switch_#{name}_mode" do
          switch_selection_mode name
        end
      end

      def delete_selection
        insert_index = self.insert_index

        chunks = tag_ranges(:sel).map{|sel|
          content = get(*sel)
          delete(*sel)
          content
        }
        copy(chunks.size == 1 ? chunks.first : chunks)
        clear_selection
        mark_set(:insert, insert_index.join('.'))
        start_control_mode
      end

      def indent_selection
        tag_ranges(:sel).each do |sel|
          (from_y, from_x), (to_y, to_x) = sel.map{|pos| pos.split('.').map(&:to_i) }
          from_y.upto(to_y) do |y|
            next if get("#{y}.#{from_x}", "#{y}.#{to_x}").empty?
            insert("#{y}.#{from_x}", '  ')
          end
        end

        refresh_selection
      end

      def unindent_selection
        tag_ranges(:sel).each do |sel|

          (from_y, from_x), (to_y, _) = sel.map{|pos| pos.split('.').map(&:to_i) }
          to_x = from_x + 2

          queue = from_y.upto(to_y).map{|y|
            left, right = "#{y}.#{from_x}", "#{y}.#{to_x}"
            next unless get(left, right) == '  '
            [left, right]
          }.compact.flatten

          delete(*queue) unless queue.empty?
        end

        refresh_selection
      end

      def selection_evaluate
        tag_ranges(:sel).each do |from, to|
          code = get(from, to)

          begin
            result = eval(code)
            insert("#{to} lineend", "\n%p" % [result])
          rescue => exception
            insert("#{to} lineend", "\n%p" % [exception])
          end
        end
      end

      def copy_selection
        chunks = tag_ranges(:sel).map{|sel| get(*sel) }
        copy(chunks.size == 1 ? chunks.first : chunks)
        clear_selection
        start_control_mode
      end
    end
  end
end