#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"                                                                        
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"                                      
#INCLUDE "TBICODE.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±a±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ U_RLFINR02()	 º Autor ³ Tiago Dias   º Data ³  09/12/15   	 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime Relatório Financeiro no Padrão do Protheus			 ¹±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FTI		                                                 	 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function RLFINR02()   

	Local cDesc1         	:= "Rotina com objetivo de gerar um Relatório Financeiro"
	Local cDesc2         	:= "de acordo com os Parametros digitados pelo Usuário."
	Local cDesc3         	:= "Classificando os titulos Atrasos e a vencer por periodo V3"
	Local cPict         	:= ""
	Local titulo       		:= "Rel. Fin Titulos por Periodo/Vcto COM MATTER E SEGMENTO"
	Local nLin         		:= 80
	Local Cabec1       		:= ""
	Local Cabec2       		:= ""
	Local imprime      		:= .T.
	Local aOrd 				:= {'Vencto. Real'}
	Private lEnd        	:= .F.
	Private lAbortPrint  	:= .F.
	Private CbTxt        	:= ""
	Private limite          := 220
	Private tamanho         := "G"
	Private nomeprog        := "RLFINR02" // Coloque aqui o nome do programa para impressao no cabecalho
	Private nTipo           := 18
	Private aReturn         := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
	Private nLastKey        := 0
	Private cPerg       	:= "RLFINR02b2"
	Private cbtxt      		:= Space(10)
	Private cbcont     		:= 00
	Private CONTFL     		:= 01
	Private m_pag      		:= 01
	Private wnrel      		:= "RLFINR02" // Coloque aqui o nome do arquivo usado para impressao em disco
	Private cString 		:= "SE1" 
	Private a_ITEM			:= {}
	Private d_DtaAux		:= dDataBase 
	
	MsgINFO('Esse relatório precisa ser Validado e Encerrado chamado ID 30977','VR 08-03a')

	ValidPerg(cPerg)
	
	If 	!Pergunte(cPerg,.T.)
		Return Nil
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta a interface padrao com o usuario...                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)
	
	If nLastKey == 27
		Return
	Endif
	
	SetDefault(aReturn,cString)
	
	If nLastKey == 27
		Return
	Endif
	
	nTipo := If(aReturn[4]==1,15,18)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
	
Return Nil

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  21/09/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local c_Query		:= ""	// Query
Local n_TotCurr		:= 0
Local n_TotPV1		:= 0
Local n_TotPV2		:= 0
Local n_TotPV3		:= 0
Local n_TotPV4		:= 0
Local n_TotPV5		:= 0
Local n_TotGer		:= 0
Local n_TotVal		:= 0
Local n_DTRef		:= 0 
Local n_Saldo		:= 0
Local n_VAbat		:= 0
Local n_VFinal		:= 0

Private a_ITEM		:= {}

Processa( {|| c_Query := fMntQry() } , "Gerando o Relatório, aguarde...")

	Cabec1 := "NUMTIT PREF TIPO CODIGO-NOME             NATUREZA  SEGMENTO	     MATTER      EMISSAO     VENCTO REAL        VALOR         SALDO      CORRENTE        1 A 30       31 A 90       91 A 180     181 A 360          > 360"
	//		   XXXXXX XXX  XXX  999999-XXXXXXXXXXXXXXXX 999999999 XXXXXXXXXXXX 9999999999  XX/XX/XXXX XX/XX/XXXX 99.999.999,99 99.999.999,99 99.999.999,99 99.999.999,99 99.999.999,99 99.999.999,99 99.999.999,99 99.999.999,99
	//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//         0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
	
	a_Cols := {0, 7, 12, 17, 24, 41, 51, 64, 76, 88, 98, 112, 126, 140, 154, 169, 182, 197}
	
	DbSelectArea("RLTFIN02")
	RLTFIN02->(DbGoTop())
	
// ---- 1o while --------------------------------------------------------------------------------------
	
	While RLTFIN02->(!EOF())    // While para para o Cabecalho

		If !(RLTFIN02->TIPO $ "AB-#FB-#FC-#IR-#IN-#IS-#PI-#CF-#CS-#FU-#FE-#")				
			If lAbortPrint
		       @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		       Exit
		    Endif
		
			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin++
			Endif
	
			a_ITEM := cRETITEM(RLTFIN02->ORIGEM,RLTFIN02->(NUMTIT+PREFIXO))		

			DBSelectArea("SE1")
			DBSetOrder(1)		//E1_FILIAL, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, R_E_C_N_O_, D_E_L_E_T_
			If DBSeek (xfilial("SE1")+RLTFIN02->PREFIXO+RLTFIN02->NUMTIT+RLTFIN02->PARCELA+RLTFIN02->TIPO)
				dDataBase := MV_PAR17
