#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"                                                                        
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"                                      
#INCLUDE "TBICODE.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ U_RLFINR04() |  Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 30/08/19  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Programa que Gera o Relatório de Extrato Bancário com Matter e Centro de Custo´±±
±±³			   de acordo com a Data (De/Ate), relatório é gerado .csv ou .xls.		 		 ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil				                                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil 				                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function RLFINR04()    

Local oDlg
Local a_AreaATU	:= GetArea()
Local c_Query	:= ""

Private c_Perg  := "RLFIN2"  // Grupo de pergunta que sera criado no SX1
Private l_Ret	:= .F.
  
MsgINFO('Esse relatório precisa ser Validado, chamado ID 44625 - Este Relatório DESCONSIDERA os TIPOS NCC, RC, NDC, PR','VR 14-10a')

//Tela Inicial
Define MsDialog oDlg Title 'Relatório Extrato Bancário - Vr 1410a' From 7,10 To 15,55	Of oMainWnd              
@ 15 ,15  Say	'Esta Rotina tem como objetivo gerar um Rel. de Extrato Bancário'  		Of oDlg	Pixel  
@ 25 ,15  Say	'com Matter e C. Custo de acordo com a Data digitada pelo Usuário.'  	Of oDlg Pixel  
Define SButton From 40, 110 Type 01 Action ( l_Ret := .T. , oDlg:End()) 	Enable		Of oDlg   	
Define SButton From 40, 140 Type 02 Action ( l_Ret := .F. , oDlg:End()) 	Enable		Of oDlg   	
Activate MsDialog oDlg Center

If l_Ret
	ValidPerg(c_Perg)
	If !Pergunte(c_Perg,.T.)
		Return Nil
	EndIf   
	c_Query := fMntQry()
	If MV_PAR16 == 1
		Processa( {|| fExcelCSV() } , "Gerando o relatório, aguarde...") 
	Else 
		Processa( {|| fExcelXLS() } , "Gerando o relatório, aguarde...")
	EndIf 	
EndIf
    
RestArea(a_AreaATU)
                               
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
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fMntQry()

Local c_QryAux 	:= ""
Local c_EOL		:= CHR(13)

