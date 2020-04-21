#!/usr/bin/env bash
function setBackground() {
    setuppath=$1
    backgroundImage=$2
	cp $setuppath${backgroundImage} /home/vagrant/Pictures
	gsettings set org.gnome.desktop.background picture-uri /home/vagrant/Pictures/${backgroundImage}
}

setBackground "/home/vagrant/setup/" "mr.robot.jpg" 

echo "Creating the Practicum Directory"
mkdir /home/vagrant/Desktop/practicum

echo "Cloning Team 3 Docker-Dev Repo into the practicum directory"
git clone https://github.com/Practicum-Team-3/black-widow-docker-dev.git /home/vagrant/Desktop/practicum
