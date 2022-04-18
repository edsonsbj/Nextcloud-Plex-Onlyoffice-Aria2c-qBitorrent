# Servidor Plex + Nextcloud + Onlyoffice + Aria2c + qbitorrent

Script de post install

Este Script executa as seguintes funções

1. Instala o Nextcloud via snap 

2. Altera as portas padão 

3. Habilita o suporte a midia removivel

4. Instala o Onlyoffice via snap

5. Altera as portas padão

6. Habilita o suporte a midia removivel

7. Instala o Aria2c que possibilita efetuar downloads direto do servidor nextcloud  

8. Intala o qbittorrent Baixe arquivos torrent em um hd configurado juntamente com o servidor nextcloud + plex 

9. instala o Plex Media Server via snap 

10. instala o Emby-Server

11. Adiciona o usurio emby ao grupo root para ter acesso a pasta de dados do nextcloud 

12. Atualiza todos os pacotes apt e flatpak

## Execução em ambientes graficos é instalados o seguintes programas 

# Manipulador de Partições
gparted

# Gerenciador de Pacotes
synaptic

#Navegador	
Google Chrome

## Programa para realizar Backups

borgbackup	
 

## Como usar

Baixe o script, verifique as persmissões de uso e execute:<br>
``./pos-install.sh``

##  Config de Exemplo
Optiplex 3050 mini 
Memoria RAM >> 4GB
Processador >> i3
Interface Grafica >> Sim 
Distro Utilizada >> Zorin OS 16
