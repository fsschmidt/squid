#!/bin/bash
########### IMPROVE CONSULTORIA E INFORMATICA ######################
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
CTUDOBADM=$PWD/conteudobadm.sh
ESTACOES="/etc/squid/estacoes"  #DIRETORIO DOS GRUPOS DE ESTACOES
SITES="/etc/squid/sites"	#DIRETORIO DOS GRUPOS DE SITES
VERSAO="1.4.1"
ACCESSLOG="/var/log/squid/access.log"
ERRORLOG="/var/log/squid/squid.out"
##

#INTERFACE COM O USUARIO
$DIALOG --item-help --backtitle "Administracao do servidor PROXY - Improve Consultoria e Informatica - http://www.improve.inf.br" --title "Conteudo bloqueado - $VERSAO - BOZI" --menu "Menu para administracao do servidor proxy SQUID" 15 90 4 \
"Sites indesejados" "Sites de conteudo indesejado" "Sites com conteudo indesejado" \
"Spyware" "Bloqueio de Spywares" "Protecao contra Spywares e trojans" \
"Banners" "Bloqueio de banners" "Protecao contra banners" \
"Download proibido" "Download proibido" "Tipos de arquivos proibidos para download" 2>/tmp/menuitem.$$
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
"Sites indesejados") mcedit $SITES/bloqueados.txt;$CTUDOBADM;;
"Spyware") mcedit $SITES/blacklistspy.txt;$CTUDOBADM;;
"Banners")  mcedit $SITES/banner_ads.txt;$CTUDOBADM;;
"Download proibido") mcedit $SITES/controladownload.txt;$CTUDOBADM;;
esac
##

##FIM DO SCRIPT
rm -f /tmp/menuitem.$$