c_QryAux :="SELECT	SE5.E5_NUMERO	AS NUMTIT,																						"	+ c_EOL			
c_QryAux +="		SE1.E1_EMISSAO	AS DTEMI,																						"	+ c_EOL
c_QryAux +="		SE1.E1_VENCREA	AS DTVENC,																						"	+ c_EOL
c_QryAux +="		SE5.E5_DATA		AS DTPAGTO,																						"	+ c_EOL
c_QryAux +="		SE5.E5_TIPO		AS TIPONF,																						"	+ c_EOL
c_QryAux +="		SE1.E1_SERIE	AS SERIE,  																						"	+ c_EOL
c_QryAux +="		SE5.E5_BENEF	AS NOMECLI,																						"	+ c_EOL
c_QryAux +="		SE5.E5_PARCELA	AS PARCTIT,																						"	+ c_EOL
c_QryAux +="		SE5.E5_VALOR	AS VALPAGTO,																					"	+ c_EOL
c_QryAux +="		C6_XITECTB		AS MATTER,																						"	+ c_EOL
c_QryAux +="  		CTD_DESC01		AS DESCMATT,																					"	+ c_EOL
c_QryAux +="  		C6_XCC			AS CCUSTO,																						"	+ c_EOL
c_QryAux +="  		CTT_DESC01		AS DESCCCUS,																					"	+ c_EOL
c_QryAux +="		SE5.E5_BANCO	AS BANCO,																						"	+ c_EOL
c_QryAux +="		SE5.E5_AGENCIA	AS AGENCIA,																						"	+ c_EOL
c_QryAux +="		SE5.E5_CONTA	AS CONTA																						"	+ c_EOL
c_QryAux +="																														"	+ c_EOL
c_QryAux +="FROM " + RetSqlName("SE5") + " SE5																						"	+ c_EOL
c_QryAux +="																														"	+ c_EOL
c_QryAux +="INNER JOIN " + RetSqlName("SE1") + " SE1																				"	+ c_EOL
c_QryAux +="ON	E1_FILIAL='"+xFilial("SE1")+"'																						"	+ c_EOL
c_QryAux +="AND	E1_PREFIXO=E5_PREFIXO																								"	+ c_EOL
c_QryAux +="AND	E1_NUM=E5_NUMERO																									"	+ c_EOL
c_QryAux +="AND	E1_PARCELA=E5_PARCELA																								"	+ c_EOL
c_QryAux +="AND	E1_TIPO=E5_TIPO																										"	+ c_EOL
c_QryAux +="AND SE1.D_E_L_E_T_=''																									"	+ c_EOL
c_QryAux +="																														"	+ c_EOL
c_QryAux +="INNER JOIN (																											"	+ c_EOL
c_QryAux +="				SELECT D2_FILIAL, D2_DOC, D2_CLIENTE, D2_LOJA, C6_XITECTB, C6_XCC, SC6.D_E_L_E_T_ AS 'D_E_L_E_T_'		"	+ c_EOL
c_QryAux +="				FROM	 " + RetSqlName("SD2") + "  SD2																	"	+ c_EOL
c_QryAux +="																														"	+ c_EOL
c_QryAux +="				INNER JOIN  " + RetSqlName("SC6") + "  SC6																"	+ c_EOL
c_QryAux +="				ON	C6_FILIAL=D2_FILIAL																					"	+ c_EOL
c_QryAux +="				AND	C6_NUM=D2_PEDIDO																					"	+ c_EOL
c_QryAux +="				AND	C6_ITEM=D2_ITEMPV																					"	+ c_EOL
c_QryAux +="				AND	SC6.D_E_L_E_T_=''																					"	+ c_EOL
c_QryAux +="																														"	+ c_EOL
c_QryAux +="				WHERE SD2.D_E_L_E_T_ = ''																				"	+ c_EOL
c_QryAux +="																														"	+ c_EOL
c_QryAux +="				GROUP BY D2_FILIAL, D2_DOC, D2_CLIENTE, D2_LOJA, C6_XITECTB, C6_XCC, SC6.D_E_L_E_T_						"	+ c_EOL
c_QryAux +="					) AS RESULTADO																						"	+ c_EOL
c_QryAux +="																														"	+ c_EOL
c_QryAux +="ON	D2_FILIAL=E5_FILORIG																								"	+ c_EOL
c_QryAux +="AND	D2_DOC=E5_NUMERO																									"	+ c_EOL
c_QryAux +="AND	D2_CLIENTE=E5_CLIENTE																								"	+ c_EOL
c_QryAux +="AND	D2_LOJA=E5_LOJA																										"	+ c_EOL
c_QryAux +="AND RESULTADO.D_E_L_E_T_ = ''																							"	+ c_EOL
c_QryAux +="																														"	+ c_EOL
c_QryAux +="LEFT JOIN  " + RetSqlName("CTT") + "  CTT																				"	+ c_EOL
c_QryAux +="ON	CTT_CUSTO=C6_XCC																									"	+ c_EOL
c_QryAux +="AND CTT_CUSTO  BETWEEN '" + MV_PAR09 + "' AND '" + MV_PAR10 + "'                  										"	+ c_EOL
c_QryAux +="AND	CTT.D_E_L_E_T_=''																									"	+ c_EOL
c_QryAux +="																														"	+ c_EOL
c_QryAux +="LEFT JOIN  " + RetSqlName("CTD") + "  CTD																				"	+ c_EOL
c_QryAux +="ON	CTD_ITEM=C6_XITECTB																									"	+ c_EOL
c_QryAux +="AND CTD_ITEM  BETWEEN '" + MV_PAR11 + "' AND '" + MV_PAR12 + "'                  										"	+ c_EOL
c_QryAux +="AND	CTD.D_E_L_E_T_=''																									"	+ c_EOL
c_QryAux +="																														"	+ c_EOL
c_QryAux +="WHERE	SE5.D_E_L_E_T_=''																								"	+ c_EOL
c_QryAux +="AND		SE5.E5_CLIENTE BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "'                  								"	+ c_EOL
c_QryAux +="AND		SE1.E1_EMISSAO BETWEEN '" + DTOS(MV_PAR03) + "' AND '" + DTOS(MV_PAR04) + "'            						"	+ c_EOL
c_QryAux +="AND		SE1.E1_VENCREA BETWEEN '" + DTOS(MV_PAR05) + "' AND '" + DTOS(MV_PAR06) + "'									"	+ c_EOL
c_QryAux +="AND		SE5.E5_DATA   BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "'										"	+ c_EOL
If MV_PAR13 == 1
	c_QryAux +="AND		SE1.E1_TIPO NOT IN ('NCC','RC','NDC','PR') 																	"	+ c_EOL
