#!/bin/bash

set -euxo pipefail

#======================================
# Functions...
#--------------------------------------
test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

#======================================
# Greeting...
#--------------------------------------
echo "Configure image: [$kiwi_iname]-[$kiwi_profiles]..."

#======================================
# Clear machine specific configuration
#--------------------------------------
## Force generic hostname
echo "localhost" > /etc/hostname
## Clear machine-id on pre generated images
truncate -s 0 /etc/machine-id

#======================================
# Remove default apt mirror
#--------------------------------------
# This repo is already configured in config.xml
echo "" > /etc/apt/sources.list

#======================================
# Delete & lock the root user password
#--------------------------------------
if [[ "$kiwi_profiles" == *"AWS"* ]] || [[ "$kiwi_profiles" == *"Azure"* ]] || [[ "$kiwi_profiles" == *"OpenStack"* ]]; then
	passwd -d root
	passwd -l root
fi

#======================================
# Setup default services
#--------------------------------------

if [[ "$kiwi_profiles" == *"AWS"* ]] || [[ "$kiwi_profiles" == *"Azure"* ]] || [[ "$kiwi_profiles" == *"OpenStack"* ]]; then
	## Enable cloud-init
	systemctl enable cloud-config.service cloud-final.service cloud-init.service cloud-init-local.service cloud-init.target
fi

#=====================================
# Permissions for vagrant-specific files
#-------------------------------------
if [[ "$kiwi_profiles" == *"Vagrant"* ]]; then
	mkdir -p /home/vagrant/.ssh
	# Key used by Vagrant to configure the box - will be removed on startup
	echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys
	echo "vagrant ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vagrant
	chmod 0600 /home/vagrant/.ssh/authorized_keys
	chown -R vagrant:vagrant /home/vagrant
	chmod 0440 /etc/sudoers.d/vagrant
fi

## Enable chrony
systemctl enable chrony.service
## Enable resolved
systemctl enable systemd-resolved.service
## Enable persistent journal
mkdir -p /var/log/journal
## Disable unattended-upgrades and daily upgrade timer
systemctl disable unattended-upgrades.service
systemctl disable apt-daily-upgrade.timer

#======================================
# Setup default target
#--------------------------------------
systemctl set-default multi-user.target

#======================================
# Generate locale
#--------------------------------------
locale-gen "${kiwi_language}.UTF-8"

exit 0
