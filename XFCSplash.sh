#!/bin/bash

# Entra na pasta Imagens
cd /home/$USER/Imagens;

# Baixa um wallpaper aleatório 1920x1080
wget https://unsplash.it/1920/1080/?random -O image.jpg -q;

if [[ "$?" -ne 0 ]]; then
    file=`ls /home/$USER/Imagens | shuf -n 1`;
    xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set "/home/$USER/Imagens/$file";
    echo "Off"
    exit 0;
fi

#Cria hash md5 de 10 bytes para o arquivo baixado
hash=`md5sum /home/$USER/Imagens/image.jpg | cut -c 1-9`;

#Define o nome do arquivo somado à hash criada
name="wallpaper-$hash.jpg";

#Renomear wallpaper baixado
mv /home/$USER/Imagens/image.jpg "/home/$USER/Imagens/$name";

# Definir o novo wallpaper
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set "/home/$USER/Imagens/$name";

echo "On";