Else
	c_QryAux +="AND		SE1.E1_TIPO NOT IN ('NCC','RC','NDC','PR','PA') 															"	+ c_EOL
EndIf
If MV_PAR14 == 2
	c_QryAux +="AND		SE1.E1_TIPO NOT IN ('RA') 																					"	+ c_EOL
EndIf
If MV_PAR15 == 1
	c_QryAux +="AND		SE5.E5_BANCO <> '' 																							"	+ c_EOL
	c_QryAux +="AND		SE5.E5_AGENCIA <> '' 																						"	+ c_EOL
	c_QryAux +="AND		SE5.E5_CONTA <> ''																							"	+ c_EOL
EndIf
c_QryAux +="AND		SE5.E5_FILIAL='"+xFilial("SE5")+"'																				"	+ c_EOL
c_QryAux +="																														"	+ c_EOL
c_QryAux +="ORDER BY  NUMTIT, DTEMI, MATTER, CCUSTO																					"	+ c_EOL

IF Select("RLFINR04") > 0
	RLFINR04->(dbCloseArea())
ENDIF

MemoWrite("RLFINR04.SQL", c_QryAux)

TcQuery c_QryAux New Alias "RLFINR04"	                              

Return c_QryAux	

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fExcelXLS  |  Autor ³ Tiago Dias (Focus Consultoria)  |  Data ³ 22/01/16 	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta o Excel em formato colorido                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fExcelXLS()

Local oExcel 		:= FWMSEXCEL():New() 
Local c_Dia 		:= STRTRAN(DTOC(MSDATE()),"/","_")+"_"+Replace(Time(),":","_")
Local c_Arq			:= ""
Local c_ExtArq	 	:= ".xls"
Local c_Path 		:= cGetFile("\", "Selecione o Local para salvar o Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY)

If !ExistDir( c_Path )
	c_Path 	:= __RELDIR                                      
EndIf

/********************  Gera parametros em XML ********************/ 
fCabecXML(oExcel, c_Perg,  "Parâmetros - Extrato Bancário" )   
		
//Configuração Impressão Excel 
oExcel:SetTitleSizeFont	(13)		// Define o tamanho para a fonte do estilo do Título
oExcel:SetTitleBold		(.T.)		// Define se a fonte terá a configuração "Negrito" no estilo do Título 
oExcel:SetTitleFrColor	("#0000FF")	// Cor do Texto da Primeira Linha - Título
oExcel:SetTitleBgColor	("#FFFFFF") // Cor de Fundo da Primeira Linha - Título
oExcel:SetFrColorHeader	("#FFFFFF") // Texto do Titulo das Colunas
oExcel:SetBgColorHeader	("#4682B4") // Background do Titulo das Colunas
oExcel:SetLineBGColor	("#B8CCE4") // Background das linhas de texto
oExcel:Set2LineBGColor	("#DBE5F1")	// Background das linhas de texto 	
                              
//Gerando o Arquivo Excel
DbSelectArea("RLFINR04")
RLFINR04->(DbGoTop())
c_DataQ := DTOS(dDataBase) 

