{ config, pkgs, ... }:

{
  #Printer-Services: HP.
    services.printing = {
    enable = true;
    drivers = [
      pkgs.hplip
    ];
  };

  #Auto detect WI-FI Printers (Local).  
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # For USB port - Printers.
  hardware.printers = {
    ensurePrinters = [];
  };
}