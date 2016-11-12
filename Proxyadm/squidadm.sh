#!/bin/bash
########### IMPROVE CONSULTORIA E INFORMATICA #######################
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
       echo "Schmidt Informatica Ltda / (27) 3337-4338 / schinfo@veloxmail.com.br                  #"
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
SQUIDADM=$PWD/squidadm.sh
ESTACOES="/etc/squid/estacoes"  #DIRETORIO DOS GRUPOS DE ESTACOES
SITES="/etc/squid/sites"	#DIRETORIO DOS GRUPOS DE SITES
VERSAO="1.4.1"
ACCESSLOG="/var/log/squid/access.log"
ERRORLOG="/var/log/squid/squid.out"
##

if [ $USER != root ]
 then
  dialog --msgbox "ACESSO RESTRITO AO USUARIO ROOT" 10 40
  $PROGRAMA
  exit 0
fi

#INTERFACE COM O USUARIO
$DIALOG --item-help --backtitle "Administracao do servidor PROXY - Improve Consultoria e Informatica - http://www.improve.inf.br" --title "Administracao do SQUID - $VERSAO - BOZI" --menu "Menu para administracao do servidor proxy SQUID" 15 90 4 \
"Logs de erro"	"Visualizar logs de erro" "Logs de erro" \
"Logs de acesso" "Visualizar logs de acesso" "Logs de acesso" \
"Relatorio de acesso"	"Gerar relatorio diario de acesso" "Gerar relatorio diario de acesso" \
"Backup do sistema"   "Realizar backup do sistema" "Backup do sistema"  2>/tmp/menuitem.$$
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
"Logs de erro") $DIALOG --title "Relatorio de erros" --tailbox $ERRORLOG 40 120;$SQUIDADM;;
"Logs de acesso")  $DIALOG --title "Relatorio de acesso" --tailbox $ACCESSLOG 40 120;$SQUIDADM;; 

esac
##

##FIM DO SCRIPT
rm -f /tmp/menuitem.$$