oExcel:AddworkSheet	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ 			 			)
oExcel:AddTable 	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ 				  		)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "NUM.TIT."		,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "DT.EMISSÃO"		,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "DT.VENC."		,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "DT.RECEB."		,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "TIPO NF"			,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "SERIE NF"		,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "NOME CLI."		,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "PARC.TIT."		,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "VAL.PAGTO"	 	,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "MATTER"			,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "DESC.MATTER"	   	,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "C.CUSTO"			,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "DESC.C.CUSTO"	,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "BANCO"			,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "AGENCIA"			,1,1)
oExcel:AddColumn	( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ , "CONTA"			,1,1)

While RLFINR04->(!EOF()) 

	c_NumTit	:= RLFINR04->NUMTIT
	c_DtEmi		:= DTOC(STOD(RLFINR04->DTEMI))
	c_DtVenc	:= DTOC(STOD(RLFINR04->DTVENC))
	c_DtPagto	:= DTOC(STOD(RLFINR04->DTPAGTO))	
	c_TipoNF	:= RLFINR04->TIPONF	
	c_Serie		:= RLFINR04->SERIE
	c_NomCli	:= RLFINR04->NOMECLI
	c_ParcTit	:= RLFINR04->PARCTIT
	c_ValPagto	:= RLFINR04->VALPAGTO
	c_Matter	:= RLFINR04->MATTER	
	c_DescMatt	:= RLFINR04->DESCMATT
	c_CCusto	:= RLFINR04->CCUSTO
	c_DescCCus	:= RLFINR04->DESCCCUS
	c_Banco		:= RLFINR04->BANCO	
	c_Agencia	:= RLFINR04->AGENCIA	
	c_Conta		:= RLFINR04->CONTA   
	
	oExcel:AddRow ( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ, {c_NumTit, c_DtEmi, c_DtVenc, c_DtPagto, c_TipoNF, c_Serie, c_NomCli, c_ParcTit, c_ValPagto, c_Matter, c_DescMatt, c_CCusto, c_DescCCus, c_Banco, c_Agencia, c_Conta} )
	
	RLFINR04->(DbSkip())

Enddo
                                      
//- Linha em Branco
	oExcel:AddRow ( "Relatório_Extrato_Banc." , "Relatório_Extrato_Banc."+c_DataQ, {"","","","","","","","","","","","","","","",""} )

	MsUnLock()

	c_Arq := UPPER("RLFINR04_") + c_DataQ + "_" + Left(Time(),2) + SubStr(Time(),4,2) + Right(Time(),2)
	
	oExcel:Activate()
	oExcel:GetXMLFile(UPPER(c_Arq)+c_ExtArq)
	                                        
//- Move Arquivo para Pasta Relato do Usuário
	c_NovoArq	:= AllTrim(c_Path + UPPER(c_Arq) + c_ExtArq)          
	
	If __CopyFile( UPPER(c_Arq)+c_ExtArq, c_NovoArq )
		MsgInfo( "Relatório " + UPPER(c_Arq) + " gerado com sucesso no diretório: " + c_Path, "Relatório_Extrato_Banc." )     
		
		If ApOleClient("MsExcel")
			oExcelApp := MsExcel():New()
			oExcelApp:WorkBooks:Open( c_NovoArq )
			oExcelApp:SetVisible(.T.)
		EndIf
	Else
		MsgAlert( "Relatório não Gerado.", "Relatório_Extrato_Banc." )
	EndIf

//- Limpa variável Configuração Excel
	oExcel:= FWMSEXCEL():New() 
	oExcel:SetTitleSizeFont	(13)		// Define o tamanho para a fonte do estilo do Título
	oExcel:SetTitleBold		(.T.)		// Define se a fonte terá a configuração "Negrito" no estilo do Título 
	oExcel:SetTitleFrColor	("#0000FF")	// Cor do Texto da Primeira Linha - Título
	oExcel:SetTitleBgColor	("#FFFFFF") // Cor de Fundo da Primeira Linha - Título
	oExcel:SetFrColorHeader	("#FFFFFF") // Texto do Titulo das Colunas
	oExcel:SetBgColorHeader	("#4682B4") // Background do Titulo das Colunas
	oExcel:SetLineBGColor	("#B8CCE4") // Background das linhas de texto
	oExcel:Set2LineBGColor	("#DBE5F1")	// Background das linhas de texto 		

