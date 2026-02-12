# This document is strictly dedicated to printer settings.

{ config, pkgs, ... }:

{
  # Printer Services: HP
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  # Auto detect WI-FI Printers (Local) – opcional
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Scanner (HP Ink Tank 315 – USB)
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };

  # UDEV for HP USB devices
  services.udev.packages = [ pkgs.hplip ];

  # User permissions
  users.users.user_933.extraGroups = [ "scanner" "lp" ];

  # Configuración SANE: usar solo el backend HP (hpaio)
  environment.etc."sane.d/dll.conf".text = ''
    hpaio
  '';
}
