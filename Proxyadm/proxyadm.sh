#!/bin/bash
########### IMPROVE CONSULTORIA E INFORMATICA#######################
#                                                                  #
# Script elaborado por: Fabio S. Schmidt (fabio@improve.inf.br)    #
# Data de criacao: 27/01/2006                                      #
# Contato: 55 (27) 3337-4338                                       #
# ULTIMA ALTERACAO: 04/03/2006                                     #
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
       echo "Improve Consultoria e Informatica - http://www.improve.inf.br  #"
       echo "#######################################################################################"
       exit 0
  fi
}
Testa_Mcedit #EXECUTA A FUNCAO PARA TESTAR SE O MCEDIT ESTA INSTALADO


##VARIAVEIS GLOBAIS
DIALOG=`type -p dialog`
PROGRAMA=$PWD/proxyadm.sh
APLADM=$PWD/apladm.sh
GRUPOSADM=$PWD/gruposadm.sh
CTUDOBADM=$PWD/conteudobadm.sh
CTUDOLADM=$PWD/conteudoladm.sh
SQUIDADM=$PWD/squidadm.sh
ESTACOES="/etc/squid/estacoes"  #DIRETORIO DOS GRUPOS DE ESTACOES
SITES="/etc/squid/sites"	#DIRETORIO DOS GRUPOS DE SITES
VERSAO="1.9.1"
##
    
##VERIFICA SE FOI POSSIVEL ATUALIZAR AS REGRAS DO SQUID
Reload()
{
  service squid reload > /dev/null 2>/dev/null
  if [ $? == 0 ]
  then
         $DIALOG --msgbox "\n\n   REGRAS ATUALIZADAS" 10 30
  else
         $DIALOG --msgbox "ERRO! NAO FOI POSSIVEL ATUALIZAR AS REGRAS" 30 30
         
  fi
}

#INTERFACE COM O USUARIO
$DIALOG --item-help --backtitle "Administracao do servidor PROXY - Improve Consultoria e Informatica - http://www.improve.inf.br" --title "Menu principal - $VERSAO - BOZI" --menu "Ferramenta para gerenciamento das regras do proxy SQUID" 15 90 6 \
"Aplicativos bloqueados" "Aplicativos com acesso controlado" "Aplicativos com acesso controlado" \
"Conteudo bloqueado" "Sites com conteudo bloqueado" "Conteudo bloqueado" \
"Conteudo controlado" "Sites com acesso controlado" "Sites liberados para usuarios com acesso controlado" \
"Grupos de usuarios" "Grupos de usuarios" "Usuarios sem acesso,controlado e com acesso total" \
"ATUALIZAR REGRAS"      "Atualiza as regras com as novas alteracoes" "Atualiza as regras com as alteracoes feitas" \
"ADMINISTRAR O SQUID"   "Administrar a configuracoes do SQUID" "Administrar o SQUID" 2>/tmp/menuitem.$$
##

##Tratamento de resultado do sistema 1=CANCEL BUTTON, 2=HELP BUTTON, 3=ESC PRESSED
sel=$?
na=`cat /tmp/menuitem.$$`
case $sel in
  1) clear;echo "EXECUCAO DO PROGRAMA CANCELADA PELO USUARIO";;
  255) clear;echo "TECLA [ESC] PRESSIONADA";;
esac
##

##RESULTADO DA SELECAO DO USUARIO
menuitem=`cat /tmp/menuitem.$$`
opt=$?
case $menuitem in
"Aplicativos bloqueados") $APLADM;$PROGRAMA;;
"Conteudo bloqueado") $CTUDOBADM;$PROGRAMA;;
"Conteudo controlado") $CTUDOLADM;$PROGRAMA;;
"Grupos de usuarios") $GRUPOSADM;$PROGRAMA;;
"ATUALIZAR REGRAS") Reload;$PROGRAMA;; 
"ADMINISTRAR O SQUID") $SQUIDADM;$PROGRAMA;;
esac
##

##FIM DO SCRIPT
rm -f /tmp/menuitem.$$
