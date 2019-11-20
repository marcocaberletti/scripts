#!/bin/bash

set -xe

ENABLE_CRONTAB=${ENABLE_CRONTAB:-n}

## Add RPM Fusion repos
dnf install -y \
	http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

## Install Google Chrome repo
cp -v /home/marco/programmi/google-chrome.repo /etc/yum.repos.d/google-chrome.repo

## Install Slack repo
cp -v /home/marco/programmi/slack.repo /etc/yum.repos.d/slack.repo

## Install Kube repo
cp -v /home/marco/programmi/kubernetes.repo /etc/yum.repos.d/kubernetes.repo


## Install VS Code repo
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

## Install Adobe repo
#dnf install -y http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
#rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux

package_list=\
"alsa-plugins-pulseaudio \
 bind-utils \
 calibre \
 code \
 chrome-gnome-shell \
 dnf-automatic \
 dropbox \
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
 jemalloc \
 libcurl \
 nautilus-dropbox \
 nmap \
 redis \
 slack \
 smartmontools \
 sqlitebrowser \
 sysstat \
 terminator \
 texlive-babel-english \
 texlive-babel-italian \
 texlive-emptypage \
 texlive-etoolbox \
 texlive-lipsum \
 texlive-titlesec \
 texlive-tocloft \
 texlive-wrapfig \
 texlive-xifthen \
 thunderbird \
 tomboy \
 unrar \
 unzip \
 vim \
 vlc"

## Update & install
dnf update -y && dnf install -y $package_list

## Enable SSH
systemctl enable sshd && systemctl start sshd

## Enable automatic updates
systemctl enable dnf-automatic-notifyonly.timer && systemctl start dnf-automatic-notifyonly.timer
systemctl enable dnf-automatic-download.timer && systemctl start dnf-automatic-download.timer
systemctl enable dnf-automatic-install.timer && systemctl start dnf-automatic-install.timer

if [ $ENABLE_CRONTAB == 'y' ]; then
  ## Add db dump cron job
  crontab -u marco -r
  echo "0 * * * *  /home/marco/bin/db-dump" | crontab -u marco -
fi

