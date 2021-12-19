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
      ./graphical.nix
      ./chat.nix
      ./firewall.nix
      <home-manager/nixos>
    ];

  networking.hostName = "akat"; # Define your hostname.
  time.timeZone = "America/Denver";
  networking.useDHCP = false;
  networking.interfaces.enp0s20f0u4.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  services.xserver.libinput.enable = true;
  hardware.bluetooth.enable = true;
  programs.adb.enable = true;
  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    users.akat = {
      initialHashedPassword = "$6$vcOQuFkT.XCtF0kP$LbESHYg2/viILQJlNWT3hUU9LnowsHtSymjuW4oDlSuZR.CI9WW0T.qX5jhK03Ys5LDK5UgYv48KBHtaOpIsH1";
      isNormalUser = true;
      createHome = true;
      extraGroups = [ "wheel" "adbusers" ]; # Enable ‘sudo’ for the user.
    };
  };
  home-manager.users.akat = { pkgs, ... }: {
    home.packages = [ pkgs.atool pkgs.httpie pkgs.libreoffice pkgs.starship pkgs.oh-my-zsh pkgs.screen pkgs.weechat pkgs.element-desktop pkgs.joplin-desktop ];
    programs.bash.enable = true;
  };
  environment.shells = [ pkgs.zsh ];
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    htop
    firefox
    google-chrome
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
    idea.idea-ultimate
    obs-studio
    google-cloud-sdk
    oh-my-zsh
    screenfetch
    dig
    neofetch
    minecraft
  ];
  
  #nix-direnv
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}
