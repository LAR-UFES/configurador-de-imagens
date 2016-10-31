#!/bin/bash

## Instalação de pacotes e configurações da imagem das maquinas do LabGrad ##

if [ "`id -u`" != "0" ]; then
	echo "Este script precisa ser executado como root!!!!"
	exit 1
fi

## Adicionando repositórios ##
if [ ! -f "repositorios.txt" ]; then
	echo "Arquivo 'repositorios.txt' não encontrado"
	echo "Crie o arquivo com os repositórios a serem adicionados no sistema"
	exit 1
else
	echo "## Adicionando repositórios ##"
	
	for i in `cat repositorios.txt`;
	do
		apt-add-repository -y $i
		if [ $? != 0 ]; then
			echo "Erro ao adicionar repositório $i !!!"
			exit 1 
		fi
	done

	echo "Repositórios adicionados com sucesso!!!!"
	
	echo "Realizando update"
	apt-get -y update
	if [ $? != 0 ]; then
		echo "Erro ao fazer o update!!!"
		exit 1 
	fi

fi


## Instalando pacotes ##
if [ ! -f "pacotes.txt" ]; then
	echo "Arquivo 'pacotes.txt' não encontrado"
	echo "Crie o arquivo com os pacotes a serem adicionados no sistema"
	exit 1
else 
	echo "## Instalando pacotes  ##"

	for i in `cat pacotes.txt`;
	do
		apt-get -y install $i
		if [ $? != 0 ]; then
			echo "Erro ao instalar pacote $i !!!"
			exit 1 
		fi
	done
	
	echo "Pacotes instalados com sucesso!!!!"
fi
