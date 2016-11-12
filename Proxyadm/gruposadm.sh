#!/bin/bash
########### IMPROVE CONSULTORIA E INFORMATICA ######################
#                                                                  #
# Script elaborado por: Fabio S. Schmidt (fabio@improve.inf.br)    #
# Data de criacao: 27/01/2006                                      #
                                    #
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
GRUPOSADM=$PWD/gruposadm.sh
ESTACOES="/etc/squid/estacoes"  #DIRETORIO DOS GRUPOS DE ESTACOES
SITES="/etc/squid/sites"	#DIRETORIO DOS GRUPOS DE SITES
VERSAO="1.4.1"
ACCESSLOG="/var/log/squid/access.log"
ERRORLOG="/var/log/squid/squid.out"
##

#INTERFACE COM O USUARIO
$DIALOG --item-help --backtitle "Administracao do servidor PROXY - Improve Consultoria e Informatica - http://www.improve.inf.br" --title "Grupos de usuarios - $VERSAO - BOZI" --menu "Menu para administracao do servidor proxy SQUID" 15 90 7 \
"Usuarios liberados" "Usuarios com acesso total" "Acesso total,exceto sites de conteudo indesejado" \
"Usuarios controlados" "Usuarios com acesso controlado" "Acesso somente aos sites liberados para o grupo e os sempre liberados" \
"Usuarios sem acesso" "Usuarios sem acesso" "Usuarios com acesso somente aos sites sempre liberados" \
"Download controlado" "Usuarios com download controlado" "Usuarios com download controlado" \
"Usuarios sem MSN" "Usuarios sem MSN e WEBMSN" "Usuarios sem acesso ao MSN e WEBMSN" \
"Usuarios sem SKYPE" "Usuarios sem SKYPE" "Usuarios sem acesso ao SKYPE" \
"REDE GERAL" "FAIXA DE IPS DA REDE" "FAIXAS DE IP DA REDE"  2>/tmp/menuitem.$$
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
"Usuarios liberados") mcedit $ESTACOES/acessototal.txt;$GRUPOSADM;;
"Usuarios controlados")  mcedit $ESTACOES/acessocontrolado.txt;$GRUPOSADM;;
"Usuarios sem acesso") mcedit $ESTACOES/semacesso.txt;$GRUPOSADM;;
"Download controlado") mcedit $ESTACOES/downloadcontrolado.txt;$GRUPOSADM;;
"Usuarios sem MSN") mcedit $ESTACOES/semmsn.txt;$GRUPOSADM;;
"Usuarios sem SKYPE") mcedit $ESTACOES/semskype.txt;$GRUPOSADM;;
"REDE GERAL") mcedit $ESTACOES/redegeral.txt;$GRUPOSADM;;
esac
##

##FIM DO SCRIPT
rm -f /tmp/menuitem.$$
