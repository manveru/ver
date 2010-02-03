module VER
  # Some convenience methods for the default {Tk::Tile::Treeview}
  class Treeview < Tk::Tile::Treeview
    LINE_UP = <<-'TCL'.strip
set children [%path% children {}]
set children_length [llength $children]

if { $children_length > 1 } {
set item [%path% prev [%path% focus]]

if { $item == {} } { set item [lindex $children [expr $children_length - 1]] }

%path% focus $item
%path% see $item
%path% selection set $item
}
    TCL

    # Go one item in the tree up, wraps around to the bottom if the first item
    # has focus.
    #
    # Some lists may be huge, so we handle this in tcl to avoid lots of
    # useless traffic between tcl and ruby.
    # My apologies.
    def line_up(event = nil)
      Tk.eval(LINE_UP.gsub(/%path%/, tk_pathname))
    end

    LINE_DOWN = <<-'TCL'.strip
set children [%path% children {}]
set children_length [llength $children]

if { $children_length > 1 } {
set item [%path% next [%path% focus]]

if { $item == {} } { set item [lindex $children 0] }

%path% focus $item
%path% see $item
%path% selection set $item
}
    TCL

    # Go one line in the tree down, wraps around to the top if the last item
    # has focus.
    #
    # Some lists may be huge, so we handle this in tcl to avoid lots of
    # useless traffic between tcl and ruby.
    # My apologies.
    def line_down(event = nil)
      Tk.eval(LINE_DOWN.gsub(/%path%/, tk_pathname))
    end
  end
end
