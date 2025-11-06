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
    legcord
    sl
  ];


  


  # ==PROGRAM CONFIGS== #

 
  
  



  # add basic programs enable thingies below
  programs.wezterm.enable = true;
  #the bigger ones (without .enable) go here



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

  enabledExtensions = with spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.extensions; [
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
        git add .
        git commit -m "$argv"
        git push
      '';
    };
        
     nvim = { 
      body = ''
        set old_dir (pwd)
        cd /etc/nixos
        command nvim $argv
        z $old_dir
          
               
      '';
     };

      him = {
        body = ''
         nvim /etc/nixos/home.nix
        
      '';
      };
     fim = {
        body = ''
          nvim /etc/nixos/flake.nix
       '';
      };
      cim = {
        body = ''
          nvim /etc/nixos/configuration.nix        
        '';
      };
   };
 };
}
