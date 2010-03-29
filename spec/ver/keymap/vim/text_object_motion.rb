require_relative '../vim'

VER.spec keymap: 'vim', hidden: false do
  describe 'Keymap for VIM' do
    describe 'Control mode Text object motions' do
      behaves_like :key_spec

      key 'w', 'N words forward' do |key|
        type key
        insert.index.should == '1.10'
        type "20#{key}"
        insert.index.should == '4.28'
      end

      key 'W', 'N blank-separated WORDs forward' do |key|
        type key
        insert.index.should == '1.10'
        type "20#{key}"
        insert.index.should == '5.13'
      end

      key 'e', 'forward to the end of the Nth word' do |key|
        type key
        insert.index.should == '1.8'
      end

      key 'E', 'forward to the end of the Nth blank-separated WORD' do |key|
        type key
        insert.index.should == '1.8'
      end

      key 'b', 'N words backward' do |key|
        insert.index = 'end'
        type key
        insert.index.should == '41.39'
      end

      key 'B', 'N blank-separated WORDs backward' do |key|
        insert.index = 'end'
        type key
        insert.index.should == '41.29'
      end

      key 'ga', 'backward to the end of the Nth word' do |key|
        insert.index = 'end'
        type key
        insert.index.should == '41.40'
      end

      key 'gE', 'backward to the end of the Nth blank-separated WORD' do |key|
        insert.index = 'end'
        type key
        insert.index.should == '41.40'
      end

      key ')', 'N sentences forward' do |key|
        skip
      end

      key '(', 'N sentences backward' do |key|
        skip
      end

      key '}', 'N paragraphs forward' do |key|
        skip
      end

      key '{', 'N paragraphs backward' do |key|
        skip
      end

      key ']]', 'N sections forward, at start of section' do |key|
        skip
      end

      key '[[', 'N sections backward, at start of section' do |key|
        skip
      end

      key '][', 'N sections forward, at end of section' do |key|
        skip
      end

      key '[]', 'N sections backward, at end of section' do |key|
        skip
      end

      key '[(', 'N times back to unclosed "("' do |key|
        skip
      end

      key '[{', 'N times back to unclosed "{"' do |key|
        skip
      end

      key '[m', 'N times back to start of method (for Java)' do |key|
        skip
      end

      key '[M', 'N times back to end of method (for Java)' do |key|
        skip
      end

      key '])', 'N times forward to unclosed ")"' do |key|
        skip
      end

      key ']{', 'N times forward to unclosed "}"' do |key|
        skip
      end

      key ']m', 'N times forward to start of method (for Java)' do |key|
        skip
      end

      key ']M', 'N times forward to end of method (for Java)' do |key|
        skip
      end

      key '[#', 'N times back to unclosed "#if" or "#else"' do |key|
        skip
      end

      key ']#', 'N times forward to unclosed "#else" or "#endif"' do |key|
        skip
      end

      key '[*', 'N times back to start of comment "/*"' do |key|
        skip
      end

      key ']*', 'N times forward to end of comment "*/"' do |key|
        skip
      end
    end
  end
end
