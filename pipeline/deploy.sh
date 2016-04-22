#!/bin/bash

echo "This is a script to run on a Deploy"
# echo "==============INSTALL chrome========================"
# if [ ! -f "linux_signing_key.pub" ]; then
#   echo "Downloading repository key"
#   wget https://dl.google.com/linux/linux_signing_key.pub
#   echo "Adding repository"
#   sudo rpm --import linux_signing_key.pub
#   sudo yum-config-manager --add-repo http://dl.google.com/linux/rpm/stable/x86_64
#   echo "Install chrome"
#   sudo yum install -y --skip-broken google-chrome-stable
# fi
# echo "Remove Key"
# rm linux_signing_key.pub*
# echo "==============INSTALL xvfb========================"
# sudo yum install -y xorg-x11-server-Xvfb-1.15.0-32.el7 gdk-pixbuf2
# startx &
# echo "==============INSTALL behave========================"
# sudo easy_install behave
# echo "==============DOWNLOAD pip========================"
# if [ ! -f "get-pip.py" ]; then
#   wget https://bootstrap.pypa.io/get-pip.py
# fi
# echo "==============INSTALL pip========================"
# sudo easy_install pip
# rm get-pip.py*
# echo "==============INSTALL virtualEnv========================"
# source /opt/rh/python27/enable
# which python

# pip install virtualenv
# echo "==============CREATE virtualEnv-2.7========================"
# if [ ! -d "venv" ]; then
#   rm -rf venv/
# fi
# ls -la
# virtualenv -p /opt/rh/python27/root/usr/bin/python venv
# ls -la
# echo "==============ACTIVATE virtualEnv-2.7========================"
# source venv/bin/activate
# which python
# echo "==============INSTALL requirements========================"
# pip install --upgrade setuptools
# pip install -r requirements.txt
# echo "==============INSTALL driver========================"
#sudo yum install unzip
#ls -la *
# if [ ! -f "bin/chromedriver_linux64.zip" ]; then
#   wget -N http://chromedriver.storage.googleapis.com/2.10/chromedriver_linux64.zip -P bin/
#   unzip bin/chromedriver_linux64.zip -d bin/
#   chmod a+x bin/chromedriver
#   sudo ln -s bin/chromedriver /usr/local/bin/chromedriver
#   rm bin/chromedriver_linux64.zip
#   sudo chmod a+x /usr/local/bin/chromedriver
# fi
# netstat -putan
virtualenv venv
pwd
source /home/contint/workspace/vdc/portalesnovdc/venv/bin/activate
sudo pip install -r requirements.txt --ignore-installed
wget https://github.com/jgraham/wires/releases/download/v0.6.2/wires-0.6.2-linux64.gz /home/contint/workspace/vdc/portalesnovdc/
gzip -d /home/contint/workspace/vdc/portalesnovdc/wires-0.6.2-linux64.gz
export PATH=$PATH:/home/contint/workspace/vdc/portalesnovdc/

# ---------------------------------------------------------
# DOWNLOAD
# ---------------------------------------------------------
#wget https://github.com/jgraham/wires/releases/download/v0.6.2/wires-0.6.2-linux64.gz
