#!/bin/bash
#Julio Saraçol
#Universidade Federal do Pampa -Unipampa
#Projeto Integrador I - Projeto 3

#Script de exemplo com uso de parametros 

function help(){
    echo "-----------------HELP---------------------------------"
	echo "./exemploScript.sh parametros Script 2 modos de execução:"
	echo "  1# Hello: flag [Hello] executar da seguinte forma: ./exemploScript.sh -hello [seuNome]"
	echo "  2# Bye: [Bye] executar da seguinte forma: ./exemploScript.sh -bye [seuNome]"
	echo "-------------------------------------------------------"
}


#testa se não teve parametros suficientes (2 pelo menos) ou se vai para Help
if [ $# -gt 1 ] & [ "$1" = "help" >/dev/null ];
then
    help
	exit 1
fi


#pelo menos dois parametros
if [ $# -eq 2 ]
then
param1=$1;
param2=$2;


#---------------------------------------------------------------------------------------------
if [ "$1" = "-hello" >/dev/null ]
then
echo "executando: Hello" $param2"!"
#poderia executar códigos aqui

#invocando o uso do google-chrome com o endereço unipampa.edu.br
google-chrome https://cursos.unipampa.edu.br/cursos/engenhariadecomputacao

#exemplo de acesso a string de retorno do programa (o que seria impresso na tela)
resultado=$(python mergesort.py 100)
echo "valor da variavel resultado" $resultado

#exemplo de separação da string de resultado do programa de ordenação
IFS=';' read -r entrada tempo <<< $resultado
echo "para a entrada " $entrada "utilizou o tempo " $tempo

#exemplo de utilização de expressão matematica com string pelo BC
echo "$entrada+$tempo" | bc -l



fi
if [ "$1" = "-bye" >/dev/null ]
then
echo "executando: Bye Bye" $param2"!"
echo $param2
#poderia executar códigos aqui
fi
else
    help
	exit 1
fi
