module VER
  module Keymapped
    def major_modes
      bindtags.grep(/_major_mode$/).map{|mode| MajorMode[mode] }
    end

    def minor_modes
      bindtags.grep(/_minor_mode$/).map{|mode| MinorMode[mode] }
    end

    def modes
      [*minor_modes, *major_modes]
    end

    def major_mode=(name)
      MajorMode[name].use!(self)
    end
  end
end
