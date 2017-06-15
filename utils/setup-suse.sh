#!/bin/bash

set -xe

package_list=\
"
 calibre \
 dropbox \
 gimp \
 git \
 gnome-subtitles \
 google-chrome-stable \
 gstreamer-plugins-base \
 gstreamer-plugins-good \
 gstreamer-plugins-ugly \
 gstreamer-plugins-good \
 jq \
 k3b \
 libreoffice-base \
 lyx \
 mysql-community-server-client \
 mysql-workbench \
 nautilus-extension-dropbox \
 nmap \
 python-gpgme \
 python-pip \
 smartmontools \
 sqlitebrowser \
 sysstat \
 thunderbird \
 tree \
 unrar \
 unzip \
 vlc"

wget https://dl.google.com/linux/linux_signing_key.pub
rpm --import linux_signing_key.pub

zypper install -y /home/marco/programmi/google-chrome-stable_current_x86_64.rpm
zypper update -y && zypper install -y $package_list