//				d_DtAux := GravaData(MV_PAR17, .F., 8)
				n_Saldo := SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,SE1->E1_MOEDA,,dDataBase,SE1->E1_LOJA, SE1->E1_FILIAL)
				dDataBase := d_DtaAux
				If !(RLTFIN02->TIPO $ "RA#NCC#")
	       			n_VAbat	 := SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1)
	       			n_Saldo	 := n_Saldo - n_VAbat
	       			//n_VFinal := RLTFIN02->VALOR - n_VAbat
	       		EndIf
       		EndIf

			If n_Saldo > 0
			
				@ nLin, a_Cols[01] PSAY RIGHT(RLTFIN02->NUMTIT,6)
				@ nLin, a_Cols[02] PSAY RLTFIN02->PREFIXO
				@ nLin, a_Cols[03] PSAY RLTFIN02->TIPO	                  
				@ nLin, a_Cols[04] PSAY LEFT(RLTFIN02->CODCLI, 6)+"-"
				@ nLin, a_Cols[05] PSAY LEFT(RLTFIN02->NOMECLI, 15)
				@ nLin, a_Cols[06] PSAY LEFT(RLTFIN02->NATUREZA, 9)
				@ nLin, a_Cols[07] PSAY LEFT(a_ITEM[2], 12)
				@ nLin, a_Cols[08] PSAY LEFT(a_ITEM[1], 10)
				@ nLin, a_Cols[09] PSAY DTOC(STOD(RLTFIN02->EMISSAO))	
				@ nLin, a_Cols[10] PSAY DTOC(STOD(RLTFIN02->VENCREAL))
				@ nLin, a_Cols[11] PSAY Transform(RLTFIN02->VALOR,"@E 999,999,999.99")
	   			@ nLin, a_Cols[12] PSAY Transform(n_Saldo ,"@E 999,999,999.99")
							
				//----------------------------------------------------   
				// Classifica o ATRASO (dias) 
				//----------------------------------------------------
				If  STOD(RLTFIN02->VENCREAL) >= dDataBase
			   		n_DTRef := 0
				Else
			   		n_DTRef := dDataBase - STOD(RLTFIN02->VENCREAL)
				EndIf		  
				
				n_Current	:= IIF(n_DTRef<=0,n_Saldo,0)
				n_PVenc1	:= IIF(n_DTRef>=1   .And. n_DTRef<=30,n_Saldo,0)	
				n_PVenc2	:= IIF(n_DTRef>=31  .And. n_DTRef<=90,n_Saldo,0)
				n_PVenc3	:= IIF(n_DTRef>=91  .And. n_DTRef<=180,n_Saldo,0)
				n_PVenc4	:= IIF(n_DTRef>=181 .And. n_DTRef<=360,n_Saldo,0)	
				n_PVenc5	:= IIF(n_DTRef>360,n_Saldo,0)
				
				@ nLin, a_Cols[13] PSAY Transform(n_Current,"@E 999,999,999.99")
				@ nLin, a_Cols[14] PSAY Transform(n_PVenc1 ,"@E 999,999,999.99")
				@ nLin, a_Cols[15] PSAY Transform(n_PVenc2 ,"@E 999,999,999.99")
				@ nLin, a_Cols[16] PSAY Transform(n_PVenc3 ,"@E 999,999,999.99")
				@ nLin, a_Cols[17] PSAY Transform(n_PVenc4 ,"@E 999,999,999.99")
				@ nLin, a_Cols[18] PSAY Transform(n_PVenc5 ,"@E 999,999,999.99") 
				
				n_TotCurr += n_Current
				n_TotPV1  += n_PVenc1
				n_TotPV2  += n_PVenc2
				n_TotPV3  += n_PVenc3
				n_TotPV4  += n_PVenc4
				n_TotPV5  += n_PVenc5
				n_TotVal  += RLTFIN02->VALOR
				
				RLTFIN02->(DbSkip())
		        nLin++
			Else
				RLTFIN02->(DbSkip()) 
			EndIf
		Else
			RLTFIN02->(DbSkip()) 		
  		EndIf
    EndDo

	n_TotGer += n_TotCurr+n_TotPV1+n_TotPV2+n_TotPV3+n_TotPV4+n_TotPV5
    
    nLin++
	@ nLin, 087 PSAY "Totais:"
	@ nLin, 098 PSAY Transform(n_TotVal ,"@E 999,999,999.99")
	@ nLin, 112 PSAY Transform(n_TotGer ,"@E 999,999,999.99")
	@ nLin, 126 PSAY Transform(n_TotCurr,"@E 999,999,999.99")
	@ nLin, 140 PSAY Transform(n_TotPV1 ,"@E 999,999,999.99")
	@ nLin, 154 PSAY Transform(n_TotPV2 ,"@E 999,999,999.99")
	@ nLin, 169 PSAY Transform(n_TotPV3 ,"@E 999,999,999.99")
	@ nLin, 182 PSAY Transform(n_TotPV4 ,"@E 999,999,999.99")
	@ nLin, 197 PSAY Transform(n_TotPV5 ,"@E 999,999,999.99")
	nLin++
