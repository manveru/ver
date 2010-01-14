# Copyright (c) 2009 Michael Fellinger <m.fellinger@gmail.com>
#
# Description:
#
# When modifying the tiling algorithm, it's useful to see the transitions
# between the different states animated.
# This is not a default feature of VER, as it can be very resource-intensive.
#
# Usage:
#
# Put following line into your rc.rb
#   VER.plugin :animated_tiling

require 'ver/layout/tiling'

module VER
  class Layout
    module Tiling
      # animates hiding the given +windows+
      def apply_hidden(*windows)
        target = { relheight: 0.0, relwidth: 0.5, relx: 0.5, rely: 1.0 }

        windows.flatten.each do |window|
          evolve(window, target){ window.place_forget }
        end
      end

      # animates movement of an +window+ to the position given as +target+
      def evolve(window, target)
        original = window.place_configure

        if original.is_a?(Hash)
          o_relh, o_relw, o_relx, o_rely = original.values_at(:relheight, :relwidth, :relx, :rely)
        else
          o_relh, o_relw, o_relx, o_rely = 0.0, 0.5, 0.5, 1.0
          # return window.place(target)
        end

        t_relh, t_relw, t_relx, t_rely = target.values_at(:relheight, :relwidth, :relx, :rely)

        steps = 50
        stepper = lambda{|from, to|
          from, to = (from * 1000).to_i, (to * 1000).to_i

          if from > to
            to.step(from, steps).to_a.reverse
          elsif to > from
            from.step(to, steps).to_a
          else
            [from]
          end
        }

        padder = lambda{|given, max|
          unless given.empty?
            ar = Array.new(max){ given.last }
            ar[0, given.size] = given
            ar.map{|e| e / 1000.0 }
          end
        }

        s_relh = stepper[o_relh, t_relh]
        s_relw = stepper[o_relw, t_relw]
        s_relx = stepper[o_relx, t_relx]
        s_rely = stepper[o_rely, t_rely]

        max = [s_relh, s_relw, s_relx, s_rely].max_by{|a| a.size }.size

        a_relh = padder[s_relh, max] || Array.new(max){ t_relh }
        a_relw = padder[s_relw, max] || Array.new(max){ t_relw }
        a_relx = padder[s_relx, max] || Array.new(max){ t_relx }
        a_rely = padder[s_rely, max] || Array.new(max){ t_rely }

        zipped = a_relh.zip(a_relw.zip(a_relx.zip(a_rely))).map{|a| a.flatten }

        time_per_step = (500 / zipped.size)
        zipped.each_with_index do |(h, w, x, y), i|
          Tk::After.ms(i * time_per_step) do
            window.place(relx: x, rely: y, relheight: h, relwidth: w)
          end
        end

        Tk::After.ms((zipped.size + 1) * time_per_step) do
          window.place(target)
          yield if block_given?
        end
      end
    end
  end
end
