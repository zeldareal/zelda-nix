{ config, pkgs, nixvim, spicetify-nix, inputs, ... }:

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
    # browsers
    chromium
    librewolf
    google-chrome
    
    # shell & prompt
    fish
    starship
    
    # terminal
    wezterm
    
    # system info and fun
    fastfetch
    hyfetch
    lolcat
    onefetch
    pokemon-colorscripts
    sl
    
    # file nav and search    
    bat
    eza
    fd
    fzf
    ripgrep
    zoxide
    
    # system monitoring
    btop
    
    # media
    mpv
    
    # apps
    fuzzel
    legcord 
    prismlauncher
    
    # dev tools
    gcc
    gnumake
    
    # system utilities
    appimage-run
    pipewire   
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
programs.firefox = {
  enable = true;
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
  lsg = "eza -la --icons --git --group-directories-first";  # the max eye candy one
  nhup = "nh os switch --update";
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
