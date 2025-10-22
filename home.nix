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
    vesktop
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
#nvim (broken lazyvim, pls fix zelda)
  programs.neovim = {
  enable = true;
  plugins = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    
  ];
};
  
programs.fzf = {
  enable = true;
  enableFishIntegration= true;
};

programs.zoxide = {
  enable = true;
  enableFishIntegration = true;
};

programs.direnv = {
  enable = true;
  nix-direnv.enable = true;
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
      nixout = "sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system && nix-env --delete-generations old --profile ~/.local/state/nix/profiles/home-manager && sudo nix-collect-garbage";
      flakeup = "nix flake update /etc/nixos";
      flakein = "sudo nixos-rebuild switch --flake /etc/nixos#zeldanixbtw";
      ls = "eza --icons";
      cat = "bat";
      top = "btop";
    };
  };
}




