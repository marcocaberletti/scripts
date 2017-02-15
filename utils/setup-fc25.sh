#!/bin/bash

set -xe

INSTALL_ECLIPSE=${INSTALL_ECLIPSE:-'n'}
ENABLE_CRONTAB=${ENABLE_CRONTAB:-'n'}

package_list=\
"alsa-plugins-pulseaudio \
 bind-utils \
 calibre \
 community-mysql \
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
 jq \
 k3b \
 libcurl \
 lyx \
 nautilus-dropbox \
 network-manager-applet \
 NetworkManager-openconnect-gnome \
 nmap \
 pygpgme \
 smartmontools \
 sqlitebrowser \
 sysstat \
 terminator \
 texlive-babel-english \
 texlive-babel-italian \
 texlive-emptypage \
 texlive-lipsum \
 texlive-titlesec \
 texlive-tocloft \
 texlive-wrapconfig \
 thunderbird \
 tomboy \
 unrar \
 unzip \
 vim-enhanced \
 vlc"
 
eclipse_packages=\
"eclipse-platform \
 eclipse-anyedit \
 eclipse-checkstyle \
 eclipse-dltk-sh \
 eclipse-eclemma \
 eclipse-egit-github \
 eclipse-jdt \
 eclipse-linuxtools \
 eclipse-m2e-core \
 eclipse-mpc \
 eclipse-nls-it \
 eclipse-pydev \
 eclipse-rpm-editor \
 eclipse-webtools-javaee \
 eclipse-webtools-servertools"

## Add RPM Fusion repos
dnf install -y \
	http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

## Install Google Chrome
if [ ! -f /etc/yum.repos.d/google-chrome.repo ]; then
  dnf install -y /home/marco/programmi/google-chrome-stable_current_x86_64.rpm
fi

## Install Adobe repo
dnf install -y http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux

## Update & install
dnf update -y && dnf install -y $package_list

## Enable SSH
systemctl enable sshd && systemctl start sshd

if [ $ENABLE_CRONTAB == 'y' ]; then
  ## Add db dump cron job
  crontab -u marco -r
  echo "0 * * * *  /home/marco/bin/db-dump" | crontab -u marco -
fi

if [ $INSTALL_ECLIPSE == 'y' ]; then
  dnf install -y $eclipse_packages
fi
