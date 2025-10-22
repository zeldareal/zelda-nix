{ config, pkgs, ... }:

{
# apologies in advance.
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

    ];

    nixpkgs.config.allowUnfree = true;

    fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
  #hardware shit
    hardware.bluetooth.enable = true;
    services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = false;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zeldanixbtw"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.

  security.rtkit.enable = true;



  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zelda = {
    isNormalUser = true;
    description = "zeldareal";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.


  # Allow unfree packages


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  bluez-tools
  flatpak
  wget
  git
  woeusb-ng
  ntfs3g
  wine
  kdePackages.discover
  lxappearance
  nitrogen
  picom
  rofi
  steam
  alacritty
  vscodium
  vcpkg
  cmake
  kdePackages.kdeconnect-kde
  ];
#hm shit so hm works because hm is stupid and i hate it FUCK YOU FUCK YOU FUCK YOU
 

  #flatpak because uhh uhmmm errr
  services.flatpak.enable = true;

  

# steam because it cant be in hm
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; #steam link
  dedicatedServer.openFirewall = true; #server
};



programs.fish.enable = true;
users.users.zelda.shell = pkgs.fish;
users.users.root.shell = pkgs.fish;  # if root shell is also fish, add this too


   users.defaultUserShell = pkgs.fish;
   
networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;
  boot.plymouth.theme = "bgrt";
  boot.kernelParams = ["quiet" "splash" "i915.fastboot=1"];
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