// ---- Fim - 1o while --------------------------------------------------------------------------------------

	Set Device To Screen
	
	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif
	
	MS_FLUSH()
	
	If MSGYESNO( "Deseja Exportar o Relatório para Excel?", "Contas a Receber - Periodo" )
		Processa( {|| U_RLFINR1B() } , "Exportando Relatório, aguarde...")
	EndIf

Return Nil

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fMntQry   |     Autor ³ Tiago Dias (Focus Consultoria)   | 	Data ³ 13/01/15  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta a Query para selecionar os dados do relatorio.                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil		  		                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil   		    	                                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fMntQry()

Local c_QryAux 	:= ""
Local c_EOL		:= CHR(13)

c_QryAux +="SELECT		E1_NUM		AS	NUMTIT											   					  							"	+ c_EOL
c_QryAux +="		,	E1_PREFIXO	AS	PREFIXO																  							"	+ c_EOL
c_QryAux +="		,	E1_TIPO		AS	TIPO											   					  							"	+ c_EOL
c_QryAux +="		,	E1_PARCELA	AS	PARCELA																  							"	+ c_EOL
c_QryAux +="		,	E1_CLIENTE	AS	CODCLI																  							"	+ c_EOL
c_QryAux +="		,	E1_LOJA		AS	LOJA																  							"	+ c_EOL
c_QryAux +="		,	E1_NOMCLI	AS	NOMECLI																  							"	+ c_EOL
c_QryAux +="		,	E1_NATUREZ	AS	NATUREZA															  							"	+ c_EOL
c_QryAux +="		,	E1_EMISSAO	AS	EMISSAO											   					  							"	+ c_EOL
c_QryAux +="		,	E1_VENCREA	AS	VENCREAL															  							"	+ c_EOL
c_QryAux +="		,	E1_BAIXA	AS	BAIXA															  								"	+ c_EOL
c_QryAux +="		,	E1_VALOR	AS	VALOR																  							"	+ c_EOL
c_QryAux +="		,	E1_SALDO	AS	SALDO																  							"	+ c_EOL
c_QryAux +="		,	E1_EMIS1	AS	DTCONTAB															   							"	+ c_EOL
c_QryAux +="		,	E1_ORIGEM	AS	ORIGEM																   							"	+ c_EOL
c_QryAux +="		,	E1_ITEMC	AS	ITEMC																   							"	+ c_EOL
c_QryAux +="		,	E1_ITEMD	AS	ITEMD																   							"	+ c_EOL
c_QryAux +="																								   							"	+ c_EOL
c_QryAux +="FROM " + RetSqlName("SE1") + " SE1																   							"	+ c_EOL     
c_QryAux +="                															   					   							"	+ c_EOL
c_QryAux +="WHERE E1_FILIAL = '"+xFilial("SE1")+"'										   												"	+ c_EOL
c_QryAux +="AND	E1_NUM		BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'			   												"	+ c_EOL
c_QryAux +="AND	E1_PREFIXO	BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'			   												"	+ c_EOL
c_QryAux +="AND	E1_TIPO		BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "'			   												"	+ c_EOL
c_QryAux +="AND E1_CLIENTE	BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "'			   												"	+ c_EOL
c_QryAux +="AND E1_NATUREZ	BETWEEN '" + MV_PAR09 + "' AND '" + MV_PAR10 + "'			   												"	+ c_EOL
c_QryAux +="AND E1_EMISSAO	BETWEEN '" + DTOS(MV_PAR13) + "' AND '" + DTOS(MV_PAR14) + "'												"	+ c_EOL
c_QryAux +="AND E1_VENCREA	BETWEEN '" + DTOS(MV_PAR15) + "' AND '" + DTOS(MV_PAR16) + "'												"	+ c_EOL
c_QryAux +="AND E1_TIPO NOT IN ('NCC','RA','RC','NDC','PR')									   											"	+ c_EOL
//c_QryAux +="AND E1_TIPO NOT IN ('NDC')													   											"	+ c_EOL
c_QryAux +="AND SE1.D_E_L_E_T_ = ''																										"	+ c_EOL
//c_QryAux +="AND E1_SALDO <> 0						 																					"	+ c_EOL

