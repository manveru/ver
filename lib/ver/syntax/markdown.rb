module VER
  module Syntax
    class Markdown < Common
      def spec
        match :mkd_list_item, /\s*[*+-]\s+/, :bol => true
        match :mkd_list_item, /\s*\d+\.\s+/, :bol => true

        match :mkd_bold, /\*\*[^*]+\*\*/
        match :mkd_bold, /__[^_]+__/

        match :mkd_italic, /\*[^*]+\*/
        match :mkd_italic, /_[^_]+_/

        match :mkd_rule, /^\s*\*\s{0,1}\*\s{0,1}\*$/,        :bol => true
        match :mkd_rule, /^\s*-\s{0,1}-\s{0,1}-$/,           :bol => true
        match :mkd_rule, /^\s*_\s{0,1}_\s{0,1}_$/,           :bol => true
        match :mkd_rule, /^\s*-{3,}$/,                       :bol => true
        match :mkd_rule, /^\s*\*{3,5}$/,                     :bol => true
        match :mkd_code, /^\s*\n((\s{4,}|\t+)[^*+ -].*\n)+/, :bol => true

        region :mkd_blockquote, /[ \t]*>/, :eol, :bol => true

        region :mkd_code, /`/, /`/
        region :mkd_code, /\s*``[^`]*/, /[^`]*``\s*/
        region :mkd_code, /<pre[^>]*>/, /<\/pre>/
        region :mkd_code, /<code[^>]*>/, /<\/code>/

        region :h6, /[ \t]*######/, :eol, :bol => true
        region :h5, /[ \t]*#####/,  :eol, :bol => true
        region :h4, /[ \t]*####/,   :eol, :bol => true
        region :h3, /[ \t]*###/,    :eol, :bol => true
        region :h2, /[ \t]*##/,     :eol, :bol => true
        region :h1, /[ \t]*#/,      :eol, :bol => true

        highlights(
          :mkd_italic        => :italic,
          :mkd_bold          => :bold,
          :mkd_string        => :string,
          :mkd_code          => :string,
          :mkd_blockquote    => :comment,
          :mkd_line_continue => :comment,
          :mkd_block_meta    => :comment,
          :mkd_list_item     => :identifier,
          :mkd_rule          => :identifier
        )
      end
    end
  end
end
