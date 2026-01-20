## Manual de Impresora & Scanner (25.11)
En NixOS no viene la configuracion para las impresoras lo cual se tiene que hacer de forma manual, dentro del manual solo usare los archivos [packages.nix y printers-configuration.nix].

🔹 **Separacion de Archivos**
- packages.nix **(Seccion 3)**.
- printers-configuration.nix **(Estructura Completa)**.

---

## Explicacion de Estructura

### [printers-configuration.nix]
Dentro de este archivo incluye la compativilidad de la impresora mas la respuesta para poder escanerla via USB, incluyendo que se uso SANE **(Scanner Access Now Easy)**, para poder usar el escaner.
Incluyendo que se priorizo el uso del lente de la impresora base al permiso del usuario, (En dado caso que solo tome la Cam de la laptop!).

```sh
En mi caso se implementaron los usos de HP para obtener los driver correspondientes de la impresora.
```

---

## Explicacion de Paquetes

### [packages.nix]
En este apartado solo enfatizare en la **Seccion #3**, la cual contiene las compativilidades entre NixOS y la impresora.

```nix
environment.systemPackages = with pkgs; [
    simple-scan #Scanner KDE with graphic ver.
    hplip #HP Linux Imaging and Printing.
    hplipWithPlugin #hplip with plugins from HP.
    sane-backends #Linux - Scanner Drivers.
    usbutils #Dienostic Tools (USB).
];
```

En este archivo solo integre estos paquetes para tener la estavilidad entre el equipo y el externo.

```sh
#SANE:
hardware.sane.enable = true;
```

Incluyendo que pueda leer el equipo el externo de interpretacion SANE (Scanner Access Now Easy).

---

## Forma de verificacion:

### Desde la consola verificar la configuracion
```sh
scanimage -L
```
Este comando dara el resultado de priorizacion para el equipo externo un ejemplo seria:
```sh
device `hpaio:/usb/HP_Ink_Tank_315?...' is a HP Ink Tank 315 all-in-one
```

---

## Lista de Comandos base a la consola:

🔹 **Archivos guardados en /home/user**

- Formato rapida pero de calidad baja:
```sh
scanimage --format=png > scan.png
```

- Formato a **Color de 300 DPI**
```sh
scanimage --resolution 300 --mode Color --format=png > documento.png
```

- Formato a **Blanco y Negro (txt)**
```sh
scanimage --resolution 300 --mode Gray --format=png > texto.png
```