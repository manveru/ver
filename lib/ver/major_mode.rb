module VER
  def self.major_mode(name, &block)
    MajorMode.new(name, &block)
  end

  class MajorMode < MinorMode
    MODES = {}
    LEAVE = "<<LeaveMajorMode%s>>"
    ENTER = "<<EnterMajorMode%s>>"

    def self.[](name)
      sym = name.to_s.sub(/_major_mode$/, '').to_sym
      MODES.fetch(sym)
    rescue KeyError => ex
      message = "%s for %p" % [ex.message, sym]
      raise(ex, message)
    end

    attr_accessor :minor_mode_names, :based_on_names

    def initialize(name, &block)
      @minor_mode_names = []
      @based_on_names = []
      common_setup(name, :major_mode)
      MODES[@name] = self
      instance_eval(&block) if block
    end

    def minor_modes(*minor_mode_names)
      @minor_mode_names = minor_mode_names
    end

    def add_minor_mode(name)
      @minor_mode_names << name
      @minor_mode_names.uniq!
    end

    def based_on(*major_mode_names)
      @based_on_names = major_mode_names
    end

    def inspect
      @tag.name.inspect
    end

    def major?
      true
    end

    def minor?
      false
    end

    # forget all major and minor modes and enter this major mode.
    def use!(widget)
      all      = widget.bindtags
      specific = all[0, 1]
      general  = all[-3..-1]

      minors   = @minor_mode_names.map{|minor| MinorMode[minor] }
      majors   = @based_on_names.map{|major| MajorMode[major] }
      minors  += majors.map{|major|
                   major.minor_mode_names.map{|minor| MinorMode[minor] }}

      minors.map!{|minor| minor.brotherhood }

      minors.flatten!
      minors.uniq!
      p [*specific, *minors, self, *majors, *general]
      widget.bindtags(*specific, *minors, self, *majors, *general)
    end
  end
end
