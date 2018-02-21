with import <nixpkgs> {};
let
  ruby = (ruby_2_4.override { useRailsExpress = false; });
  gems = pkgs.bundlerEnv { name = "ver-gems"; inherit ruby; gemdir = ./.; };
  bundix = pkgs.bundix.override { inherit bundler; };
in stdenv.mkDerivation {
  name = "ver-shell";
  buildInputs = [ ruby bundix gems tcl tk pkgconfig ];

  TCL_LIBPATH = "${tcl-8_6}/lib/libtcl8.6.so";
  TK_LIBPATH = "${tk}/lib/libtk8.6.so";
  # RUBYLIB = "../ffi-tk/lib";
}
