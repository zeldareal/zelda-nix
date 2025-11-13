{
  config,
  pkgs,
  nixvim,
  spicetify-nix,
  ...
}:
{

  imports = [
    nixvim.homeModules.default
    ./modules/nixvim
    spicetify-nix.homeManagerModules.default
    ./sway.nix
  ];
  #im sorry for writing this
  home.username = "zelda";
  home.homeDirectory = "/home/zelda";
  home.stateVersion = "25.05";
  # welcome to the fucking zelda verse where everything is #SWAGMESSIAH x100
  # Packages for your user
  home.packages = with pkgs; [

    chromium
    librewolf
    google-chrome
    fish
    starship
    wezterm
    fastfetch
    hyfetch
    lolcat
    onefetch
    pokemon-colorscripts
    sl
    onefetch
    bat
    eza
    fd
    fzf
    ripgrep
    zoxide
    btop
    mpv
    fuzzel
    notion-app-enhanced
    legcord
    prismlauncher
    gcc
    gnumake
    appimage-run
    pipewire
    nushell
    gum

    cava
    swaybg
  ];

  # ==PROGRAM CONFIGS== #
  programs.wezterm = {
    enable = true;
  };

  #starship
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./dotfiles/starship.toml);
  };

  # ==SPICETIFY== #
  programs.spicetify = {
    enable = true;
    theme = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.text;
    colorScheme = "TokyoNightStorm";
    enabledExtensions =
      with spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.extensions; [
        adblock
        shuffle
      ];
  };

  #fzf
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  #z
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  #firefox
  programs.firefox.enable = true;

  #git
  programs.git = {
    enable = true;
    extraConfig = {
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
    };
  };

  #===FISH===
  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting
        echo "hey zelda uwu" | ${pkgs.lolcat}/bin/lolcat
    '';
    shellAliases = {
      ll = "eza -l --icons --git --group-directories-first";
      la = "eza -la --icons --git";
      lt = "eza -T --icons";
      ls = "eza --icons";
      cat = "bat";
      top = "btop";
      grep = "rg";
      find = "fd";
      tree = "eza -T --icons";
      lsg = "eza -la --icons --git --group-directories-first"; # the max eye candy one
      nhup = "nh os switch --update";
    };
    functions = {

      nixcommit = ''
        cd /etc/nixos
        git add .
        git commit -m "$argv"
        git push
      '';
      him = ''
        nvim /etc/nixos/home.nix
      '';
      fim = ''
        nvim /etc/nixos/flake.nix
      '';
      cim = ''
        nvim /etc/nixos/configuration.nix
      '';
      nvim = ''
        sudo -E nvim $argv
      '';
    };
  };
}
