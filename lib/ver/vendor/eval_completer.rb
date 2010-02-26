module VER
  # Completion based on some code of IRB::InputCompleter
  #
  # Copyright by Keiju ISHITSUKA <keiju@ishitsuka.com>
  #          and Michael Fellinger <m.fellinger@gmail.com>
  # From Original Idea of shugo@ruby-lang.org
  module EvalCompleter
    ReservedWords = %w[
      BEGIN END alias and begin break case class def defined do else elsif end
      ensure false for if in module next nil not or redo rescue retry return self
      super then true undef unless until when while yield
    ]

    Operators = %w[
      % & * ** + - / < << <= <=> == === =~ > >= >> [] []= ^ ! != !~
    ]

    WordBreak = /[\t\n"'`><=;|&{(]/

    module_function

    def complete(input, bind = TOPLEVEL_BINDING)
      case input
      when /^(\/[^\/]*\/)\.([^.]*)$/
        complete_regexp_method($1, Regexp.quote($2))
      when /^([^\]]*\])\.([^.]*)$/
        complete_array_method($1, Regexp.quote($2))
      when /^([^\}]*\})\.([^.]*)$/
        complete_proc_or_hash_method($1, Regexp.quote($2))
      when /^(:[^:.]*)$/
        complete_symbol(Regexp.quote($1))
      when /^::([A-Z][^:\.\(]*)$/
        complete_absolute_constant_or_class_method(Regexp.quote($1))
      when /^(((::)?[A-Z][^:.\(]*)+)::?([^:.]*)$/
        complete_constant_or_class_method(bind, $1, Regexp.quote($4))
      when /^(:[^:.]+)\.([^.]*)$/
        complete_symbol_method($1, Regexp.quote($2))
      when /^(-?(0[dbo])?[0-9_]+(\.[0-9_]+)?([eE]-?[0-9]+)?)\.([^.]*)$/
        complete_numeric_method(bind, $1, Regexp.quote($5))
      when /^(-?0x[0-9a-fA-F_]+)\.([^.]*)$/
        complete_numeric_hex_method(bind, $1, Regexp.quote($2))
      when /^(\$[^.]*)$/
        complete_global_variable(Regexp.new(Regexp.quote($1)))
      when /^((\.?[^.]+)+)\.([^.]*)$/
        complete_variable(bind, $1, Regexp.quote($3))
      when /^\.([^.]*)$/
        complete_unknown(Regexp.quote($1))
      else
        complete_else(bind, Regexp.quote(input))
      end
    end

    def complete_regexp_method(receiver, message)
      candidates = Regexp.instance_methods
      select_message(receiver, message, candidates)
    end

    def complete_array_method(receiver, message)
      candidates = Array.instance_methods
      select_message(receiver, message, candidates)
    end

    def complete_proc_or_hash_method(receiver, message)
      candidates = Proc.instance_methods
      candidates |= Hash.instance_methods
      select_message(receiver, message, candidates)
    end

    def complete_symbol(sym)
      candidates = Symbol.all_symbols.map(&:inspect)
      candidates.grep(/^#{sym}/)
    end

    def complete_absolute_constant_or_class_method(receiver)
      candidates = Object.constants
      candidates.grep(/^#{receiver}/).map{|name| "::#{name}" }
    end

    def complete_constant_or_class_method(bind, receiver, message)
      begin
        candidates =  eval("#{receiver}.constants", bind)
        candidates |= eval("#{receiver}.methods", bind)
      rescue Exception
        candidates = [*candidates]
      end

      candidates.grep(/^#{message}/).map{|name| "#{receiver}::#{name}" }
    end

    def complete_symbol_method(receiver, message)
      candidates = Symbol.instance_methods
      select_message(receiver, message, candidates)
    end

    def complete_numeric_method(bind, receiver, message)
      begin
        candidates = eval(receiver, bind).methods
      rescue Exception
        candidates = []
      end

      select_message(receiver, message, candidates)
    end

    # Numeric(0xFFFF)
    def complete_numeric_hex_method(bind, receiver, message)
      begin
        candidates = eval(receiver, bind).methods
      rescue Exception
        candidates = []
      end

      select_message(receiver, message, candidates)
    end

    def complete_global_variable(regmessage)
      global_variables.grep(regmessage).map(&:to_s)
    end

    def complete_variable(bind, receiver, message)
      gv = eval("global_variables",     bind).map(&:to_s)
      lv = eval("local_variables",      bind).map(&:to_s)
      cv = eval("self.class.constants", bind).map(&:to_s)

      if (gv | lv | cv).include?(receiver)
        # foo.func and foo is local var.
        candidates = eval("#{receiver}.methods", bind)
      elsif /^[A-Z]/ =~ receiver and /\./ !~ receiver
        # Foo::Bar.func
        begin
          candidates = eval("#{receiver}.methods", bind)
        rescue Exception
          candidates = []
        end
      else
        # func1.func2
        candidates = []

        ObjectSpace.each_object(Module) do |mod|
          begin
            name = mod.name
          rescue Exception
            name = ""
          end

          next if name != "IRB::Context" && /^(IRB|SLex|RubyLex|RubyToken)/ =~ name
          candidates.concat mod.instance_methods(false)
        end

        candidates.sort!
        candidates.uniq!
      end

      select_message(receiver, message, candidates)
    end

    # unknown(maybe String)
    def complete_unknown(message)
      receiver = ""

      candidates = String.instance_methods(true)
      select_message(receiver, message, candidates)
    end

    def complete_else(bind, receiver)
      code = "methods | private_methods | local_variables | self.class.constants"
      candidates = eval(code, bind)

      (candidates|ReservedWords).grep(/^#{receiver}/).map(&:to_s)
    end

    def select_message(receiver, message, candidates)
      candidates.grep(/^#{message}/).map{|entity|
        case entity
        when /^[a-zA-Z_]/
          "#{receiver}.#{entity}"
        when /^[0-9]/
        when *Operators
          # "#{receiver} #{entity}"
        end
      }.compact
    end
  end
end
