# Instrucciones para Configurar Escritorio Virtual Automático con AnyDesk

## Descripción
Esta configuración permite que el contenedor Docker inicie automáticamente un escritorio virtual XFCE con AnyDesk ejecutándose en segundo plano, sin necesidad de conectarse primero vía RDP.

## Requisitos Previos
- Imagen Docker personalizada `remote-desktop-custom-v2` (creada con las modificaciones descritas)
- AnyDesk instalado en el contenedor (extraído del archivo `anydesk-7.1.2-arm64.tar.gz`)

## Paquetes a Instalar
Ejecutar dentro del contenedor:
```bash
apt update && apt install -y xvfb
```

## Modificaciones al Script de Entrada
El script `/usr/bin/entrypoint` fue modificado para incluir lo siguiente después de la creación del usuario:

```bash
# Limpiar procesos y locks previos
pkill -f Xvfb; rm -f /tmp/.X*-lock

# Iniciar servidor X virtual
Xvfb :99 -screen 0 1920x1080x24 &

# Configurar display
export DISPLAY=:99

# Iniciar sesión XFCE como usuario ubuntu
su ubuntu -c "export DISPLAY=:99; dbus-launch --exit-with-session xfce4-session &"

# Esperar que XFCE inicie
sleep 5

# Iniciar AnyDesk
su ubuntu -c "export DISPLAY=:99; anydesk &"
```

## Archivo de Configuración de Autostart (Opcional)
Si se prefiere iniciar AnyDesk solo cuando se conecta vía RDP, crear el archivo `/home/ubuntu/.config/autostart/anydesk.desktop`:

```ini
[Desktop Entry]
Type=Application
Name=AnyDesk
GenericName=AnyDesk
X-GNOME-FullName=AnyDesk
Exec=/usr/bin/anydesk
Icon=anydesk
Terminal=false
TryExec=anydesk
Categories=Network;GTK;
MimeType=x-scheme-handler/anydesk;
Name[de_DE]=AnyDesk
```

## Conexión RDP
Archivo `rdp-connection.remmina` actualizado:
```
[remmina]
name=Local RDP Desktop
server=179.51.107.228:80
protocol=RDP
username=ubuntu
password=ubuntu
colordepth=32
resolution_width=1920
resolution_height=1080
```

## Pasos para Aplicar
1. Instalar `xvfb` en el contenedor
2. Modificar `/usr/bin/entrypoint` con las líneas indicadas
3. Reiniciar el contenedor: `sudo docker restart remote-desktop`
4. AnyDesk estará disponible automáticamente en la IP del contenedor

## Notas
- El escritorio virtual usa resolución 1920x1080
- AnyDesk se ejecuta en display :99
- Tanto RDP como AnyDesk estarán disponibles simultáneamente
