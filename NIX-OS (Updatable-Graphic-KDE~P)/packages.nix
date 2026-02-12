{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix!
    # The Nano editor is also installed by default.
    # List packages installed in system profile. To search, run:
    # $ nix search wget

    #wget

    #Correcion de Video [STEAM]
    ffmpeg-full
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly

    protonup-ng #Asset - Steam Linux Tools
    vim #vim-Editor
    kdePackages.kdeplasma-addons #KDE - Plasma
    vlc #VLC Media Player
    pdfarranger #Editor de PDF's
    ntfs3g # Help NTFS Data
    qalculate-gtk # Calculadora Mamalona.

    simple-scan #Scanner KDE
    hplip #HP Linux Imaging and Printing.
    hplipWithPlugin #hplip with plugins from HP.
    sane-backends #Linux - Scanner Drivers.
    usbutils #Dienostic Tools (USB).

    # libreoffice # Stable LibreOffice

  ];
  
    #SANE:
  hardware.sane.enable = true;

    # Proton GE Tools for STEAM:
  environment.sessionVariables = {
    STEAM_EXTRA_COMPACT_TOOLS_PATCHS = "/home/user/.steam/root/compatibilitytools.d";
  };

  # Install STEAM.
  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

}
