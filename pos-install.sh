#!/usr/bin/env bash

# pos-os-postinstall.sh - Instalar e configura programas em servidores baseados em Ubuntu


 ----------------------------- VARIÁVEIS ----------------------------- #

##URLS

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_RCLONE="https://rclone.org/install.sh"
URL_EMBY="https://github.com/MediaBrowser/Emby.Releases/releases/download/4.6.7.0/emby-server-deb_4.6.7.0_amd64.deb"

##DIRETÓRIOS E ARQUIVOS

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
FILE="/home/$USER/.config/gtk-3.0/bookmarks"


#CORES

VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'


#FUNÇÕES

apt_update(){
  sudo apt update && sudo apt upgrade && sudo apt dist-upgrade
}

# -------------------------------TESTES E REQUISITOS----------------------------------------- #

# Internet conectando?
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente.${SEM_COR}"
fi

# wget está instalado?
if [[ ! -x $(which wget) ]]; then
  echo -e "${VERMELHO}[ERRO] - O programa wget não está instalado.${SEM_COR}"
  echo -e "${VERDE}[INFO] - Instalando o wget...${SEM_COR}"
  sudo apt install wget -y &> /dev/null
else
  echo -e "${VERDE}[INFO] - O programa wget já está instalado.${SEM_COR}"
fi
# ------------------------------------------------------------------------------ #
## Removendo travas eventuais do apt ##
travas_apt(){
  sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock
}
travas_apt

## Atualizando o repositório ##
sudo apt update -y

##DEB SOFTWARES TO INSTALL

PROGRAMAS_PARA_INSTALAR=(
  snapd
  gparted
  synaptic
  git
  borgbackup
  qbittorrent-nox
  qbittorrent
 
)

# Download e instalaçao de programas externos ##

echo -e "${VERDE}[INFO] - Baixando pacotes .deb${SEM_COR}"

mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_EMBY="		   -P "$DIRETORIO_DOWNLOADS"
curl "$URL_RCLONE" | sudo bash


## Adicionar Repositorio ##

sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable

## Instalando pacotes .deb baixados na sessão anterior ##
echo -e "${VERDE}[INFO] - Instalando pacotes .deb baixados${SEM_COR}"
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
echo -e "${VERDE}[INFO] - Instalando pacotes apt do repositório${SEM_COR}"

travas_apt

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

## Instalando pacotes Snap ##
echo -e "${VERDE}[INFO] - Instalando pacotes snap${SEM_COR}"

sudo snap install plexmediaserver
sudo snap install nextcloud
sudo snap install onlyoffice-ds
sudo snap install aria2c
sudo snap install htop

## Configurações pacote Snap ##

sudo snap set nextcloud ports.http=8090
sudo snap set nextcloud ports.https=8092
sudo snap connect nextcloud:removable-media
sudo snap connect onlyoffice-ds:removable-media
sudo snap connect plexmediaserver:removable-media
sudo snap set onlyoffice-ds onlyoffice.ds-port=8091
sudo snap set onlyoffice-ds onlyoffice.ds-ssl-port=8093
sudo snap set onlyoffice-ds onlyoffice.use-unautorized-storage=true

# ---------------------------------------------------------------------- #

## Configuraçção Adicional Emby ##
sudo adduser emby root


## Configurar Varlor Swapfile ##

sudo swapoff -a
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
apt_update -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
nautilus -q
# -------------------------------------------------------------------------- #

## finalização

apt_update -y

  echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"

