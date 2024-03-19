#!/bin/bash

# Actualiza el sistema y los paquetes
sudo apt-get update && sudo apt-get upgrade -y

# Configuración para que los cambios tomen efecto sin interacción manual
sudo raspi-config nonint do_i2c 0
sudo raspi-config nonint do_spi 0

# Instala herramientas y librerías necesarias
sudo apt-get install -y python3 python3-pip i2c-tools

# Habilita I2C
sudo apt-get install -y python3-smbus
echo "dtparam=i2c_arm=on" | sudo tee -a /boot/config.txt
echo "i2c-dev" | sudo tee -a /etc/modules

# Instala bibliotecas de Python
pip3 install RPi.GPIO spidev mfrc522 Pillow adafruit-circuitpython-ssd1306 flask gunicorn

# Reinicia para aplicar los cambios
echo "Configuración completada, reiniciando en 10 segundos..."
sleep 10
sudo reboot