//If MV_PAR17 == 2
//	c_QryAux +="AND E1_TIPO NOT IN ('NCC','RA','RC','NDC','PR')									   												"	+ c_EOL
//EndIf

c_QryAux +="																			   												"	+ c_EOL
c_QryAux +="ORDER BY EMISSAO, VENCREAL														   					   								"	+ c_EOL

IF Select("RLTFIN02") > 0     
	RLTFIN02->(dbCloseArea())
EndIf

MemoWrite("RLTFIN02b.SQL", c_QryAux)

TcQuery c_QryAux New Alias "RLTFIN02"	                              

Return c_QryAux	

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RLFINR1B  |  Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 18/09/15      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Programa que Gera o Relatório Financeiro			  						     ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil				                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil 				                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function RLFINR1B()   
                         
Local a_AreaATU	:= GetArea()
Local c_Query	:= ""

c_Query := fMntQry()
Processa( {|| fExcelColor() } , "Exportando Relatório, aguarde...")
    
RestArea(a_AreaATU)
                               
Return Nil 

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fExcelColor  |  Autor ³ Tiago Dias (Focus Consultoria)  |  Data ³ 21/08/14 	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta o Excel em formato colorido                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fExcelColor()

Local oExcel 		:= FWMSEXCEL():New() 
Local c_Dia 		:= STRTRAN(DTOC(MSDATE()),"/","_")+"_"+Replace(Time(),":","_")
Local c_Arq			:= ""
Local c_ExtArq	 	:= ".xls"
Local c_Path 		:= cGetFile("\", "Selecione o Local para salvar o Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY)
Local n_TotCurr		:= 0
Local n_TotPV1		:= 0
Local n_TotPV2		:= 0
Local n_TotPV3		:= 0
Local n_TotPV4		:= 0
Local n_TotPV5		:= 0
Local n_TotGer		:= 0
Local n_TotVal		:= 0
Local n_DTRef		:= 0
Local n_Saldo		:= 0
Local n_VFinal		:= 0
Local l_Ret			:= .T.

Private a_ITEM		:= {}

If !ExistDir( c_Path )
	c_Path 	:= __RELDIR 
	l_Ret	:= .F.                                     
EndIf

