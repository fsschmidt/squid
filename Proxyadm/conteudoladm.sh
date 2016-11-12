#!/bin/bash
########### IMPROVE CONSULTORIA E INFORMATICA#######################
#                                                                  #
# Script elaborado por: Fabio S. Schmidt (fabio@improve.inf.br)    #
# Data de criacao: 27/01/2006                                      #
                                 
# ULTIMA ALTERACAO: 04/02/2006                                     #
####################################################################
#COPIE E ALTERE ESTE SCRIPT CONFORME SUA NECESSIDADE,POREM MANTENHA#
#OS CREDITOS DO AUTOR                                              #
####################################################################


##FUNCAO PARA TESTAR SE O DIALOG ESTA INSTALADO
Testa_Dialog()
{
       type dialog >/dev/null 2>/dev/null
  if [ $? == 0 ]
  then
       clear
 else
       clear
       echo "#######################################################################################"
       echo "Para executar este script e necessario que o pacote dialog esteja instalado no sistema#"
       echo "Improve Consultoria e Informatica - http://www.improve.inf.br                  #"
       echo "#######################################################################################"
       exit 0
  fi
}
Testa_Dialog #EXECECUTA A VERIFICACAO SE O DIALOG ESTA INSTALADO

##FUNCAO PARA TESTAR SE O MCEDIT ESTA INSTALADO
Testa_Mcedit()
{
       type mcedit >/dev/null 2>/dev/null
  if [ $? == 0 ]
  then
       clear
  else
       clear
       echo "#######################################################################################"
       echo "Para executar este script e necessario que o pacote mc esteja instalado no sistema    #"
       echo "Improve Consultoria e Informatica - http://www.improve.inf.br                  #"
       echo "#######################################################################################"
       exit 0
  fi
}
Testa_Mcedit #EXECUTA A FUNCAO PARA TESTAR SE O MCEDIT ESTA INSTALADO

##VARIAVEIS GLOBAIS
DIALOG="/usr/bin/dialog"
PROGRAMA=$PWD/proxyadm.sh
CTUDOLADM=$PWD/conteudoladm.sh
ESTACOES="/etc/squid/estacoes"  #DIRETORIO DOS GRUPOS DE ESTACOES
SITES="/etc/squid/sites"	#DIRETORIO DOS GRUPOS DE SITES
VERSAO="1.4.1"
ACCESSLOG="/var/log/squid/access.log"
ERRORLOG="/var/log/squid/squid.out"
##

#INTERFACE COM O USUARIO
$DIALOG --item-help --backtitle "Administracao do servidor PROXY - Improve Consultoria e Informatica - http://www.improve.inf.br" --title "Conteudo controlado - $VERSAO - BOZI" --menu "Menu para administracao do servidor proxy SQUID" 15 90 2 \
"Sempre liberados" "Sites sempre liberados" "Sites sempre liberados para TODOS usuarios" \
"Sites liberados" "Sites liberados para o grupo controlado" "Sites liberados para os usuarios controlados" 2>/tmp/menuitem.$$
##

##Tratamento de resultado do sistema 1=CANCEL BUTTON, 2=HELP BUTTON, 3=ESC PRESSED
sel=$?
na=`cat /tmp/menuitem.$$`
case $sel in
   255) clear;echo "TECLA [ESC] PRESSIONADA";;
esac
##

##RESULTADO DA SELECAO DO USUARIO
menuitem=`cat /tmp/menuitem.$$`
opt=$?
case $menuitem in
"Sempre liberados") mcedit $SITES/sempreliberados.txt;$CTUDOLADM;;
"Sites liberados") mcedit $SITES/sitesliberados.txt;$CTUDOLADM;;
esac
##

##FIM DO SCRIPT
rm -f /tmp/menuitem.$$
