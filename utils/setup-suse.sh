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
 gsmartcontrol \
 gstreamer-plugins-bad-free \
 gstreamer-plugins-base \
 gstreamer-plugins-good \
 gstreamer-plugins-ugly \
 gstreamer-plugins-good \
 gstreamer-plugins-good-extras \
 k3b \
 libreoffice-base \
 libcurl \
 lyx \
 nautilus-extension-dropbox \
 nmap \
 pygpgme \
 smartmontools \
 sqlitebrowser \
 sysstat \
 thunderbird \
 tomboy \
 unrar \
 unzip \
 vlc"

zypper install -y /home/marco/programmi/google-chrome-stable_current_x86_64.rpm
zypper update -y && zypper install -y $package_list



