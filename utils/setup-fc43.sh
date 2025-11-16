#!/bin/bash

set -xe

## Add RPM Fusion repos
dnf install -y \
	http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

## Install repos
cp -v /home/marco/programmi/kubernetes.repo /etc/yum.repos.d/
cp -v /home/marco/programmi/vscode.repo /etc/yum.repos.d/
cp -v /home/marco/programmi/google-chrome.repo /etc/yum.repos.d/
cp -v /home/marco/programmi/google-cloud-sdk.repo /etc/yum.repos.d/

## Hashicorp repo
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

package_list=\
"ansible \
 awscli2 \
 bind-utils \
 calibre \
 code \
 environment-modules \
 gedit \
 gh \
 gimp \
 git \
 google-chrome-stable \
 google-cloud-cli \
 gnome-extensions-app \
 gnome-shell-extension-appindicator \
 gnome-tweaks \
 gstreamer1-plugins-bad-free \
 gstreamer1-plugins-base \
 gstreamer1-plugins-good \
 helm \
 jq \
 jemalloc \
 kubectl \
 latexmk \
 nmap \
 nodejs \
 postgresql \
 python-pip \
 pre-commit \
 terraform \
 texlive-babel-english \
 texlive-babel-italian \
 texlive-emptypage \
 texlive-etoolbox \
 texlive-everysel \
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
 texlive-unicode-math \
 texlive-trajan \
 texlive-blindtext \
 thunderbird \
 unrar \
 unzip \
 vim"

## Update & install
dnf update -y
#dnf install -y ffmpeg
dnf install -y $package_list
#dnf install https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm

## Enable SSH
systemctl enable sshd && systemctl start sshd
