{
  description = "sway wayland compositor";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    wlroots-tris = {
      url = "path:/home/tris/vend/wlroots";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, wlroots-tris }: {
    packages.x86_64-linux.default = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in (pkgs.sway-unwrapped.override {
        wlroots = wlroots-tris.packages.x86_64-linux.default;
      }).overrideAttrs (old: {
      version = "${old.version}-tris-patches";
      src = ./.;
    });
  };
}
