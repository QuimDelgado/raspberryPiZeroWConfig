#!/bin/bash

# Actualizar el sistema e instalar dependencias necesarias
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y build-essential cmake pkg-config
sudo apt-get install -y libjpeg-dev libtiff5-dev libjasper-dev libpng-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install -y libxvidcore-dev libx264-dev
sudo apt-get install -y libgtk-3-dev
sudo apt-get install -y libatlas-base-dev gfortran
sudo apt-get install -y python3-dev python3-pip
sudo apt-get install -y libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5

# Expandir el sistema de archivos, si es necesario
# Asumimos que este paso ya no es necesario en versiones recientes de Raspbian

# Aumentar el espacio de intercambio para evitar errores durante la compilación
sudo dphys-swapfile swapoff
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=2048/' /etc/dphys-swapfile
sudo dphys-swapfile swapon
sudo reboot

# Después del reinicio, continuar con el script desde aquí

# Instalar pip y numpy
pip3 install numpy

# Descargar OpenCV y OpenCV Contrib
cd ~
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.5.1.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.5.1.zip
unzip opencv.zip
unzip opencv_contrib.zip
rm opencv.zip opencv_contrib.zip

# Compilar e instalar OpenCV
cd ~/opencv-4.5.1/
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-4.5.1/modules \
      -D BUILD_EXAMPLES=ON \
      -D PYTHON_EXECUTABLE=$(which python3) ..
      
make -j$(nproc)
sudo make install
sudo ldconfig

# Verificar la instalación
python3 -c "import cv2; print(cv2.__version__)"

# Restaurar el tamaño del archivo de intercambio, si se desea
sudo dphys-swapfile swapoff
sudo sed -i 's/CONF_SWAPSIZE=2048/CONF_SWAPSIZE=100/' /etc/dphys-swapfile
sudo dphys-swapfile swapon

# Limpiar los directorios de descarga, si se desea
# cd ~
# sudo rm -rf opencv-4.5.1 opencv_contrib-4.5.1

echo "La instalación de OpenCV para Python 3 ha finalizado."
