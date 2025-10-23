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
    appimage-run
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

programs.atuin = {
  enable = true;
  enableFishIntegration = true;
  settings = {
    # optional: sync across machines (needs account at atuin.sh)
    # sync_address = "https://api.atuin.sh";
    # auto_sync = true;
    
    # or keep it local-only (default)
    auto_sync = false;
    
    # some nice defaults
    search_mode = "fuzzy";
    filter_mode_shell_up_key_binding = "directory";
    inline_height = 30;
  };
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
      nixout = "sudo nix-collect-garbage -d";
      flakein = "sudo nixos-rebuild switch --flake /etc/nixos#zeldanixbtw";
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