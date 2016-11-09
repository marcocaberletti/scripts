#!/bin/bash

set -xe

package_list=\
"alsa-plugins-pulseaudio \
 bind-utils \
 calibre \
 dropbox \
 flash-plugin \
 gimp \
 git \
 google-chrome-stable \
 gsmartcontrol \
 gstreamer1-plugins-bad-free \
 gstreamer1-plugins-bad-freeworld \
 gstreamer1-plugins-base \
 gstreamer1-plugins-good \
 gstreamer1-plugins-ugly \
 gstreamer-plugins-good \
 gstreamer-plugins-good-extras \
 k3b \
 libcurl \
 lyx \
 nautilus-dropbox \
 network-manager-applet \
 NetworkManager-openconnect-gnome \
 nmap \
 pygpgme \
 rhythmbox \
 smartmontools \
 sqlitebrowser \
 sysstat \
 thunderbird \
 tomboy \
 transmission-common \
 unetbootin \
 unrar \
 unzip \
 vim-enhanced \
 vlc"

dnf install -y http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

if [ ! -f /etc/yum.repos.d/google-chrome.repo ]; then
  dnf install -y /home/marco/programmi/google-chrome-stable_current_x86_64.rpm
fi

dnf install -y http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux

dnf update -y && dnf install -y $package_list



