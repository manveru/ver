{
  description = "VER — Vim & Emacs in Ruby, on Tcl/Tk via ffi-tk";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    # To test local ffi-tk changes, pass
    # `--override-input ffi-tk path:/path/to/ffi-tk`.
    ffi-tk = {
      url = "github:manveru/ffi-tk";
      flake = false;
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, lib, ... }:
        let
          ruby = pkgs.ruby_4_0;
          libtcl = "${pkgs.tcl}/lib/libtcl8.6${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
          libtk = "${pkgs.tk}/lib/libtk8.6${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";

          gems = pkgs.bundlerEnv {
            name = "ver-gems";
            inherit ruby;
            gemdir = ./.;
          };

          # bundlerEnv only supports path gems for the app itself, so ffi-tk
          # (whose sole runtime gem, ffi, is in the Gemfile) goes on RUBYLIB.
          ffiTkLib = "${inputs.ffi-tk}/lib";

          ver = pkgs.stdenv.mkDerivation {
            pname = "ver";
            version = "2013.03";
            src = lib.fileset.toSource {
              root = ./.;
              fileset = lib.fileset.unions [
                ./bin
                ./config
                ./help
                ./lib
              ];
            };
            nativeBuildInputs = [ pkgs.makeWrapper ];
            installPhase = ''
              mkdir -p $out/share/ver $out/bin
              cp -r bin config help lib $out/share/ver
              makeWrapper ${gems.wrappedRuby}/bin/ruby $out/bin/ver \
                --add-flags $out/share/ver/bin/ver \
                --prefix PATH : ${
                  lib.makeBinPath [
                    gems # rchardet, called by Pathname#encoding
                    gems.wrappedRuby # ruby -c, called by --install-tm-*
                  ]
                } \
                --prefix RUBYLIB : ${ffiTkLib} \
                --set TCL_LIBPATH ${libtcl} \
                --set TK_LIBPATH ${libtk}
            '';
            meta.mainProgram = "ver";
          };
        in
        {
          packages.default = ver;

          formatter = pkgs.nixfmt;

          devShells.default = pkgs.mkShell {
            RUBYLIB = ffiTkLib;
            TCL_LIBPATH = libtcl;
            TK_LIBPATH = libtk;
            packages = [
              gems
              gems.wrappedRuby
              pkgs.tcl
              pkgs.tk
            ]
            # `rake` runs the specs on a private Xvfb (tasks/support/
            # headless_display.rb). The window manager is required: keymap
            # specs synthesise key events that only reach a focused window.
            ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
              pkgs.xorg-server # Xvfb
              pkgs.openbox
              pkgs.xprop # WM-readiness probe
            ];
          };
        };
    };
}
