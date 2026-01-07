## ¿Qué es NixOS? (Ver. 24.00 - 25.11)
NixOS es una distribución de Linux basada en el **gestor de paquetes Nix**, lo que permite una configuración **declarativa y reproducible**. Ideal para quienes buscan estabilidad y control total sobre su entorno.

🔹 **Ventajas de NixOS**
- Configuración **determinista** y predecible.
- Fácil reversión de cambios.
- Sistema de paquetes atómico con **Nix**.
- Seguridad mejorada gracias a su aislamiento.

---

## Instalación en una USB

### Descargar la ISO
Ve a [https://nixos.org](https://nixos.org) y descarga la última versión de NixOS.

### Crear un medio de instalación  
Usa `dd` o `balenaEtcher` para escribir la imagen en tu USB:

```sh
sudo dd if=nixos-xx.iso of=/dev/sdX bs=4M status=progress && sync
```
Reemplaza `nixos-xx.iso` con el nombre del archivo y `/dev/sdX` con el identificador de tu USB.

### Arrancar desde la USB  
- Conecta la USB y **reinicia** tu computadora.
- Accede al **BIOS/UEFI** y selecciona la USB como dispositivo de arranque.

---

## Configuración de NixOS

### Particionar el Disco  
Ejecuta `fdisk` o `parted` para definir las particiones:

```sh
fdisk /dev/sdX
```

### Formatear las Particiones  
 Para **ext4**:
```sh
mkfs.ext4 /dev/sdX1
```
 Para **swap**:
```sh
mkswap /dev/sdX2
swapon /dev/sdX2
```

### Montar el Sistema de Archivos  
```sh
mount /dev/sdX1 /mnt
```

### Generar la Configuración Inicial  
```sh
nixos-generate-config --root /mnt
```

### Editar `configuration.nix`  
Ajusta la configuración básica en el archivo:

```sh
nano /mnt/etc/nixos/configuration.nix
```

Ejemplo de configuración:
```nix
{
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdX";
  networking.hostName = "nixos";
  services.openssh.enable = true;
  users.users.juan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
```

### Instalar NixOS  
Ejecuta el siguiente comando para la instalación:

```sh
nixos-install
```

### Reiniciar  
```sh
reboot
```

---

## Configuraciones Adicionales

🔹 **Instalar paquetes esenciales**  
```sh
nix-env -iA nixpkgs.vim nixpkgs.git nixpkgs.firefox
```

🔹 **Habilitar interfaces gráficas**  
```sh
services.xserver.enable = true;
services.xserver.windowManager.i3.enable = true;
```

🔹 **Actualizar el sistema**  
```sh
nixos-rebuild switch
```