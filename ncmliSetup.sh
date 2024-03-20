#!/bin/bash

# Desactiva wpa_supplicant
sudo systemctl stop wpa_supplicant
sudo systemctl disable wpa_supplicant

# Instal·la network-manager
sudo apt-get update && sudo apt-get install network-manager

# Activa network-manager
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

# Llista l'estat del dispositiu wifi
nmcli device status

echo "Per llistar les conexions disponibles: nmcli dev wifi list"
echo "Per conectar-te: nmcli dev wifi connect <SSID_de_tu_red> password <contraseña>"
