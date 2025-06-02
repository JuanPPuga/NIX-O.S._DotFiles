{
  config,
  pkgs,
  lib,
  ...
}:
let
  dock-script = pkgs.writeShellScriptBin "dock-sh" ''
    niri msg output eDP-1 off
    niri msg output DP-1 vrr on
  '';
  undock-script = pkgs.writeShellScriptBin "undock-sh" ''
    niri msg output eDP-1 on
    niri msg output eDP-1 vrr on
  '';
  firefox-sync = pkgs.writeShellScriptBin "firefox-sync" ''
        static=static-$1
        link=$1
        volatile=/dev/shm/firefox-$1-$USER

        IFS=
        set -efu

        cd ~/.mozilla/firefox

        if [ ! -r $volatile ]; then
        	mkdir -m0700 $volatile
        fi

        if [ "$(readlink $link)" != "$volatile" ]; then
    	    mv $link $static
    	    ln -s $volatile $link
        fi

        if [ -e $link/.unpacked ]; then
    	    rsync -av --delete --exclude .unpacked ./$link/ ./$static/
        else
    	    rsync -av ./$static/ ./$link/
    	    touch $link/.unpacked
        fi
  '';
in
{
  environment.systemPackages = with pkgs; [
    git # GIT
    niri # Gestor de Ventanas.
    neovim #Editor Principal de Neo Vim.
    firefox # Navegador Predeterminado de NIX-OS.
    xfce.thunar # Explorador de Archivos.
    grub2
    dislocker
    xfce.thunar-volman # Leer dispositivos extraibles.
    gvfs # (Gnome Virtual Files System) - Permite leer dispositivos (Extraibles o Red).
    pipewire # Audio XD.
    eww # Barra de Tareas.
    jq # Parseador de json.
    jaq # Parseador de json en rust.
    swww # fondos de Pantalla.
    xwayland-satellite # compatibilidad de Programas Antiguos.
    htop # Administrador de Tareas.
    pwvucontrol # Gestor de Audio.
    nomacs # Visualizador de Fotos.
    wl-clipboard # Acceder al portapapeles.
    qalculate-gtk # Calculadora Mamalona.
    gnome-themes-extra # Tema principal de NIX-OS.
    lazygit # Interfaz grafica para GIT.
    grim # Sleccionar una region de una pantalla.
    swaylock # Bloqueo de Pantalla.
    bluetuith # Gestor de Bluetooth.

    wl-mirror # Permite hacer un mirror en segundo monitor.
    _7zz # 7-Zip.
    gnupg # Firmar Commits en GIT.
    pinentry-tty # Poner password de llave GPG.
    apple-cursor # Cursor Copypaste de MAC.
    nautilus # Needed for gtk4 FileChooserNative
    waypaper # NO BORRAR
    ripdrag # Permite Drag&Drop en YAZI.
    ouch # Descompresion de Archivos en YAZI.
    vscode #Importe de Visual Studio Code (Empresarial)
    jftui #JellyFin Pagina de Anime.

    dock-script
    undock-script
    firefox-sync # Sincronizacion de cuenta de Firefox.
  ];

  # Crea un Slot para guardar la sincronizacion de FireFox.
  systemd.user.services.firefox-profile-memory-cache = {
    description = "Firefox profile memory cache";
    wantedBy = [ "default.target" ];
    path = [ pkgs.rsync ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = ''${firefox-sync}/bin/firefox-sync 0shu6evv.default'';
      ExecStop = ''${firefox-sync}/bin/firefox-sync 0shu6evv.default'';
    };
  };
}
