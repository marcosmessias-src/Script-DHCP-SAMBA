#################################
#           Criador		#
#    	Marcos Messias 		#
#  marcosmessias1998@gmail.com	#
#   Github: marcosmessias-src	#
#################################

# Repositório do projeto: https://github.com/marcosmessias-src/script-instalador

#Inicio do comando update
echo -e "\033[0;32mFAZENDO UPDATE...\033[0m"
if ! apt-get update
then
	echo "Não foi possível fazer update... Verifique a conexão ou o arquivo /etc/apt/sources.list"
	exit 1
fi
echo -e "\033[0;32mUPDATE REALIZADO COM SUCESSO.\033[0m"
#Fim do update

#Instalação do DHCP
echo -e "\033[0;32mINSTALANDO O DHCP...\033[0m"
if ! apt-get install -y isc-dhcp-server
then
	echo "Ocorreu um erro ao instalar o DHCP"
	exit 1
fi
echo -e "\033[0;32mDHCP INSTALADO COM SUCESSO.\033[0m"
#Fim da instalação do DHCP

#Inicio da configuração do DHCP e das Interfaces
#Este comando modifica o arquivo /etc/default/isc-dhcp-server para a minha rede LAN
echo Modificando o arquivo Interfaces
sed -i 's/INTERFACESv4=""/INTERFACESv4="enp0se8"/g' /etc/default/isc-dhcp-server
echo -e "\033[0;32mARQUIVO ISC-DHCP-SERVER CONFIGURADO.\033[0m"

#Este comando modifica o arquivo dhcpd.conf
mv /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.backup
mv dhcpd.txt /etc/dhcp/dhcpd.conf
echo -e "\033[0;32mARQUIVO /ETC/DHCP/DHCPD.CONF CONFIGURADO.\033[0m"

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
echo -e "\033[0;32m ARQUIVO INTERFACES CONFIGURADO COM SUCESSO. \033[0m"
echo -e "\033[0;32m AGORA ESTÁ TUDO PRONTO  :D
echo -e "\033[1;32mEXECUTE O COMANDO:\033[0m" "\033[0;31mreboot\033[0m"
