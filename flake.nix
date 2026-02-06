{
  description = "sway wayland compositor";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
    wlroots-tris = {
      url = "github:an-empty-string/wlroots-hacks/tris-patches";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat = {
      url = "github:ckiee/flake-compat/add-overrideInputs";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, wlroots-tris, ... }: {
    packages.x86_64-linux.default =
      let pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in (pkgs.sway-unwrapped.override {
        wlroots = wlroots-tris.packages.x86_64-linux.default;
      }).overrideAttrs (old: {
        version = "${old.version}-tris-patches";
        src = ./.;
      });
  };
}
