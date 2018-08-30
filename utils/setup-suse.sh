#!/bin/bash

set -xe

package_list=\
"
 calibre \
 dropbox \
 gimp \
 git \
 gnome-subtitles \
 go \
 google-chrome-stable \
 gstreamer-plugins-base \
 gstreamer-plugins-good \
 gstreamer-plugins-ugly \
 gstreamer-plugins-good \
 jq \
 k3b \
 libreoffice-base \
 libreoffice-l10n-it \
 lyx \
 mysql-community-server-client \
 mysql-workbench \
 nautilus-extension-dropbox \
 nmap \
 npm \
 python-gpgme \
 python-pip \
 smartmontools \
 sqlitebrowser \
 sysstat \
 texlive-emptypage \
 texlive-tocloft \
 thunderbird \
 tree \
 unrar \
 unzip \
 vlc"

wget https://dl.google.com/linux/linux_signing_key.pub
rpm --import linux_signing_key.pub

zypper install -y /home/marco/programmi/google-chrome-stable_current_x86_64.rpm
zypper update -y && zypper install -y $package_list