Return Nil

//**********************************************************************************************************************************************************//
 
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fExcelCSV  |  Autor ³ Tiago Dias (Focus Consultoria)  |  Data ³ 22/01/16 	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta o Excel em formato preto e branco                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fExcelCSV()

Local c_NomeArq	:= "RLFINR04"
	
DbSelectArea("RLFINR04")
RLFINR04->(DbGoTop()) 

a_Excel := {}
aAdd(a_Excel,{"NUM.TIT.;DT.EMISSÃO;DT.VENC.;DT.RECEB.;TIPO NF;SERIE NF;NOME CLI.;PARC.TIT.;VAL.PAGTO;MATTER;DESC.MATTER;C.CUSTO;DESC.C.CUSTO;BANCO;AGENCIA;CONTA;"})
		                                         
While RLFINR04->(!Eof())
                              
	aAdd(a_Excel,{	"'"+RLFINR04->NUMTIT+";"+ ;
					DTOC(STOD(RLFINR04->DTEMI))+";"+ ;
	 				DTOC(STOD(RLFINR04->DTVENC))+";"+ ;
					DTOC(STOD(RLFINR04->DTPAGTO))+";"+ ;
					"'"+RLFINR04->TIPONF+";"+ ;
   					RLFINR04->SERIE+";"+ ;
					Alltrim(RLFINR04->NOMECLI)+";"+ ;
  					"'"+RLFINR04->PARCTIT+";"+ ;
 					cValToChar(RLFINR04->VALPAGTO)+";"+ ;
 					"'"+RLFINR04->MATTER+";"+ ;
 					RLFINR04->DESCMATT+";"+ ;
					"'"+RLFINR04->CCUSTO+";"+ ;
 					RLFINR04->DESCCCUS+";"+ ;
 					"'"+RLFINR04->BANCO+";"+ ;
	 				"'"+RLFINR04->AGENCIA+";"+ ;
	 				"'"+RLFINR04->CONTA+";" })

	RLFINR04->(DbSkip())    

EndDo

U_fAqvCSV( a_Excel, c_NomeArq, "", ".csv" )                                      
                                      
Return Nil

//***********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fAqvCSV | Autor ³ Claudio Dias Junior (Focus Consultoria)  | Data ³ 26/07/10  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Gera arquivo com base no array passado.                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 	a_Dados => Array que contém os dados para geração do arquivo                 ³±±
±±³          ³ 	c_NomeArq => Nome do arquivo                                                 ³±±
±±³          ³ 	c_Local => Local de geração do arquivo                                       ³±±
±±³          ³ 	c_Extencao => Extensão ( CSV, TXT, XLS )                           	         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                                					 ³±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function fAqvCSV( a_Dados, c_NomeArq, c_Local, c_Extencao )

Local o_Excel
Local c_Arq
Local n_Arq
Local c_Path
Local l_Retn	:= .T.
                                   	
c_NomeArq 	:= ( c_NomeArq + "_" + DTOS(dDatabase) + "_" + Left(Time(),2) + SubStr(Time(),4,2) + Right(Time(),2) ) + c_Extencao
c_Arq  		:= CriaTrab( Nil, .F. )

If Empty(c_Local)
	c_Path := cGetFile("\", "Selecione o Local para salvar a Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY/*128+GETF_NETWORKDRIVE*/)
Else
	c_Path := c_Local
EndIf

n_Arq := FCreate( c_Path + c_NomeArq )

If ( n_Arq == -1 )
	MsgAlert( "Nao conseguiu criar o arquivo!" , " A T E N C A O !" )
	l_Retn := .F.
	Return()
EndIf

For i := 1 To Len(a_Dados)
	FWrite( n_Arq, a_Dados[i][1] + Chr(13) + Chr(10) )
Next i