If l_Ret 

	/********************  Gera parametros em XML ********************/ 
	IF GetMv("MV_IMPSX1") == "S"
		U_fCabecXML(oExcel, cPerg,  "Parâmetros - Financeiro" )   
	EndIf
			
	oExcel:SetTitleSizeFont	(13)		// Define o tamanho para a fonte do estilo do Título
	oExcel:SetTitleBold		(.T.)		// Define se a fonte terá a configuração "Negrito" no estilo do Título 
	oExcel:SetTitleFrColor	("#0000FF")	// Cor do Texto da Primeira Linha - Título
	oExcel:SetTitleBgColor	("#FFFFFF") // Cor de Fundo da Primeira Linha - Título
	oExcel:SetFrColorHeader	("#FFFFFF") // Texto do Titulo das Colunas
	oExcel:SetBgColorHeader	("#4682B4") // Background do Titulo das Colunas
	oExcel:SetLineBGColor	("#B8CCE4") // Background das linhas de texto
	oExcel:Set2LineBGColor	("#DBE5F1")	// Background das linhas de texto 	
	
	DbSelectArea("RLTFIN02")
	RLTFIN02->(DbGoTop())
	c_DataQ := DTOS(dDataBase) 
	
	oExcel:AddworkSheet	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ 			 			)
	oExcel:AddTable 	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ 				  		)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "TITULO"		,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "PREFIXO"		,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "TIPO"			,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "CODIGO"		,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "NOME"		   	,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "NATUREZA"		,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "SEGMENTO"	 	,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "MATTER"	 	,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "EMISSAO"		,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "VENCTO REAL"	,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "VALOR"		,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "SALDO"		,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "CORRENTE"		,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "1 A 30"		,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "31 A 90"		,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "91 A 180"	  	,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "181 A 360"	,1,1)
	oExcel:AddColumn	( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ , "> 360"		,1,1)
	
	While RLTFIN02->(!EOF()) 

		If !(RLTFIN02->TIPO $ "AB-#FB-#FC-#IR-#IN-#IS-#PI-#CF-#CS-#FU-#FE-#")				
		
			a_ITEM := cRETITEM(RLTFIN02->ORIGEM,RLTFIN02->(NUMTIT+PREFIXO))		

			DBSelectArea("SE1")
			DBSetOrder(1)		//E1_FILIAL, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, R_E_C_N_O_, D_E_L_E_T_
			If DBSeek (xfilial("SE1")+RLTFIN02->PREFIXO+RLTFIN02->NUMTIT+RLTFIN02->PARCELA+RLTFIN02->TIPO)
				dDataBase := MV_PAR17
