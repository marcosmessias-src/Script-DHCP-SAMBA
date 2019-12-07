Para utilizar o script basta seguir os passos abaixo.

Na sua máquina Debian siga os comandos:

apt-get install -y sudo
apt-get install -y git
git clone https://github.com/marcosmessias-src/script-instalador.git
cd script-instalador
sudo bash instalador.sh

Pronto. Sua máquina estará configurada com DHCP e SAMBA.

Para adicionar um usuário Unix para o samba basta usar o comando:
smbpasswd -a nomedousuario
