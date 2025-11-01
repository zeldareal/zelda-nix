{ config, pkgs, nixvim, spicetify-nix, ... }:

{

  imports = [
    nixvim.homeModules.default
    ./modules/nixvim
    spicetify-nix.homeManagerModules.default
  ];
#im sorry for writing this
  home.username = "zelda";
  home.homeDirectory = "/home/zelda";
  home.stateVersion = "25.05";
# welcome to the fucking zelda verse where everything is #SWAGMESSIAH x100

 

  # Packages for your user
  home.packages = with pkgs; [
    google-chrome
    fish
    starship
    fastfetch
    hyfetch
    wezterm
    fzf
    prismlauncher
    onefetch
    discord
    lolcat
    mpv
    eza
    bat 
    ripgrep
    fd 
    zoxide
    btop
    pokemon-colorscripts
    appimage-run
    pipewire
    chromium
    gnumake
    gcc
  ];


  


  #config file symlinks below *tumbleweed rolling*

 
  
  



  # add basic programs enable thingies below
  programs.wezterm.enable = true;
  #the bigger ones (without .enable) go here



#starship
  programs.starship = {
  enable = true;
  enableFishIntegration = true;
  settings = builtins.fromTOML (builtins.readFile ./dotfiles/starship.toml);
};

programs.spicetify = {
  enable = true;
  theme = spicetify-nix.legacyPackages.${pkgs.system}.themes.text;
  colorScheme = "TokyoNightStorm";

  enabledExtensions = with spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
    adblock
    shuffle
  ];
};

#vencord but discord uhmmmmmmm
  programs.vesktop = {
    enable = true;
  };

#fzf
programs.fzf = {
  enable = true;
  enableFishIntegration = true;
};

#z nix z nix z nix
programs.zoxide = {
  enable = true;
  enableFishIntegration = true;
};

#firefox
programs.firefox = {
  enable = true;
};


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
  nixin = "sudo nixos-rebuild switch";
  nixup = "sudo nixos-rebuild switch --upgrade";
  nixout = "sudo nix-collect-garbage -d && nix-store --optimize";
  flakein = "sudo nixos-rebuild switch --flake /etc/nixos#kernel-linux-mckenzie";
  ls = "eza --icons";
  cat = "bat";
  top = "btop";
  grep = "rg";
  find = "fd";
  tree = "eza -T --icons";
  lsg = "eza -la --icons --git --group-directories-first";  # the max eye candy one
};
  
  

  functions = {
    nixcommit = {
      body = ''
        cd /etc/nixos
        sudo git add .
        sudo git commit -m "$argv"
        sudo git push
      '';
    };
    flakeup = {
      body = ''
        echo "flake updating"
        cd /etc/nixos
        sudo chown -R (whoami):(id -gn) .
        nix flake update
        sudo chown -R root:root .
        echo "flake updated"
       '';
     };
   };
 };
}