//				d_DtAux := GravaData(MV_PAR17, .F., 8)
				n_Saldo := SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,1,,dDataBase,SE1->E1_LOJA, SE1->E1_FILIAL)
				dDataBase := d_DtaAux
				If !(RLTFIN02->TIPO $ "RA#NCC#")
	       			n_VAbat  := SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1)
	       			n_Saldo	 := n_Saldo - n_VAbat
	       			//n_VFinal := RLTFIN02->VALOR - n_VAbat
	       		EndIf
       		EndIf
		    
			If n_Saldo > 0
			
				c_Titulo	:= LEFT(ALLTRIM(RLTFIN02->NUMTIT),9)
				c_Prefixo	:= RLTFIN02->PREFIXO
				c_Tipo		:= RLTFIN02->TIPO	
				c_CodCli	:= RLTFIN02->CODCLI	
				c_NomeCli	:= RLTFIN02->NOMECLI
				c_Naturez	:= RLTFIN02->NATUREZA
				c_Segment	:= a_ITEM[2]
				c_Matter	:= a_ITEM[1]
				c_Emissao	:= RLTFIN02->EMISSAO	
				c_Vencto	:= RLTFIN02->VENCREAL
				c_Valor		:= Transform(RLTFIN02->VALOR,"@E 999,999,999.99")	
					
				//----------------------------------------------------   
				// Classifica o ATRASO (dias) 
				//----------------------------------------------------
				If STOD(RLTFIN02->VENCREAL) >= dDataBase
			   		n_DTRef := 0
				Else
			   		n_DTRef := dDataBase - STOD(RLTFIN02->VENCREAL)
				EndIf		  
								
				n_Current	:= IIF(n_DTRef<=0,n_Saldo,0)
				n_PVenc1	:= IIF(n_DTRef>=1   .And. n_DTRef<=30,n_Saldo,0)	
				n_PVenc2	:= IIF(n_DTRef>=31  .And. n_DTRef<=90,n_Saldo,0)
				n_PVenc3	:= IIF(n_DTRef>=91  .And. n_DTRef<=180,n_Saldo,0)
				n_PVenc4	:= IIF(n_DTRef>=181 .And. n_DTRef<=360,n_Saldo,0)	
				n_PVenc5	:= IIF(n_DTRef>360,n_Saldo,0)
				
				n_TotCurr	+= n_Current
				n_TotPV1    += n_PVenc1
				n_TotPV2    += n_PVenc2
				n_TotPV3    += n_PVenc3
				n_TotPV4    += n_PVenc4
				n_TotPV5    += n_PVenc5
				n_TotVal	+= RLTFIN02->VALOR
				
				oExcel:AddRow ( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ, {c_Titulo,c_Prefixo,c_Tipo,c_CodCli,c_NomeCli,c_Naturez, c_Segment, c_Matter,DTOC(STOD(c_Emissao)),DTOC(STOD(c_Vencto)),c_Valor,Transform(n_Saldo,"@E 999,999,999.99"),Transform(n_Current,"@E 999,999,999.99"),Transform(n_PVenc1,"@E 999,999,999.99"),Transform(n_PVenc2,"@E 999,999,999.99"),Transform(n_PVenc3,"@E 999,999,999.99"),Transform(n_PVenc4,"@E 999,999,999.99"),Transform(n_PVenc5,"@E 999,999,999.99")} )
				
				RLTFIN02->(DbSkip())   
			Else
				RLTFIN02->(DbSkip()) 		
			EndIf
		Else
			RLTFIN02->(DbSkip()) 		
  		EndIf		
	Enddo

	n_TotGer += n_TotCurr+n_TotPV1+n_TotPV2+n_TotPV3+n_TotPV4+n_TotPV5
	                                      
	//- Linha em Branco
		oExcel:AddRow ( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ, {"","","","","","","","","","","","","","","","","",""} )
	
	//- Linha TOTAIS
		oExcel:AddRow ( "Relatório_Financeiro" , "Relatório_Financeiro_"+c_DataQ, {"","","","","","","","","","Totais: ",Transform(n_TotVal,"@E 999,999,999.99"),Transform(n_TotGer,"@E 999,999,999.99"),Transform(n_TotCurr,"@E 999,999,999.99"),Transform(n_TotPV1,"@E 999,999,999.99"),Transform(n_TotPV2,"@E 999,999,999.99"),Transform(n_TotPV3,"@E 999,999,999.99"),Transform(n_TotPV4,"@E 999,999,999.99"),Transform(n_TotPV5,"@E 999,999,999.99")} )
	
		MsUnLock()
	
		c_Arq := UPPER("RLFINR02_")+ DtoS(Date()) +"_"+ StrTran(Time(),":","")
		
		oExcel:Activate()
		oExcel:GetXMLFile(UPPER(c_Arq)+c_ExtArq)
		                                        
	//- Move Arquivo para Pasta Relato do Usuário
		c_NovoArq	:= AllTrim(c_Path + UPPER(c_Arq) + c_ExtArq)         
		
		If __CopyFile( UPPER(c_Arq)+c_ExtArq, c_NovoArq )
			MsgInfo( "Relatório " + UPPER(c_Arq) + " gerado com sucesso no diretório: " + c_Path, "Relatório Financeiro" )
		Else
			MsgAlert( "Relatório não Gerado.", "Relatório Financeiro" )
		EndIf
	
	//- Limpa variável Excel
		oExcel:= FWMSEXCEL():New() 
		oExcel:SetTitleSizeFont	(13)		// Define o tamanho para a fonte do estilo do Título
		oExcel:SetTitleBold		(.T.)		// Define se a fonte terá a configuração "Negrito" no estilo do Título 
		oExcel:SetTitleFrColor	("#0000FF")	// Cor do Texto da Primeira Linha - Título
		oExcel:SetTitleBgColor	("#FFFFFF") // Cor de Fundo da Primeira Linha - Título
		oExcel:SetFrColorHeader	("#FFFFFF") // Texto do Titulo das Colunas
		oExcel:SetBgColorHeader	("#4682B4") // Background do Titulo das Colunas
		oExcel:SetLineBGColor	("#B8CCE4") // Background das linhas de texto
		oExcel:Set2LineBGColor	("#DBE5F1")	// Background das linhas de texto 
EndIf		
	
Return Nil

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ                                                                                                                                                            ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ValidPerg   |   Autor ³ Tiago Dias (Focus Consultoria)   |  	 Data ³ 21/08/14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Responsável em criar o SX1.                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_Perg -> Grupo de perguntas a ser criado.                              		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function ValidPerg(c_Perg)

Local a_AreaATU := GetArea()
Local aHelpPor 	:= {}
Local aHelpEsp 	:= {}              
Local aHelpIng 	:= {}
Local aStringP	:= {}  			// Array dos textos em portugues

Aadd( aHelpPor, "Informe o Titulo." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Do Titulo : ?")

PutSx1(c_Perg,"01",aStringP[1],"","","mv_ch1","C",09,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)                                             

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe o Titulo." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Ate o Titulo: ?")

PutSx1(c_Perg,"02",aStringP[2],"","","mv_ch2","C",09,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)                                             

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe o Prefixo." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Do Prefixo : ?")

PutSx1(c_Perg,"03",aStringP[3],"","","mv_ch3","C",03,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe o Prefixo." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Ate o Prefixo : ?")

