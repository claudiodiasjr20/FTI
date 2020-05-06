#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"                                                                        
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"                                      
#INCLUDE "TBICODE.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ U_RLCTBR01() |  Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 12/01/15  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Programa que Gera o Relatório Razao CT2.			  						     ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil				                                                       sidao ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil 				                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function RLCTBR01()   
                         
Local 	oDlg
Local 	a_AreaATU	:= GetArea()
Local 	c_Query		:= ""

Private c_Perg  	:= "RLCTBR01N7"  // Grupo de pergunta que sera criado no SX1
Private l_Ret		:= .F.

//Tela Inicial
Define MsDialog oDlg Title 'Relatório Razão CT2 - Vr20171220a (Grafico)' From 7,10 To 15,55	Of oMainWnd ////Versao antiga Vr20082015a
@ 15 ,15  Say	'Esta Rotina tem como objetivo gerar um Relatório Razão CT2'  				Of oDlg	Pixel  
@ 25 ,15  Say	'de acordo com a Data, a Conta e o Custo digitado pelo Usuário.'  			Of oDlg Pixel  
Define SButton From 40, 110 Type 01 Action ( l_Ret := .T. , oDlg:End()) 	Enable			Of oDlg   	
Define SButton From 40, 140 Type 02 Action ( l_Ret := .F. , oDlg:End()) 	Enable			Of oDlg   	
Activate MsDialog oDlg Center

If l_Ret
	ValidPerg(c_Perg)
	If !Pergunte(c_Perg,.T.)
		Return Nil
	EndIf   
	c_Query := fMntQry()
	Processa( {|| fExcelColor() } , "Gerando o relatório, aguarde...")
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

