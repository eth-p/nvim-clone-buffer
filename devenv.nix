{ pkgs, lib, config, inputs, ... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };
in
{
  packages = [
    pkgs.git
    pkgs.stylua
    pkgs-unstable.selene
  ];

  # Disable the default enterShell task.
  enterShell = lib.mkForce "";
}