PutSx1(c_Perg,"04",aStringP[4],"","","mv_ch4","C",03,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe o Tipo." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Do Tipo : ?")

PutSx1(c_Perg,"05",aStringP[5],"","","mv_ch5","C",03,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe o Tipo." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Ate o Tipo : ?")

PutSx1(c_Perg,"06",aStringP[6],"","","mv_ch6","C",03,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe o Cliente." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Do Cliente : ?")

PutSx1(c_Perg,"07",aStringP[7],"","","mv_ch7","C",06,0,0,"G","","SA1","","","mv_par07","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe o Cliente." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Ate o Cliente : ?")

PutSx1(c_Perg,"08",aStringP[8],"","","mv_ch8","C",06,0,0,"G","","SA1","","","mv_par08","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe a Natureza." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Da Natureza : ?")

PutSx1(c_Perg,"09",aStringP[9],"","","mv_ch9","C",10,0,0,"G","","SED","","","mv_par09","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe a Natureza." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Ate a Natureza : ?")

PutSx1(c_Perg,"10",aStringP[10],"","","mv_ch10","C",10,0,0,"G","","SED","","","mv_par10","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe o número do Matter." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Do Matter : ?")

PutSx1(c_Perg,"11",aStringP[11],"","","mv_ch11","C",12,0,0,"G","","CTD","","1","mv_par11","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe o número do Matter." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Ate o Matter : ?")

PutSx1(c_Perg,"12",aStringP[12],"","","mv_ch12","C",12,0,0,"G","","CTD","","","mv_par12","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe a Data de Emissão." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Da Emissao : ?")

PutSx1(c_Perg,"13",aStringP[13],"","","mv_ch13","D",08,0,0,"G","","","","","mv_par13","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe a Data de Emissão." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Ate a Emissao : ?")

PutSx1(c_Perg,"14",aStringP[14],"","","mv_ch14","D",08,0,0,"G","","","","","mv_par14","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe a Data de Vencimento." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Do Vencimento : ?")

PutSx1(c_Perg,"15",aStringP[15],"","","mv_ch15","D",08,0,0,"G","","","","","mv_par15","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe a Data de Vencimento." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Ate o Vencimento : ?")

PutSx1(c_Perg,"16",aStringP[16],"","","mv_ch16","D",08,0,0,"G","","","","","mv_par16","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

/*aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informar se irá considerar o Abatimento." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Considera Abatimento : ?")

PutSx1(c_Perg,"17",aStringP[17],"","","mv_ch17","C",01,0,1,"C","","","","1","mv_par17","Sim","","","","Não","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)
*/

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informar a Data Base de referência." )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Data Base : ?")

PutSx1(c_Perg,"17",aStringP[17],"","","mv_ch17","D",08,0,0,"G","","","","1","mv_par17","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)

RestArea(a_AreaATU)

Return Nil

//**********************************************************************************************************************************************************//

Static Function cRETITEM(cOrigem,cBusca)

Local vRETITEM 	:= Space(10)     
Local vRETSEQCC	:= Space(12)          
Local a_AreSC6 	:= GetArea() 
Local a_ItemAux	:= {}

If 	Upper(Left(cOrigem,3)) == 'FIN' 

   	If	!Empty(RLTFIN02->ITEMD)
		vRETITEM = RLTFIN02->ITEMD 
	Else
		vRETITEM = RLTFIN02->ITEMC
	End

EndIf

If 	Upper(Left(cOrigem,3)) == 'MAT' 

	a_AreSC6 	:= GetArea()     

	DbSelectArea("SC6")
	DbSetOrder(4)
	DbGoTop()
	If DbSeek(xFilial("SC6")+cBusca)
		vRETITEM := C6_XITECTB 
		vRETSEQCC:= C6_XCC
	EndIf

	If	!Empty(vRETSEQCC) 
		DbSelectArea("CTT")
		DbGoTop()
		If DbSeek(xFilial("CTT")+vRETSEQCC)
			vRETSEQCC:= CTT->CTT_DESC01
//			vRETSEQCC:= CTT->(CTT_XFTILC+CTT_XFTIBS+CTT_XFTIDP+CTT_XFTISC)
		EndIf	
	Endif

	RestArea(a_AreSC6)

EndIf                          

AADD(a_ItemAux, vRETITEM)    
AADD(a_ItemAux, vRETSEQCC)

Return a_ItemAux
//**********************************************************************************************************************************************************//