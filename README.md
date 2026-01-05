# Docker RDP - Escritorio Remoto con XFCE

Este proyecto configura un contenedor Docker con un servidor RDP completo, incluyendo escritorio XFCE y navegadores web.

## 🚀 Inicio Rápido

### Ejecutar el Contenedor
```bash
# Usando Docker Compose (recomendado)
sudo docker-compose up -d

# O usando Docker directamente
sudo docker run -p 80:3389 --memory=4g -d scottyhardy/docker-remote-desktop
```

### Conectar por RDP
```bash
# Con Remmina (GUI)
# Servidor: 179.51.107.228:80
# Usuario: ubuntu
# Contraseña: ubuntu

# O con línea de comandos
xfreerdp /u:ubuntu /p:ubuntu /v:179.51.107.228:80 /cert-ignore
```

## 📋 Requisitos

### En el Servidor
- Docker instalado
- Docker Compose instalado
- Puerto 80 disponible

### En el Cliente
- Cliente RDP (Remmina, Microsoft Remote Desktop, xfreerdp)
- Conexión a internet

## 🛠️ Instalación del Cliente RDP

### Ubuntu/Debian
```bash
sudo apt update && sudo apt install -y remmina freerdp2-x11
```

### Windows
- Ya incluido: "Conexión a Escritorio Remoto"

### macOS
- Descarga: "Microsoft Remote Desktop" de la App Store

## ⚙️ Configuración

### Variables de Entorno
```yaml
environment:
  - FRX_XRDP_USER_NAME=miusuario      # Cambiar usuario
  - FRX_XRDP_USER_PASSWORD=mipassword # Cambiar contraseña
```

### Personalizar Memoria
```yaml
deploy:
  resources:
    limits:
      memory: 4g  # Cambiar según necesidad
```

## 📁 Archivos del Proyecto

- `docker-compose.yml` - Configuración del contenedor
- `Dockerfile` - Construcción personalizada (opcional)
- `rdp-connection.remmina` - Archivo de conexión RDP
- `README.md` - Esta documentación

## 🔧 Comandos Útiles

```bash
# Ver estado del contenedor
sudo docker-compose ps

# Ver logs
sudo docker-compose logs

# Reiniciar contenedor
sudo docker-compose restart

# Detener contenedor
sudo docker-compose down

# Actualizar imagen
sudo docker-compose pull

# Limpiar contenedores
sudo docker system prune -f
```

## 🌐 Conexión Remota

### Desde la misma red
```bash
xfreerdp /u:ubuntu /p:ubuntu /v:192.168.58.138:80 /cert-ignore
```

### Desde internet
```bash
xfreerdp /u:ubuntu /p:ubuntu /v:179.51.107.228:80 /cert-ignore
```

## 📦 Contenido del Contenedor

- **Sistema operativo:** Ubuntu 24.04
- **Escritorio:** XFCE4
- **Servidor RDP:** xRDP
- **Navegadores:** Firefox, Chromium
- **Herramientas:** Terminal, editor de texto, administrador de archivos

## 🔒 Seguridad

- RDP usa puerto 80 (común, pero no seguro)
- Considera cambiar a puerto 443 para HTTPS
- Usa contraseñas fuertes
- Limita acceso por firewall

## 🐛 Solución de Problemas

### Error de conexión
```bash
# Verificar contenedor
sudo docker-compose ps

# Ver logs detallados
sudo docker-compose logs -f

# Reiniciar servicios
sudo docker-compose restart
```

### Problemas de rendimiento
- Aumenta la memoria asignada
- Verifica conexión a internet
- Cierra otras aplicaciones

## 📞 Soporte

Si tienes problemas:
1. Verifica que el puerto 80 esté abierto
2. Confirma las credenciales
3. Revisa los logs del contenedor
4. Reinicia el contenedor

## 📄 Licencia

Este proyecto usa imágenes Docker públicas con sus respectivas licencias.

---

¡Disfruta de tu escritorio remoto con Docker! 🐳