c_QryAux +="SELECT		DATA+LEFT(LOTE_SBLT_DOC_LINHA,15) 'CHAVE'												   								   			"	+ c_EOL
c_QryAux +="		,	Substring(LOTE_SBLT_DOC_LINHA,16,3) 'LINHA'                                                                          				"	+ c_EOL
c_QryAux +="		,	CT2_FILIAL 'FILIAL'                                                                       								   			"	+ c_EOL
c_QryAux +="		,	DATA AS EMISSAO																		  								   				"	+ c_EOL
c_QryAux +="		,	CASE CT1_NORMAL WHEN '1' THEN 'Devedor' WHEN '2' THEN 'Credor' END 'TP_CTA'				 								   			"	+ c_EOL
c_QryAux +="		,	DC 'TP_LANC'																			 								   			"	+ c_EOL
c_QryAux +="		,	CONTA																					   								   			"	+ c_EOL
c_QryAux +="		,	CT1_DESC01 'DESCR_CONTA'																   								   			"	+ c_EOL
c_QryAux +="		,	MOEDA																					   								  			"	+ c_EOL
c_QryAux +="		,	VALOR																					   								  			"	+ c_EOL
c_QryAux +="		,	CONTRA_PART																				   								  			"	+ c_EOL
c_QryAux +="		,	'' 'DESC_CONTRAPART'																	   								   			"	+ c_EOL
c_QryAux +="		,	CT2_HIST 'HISTORICO'																	   								  			"	+ c_EOL
c_QryAux +="		,	CCUSTO																					   								   			"	+ c_EOL
c_QryAux +="		,	ISNULL(CTT_DESC01, '') 'DESCR_CC'														   								   			"	+ c_EOL
c_QryAux +="		,	MATTER																					  								   			"	+ c_EOL
c_QryAux +="		,	ISNULL(CTD_DESC01,'') 'DESCR_MATTER'													  								   			"	+ c_EOL
c_QryAux +="		,	CONSULTOR																				   								   			"	+ c_EOL
c_QryAux +="		,	ISNULL(CTH_DESC01,'') 'DESCR_CONSULTOR'													   								  			"	+ c_EOL
c_QryAux +="		,	CT2_ORIGEM 'ORIGEM'																		   								   			"	+ c_EOL
c_QryAux +="		,	CT2_ROTINA 'ROTINA'																		   								   			"	+ c_EOL
c_QryAux +="																									   											"	+ c_EOL
c_QryAux +="FROM	( 																							   								   			"	+ c_EOL
c_QryAux +="			SELECT		CT2_FILIAL																									   			"	+ c_EOL
c_QryAux +="					,	Substring(CT2_DATA,7,2)+'/'+Substring(CT2_DATA,5,2)+'/'+left(CT2_DATA,4) 'DATA'								   			"	+ c_EOL
c_QryAux +="					,	CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA 'LOTE_SBLT_DOC_LINHA'					   								   			"	+ c_EOL
c_QryAux +="					,	CT2_DC 'DCX'																   								   			"	+ c_EOL
c_QryAux +="					,	'D' 'DC'																	   								   			"	+ c_EOL
c_QryAux +="					,	CT2_DEBITO 'CONTA'															  								   			"	+ c_EOL
c_QryAux +="					,	CT2_CREDIT 'CONTRA_PART'													   								   			"	+ c_EOL
c_QryAux +="					,	CT2_VALOR*01 'VALOR'														  								   			"	+ c_EOL
c_QryAux +="					,	CT2_HIST																	  								   			"	+ c_EOL
c_QryAux +="					,	CT2_CCD 'CCUSTO'															   								   			"	+ c_EOL
c_QryAux +="					,	CT2_ITEMD 'MATTER'															 								   			"	+ c_EOL
c_QryAux +="					,	CT2_CLVLDB 'CONSULTOR'														  											"	+ c_EOL
c_QryAux +="					,	CT2_ORIGEM																	  											"	+ c_EOL
c_QryAux +="					,	CT2_ROTINA 																	 								   			"	+ c_EOL
c_QryAux +="					,	CT2_MOEDLC 'MOEDA' 																	 								   	"	+ c_EOL
c_QryAux +="			FROM	" + RetSqlName("CT2") + " CT2 																		  						"	+ c_EOL
c_QryAux +="			WHERE	CT2_FILIAL		>=	'' 															  								   			"	+ c_EOL
c_QryAux +="			AND		CT2_DATA		BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "'	-- Parametros 				   				"	+ c_EOL
c_QryAux +="			AND		CT2_DC			IN ('1','3')	-- Somente os Debitos e Partida Dobrada 		   								   			"	+ c_EOL
c_QryAux +="			AND		CT2.D_E_L_E_T_	=	'' 															   							   	   			"	+ c_EOL
c_QryAux +="																									   								   			"	+ c_EOL
c_QryAux +="		UNION ALL																													  			"	+ c_EOL
c_QryAux +="																																	   			"	+ c_EOL
c_QryAux +="			SELECT		CT2_FILIAL																	   								  			"	+ c_EOL
c_QryAux +="					,	Substring(CT2_DATA,7,2)+'/'+Substring(CT2_DATA,5,2)+'/'+left(CT2_DATA,4) 'DATA'								   			"	+ c_EOL
c_QryAux +="					,	CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA 'LOTE_SBLT_DOC_LINHA'													   			"	+ c_EOL
c_QryAux +="					,	CT2_DC 'DCX'																   								   			"	+ c_EOL
c_QryAux +="					,	'C' 'DC'																	   											"	+ c_EOL
c_QryAux +="					,	CT2_CREDIT 'CONTA'															  											"	+ c_EOL
c_QryAux +="					,	CT2_DEBITO 'CONTRA_PART'													  							   				"	+ c_EOL
c_QryAux +="					,	CT2_VALOR*-1 'VALOR'														  								   			"	+ c_EOL
c_QryAux +="					,	CT2_HIST																	   								   			"	+ c_EOL
c_QryAux +="					,	CT2_CCC 'CCUSTO'															  								   			"	+ c_EOL
c_QryAux +="					,	CT2_ITEMC 'MATTER'															   								   			"	+ c_EOL
c_QryAux +="					,	CT2_CLVLCR 'CONSULTOR'														   								   			"	+ c_EOL
c_QryAux +="					,	CT2_ORIGEM																	   							   	   			"	+ c_EOL
c_QryAux +="					,	CT2_ROTINA 																	   								   			"	+ c_EOL
c_QryAux +="					,	CT2_MOEDLC 'MOEDA' 																	 								   	"	+ c_EOL
c_QryAux +="			FROM	" + RetSqlName("CT2") + " CT2 																		   						"	+ c_EOL
c_QryAux +="			WHERE	CT2_FILIAL		>=	'' 																							   			"	+ c_EOL
c_QryAux +="			AND		CT2_DATA		BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "'	-- Parametros								"	+ c_EOL
c_QryAux +="			AND		CT2_DC			IN ('2','3')	-- Somente os Creditos e Partida Dobrada		   								  			"	+ c_EOL
c_QryAux +="			AND		CT2.D_E_L_E_T_	=	'' 															   								  			"	+ c_EOL
c_QryAux +="		)	AS _ATEMP 																												   			"	+ c_EOL
c_QryAux +="																																	   			"	+ c_EOL
c_QryAux +="INNER JOIN " + RetSqlName("CT1") + " CT1	ON	CT1_FILIAL>='' AND CT1_CONTA=CONTA		AND CT1.D_E_L_E_T_=''  			   						"	+ c_EOL
c_QryAux +="LEFT  JOIN " + RetSqlName("CTT") + " CTT	ON	CTT_FILIAL>='' AND CTT_CUSTO=CCUSTO		AND CTT.D_E_L_E_T_='' 									"	+ c_EOL
c_QryAux +="LEFT  JOIN " + RetSqlName("CTD") + " CTD	ON	CTD_FILIAL>='' AND CTD_ITEM=MATTER		AND CTD.D_E_L_E_T_='' 									"	+ c_EOL
c_QryAux +="LEFT  JOIN " + RetSqlName("CTH") + " CTH	ON	CTH_FILIAL>='' AND CTH_CLVL=CONSULTOR	AND CTH.D_E_L_E_T_=''               					"	+ c_EOL
c_QryAux +="WHERE CONTA BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' AND CCUSTO BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "'						"	+ c_EOL
If !EMPTY(MV_PAR07)
	c_QryAux +="AND MOEDA='" + MV_PAR07 + "'																										"	+ c_EOL
