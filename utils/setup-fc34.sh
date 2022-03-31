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

package_list=\
"awscli \
 bind-utils \
 calibre \
 code \
 dropbox \
 gimp \
 git \
 google-chrome-stable \
 gnome-tweak-tool \
 gsmartcontrol \
 gstreamer1-plugins-bad-free \
 gstreamer1-plugins-bad-freeworld \
 gstreamer1-plugins-base \
 gstreamer1-plugins-good \
 gstreamer1-plugins-ugly \
 jq \
 jemalloc \
 kubectl \
 libatomic \
 libcurl \
 nautilus-dropbox \
 nmap \
 slack \
 sqlitebrowser \
 sysstat \
 terminator \
 texlive-babel-english \
 texlive-babel-italian \
 texlive-emptypage \
 texlive-etoolbox \
 texlive-fancyhdr \
 texlive-latexindent \
 texlive-lipsum \
 texlive-lm-math \
 texlive-parskip \
 texlive-ragged2e \
 texlive-tex-gyre \
 texlive-tex-gyre-math \
 texlive-titlesec \
 texlive-tocloft \
 texlive-wrapfig \
 texlive-xetex \
 texlive-xifthen \
 thunderbird \
 unrar \
 unzip \
 vim \
 vlc"

## Update & install
dnf update -y && dnf install -y $package_list

## Enable SSH
systemctl enable sshd && systemctl start sshd
