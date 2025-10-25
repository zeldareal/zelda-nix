{ config, pkgs, ... }:

{
#im sorry for writing this
  home.username = "zelda";
  home.homeDirectory = "/home/zelda";
  home.stateVersion = "25.05";
# welcome to the fucking zelda verse where everything is #SWAGMESSIAH x100



  # Packages for your user
  home.packages = with pkgs; [
    google-chrome
    fish
    spotify
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
  ];


  xdg.desktopEntries.vesktop = {
    name = "Vesktop";
    genericName = "Internet Messenger";
    exec = "vesktop %U";
    icon = "vesktop";
    categories = [ "Network" "InstantMessaging" "Chat" ];
    startupNotify = true;
    settings = {
      StartupWMClass = "Vesktop";
      Keywords = "discord;vencord;electron;chat";
    };
  };


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
#nvim (broken lazyvim, pls fix zelda)
  programs.neovim = {
  enable = true;
  plugins = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    
  ];
};
  programs.vesktop = {
    enable = true;
  };
programs.fzf = {
  enable = true;
  enableFishIntegration = true;
};

programs.zoxide = {
  enable = true;
  enableFishIntegration = true;
};





programs.fish = {
  enable = true;

  shellInit = ''
    set fish_greeting
      echo "hey zelda uwu" | ${pkgs.lolcat}/bin/lolcat
    
  '';

  shellAliases = {
    ll = "ls -l";
    la = "ls -a";
    nixin = "sudo nixos-rebuild switch";
    nixup = "sudo nixos-rebuild switch --upgrade";
    nixout = "sudo nix-collect-garbage -d && nix-store --optimize";
    flakein = "sudo nixos-rebuild switch --flake /etc/nixos#kernel-linux-mckenzie";
    ls = "eza --icons";
    cat = "bat";
    top = "btop";
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