#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"                                                                        
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"                                      
#INCLUDE "TBICODE.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ U_RLCTBR02() |  Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 01/06/15  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Programa que Gera o Relatório Razao CT2 em um arquivo .csv				     ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil				                                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil 				                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function RLCTBR02()   
                         
Local 	oDlg
Local 	a_AreaATU	:= GetArea()
Local 	c_Query		:= ""

Private c_Perg  	:= "RLCTBR02N1"  // Grupo de pergunta que sera criado no SX1
Private l_Ret		:= .F.

//Tela Inicial
Define MsDialog oDlg Title 'Relatório Razão CT2 - Vr20171220a' From 7,10 To 15,55	Of oMainWnd //Versao antiga Vr20082015a             
@ 15 ,15  Say	'Esta Rotina tem como objetivo gerar um Relatório Razão CT2'  		Of oDlg	Pixel  
@ 25 ,15  Say	'de acordo com a Data, a Conta e o Custo digitado pelo Usuário.'  	Of oDlg Pixel  
Define SButton From 40, 115 Type 01 Action ( l_Ret := .T. , oDlg:End()) 	Enable	Of oDlg   	
Define SButton From 40, 145 Type 02 Action ( l_Ret := .F. , oDlg:End()) 	Enable	Of oDlg   	
Activate MsDialog oDlg Center

If l_Ret
	ValidPerg(c_Perg)
	If !Pergunte(c_Perg,.T.)
		Return Nil
	EndIf   
	c_Query := fMntQry()
	Processa( {|| fMontExcel() } , "Gerando o relatório, aguarde...")
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
c_QryAux +="ORDER BY FILIAL, DATA, LOTE_SBLT_DOC_LINHA, TP_LANC	   																							"	+ c_EOL

IF Select("RLCTBR02") > 0
	RLCTBR01->(dbCloseArea())
ENDIF

MemoWrite("RLCTBR02.SQL", c_QryAux)

TcQuery c_QryAux New Alias "RLCTBR02"	                              

Return c_QryAux	

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fMontExcel  |  Autor ³ Tiago Dias (Focus Consultoria)  |  Data ³ 21/08/14 	 ³±±
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

Static Function fMontExcel()

Local c_NomeArq	:= "RLCTBR02_CSV"
	
DbSelectArea("RLCTBR02")
RLCTBR02->(DbGoTop()) 

a_Excel := {}
aAdd(a_Excel,{"CHAVE;LINHA;FILIAL;DATA;TP_CTA;TP_LANC;CONTA;DESCR_CONTA;MOEDA;VALOR;CONTRA_PART;DESC_CONTRAPART;HISTORICO;CCUSTO;DESCR_CC;MATTER;DESCR_MATTER;CONSULTOR;DESCR_CONSULTO;ORIGEM;ROTINA;"})
		                                         
While RLCTBR02->(!Eof())
                              
	aAdd(a_Excel,{		RLCTBR02->CHAVE+";"+ ;
						RLCTBR02->LINHA+";"+ ;
						RLCTBR02->FILIAL+";"+ ;
						RLCTBR02->EMISSAO+";"+ ; 
						RLCTBR02->TP_CTA+";"+ ;
						RLCTBR02->TP_LANC+";"+ ;
						RLCTBR02->CONTA+";"+ ;
						RLCTBR02->DESCR_CONTA+";"+ ;
						RLCTBR02->MOEDA+";"+ ;
						Transform(RLCTBR02->VALOR, "@E 999,999,999.99")+";"+ ;
						RLCTBR02->CONTRA_PART+";"+ ;
						GetAdvFVal("CT1","CT1_DESC01",xFilial("CT1")+RLCTBR02->CONTRA_PART,1,"")+";"+ ;
						RLCTBR02->HISTORICO+";"+ ;
						RLCTBR02->CCUSTO+";"+ ;
						RLCTBR02->DESCR_CC+";"+ ;
						RLCTBR02->MATTER+";"+ ;
						RLCTBR02->DESCR_MATTER+";"+ ;
						RLCTBR02->CONSULTOR+";"+ ;
						RLCTBR02->DESCR_CONSULTOR+";"+ ;
						RLCTBR02->ORIGEM+";"+ ;
				   		RLCTBR02->ROTINA })

	RLCTBR02->(DbSkip())    

EndDo

U_fCriaAqv( a_Excel, c_NomeArq, "", ".csv" )                                      
                                      
Return Nil

//***********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fCriaAqv | Autor ³ Claudio Dias Junior (Focus Consultoria)  | Data ³ 26/07/10 ³±±
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

User Function fCriaAqv( a_Dados, c_NomeArq, c_Local, c_Extencao )

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

n_Arq  		:= FCreate( c_Path + c_NomeArq )

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
	MsgInfo( "Relatório " + UPPER(c_NomeArq) + " gerado com sucesso no diretório: " + c_Path, "Relatório Razão CT2" )     
EndIf

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
aAdd(aRegs,{c_Perg,"01","Data de: ?        		","","","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"02","Data ate: ?       		","","","mv_ch2","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"03","Conta de: ?       		","","","mv_ch3","C",15,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","CT1"})
aAdd(aRegs,{c_Perg,"04","Conta ate: ?      		","","","mv_ch4","C",15,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","CT1"})
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