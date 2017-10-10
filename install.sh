#!/bin/bash

sudo apt-get -y install git
sudo apt-get -y install python3-dev
python --version
sudo apt-get -y install python3-pip
sudo apt-get -y install python-pip
pip3 --version
sudo pip3 install robotframework-python3
robot --version
sudo pip3 install --upgrade pip
sudo pip3 install robotframework-imaplibrary
sudo pip3 install --pre --upgrade robotframework-seleniumlibrary
sudo pip3 install pyyaml
sudo pip3 install requests
sudo pip install robotframework-xvfb

sudo apt-get -y install xvfb
sudo apt -y install wget
sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

# chrome
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

sudo apt-get update
sudo apt-get -y install google-chrome-stable 
 
# chromedriver

wget https://chromedriver.storage.googleapis.com/2.29/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo chmod +x chromedriver
sudo mv chromedriver /usr/bin/

# firefox

# Geckodriver
wget https://github.com/mozilla/geckodriver/releases/download/v0.16.1/geckodriver-v0.16.1-linux64.tar.gz
sudo sh -c 'tar -x geckodriver -zf geckodriver-v0.16.1-linux64.tar.gz -O > /usr/bin/geckodriver'
sudo chmod +x /usr/bin/geckodriver
rm geckodriver-v0.16.1-linux64.tar.gz
