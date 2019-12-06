#Inicio do Script

#Inicio do comando update
echo Fazendo update...
if ! apt-get update
then
	echo "Não foi possível fazer update... Verifique a conexão ou o arquivo /etc/apt/sources.list"
	exit 1
fi
echo Update realizado com sucesso.

#Instalação do DHCP
echo Iniciando instalação do DHCP
if ! apt-get install -y isc-dhcp-server
then
	echo "Ocorreu um erro ao instalar o DHCP"
	exit 1
fi
echo DHCP instalado com sucesso.