EndIf
c_QryAux +="ORDER BY FILIAL, DATA, LOTE_SBLT_DOC_LINHA, TP_LANC																																												"	+ c_EOL

IF Select("RLCTBR01") > 0
	RLCTBR01->(dbCloseArea())
ENDIF

MemoWrite("RLCTBR01.SQL", c_QryAux)

TcQuery c_QryAux New Alias "RLCTBR01"	                              

Return c_QryAux	

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
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fExcelColor()

Local oExcel 		:= FWMSEXCEL():New() 
Local c_Dia 		:= STRTRAN(DTOC(MSDATE()),"/","_")+"_"+Replace(Time(),":","_")
Local c_Arq			:= ""
Local c_ExtArq	 	:= ".xml"
Local c_Path 		:= cGetFile("\", "Selecione o Local para salvar o Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY)

If !ExistDir( c_Path )
	c_Path 	:= __RELDIR                                      
EndIf

/********************  Gera parametros em XML ********************/ 
IF GetMv("MV_IMPSX1") == "S"
	U_fCabecXML(oExcel, c_Perg,  "Parâmetros - Razão_CT2" )   
EndIf
		
oExcel:SetTitleSizeFont	(13)		// Define o tamanho para a fonte do estilo do Título
oExcel:SetTitleBold		(.T.)		// Define se a fonte terá a configuração "Negrito" no estilo do Título 
oExcel:SetTitleFrColor	("#0000FF")	// Cor do Texto da Primeira Linha - Título
oExcel:SetTitleBgColor	("#FFFFFF") // Cor de Fundo da Primeira Linha - Título
oExcel:SetFrColorHeader	("#FFFFFF") // Texto do Titulo das Colunas
oExcel:SetBgColorHeader	("#4682B4") // Background do Titulo das Colunas
oExcel:SetLineBGColor	("#B8CCE4") // Background das linhas de texto
oExcel:Set2LineBGColor	("#DBE5F1")	// Background das linhas de texto 	

DbSelectArea("RLCTBR01")
RLCTBR01->(DbGoTop())
c_DataQ := DTOS(dDataBase) 

oExcel:AddworkSheet	( "Relatório_Razão_CT2", "")
oExcel:AddTable 	( "Relatório_Razão_CT2", "")
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "CHAVE"				,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "LINHA"				,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "FILIAL"				,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "DATA"				,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "TP_CTA"		   		,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "TP_LANC"			,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "CONTA"				,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "DESCR_CONTA"	 	,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "MOEDA"		  		,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "VALOR"		  		,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "CONTRA_PART"	   	,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "DESC_CONTRAPART"	,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "HISTORICO"			,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "CCUSTO"		   		,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "DESCR_CC"			,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "MATTER"				,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "DESCR_MATTER"		,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "CONSULTOR"	  		,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "DESCR_CONSULTOR"	,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "ORIGEM"				,1,1)
oExcel:AddColumn	( "Relatório_Razão_CT2" , "" , "ROTINA"				,1,1)

