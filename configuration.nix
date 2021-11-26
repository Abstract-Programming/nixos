# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, callPackage, options, ... }:

with pkgs;
let unstable = import <unstable> {
  config.allowUnfree = true;
};
in {

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = unstable.linuxPackages_latest;

  imports =
    [ # Include the results of the hardware scan.
      ./btrfs.nix
      ./boot.nix
      ./hardware-configuration.nix
      # ./audio.nix
      # ./nvidia.nix
      ./graphical.nix
      <home-manager/nixos>
    ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "akat"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Denver";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s20f0u4.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.akat = {
      initialHashedPassword = "$6$vcOQuFkT.XCtF0kP$LbESHYg2/viILQJlNWT3hUU9LnowsHtSymjuW4oDlSuZR.CI9WW0T.qX5jhK03Ys5LDK5UgYv48KBHtaOpIsH1";
      isNormalUser = true;
      createHome = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    };
  };
  home-manager.users.akat = { pkgs, ... }: {
    home.packages = [ pkgs.atool pkgs.httpie pkgs.libreoffice pkgs.starship ];
    programs.bash.enable = true;
  };
  environment.shells = [ pkgs.zsh ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    htop
    firefox
    exfat
    file
    expect
    git
    git-lfs
    gnumake
    home-manager
    jq
    killall
    moreutils
    neovim
    nix-index
    pciutils
    pv
    ripgrep
    sshfs-fuse
    tio
    tmux
    tree
    usbutils
    curl
    discord
    flameshot
    idea.idea-ultimate
    obs-studio
    google-cloud-sdk
  ];

  #nix-direnv
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

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
  system.stateVersion = "21.05"; # Did you read the comment?

}
