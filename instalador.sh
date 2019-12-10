#################################
#           Criador		#
#    	Marcos Messias 		#
#  marcosmessias1998@gmail.com	#
#   Github: marcosmessias-src	#
#################################

# Repositório do projeto: https://github.com/marcosmessias-src/script-instalador

#----------------------------------------------------------------
#Inicio do comando update
echo -e "\033[0;32mFAZENDO UPDATE...\033[0m"
if ! apt-get update
then
	echo "Não foi possível fazer update... Verifique a conexão ou o arquivo /etc/apt/sources.list"
	exit 1
fi
echo -e "\033[0;34m---------- UPDATE REALIZADO COM SUCESSO ----------\033[0m"
#Fim do update

#Instala o SUDO
apt-get install -y sudo

#-------------------------------------------------------------
#Instalação do DHCP
echo -e "\033[0;31m---------- INSTALANDO O DHCP ----------\033[0m"
if ! apt-get install -y isc-dhcp-server
then
	echo "Ocorreu um erro ao instalar o DHCP"
	exit 1
fi
echo -e "\033[0;34m---------- DHCP INSTALADO COM SUCESSO ----------\033[0m"
#Fim da instalação do DHCP

#--------------------------------------------------------------------
#Estes comandos configuram o arquivo /etc/default/isc-dhcp-server para a minha rede LAN
sed -i 's/INTERFACESv4=""/INTERFACESv4="enp0se8"/g' /etc/default/isc-dhcp-server
echo -e "\033[0;32m---------- ARQUIVO ISC-DHCP-SERVER CONFIGURADO ----------\033[0m"

#--------------------------------------------------------------------
#Estes comandos configuram o arquivo dhcpd.conf
mv /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.backup
mv dhcpd.txt /etc/dhcp/dhcpd.conf
echo -e "\033[0;34m---------- ARQUIVO /ETC/DHCP/DHCPD.CONF CONFIGURADO ----------\033[0m"

#--------------------------------------------------------------------
#Estes comandos adicionam a configuração LAN ao arquivo /etc/network/interfaces
sed -i 's/# The primary network interface/# REDE WAN/g' /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "# REDE LAN" >> /etc/network/interfaces
echo "allow-hotplug enp0s8" >> /etc/network/interfaces
echo "iface enp0s8 inet static" >> /etc/network/interfaces
echo "address 192.168.100.1" >> /etc/network/interfaces
echo "netmask 255.255.255.0" >> /etc/network/interfaces
echo "network 192.168.100.0" >> /etc/network/interfaces
echo "broadcast 192.168.100.255" >> /etc/network/interfaces
echo -e "\033[0;34m---------- ARQUIVO INTERFACES CONFIGURADO COM SUCESSO ---------- \033[0m"
#--------------------------------------------------------------------
#Instalando o SAMBA
if ! apt-get install -y samba
then
	echo "Ocorreu um erro ao tentar instalar o SAMBA"
	exit 1
fi

#Cria a pasta que será compartilhada no samba
mkdir /root/samba/
mkdir /root/samba/teste

mv /etc/samba/smb.conf /etc/samba/smb.original.conf
mv samba.txt /etc/samba/smb.conf

service smbd restart

#---------------------------------------------------------------------
#Finalizando o script

echo -e "\033[0;32mPARA ADICIONAR O USUARIO PARA O SAMBA DIGITE: smbpasswd -a nomedousuario\033[0m"
echo -e "\033[0;32mAGORA ESTÁ TUDO PRONTO  :D\033[0m"
echo -e "\033[1;32mEXECUTE O COMANDO:\033[0m" "\033[0;31mreboot\033[0m"