FClose(n_Arq)    

If l_Retn
	MsgInfo( "Relatório " + UPPER(c_NomeArq) + " gerado com sucesso no diretório: " + c_Path, "Relatório_Extrato_Banc." )     
EndIf

Return Nil

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fCabecXML  |  Autor ³ Tiago Dias (Focus Consultoria)  |  Data ³ 22/01/16 	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Função generica - Impressão de Paramtros XML                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fCabecXML( __oObj, __cPergunta,  __cTitulo )   

	__oObj:AddWorkSheet( __cTitulo )
	__oObj:AddTable( __cTitulo, "Parâmetros" )
	__oObj:AddColumn( __cTitulo, "Parâmetros" , ""   , 1,1)
	__oObj:AddColumn( __cTitulo, "Parâmetros" , ""   , 1,1)                       
	
	SX1->(DbSeek( PadR(__cPergunta, Len(SX1->X1_GRUPO)) ))
	While SX1->X1_GRUPO == PadR(__cPergunta, Len(SX1->X1_GRUPO)) .And. SX1->(!Eof())
		cParam  := "MV_PAR"+StrZero(Val(SX1->X1_ORDEM),2)
		cRetStr := IIF(SX1->X1_GSC = 'C', StrZero(&(cParam),2), "")
		cRetSX1 := IIF(SX1->X1_GSC = 'C', IIF(&(cParam) > 0, SX1->&("X1_DEF"+cRetStr),""), &(cParam))
		
		If ValType(cRetSX1) == "D" .And. Empty(cRetSX1)
			cRetSX1 := Dtoc(cRetSx1)
		EndIf                                 
		                                                                  
		__oObj:AddRow( __cTitulo, "Parâmetros", {SX1->X1_PERGUNT, cRetSX1 }) 
		
		SX1->(DbSkip())                                                                        
	End-While
	
Return()                                    

//**********************************************************************************************************************************************************//
                                     
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
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

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
c_Perg := PADR(c_Perg,6)
aRegs:={}

c_Perg := c_Perg + Replicate(" ", 10 - Len(c_Perg))               

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

aAdd(aRegs,{c_Perg,"01","Da Data de Recebimento 	?","","","mv_ch1","D",8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"02","Ate a Data de Recebimento 	?","","","mv_ch2","D",8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"03","Da Data de Emissão 		?","","","mv_ch3","D",8,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"04","Ate a Data de Emissão	 	?","","","mv_ch4","D",8,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"05","Da Data de Vencimento 		?","","","mv_ch5","D",8,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"06","Ate a Data de Vencimento 	?","","","mv_ch6","D",8,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"07","Do Centro de Custo 		?","","","mv_ch7","C",10,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
aAdd(aRegs,{c_Perg,"08","Ate Centro de Custo 		?","","","mv_ch8","C",10,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
aAdd(aRegs,{c_Perg,"09","Do Matter			 		?","","","mv_ch9","C",10,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","CTD"})
aAdd(aRegs,{c_Perg,"10","Ate o Matter		 		?","","","mv_cha","C",10,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","CTD"})
aAdd(aRegs,{c_Perg,"11","Do Cliente			 		?","","","mv_chb","C",6,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","SA1"})
aAdd(aRegs,{c_Perg,"12","Ate o Cliente		 		?","","","mv_chc","C",6,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","SA1"})
aAdd(aRegs,{c_Perg,"13","Considera PA: 				?","","","mv_chd","N",01,0,0,"C","","mv_par13","1.Sim","","","","","2.Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"14","Considera RA: 				?","","","mv_che","N",01,0,0,"C","","mv_par14","1.Sim","","","","","2.Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"15","Considera Bancos: 			?","","","mv_chf","N",01,0,0,"C","","mv_par15","1.Sim","","","","","2.Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"16","Imprime em: 				?","","","mv_chg","N",01,0,0,"C","","mv_par16","1.CSV","","","","","2.XLS","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(c_Perg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

DbSelectArea(_sAlias)

Return Nil

//**********************************************************************************************************************************************************//
