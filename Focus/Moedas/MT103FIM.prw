//Programa: Ponto Entrada MT103FIM()
//Fun��o: Executada ap�s a confirma��o da Exclus�o do Documento de Entrada, para validar e corrigir saldo dos titulos - SE2
//Autor - Andre Luis - INTRODE Integrated Solutions - Em 10/10/2015
//Solicita��o - Marcel/FTI
//Link Apoio: http://tdn.totvs.com/pages/releaseview.action?pageId=6085406
#include "rwmake.ch"
#include "topconn.ch"

User Function MT103FIM()
//Local cNota:= SF1->F1_DOC + SF1->F1_SERIE
Local nOpcao 	:= PARAMIXB[1]   	// Op��o Escolhida pelo usuario no aRotina
Local nConfirma := PARAMIXB[2]	// Se o usuario confirmou a opera��o de grava��o da NFE

if nConfirma == 1 .and. nOpcao == 5
	cQry := "DELETE "+RetSqlName("SE2")+"  WHERE E2_NUM = '"+SF1->F1_DOC+"'  AND E2_PREFIXO = '"+SF1->F1_SERIE+"' " //AND  E2_EMISSAO = '"+SF1->F1_EMISSAO+"' "
	TcSqlExec(cQry)
endIF

Return
