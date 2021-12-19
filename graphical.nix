{ config, pkgs, lib, ... }:


# let
#  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
#    export __NV_PRIME_RENDER_OFFLOAD=1
#    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
#    export __GLX_VENDOR_LIBRARY_NAME=nvidia
#    export __VK_LAYER_NV_optimus=NVIDIA_only
#    exec -a "$0" "$@"
#  '';
#in
{
  environment.systemPackages = with pkgs; [
    evince
    evolution
    fprintd
    gnome.eog
    gnome.geary
    gnome3.gnome-tweak-tool
    gnome3.networkmanagerapplet
    gnomeExtensions.appindicator
    libappindicator
    libimobiledevice
    neovim-qt
  ];
  # Nvidia specific stuff, need beta version for wayland support (470+).
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    sync.enable = true;
    # Bus ID of the Intel GPU.
    intelBusId = "PCI:0:2:0";
    # Bus ID of the NVIDIA GPU.
    nvidiaBusId = "PCI:1:0:0";
  };  
  
  environment.variables = {
    VISUAL = "vim";
    MOZ_ENABLE_WAYLAND = "1";
  };

  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "Cousine" "FiraCode" "RobotoMono" ]; })
      carlito
      corefonts
      crimson
      dejavu_fonts
      fira
      fira-code
      fira-mono
      inconsolata
      inter
      inter-ui
      libertine
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
      roboto
      roboto-mono
      source-code-pro
      source-sans-pro
      source-serif-pro
    ];
    fontconfig.localConf = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <alias binding="weak">
          <family>monospace</family>
          <prefer>
            <family>emoji</family>
          </prefer>
        </alias>
        <alias binding="weak">
          <family>sans-serif</family>
          <prefer>
            <family>emoji</family>
          </prefer>
        </alias>
        <alias binding="weak">
          <family>serif</family>
          <prefer>
            <family>emoji</family>
          </prefer>
        </alias>
      </fontconfig>
          '';
    fontconfig.defaultFonts = {
      sansSerif = [ "Arimo" ];
      serif = [ "Tinos" ];
      monospace = [ "Cousine" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
  };

  services = {
    xserver = {
      enable = true;
      # videoDrivers = [ "nvidiaBeta" ];
      xkbOptions = "caps:escape";
      libinput.enable = true;
      displayManager = {
        gdm = {
          enable = true;
          nvidiaWayland = true;
        };
      };
      desktopManager.gnome.enable = true;
    };
    blueman.enable = true;
    gnome = {
      core-os-services.enable = true;
      evolution-data-server.enable = true;
      core-shell.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      media-session.enable = true;
      pulse.enable = true;
    };
    dbus.enable = true;
    flatpak.enable = true;
    fprintd.enable = true;
    fwupd.enable = true;
    geoclue2.enable = false;
    localtime.enable = false;
    printing.enable = false;
    redshift.enable = false;
    usbmuxd.enable = true;
  };
  # location.provider = "geoclue2";

  programs = {
    dconf.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nm-applet.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [ ];
    };
  };

  security = {
    rtkit.enable = true;
    pam.services = {
      login.fprintAuth = true;
      xscreensaver.fprintAuth = true;
      login.enableGnomeKeyring = true;
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages32 = with pkgs; [ pkgsi686Linux.libva ];
    setLdLibraryPath = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
}
