FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    xrdp \
    sudo \
    dbus \
    dbus-x11 \
    && rm -rf /var/lib/apt/lists/*

# Create a user for RDP
RUN useradd -m -s /bin/bash rdpuser && \
    echo 'rdpuser:password' | chpasswd && \
    usermod -aG sudo rdpuser

# Configure xrdp
RUN sed -i 's/3389/3389/g' /etc/xrdp/xrdp.ini && \
    sed -i 's/max_bpp=32/max_bpp=128/g' /etc/xrdp/xrdp.ini

# Set up the desktop environment for the user
RUN mkdir -p /home/rdpuser/.config && \
    chown rdpuser:rdpuser /home/rdpuser/.config && \
    echo "dbus-launch --exit-with-session xfce4-session" > /home/rdpuser/.xsession && \
    chown rdpuser:rdpuser /home/rdpuser/.xsession

# Create startup script
RUN echo '#!/bin/bash' > /start.sh && \
    echo 'dbus-daemon --system --fork' >> /start.sh && \
    echo '/usr/sbin/xrdp-sesman' >> /start.sh && \
    echo '/usr/sbin/xrdp -nodaemon' >> /start.sh && \
    chmod +x /start.sh

# Expose RDP port
EXPOSE 3389

# Start both services
CMD ["/start.sh"]
