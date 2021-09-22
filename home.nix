{ config, pkgs, ... }:

let
  unstable = import (
    fetchTarball
      "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz"
  ) {
    overlays = [
      (
        import (
          builtins.fetchTarball {
            url =
              "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
          }
        )
      )
    ];
  };
in
{

  home.packages = with pkgs; [
    # Rust Utilities
    bat
    exa
    fd
    ripgrep
    tre-command

    # Misc Utilities
    pandoc
    ispell
    gnupg
    cmake

    # Fun Stuff
    cowsay
    figlet
    lolcat
    neofetch
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Emacs
  programs.emacs = {
    enable = true;
    package = unstable.emacsGcc;
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "benjaminmurray";
  home.homeDirectory = "/Users/benjaminmurray";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
