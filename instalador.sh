#Inicio do Script

#Inicio do comando update
echo Fazendo update...
if ! apt-get update
then
	echo "Não foi possível fazer update... Verifique a conexão ou o arquivo /etc/apt/sources.list"
	exit 1
fi
echo Update realizado com sucesso.
#Fim do update

#Instalação do DHCP
echo Iniciando instalação do DHCP
if ! apt-get install -y isc-dhcp-server
then
	echo "Ocorreu um erro ao instalar o DHCP"
	exit 1
fi
echo DHCP instalado com sucesso.
#Fim da instalação do DHCP

#Inicio da configuração do DHCP e das Interfaces
#Este comando modifica o arquivo interfaces para a minha rede LAN
echo Modificando o arquivo Interfaces
sed -i 's/INTERFACESv4=""/INTERFACESv4="enp0se8"/g' /etc/default/isc-dhcp-server
echo Arquivo interfaces modificado com sucesso.


