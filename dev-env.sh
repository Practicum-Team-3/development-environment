#!/usr/bin/env bash

function aptInstall() {
	binary=("$@")
	for i in "${binary[@]}" ; do
		dpkg -s "$i" &> /dev/null
		if [ "$?" -ne 0 ] 
		then
			echo ""$i" not installed"
			apt-get install -y "$i"
		else
			echo ""$i" is already installed"
		fi
	done
}

declare -a primary_binary=( "ubuntu-desktop" "bash-completion" "apt-transport-https" "ca-certificates" "curl" "gnupg-agent" "software-properties-common" "linux-headers-generic" "linux-headers-5.3.0-29-generic")


declare -a secondary_binary=( "python3-pip" "git" "docker-ce" "docker-ce-cli" "containerd.io")

apt-get update
aptInstall "${primary_binary[$@]}"


# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

declare -a secondary_binary=( "python3-pip" "git" "docker-ce" "docker-ce-cli" "containerd.io")

aptInstall "${secondary_binary[@]}"


dock_comp_v="docker-compose --version"
dock_comp="docker-compose"


$dock_comp_v &> /dev/null
if [ "$?" -ne 0 ] 
then
	# Download the current stable release of Docker Compose
	curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	# Apply executable permissions to the Docker Compose binary:
	chmod +x /usr/local/bin/docker-compose

	# Creating a symbolic link to /usr/bin/docker-compose
	ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

	# Download and install bash command completion for Docker Compose
	curl -L https://raw.githubusercontent.com/docker/compose/1.25.4/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

	# Post Installation set up for Docker
	# Manage Docker as a non root user
	# Create the docker group
	groupadd docker
	# Add vagrant user to the docker group
	usermod -aG docker vagrant
else
	echo ""$dock_comp" is already installed"
fi


echo "Downloading and installing Visual Studio"
snap install --classic code


echo "Downloading and installing Pycharm Community Edition"
snap install pycharm-community --classic


vbox_v="vboxmanage -v"
vbox="virtualbox"

vagran_v="vagrant --version"
vagrant="vagrant"


#$vbox_v &> /dev/null
#if [ "$?" -ne 0 ] 
#then
#	echo ""$vbox" not installed"
#	curl -o $vbox.deb https://download.virtualbox.org/virtualbox/6.1.4/virtualbox-6.1_6.1.4-136177~Ubuntu~eoan_amd64.deb
#	apt install -y ./$vbox.deb 
#	rm -f $vbox.deb
#else
#	echo ""$vbox" is already installed"
#fi


#$vagrant_v &> /dev/null
#if [ "$?" -ne 0 ] 
#then
#	echo ""$vagrant" not installed"
#	curl -o $vagrant.deb https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_x86_64.deb
#	apt install -y ./$vagrant.deb 
#	rm -f $vagrant.deb
#else
#	echo ""$vagrant" is already installed"
#fi

#echo "Downloading and installing VirtualBox"
#curl -o vitualbox-6.1.deb https://download.virtualbox.org/virtualbox/6.1.4/virtualbox-6.1_6.1.4-136177~Ubuntu~eoan_amd64.deb
#apt install -y ./vitualbox-6.1.deb 
#rm -f ./virtualbox-6.1.deb


echo "Downloading and installing Vagrant"
curl -o vagrant.deb https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_x86_64.deb
apt install -y ./vagrant.deb
rm -f ./vagrant.deb

echo "Creating the Practicum Directory"
mkdir /home/vagrant/Desktop/practicum

echo "Cloning Team 3 Docker-Dev Repo into the practicum directory"
git clone https://github.com/Practicum-Team-3/black-widow-docker-dev.git /home/vagrant/Desktop/practicum