While RLCTBR01->(!EOF()) 

	c_Chave		:= RLCTBR01->CHAVE
	c_Linha		:= RLCTBR01->LINHA
	c_Filial	:= RLCTBR01->FILIAL	
	c_Data		:= RLCTBR01->EMISSAO	
	c_TpCta		:= RLCTBR01->TP_CTA
	c_TpLanc	:= RLCTBR01->TP_LANC
	c_Conta		:= RLCTBR01->CONTA
	c_DConta	:= RLCTBR01->DESCR_CONTA
	c_Moeda		:= RLCTBR01->MOEDA	
	c_Valor		:= RLCTBR01->VALOR	
	c_CPart		:= RLCTBR01->CONTRA_PART
	c_DCPart	:= GetAdvFVal("CT1","CT1_DESC01",xFilial("CT1")+RLCTBR01->CONTRA_PART,1,"")
	c_Hist		:= RLCTBR01->HISTORICO
	c_CCusto	:= RLCTBR01->CCUSTO	
	c_DCC		:= RLCTBR01->DESCR_CC	
	c_Matter	:= RLCTBR01->MATTER
	c_DMatter	:= RLCTBR01->DESCR_MATTER	
	c_Consult	:= RLCTBR01->CONSULTOR	
	c_DConsult	:= RLCTBR01->DESCR_CONSULTOR	
	c_Origem	:= RLCTBR01->ORIGEM	
	c_Rotina	:= RLCTBR01->ROTINA
	
	//oExcel:AddRow ( "Relatório_Razão_CT2" , "Relatório_Razão_CT2_"+c_DataQ, {c_Chave,c_Linha,c_Filial,c_Data,c_TpCta,c_TpLanc,c_Conta,c_DConta,c_Valor,c_CPart,c_DCPart,c_Hist,c_CCusto,c_DCC,c_Matter,c_DMatter,c_Consult,c_DConsult,c_Origem,c_Rotina} )
	  oExcel:AddRow ( "Relatório_Razão_CT2" , "", {c_Chave,c_Linha,c_Filial,c_Data,c_TpCta,c_TpLanc,c_Conta,c_DConta,c_Moeda,c_Valor,c_CPart,c_DCPart,c_Hist,c_CCusto,c_DCC,c_Matter,c_DMatter,c_Consult,c_DConsult,c_Origem,c_Rotina} )
	
	RLCTBR01->(DbSkip())

Enddo
                                      
//- Linha em Branco
//	oExcel:AddRow ( "Relatório_Razão_CT2" , "Relatório_Razão_CT2_"+c_DataQ, {"","","","","","","","","","","","","","","","","","","",""} )

	MsUnLock()

	c_Arq := UPPER("RLCTBR01_GRAFICO_")+c_DataQ
	
	oExcel:Activate()
	oExcel:GetXMLFile(UPPER(c_Arq)+c_ExtArq)
	                                        
//- Move Arquivo para Pasta Relato do Usuário
	c_NovoArq	:= AllTrim(c_Path + UPPER(c_Arq) + c_ExtArq)          
	
	If __CopyFile( UPPER(c_Arq)+c_ExtArq, c_NovoArq )
		MsgInfo( "Relatório " + UPPER(c_Arq) + " gerado com sucesso no diretório: " + c_Path, "Relatório Razão CT2" )     
		
		If ApOleClient("MsExcel")
			oExcelApp := MsExcel():New()
			oExcelApp:WorkBooks:Open( c_NovoArq )
			oExcelApp:SetVisible(.T.)
		EndIf
	Else
		MsgAlert( "Relatório não Gerado.", "Relatório Razão CT2" )
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

Return Nil

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ                                                                                                                                                          ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
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
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function ValidPerg(c_Perg)

Local a_AreaATU := GetArea()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
aRegs:={}

c_Perg := c_Perg + Replicate(" ", 10 - Len(c_Perg))
aAdd(aRegs,{c_Perg,"01","Data de: ?     		","","","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"02","Data ate: ?    		","","","mv_ch2","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"03","Conta de: ?     		","","","mv_ch3","C",15,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","CT1"})
aAdd(aRegs,{c_Perg,"04","Conta ate: ?    		","","","mv_ch4","C",15,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","CT1"})
aAdd(aRegs,{c_Perg,"05","C. Custo de: ?     	","","","mv_ch5","C",09,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
aAdd(aRegs,{c_Perg,"06","C. Custo ate: ?    	","","","mv_ch6","C",09,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
aAdd(aRegs,{c_Perg,"07","Moeda: ? (Vazio=Todas)	","","","mv_ch7","C",02,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","CTO"}) //39519

For i:=1 to Len(aRegs)
	IF !dbSeek(c_Perg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			IF j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			ENDIF
		Next
		MsUnlock()
	ENDIF
Next

RestArea(a_AreaATU)

Return Nil

//**********************************************************************************************************************************************************//