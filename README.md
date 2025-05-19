# ✨ Guía Completa de NixOS 🚀

Bienvenido a esta guía de **instalación y configuración** de **NixOS**. Aquí aprenderás qué es, cómo instalarlo en una USB y cómo configurarlo. ¡Vamos allá! 🔥

---

## 🐧💻 ¿Qué es NixOS?
NixOS es una distribución de Linux basada en el **gestor de paquetes Nix**, lo que permite una configuración **declarativa y reproducible**. Ideal para quienes buscan estabilidad y control total sobre su entorno.

🔹 **Ventajas de NixOS**
- Configuración **determinista** y predecible.
- Fácil reversión de cambios.
- Sistema de paquetes atómico con **Nix**.
- Seguridad mejorada gracias a su aislamiento.

---

## 🏗️ Instalación en una USB

### 1️⃣ Descargar la ISO
📥 Ve a [https://nixos.org](https://nixos.org) y descarga la última versión de NixOS.

### 2️⃣ Crear un medio de instalación  
Usa `dd` o `balenaEtcher` para escribir la imagen en tu USB:

```sh
sudo dd if=nixos-xx.iso of=/dev/sdX bs=4M status=progress && sync
```
⚠️ Reemplaza `nixos-xx.iso` con el nombre del archivo y `/dev/sdX` con el identificador de tu USB.

### 3️⃣ Arrancar desde la USB  
- Conecta la USB y **reinicia** tu computadora.
- Accede al **BIOS/UEFI** y selecciona la USB como dispositivo de arranque.

---

## 🔧 Configuración de NixOS

### 1️⃣ Particionar el Disco  
Ejecuta `fdisk` o `parted` para definir las particiones:

```sh
fdisk /dev/sdX
```

### 2️⃣ Formatear las Particiones  
📌 Para **ext4**:
```sh
mkfs.ext4 /dev/sdX1
```
📌 Para **swap**:
```sh
mkswap /dev/sdX2
swapon /dev/sdX2
```

### 3️⃣ Montar el Sistema de Archivos  
```sh
mount /dev/sdX1 /mnt
```

### 4️⃣ Generar la Configuración Inicial  
```sh
nixos-generate-config --root /mnt
```

### 5️⃣ Editar `configuration.nix`  
🔍 Ajusta la configuración básica en el archivo:

```sh
nano /mnt/etc/nixos/configuration.nix
```

📜 Ejemplo de configuración:
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

### 6️⃣ Instalar NixOS  
🚀 Ejecuta el siguiente comando para la instalación:

```sh
nixos-install
```

### 7️⃣ Reiniciar  
```sh
reboot
```
✔️ ¡Tu NixOS está listo y funcionando! 🎉

---

## 🛠️ Configuraciones Adicionales

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

---

## 🎯 Conclusión
Ahora tienes NixOS instalado y listo para personalizar a tu gusto. Su enfoque declarativo te permitirá mantener un sistema limpio y eficiente. 🚀

Si tienes dudas o quieres explorar más configuraciones, revisa la [documentación oficial](https://nixos.org).
