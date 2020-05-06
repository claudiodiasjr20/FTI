#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH"                           

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RLCTBR05  | Autor ³ Claudio Dias JR     (Focus Consultoria) | Data ³ 21/06/18 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatório CHAMADO                                                             ³±±
±±³          ³ Origem VIEW = VW_RLCTBR05                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI-Consulting                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

#DEFINE DDOC 		 01
#DEFINE DFORNECE 	 02
#DEFINE DLOJA 		 03
#DEFINE DTIPO        04
#DEFINE DNOME        05
#DEFINE DCTA_FORN    06
#DEFINE DFORNDESC    07
#DEFINE DFORNUSGAAP  08
#DEFINE DFORNDUSGAAP 09
#DEFINE DITEM        10
#DEFINE DCOD_PROD    11
#DEFINE DDESC_PROD   12
#DEFINE DTOTAL       13
#DEFINE DVLR_IR      14
#DEFINE DVLR_INSS    15
#DEFINE DVLR_ISS     16
#DEFINE DCTA_PROD    17
#DEFINE DPRODDESC    18
#DEFINE DPRODUSGAAP  19
#DEFINE DPRODDUSGAAP 20
#DEFINE DCCUSTO      21
#DEFINE DSEGMENTO    22
#DEFINE DDTDIGIT     23
#DEFINE DTIPO_FORN   24
#DEFINE DDPTO        25
#DEFINE DMES         26
#DEFINE DMATTER      27

User Function RLCTBR05()

Local   o_Dlg
Local   c_Perg	 	:= "RLCTBR05" 
Local   c_Titulo 	:= ""
Local   l_Ret 	 	:= .T.

Private c_Versao 	:= "Vr.28/09/2018"

c_Titulo := "| FTI - Resultados FAT 1 | " + c_Versao + " | "

DEFINE MSDIALOG o_Dlg TITLE c_Titulo;
FROM 000,000 TO 300,390 PIXEL

@015,010 SAY   "Este programa tem como objetivo gerar relatório em .XLS ou .CSV	     "  OF o_Dlg PIXEL
@025,010 SAY   "A base das informações são os itens da nota fiscal de entrada(SD1),  "  OF o_Dlg PIXEL
@035,010 SAY   "Produtos(SB1), Conta Contábil(CT1) e Centro de Custo (CTT)        	 "  OF o_Dlg PIXEL

@055,010 SAY   "IMPORTANTE                                                           "  OF o_Dlg PIXEL COLOR CLR_RED
@065,010 SAY   "Caso haja a necessidade de extrair um período muito longo, verifique "  OF o_Dlg PIXEL
@075,010 SAY   "a opção do parâmetro 'Tipo relatório' e deixe o mesmo como 'CSV'     "  OF o_Dlg PIXEL
@095,010 SAY   "ID 40954/41139                                                       "  OF o_Dlg PIXEL COLOR CLR_RED

@115,025 BUTTON oBut1 PROMPT "&Sair"  		SIZE 44,12 OF o_Dlg PIXEl Action (n_Opcao := 0,o_Dlg:End())
@115,075 BUTTON oBut1 PROMPT "&Parametros"  SIZE 44,12 OF o_Dlg PIXEl Action (n_Opcao := 1,o_Dlg:End())
@115,125 BUTTON oBut1 PROMPT "&Exportar"  	SIZE 44,12 OF o_Dlg PIXEl Action (n_Opcao := 2,o_Dlg:End())
ACTIVATE MSDIALOG o_Dlg CENTERED

If n_Opcao == 1
	ValidPerg(c_Perg)
	Pergunte(c_Perg,.T.)
	U_RLCTBR05()
ElseIf n_Opcao == 2
	Pergunte(c_Perg,.F.)
	Processa({|lend| fProcess()},"Efetuando a seleção dos dados... Por favor, aguarde.")
Else
	MsgStop("Exportação cancelada!","CANCELADO - RLCTBR05.PRW")
EndIf

Return Nil

//*************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fProcess  | Autor ³ Claudio Dias JR     (Focus Consultoria) | Data ³ 21/06/18 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Responsável buscar as informações que serão exibidas no relatorio             ³±±
±±³          ³ Origem VIEW = VW_RLCTBR05                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI-Consulting                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fProcess()

Local c_Query 	:= ""
Local c_Chr 	:= Chr(13)+Chr(10)
Local a_Dados	:= {}

c_Query := " SELECT   DOC  " + c_Chr
c_Query += " 		, FORNECE " + c_Chr
c_Query += " 		, LOJA " + c_Chr
c_Query += " 		, TIPO " + c_Chr
c_Query += " 		, NOME " + c_Chr
c_Query += " 		, CTA_FORN " + c_Chr
c_Query += " 		, FORNDESC " + c_Chr
c_Query += " 		, FORNUSGAAP " + c_Chr
c_Query += " 		, FORNDUSGAAP " + c_Chr
c_Query += " 		, ITEM " + c_Chr
c_Query += " 		, COD_PROD " + c_Chr
c_Query += " 		, DESC_PROD " + c_Chr
c_Query += " 		, VLR_IR " + c_Chr
c_Query += " 		, VLR_INSS " + c_Chr
c_Query += " 		, VLR_ISS " + c_Chr
c_Query += " 		, TOTAL " + c_Chr
c_Query += " 		, CTA_PROD " + c_Chr
c_Query += " 		, PRODDESC " + c_Chr
c_Query += " 		, PRODUSGAAP " + c_Chr
c_Query += " 		, PRODDUSGAAP " + c_Chr
c_Query += " 		, CCUSTO " + c_Chr
c_Query += " 		, SEGMENTO " + c_Chr
c_Query += " 		, DTDIGIT " + c_Chr
c_Query += " 		, TIPO_FORN " + c_Chr
c_Query += " 		, DPTO " + c_Chr
c_Query += " 		, MATTER " + c_Chr + c_Chr

c_Query += " FROM VW_RLCTBR05 " + c_Chr + c_Chr

c_Query += " WHERE DTDIGIT 	BETWEEN '" +DTOS(MV_PAR01)+ "' AND '" +DTOS(MV_PAR02)+ "'" + c_Chr
c_Query += " AND   FORNECE 	BETWEEN '" +MV_PAR03+ "' AND '" +MV_PAR05+ "'" + c_Chr
c_Query += " AND   LOJA 	BETWEEN '" +MV_PAR04+ "' AND '" +MV_PAR06+ "'" + c_Chr
c_Query += " AND   COD_PROD	BETWEEN '" +MV_PAR07+ "' AND '" +MV_PAR08+ "'" + c_Chr
c_Query += " AND   CCUSTO	BETWEEN '" +MV_PAR09+ "' AND '" +MV_PAR10+ "'" + c_Chr

c_Query += " ORDER BY DTDIGIT " + c_Chr

If Select("RLCTBR05") > 0
	RLCTBR05->(DbCloseArea())
EndIf

TCQUERY c_Query NEW ALIAS "RLCTBR05"

If RLCTBR05->(!Eof())

	While RLCTBR05->(!Eof())

		aAdd(a_Dados,{  RLCTBR05->DOC,;
						RLCTBR05->FORNECE,;
						RLCTBR05->LOJA,;
						RLCTBR05->TIPO,;
						RLCTBR05->NOME,;
						RLCTBR05->CTA_FORN,;
						RLCTBR05->FORNDESC,;
						RLCTBR05->FORNUSGAAP,;
						RLCTBR05->FORNDUSGAAP,;
						RLCTBR05->ITEM,;
						RLCTBR05->COD_PROD,;
						RLCTBR05->DESC_PROD,;
						RLCTBR05->TOTAL,;
						RLCTBR05->VLR_IR,;
						RLCTBR05->VLR_INSS,;
						RLCTBR05->VLR_ISS,; 
						RLCTBR05->CTA_PROD,;
						RLCTBR05->PRODDESC,;
						RLCTBR05->PRODUSGAAP,;
						RLCTBR05->PRODDUSGAAP,;
						RLCTBR05->CCUSTO,;
						RLCTBR05->SEGMENTO ,;
						DTOC(STOD(RLCTBR05->DTDIGIT)),;
					    UPPER(U_NomeMes1( Val(SubStr(RLCTBR05->DTDIGIT,5,2)) )) + "/" + Left(RLCTBR05->DTDIGIT,4),;
						RLCTBR05->TIPO_FORN,;
						RLCTBR05->DPTO,;
						RLCTBR05->MATTER  } )

		RLCTBR05->(DbSkip())
		
	EndDo

//- Verifico qual a Opção de relatório XLS ou CSV	
	If MV_PAR13 == 1
		ExpXLS(a_Dados)
	Else
		ExpCSV(a_Dados)
	EndIf
	
Else
	MsgStop("Não existe registros para extração, verifique os parâmetros","A V I S O ! ! !")
EndIf

RLCTBR05->(DbCloseArea())

Return Nil

//*************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ExpXLS    | Autor ³ Claudio Dias JR     (Focus Consultoria) | Data ³ 21/06/18 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Geração de relatório XLS                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ a_Dados -> Array com dados para impressão                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI-Consulting                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function ExpXLS(a_Dados)
          
Local c_Dia 	:= STRTRAN(DTOC(MSDATE()),"/","_")+"_"+Replace(Time(),":","_")
Local c_Arq		:= ""
Local c_ExtArq 	:= ".xls"
Local c_Path 	:= "" 
Local c_Nome 	:= "RLCTBR05_" + c_Dia
Private oExcel	:= FWMSEXCEL():New() 

c_Path := cGetFile("\", "Selecione o Local para salvar a Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY)

If !ExistDir( c_Path )
	c_Path 	:= __RELDIR
EndIf
 
oExcel:SetTitleFrColor("#000000") 	// Cor do Texto da Primeira Linha
oExcel:SetTitleBgColor("#FFFFFF") 	// Cor de Fundo da Primeira Linha
oExcel:SetFrColorHeader("#FFFFFF")  // Texto do Titulo das Colunas
oExcel:SetBgColorHeader("#003366")  // Background do Titulo das Colunas
oExcel:SetLineBGColor("#FFFFFF")  	// Background das linhas de texto
oExcel:Set2LineBGColor("#FFFFFF")	// Background das linhas de texto 	

c_NomeSheet := "Parametros"
oExcel:AddworkSheet( c_NomeSheet )  
oExcel:AddTable ( c_NomeSheet , c_Nome)
oExcel:AddColumn( c_NomeSheet , c_Nome, "Parametro"		,1,1)
oExcel:AddColumn( c_NomeSheet , c_Nome, "Conteúdo"		,1,1)

oExcel:AddRow( c_NomeSheet, c_Nome, { "Dt.Digite De"		, DTOC(MV_PAR01) })
oExcel:AddRow( c_NomeSheet, c_Nome, { "Dt.Digite Ate"		, DTOC(MV_PAR02) })
oExcel:AddRow( c_NomeSheet, c_Nome, { "Fornecedor De"		, MV_PAR03 })
oExcel:AddRow( c_NomeSheet, c_Nome, { "Loja De"				, MV_PAR04 })
oExcel:AddRow( c_NomeSheet, c_Nome, { "Fornecedor Ate"		, MV_PAR05 })
oExcel:AddRow( c_NomeSheet, c_Nome, { "Loja Ate"			, MV_PAR06 })
oExcel:AddRow( c_NomeSheet, c_Nome, { "Produto De"			, MV_PAR07 })
oExcel:AddRow( c_NomeSheet, c_Nome, { "Produto Ate"			, MV_PAR08 })
oExcel:AddRow( c_NomeSheet, c_Nome, { "C.Custo De"			, MV_PAR09 })
oExcel:AddRow( c_NomeSheet, c_Nome, { "C.Custo Ate"			, MV_PAR10 })
oExcel:AddRow( c_NomeSheet, c_Nome, { "Sair Cód USGAAP?"	, IIF(MV_PAR11==1,"Sim","Nao") })
oExcel:AddRow( c_NomeSheet, c_Nome, { "Sair Depto CC ?"		, IIF(MV_PAR12==1,"Sim","Nao") })
oExcel:AddRow( c_NomeSheet, c_Nome, { "Extensão relatório"	, IIF(MV_PAR13==1,"XLS","CSV") })
	
c_NomeSheet := "Resultado_FAT1"
oExcel:AddworkSheet( c_NomeSheet )  
oExcel:AddTable ( c_NomeSheet , c_Nome)
oExcel:AddColumn( c_NomeSheet , c_Nome, "Documento",1,1) 				// DOC
oExcel:AddColumn( c_NomeSheet , c_Nome, "Código do Fornecedor",1,1)	 	// FORNECE
oExcel:AddColumn( c_NomeSheet , c_Nome, "Loja do Fornecedor",1,1) 		// LOJA 
oExcel:AddColumn( c_NomeSheet , c_Nome, "Nome do Fornecedor",1,1) 		// NOME
oExcel:AddColumn( c_NomeSheet , c_Nome, "C Contabil Fornecedor",1,1)	// CTA_FORN
If MV_PAR11 == 1
	oExcel:AddColumn( c_NomeSheet , c_Nome, "Forn. Conta USGAAP",1,1) 		// FORNUSGAAP
	oExcel:AddColumn( c_NomeSheet , c_Nome, "Forn. Descr Conta USGAAP",1,1) // FORNDUSGAAP
EndIf
oExcel:AddColumn( c_NomeSheet , c_Nome, "Item",1,1) 					// ITEM
oExcel:AddColumn( c_NomeSheet , c_Nome, "Produto",1,1) 					// COD_PROD
oExcel:AddColumn( c_NomeSheet , c_Nome, "Descrição do Produto",1,1) 	// DESC_PROD
oExcel:AddColumn( c_NomeSheet , c_Nome, "Vlr.Total",1,3) 				// TOTAL
oExcel:AddColumn( c_NomeSheet , c_Nome, "Vlr.Prov.Ret IRRF",1,3) 		// VLR_IR
oExcel:AddColumn( c_NomeSheet , c_Nome, "Vlr.Prov.Ret INSS",1,3) 		// VLR_INSS
oExcel:AddColumn( c_NomeSheet , c_Nome, "Vlr.Prov.Ret ISS",1,3) 		// VLR_ISS
oExcel:AddColumn( c_NomeSheet , c_Nome, "C Contabil Produto",1,1) 		// CTA_PROD
oExcel:AddColumn( c_NomeSheet , c_Nome, "Nome C. Contabil",1,1) 		// PRODDESC
If MV_PAR11 == 1
	oExcel:AddColumn( c_NomeSheet , c_Nome, "Prod. Conta USGAAP",1,1) 		// PRODUSGAAP
	oExcel:AddColumn( c_NomeSheet , c_Nome, "Prod. Descr Conta USGAAP",1,1) // PRODDUSGAAP
EndIf
If MV_PAR12 == 1
	oExcel:AddColumn( c_NomeSheet , c_Nome, "Centro Custo",1,1) 			// CCUSTO
EndIf
oExcel:AddColumn( c_NomeSheet , c_Nome, "Segmento",1,1) 				// SEGMENTO
oExcel:AddColumn( c_NomeSheet , c_Nome, "Data de Lançamento",1,1) 		// DTDIGIT
oExcel:AddColumn( c_NomeSheet , c_Nome, "Mês",1,1) 						// MES
oExcel:AddColumn( c_NomeSheet , c_Nome, "Tipo",1,1) 					// TIPO_FORN
oExcel:AddColumn( c_NomeSheet , c_Nome, "Departamento",1,1)				// DPTO
oExcel:AddColumn( c_NomeSheet , c_Nome, "Matter",1,1) 					// MATTER

ProcRegua(Len(a_Dados))

For n_Item := 1 To Len(a_Dados)

		IncProc()

//----- Com todas as COLUNAS
		If MV_PAR11 == 1 .And. MV_PAR12 == 1
			oExcel:AddRow( c_NomeSheet, c_Nome, { 	a_Dados[n_Item][DDOC],;
													a_Dados[n_Item][DFORNECE],;
													a_Dados[n_Item][DLOJA],;
													a_Dados[n_Item][DNOME],;
													a_Dados[n_Item][DCTA_FORN],;
													a_Dados[n_Item][DFORNUSGAAP],;
													a_Dados[n_Item][DFORNDUSGAAP],;
													a_Dados[n_Item][DITEM],;
													a_Dados[n_Item][DCOD_PROD],;
													a_Dados[n_Item][DDESC_PROD],;
													a_Dados[n_Item][DTOTAL],;
													a_Dados[n_Item][DVLR_IR],;
													a_Dados[n_Item][DVLR_INSS],;
													a_Dados[n_Item][DVLR_ISS],;
													a_Dados[n_Item][DCTA_PROD],;
													a_Dados[n_Item][DPRODDESC],;
													a_Dados[n_Item][DPRODUSGAAP],;
													a_Dados[n_Item][DPRODDUSGAAP],;
													a_Dados[n_Item][DCCUSTO],;
													a_Dados[n_Item][DSEGMENTO],;
													a_Dados[n_Item][DDTDIGIT],;
													a_Dados[n_Item][DMES],;
													a_Dados[n_Item][DTIPO_FORN],;
													a_Dados[n_Item][DDPTO],;
											 		a_Dados[n_Item][DMATTER] } )
//----- SEM as COLUNAS USGAAP
		ElseIf MV_PAR11 == 2 .And. MV_PAR12 == 1

			oExcel:AddRow( c_NomeSheet, c_Nome, { 	a_Dados[n_Item][DDOC],;
													a_Dados[n_Item][DFORNECE],;
													a_Dados[n_Item][DLOJA],;
													a_Dados[n_Item][DNOME],;
													a_Dados[n_Item][DCTA_FORN],;
													a_Dados[n_Item][DITEM],;
													a_Dados[n_Item][DCOD_PROD],;
													a_Dados[n_Item][DDESC_PROD],;
													a_Dados[n_Item][DTOTAL],;
													a_Dados[n_Item][DVLR_IR],;
													a_Dados[n_Item][DVLR_INSS],;
													a_Dados[n_Item][DVLR_ISS],;
													a_Dados[n_Item][DCTA_PROD],;
													a_Dados[n_Item][DPRODDESC],;
													a_Dados[n_Item][DCCUSTO],;
													a_Dados[n_Item][DSEGMENTO],;
													a_Dados[n_Item][DDTDIGIT],;
													a_Dados[n_Item][DMES],;
													a_Dados[n_Item][DTIPO_FORN],;
													a_Dados[n_Item][DDPTO],;
											 		a_Dados[n_Item][DMATTER] } )	
//----- SEM as COLUNAS CENTRO DE CUSTO
		ElseIf MV_PAR11 == 1 .And. MV_PAR12 == 2

			oExcel:AddRow( c_NomeSheet, c_Nome, { 	a_Dados[n_Item][DDOC],;
													a_Dados[n_Item][DFORNECE],;
													a_Dados[n_Item][DLOJA],;
													a_Dados[n_Item][DNOME],;
													a_Dados[n_Item][DCTA_FORN],;
													a_Dados[n_Item][DFORNUSGAAP],;
													a_Dados[n_Item][DFORNDUSGAAP],;
													a_Dados[n_Item][DITEM],;
													a_Dados[n_Item][DCOD_PROD],;
													a_Dados[n_Item][DDESC_PROD],;
													a_Dados[n_Item][DTOTAL],;
													a_Dados[n_Item][DVLR_IR],;
													a_Dados[n_Item][DVLR_INSS],;
													a_Dados[n_Item][DVLR_ISS],;
													a_Dados[n_Item][DCTA_PROD],;
													a_Dados[n_Item][DPRODDESC],;
													a_Dados[n_Item][DPRODUSGAAP],;
													a_Dados[n_Item][DPRODDUSGAAP],;
													a_Dados[n_Item][DSEGMENTO],;
													a_Dados[n_Item][DDTDIGIT],;
													a_Dados[n_Item][DMES],;
													a_Dados[n_Item][DTIPO_FORN],;
													a_Dados[n_Item][DDPTO],;
											 		a_Dados[n_Item][DMATTER] } )

//----- SEM as COLUNAS USGAAP E SEM as COLUNAS CENTRO DE CUSTO
		Else
			oExcel:AddRow( c_NomeSheet, c_Nome, { 	a_Dados[n_Item][DDOC],;
													a_Dados[n_Item][DFORNECE],;
													a_Dados[n_Item][DLOJA],;
													a_Dados[n_Item][DNOME],;
													a_Dados[n_Item][DCTA_FORN],;
													a_Dados[n_Item][DITEM],;
													a_Dados[n_Item][DCOD_PROD],;
													a_Dados[n_Item][DDESC_PROD],;
													a_Dados[n_Item][DTOTAL],;
													a_Dados[n_Item][DVLR_IR],;
													a_Dados[n_Item][DVLR_INSS],;
													a_Dados[n_Item][DVLR_ISS],;
													a_Dados[n_Item][DCTA_PROD],;
													a_Dados[n_Item][DPRODDESC],;
													a_Dados[n_Item][DSEGMENTO],;
													a_Dados[n_Item][DDTDIGIT],;
													a_Dados[n_Item][DMES],;
													a_Dados[n_Item][DTIPO_FORN],;
													a_Dados[n_Item][DDPTO],;
											 		a_Dados[n_Item][DMATTER] } )
	EndIf
	
Next n_Item
	
//--------------------------------------------------------------------------------------------------------------------------------------------------------//

c_Arq := c_Nome
oExcel:Activate()
oExcel:GetXMLFile(c_Arq+c_ExtArq)
                                        
//- Move Arquivo para Pasta Relato do Usuário
c_NovoArq := AllTrim(c_Path + c_Arq + c_ExtArq)           

If __CopyFile( c_Arq+c_ExtArq, c_NovoArq )
	MsgInfo( "Arquivo " + c_NovoArq + " gerado com sucesso no diretório " + c_Path, " A V I S O ! " )
Else
	MsgInfo( "Arquivo não copiado para temporário do usuário." , " A V I S O ! " )
EndIf

Return Nil

//*************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ExpCSV    | Autor ³ Claudio Dias JR     (Focus Consultoria) | Data ³ 21/06/18 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Geração de relatório XLS                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ a_Dados -> Array com dados para impressão                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI-Consulting                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function ExpCSV(a_Dados)

Local o_Excel
Local n_Arq		:= 0
Local c_Arq		:= ""
Local c_Path	:= ""
Local c_Cabec 	:= ""

c_NovoArq 	:= "RLCTBR05_" + STRTRAN(DTOC(MSDATE()),"/","_")+"_"+Replace(Time(),":","_") + ".CSV"
c_Arq  		:= CriaTrab( Nil, .F. )
c_Path 		:= cGetFile("\", "Selecione o Local para salvar a Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY)

If !ExistDir( c_Path )
	c_Path 	:= __RELDIR
EndIf

n_Arq  := FCreate( c_Path + c_NovoArq )

If ( n_Arq == -1 )
	MsgAlert( "Nao conseguiu criar o arquivo!" , " A T E N C A O !" )
	Return Nil
EndIf

c_Cabec := "Documento;"
c_Cabec += "Código do Fornecedor;"
c_Cabec += "Loja do Fornecedor;"
c_Cabec += "Nome do Fornecedor;"
c_Cabec += "C Contabil Fornecedor;"
If MV_PAR11 == 1
	c_Cabec += 	"Forn. Conta USGAAP;"
	c_Cabec += 	"Forn. Descr Conta USGAAP;"
EndIf
c_Cabec += "Item;"
c_Cabec += "Produto;"
c_Cabec += "Descrição do Produto;"
c_Cabec += "Vlr.Total;"
c_Cabec += "Vlr.Prov.Ret IRRF"
c_Cabec += "Vlr.Prov.Ret INSS"
c_Cabec += "Vlr.Prov.Ret ISS"
c_Cabec += "C Contabil Produto;"
c_Cabec += "Nome C. Contabil;"
If MV_PAR11 == 1
	c_Cabec += 	"Prod. Conta USGAAP;"
	c_Cabec += 	"Prod. Descr Conta USGAAP;"
EndIf
If MV_PAR12 == 1
	c_Cabec += 	"Centro Custo;"
EndIf
c_Cabec += "Segmento;"
c_Cabec += "Data de Lançamento;"
c_Cabec += "Mês;"
c_Cabec += "Tipo;"
c_Cabec += "Departamento;"
c_Cabec += "Matter;"

FWrite( n_Arq,  c_Cabec + Chr(13) + Chr(10) )

ProcRegua(Len(a_Dados))

For n_Item := 1 To Len(a_Dados)

		IncProc()

//----- Com todas as COLUNAS
		If MV_PAR11 == 1 .And. MV_PAR12 == 1

			FWrite( n_Arq,  a_Dados[n_Item][DDOC]+";"+;
							a_Dados[n_Item][DFORNECE]+";"+;
							a_Dados[n_Item][DLOJA]+";"+;
							a_Dados[n_Item][DNOME]+";"+;
							a_Dados[n_Item][DCTA_FORN]+";"+;
							a_Dados[n_Item][DFORNUSGAAP]+";"+;
							a_Dados[n_Item][DFORNDUSGAAP]+";"+;
							a_Dados[n_Item][DITEM]+";"+;
							a_Dados[n_Item][DCOD_PROD]+";"+;
							a_Dados[n_Item][DDESC_PROD]+";"+;
							Transform(a_Dados[n_Item][DTOTAL],"@E 999,999,999.99")+";"+;
							Transform(a_Dados[n_Item][DVLR_IR],"@E 999,999,999.99")+";"+;
							Transform(a_Dados[n_Item][DVLR_INSS],"@E 999,999,999.99")+";"+;
							Transform(a_Dados[n_Item][DVLR_ISS],"@E 999,999,999.99")+";"+;
							a_Dados[n_Item][DCTA_PROD]+";"+;
							a_Dados[n_Item][DPRODDESC]+";"+;
							a_Dados[n_Item][DPRODUSGAAP]+";"+;
							a_Dados[n_Item][DPRODDUSGAAP]+";"+;
							a_Dados[n_Item][DCCUSTO]+";"+;
							a_Dados[n_Item][DSEGMENTO]+";"+;
							a_Dados[n_Item][DDTDIGIT]+";"+;
							a_Dados[n_Item][DMES]+";"+;
							a_Dados[n_Item][DTIPO_FORN]+";"+;
							a_Dados[n_Item][DDPTO]+";"+;
					 		a_Dados[n_Item][DMATTER] + Chr(13) + Chr(10) )

//----- SEM as COLUNAS USGAAP
		ElseIf MV_PAR11 == 2 .And. MV_PAR12 == 1

			FWrite( n_Arq,  a_Dados[n_Item][DDOC]+";"+;
							a_Dados[n_Item][DFORNECE]+";"+;
							a_Dados[n_Item][DLOJA]+";"+;
							a_Dados[n_Item][DNOME]+";"+;
							a_Dados[n_Item][DCTA_FORN]+";"+;
							a_Dados[n_Item][DITEM]+";"+;
							a_Dados[n_Item][DCOD_PROD]+";"+;
							a_Dados[n_Item][DDESC_PROD]+";"+;
							Transform(a_Dados[n_Item][DTOTAL],"@E 999,999,999.99")+";"+;
							Transform(a_Dados[n_Item][DVLR_IR],"@E 999,999,999.99")+";"+;
							Transform(a_Dados[n_Item][DVLR_INSS],"@E 999,999,999.99")+";"+;
							Transform(a_Dados[n_Item][DVLR_ISS],"@E 999,999,999.99")+";"+;
							a_Dados[n_Item][DCTA_PROD]+";"+;
							a_Dados[n_Item][DPRODDESC]+";"+;
							a_Dados[n_Item][DCCUSTO]+";"+;
							a_Dados[n_Item][DSEGMENTO]+";"+;
							a_Dados[n_Item][DDTDIGIT]+";"+;
							a_Dados[n_Item][DMES]+";"+;
							a_Dados[n_Item][DTIPO_FORN]+";"+;
							a_Dados[n_Item][DDPTO]+";"+;
					 		a_Dados[n_Item][DMATTER] + Chr(13) + Chr(10) )
					 		
//----- SEM as COLUNAS CENTRO DE CUSTO
		ElseIf MV_PAR11 == 1 .And. MV_PAR12 == 2

			FWrite( n_Arq,  a_Dados[n_Item][DDOC]+";"+;
							a_Dados[n_Item][DFORNECE]+";"+;
							a_Dados[n_Item][DLOJA]+";"+;
							a_Dados[n_Item][DNOME]+";"+;
							a_Dados[n_Item][DCTA_FORN]+";"+;
							a_Dados[n_Item][DFORNUSGAAP]+";"+;
							a_Dados[n_Item][DFORNDUSGAAP]+";"+;
							a_Dados[n_Item][DITEM]+";"+;
							a_Dados[n_Item][DCOD_PROD]+";"+;
							a_Dados[n_Item][DDESC_PROD]+";"+;
							Transform(a_Dados[n_Item][DTOTAL],"@E 999,999,999.99")+";"+;
							Transform(a_Dados[n_Item][DVLR_IR],"@E 999,999,999.99")+";"+;
							Transform(a_Dados[n_Item][DVLR_INSS],"@E 999,999,999.99")+";"+;
							Transform(a_Dados[n_Item][DVLR_ISS],"@E 999,999,999.99")+";"+;
							a_Dados[n_Item][DCTA_PROD]+";"+;
							a_Dados[n_Item][DPRODDESC]+";"+;
							a_Dados[n_Item][DPRODUSGAAP]+";"+;
							a_Dados[n_Item][DPRODDUSGAAP]+";"+;
							a_Dados[n_Item][DSEGMENTO]+";"+;
							a_Dados[n_Item][DDTDIGIT]+";"+;
							a_Dados[n_Item][DMES]+";"+;
							a_Dados[n_Item][DTIPO_FORN]+";"+;
							a_Dados[n_Item][DDPTO]+";"+;
					 		a_Dados[n_Item][DMATTER] + Chr(13) + Chr(10) )

//----- SEM as COLUNAS USGAAP E SEM as COLUNAS CENTRO DE CUSTO
		Else

			FWrite( n_Arq,  a_Dados[n_Item][DDOC]+";"+;
							a_Dados[n_Item][DFORNECE]+";"+;
							a_Dados[n_Item][DLOJA]+";"+;
							a_Dados[n_Item][DNOME]+";"+;
							a_Dados[n_Item][DCTA_FORN]+";"+;
							a_Dados[n_Item][DITEM]+";"+;
							a_Dados[n_Item][DCOD_PROD]+";"+;
							a_Dados[n_Item][DDESC_PROD]+";"+;
							Transform(a_Dados[n_Item][DTOTAL],"@E 999,999,999.99")+";"+;
							Transform(a_Dados[n_Item][DVLR_IR],"@E 999,999,999.99")+";"+;
							Transform(a_Dados[n_Item][DVLR_INSS],"@E 999,999,999.99")+";"+;
							Transform(a_Dados[n_Item][DVLR_ISS],"@E 999,999,999.99")+";"+;
							a_Dados[n_Item][DCTA_PROD]+";"+;
							a_Dados[n_Item][DPRODDESC]+";"+;
							a_Dados[n_Item][DSEGMENTO]+";"+;
							a_Dados[n_Item][DDTDIGIT]+";"+;
							a_Dados[n_Item][DMES]+";"+;
							a_Dados[n_Item][DTIPO_FORN]+";"+;
							a_Dados[n_Item][DDPTO]+";"+;
					 		a_Dados[n_Item][DMATTER] + Chr(13) + Chr(10) )
EndIf
	
Next n_Item

MsgInfo( "Arquivo " + c_NovoArq + " gerado com sucesso no diretório " + c_Path, " A V I S O ! " )

FClose(n_Arq)

Return Nil

//*************************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ NomeMes  | Autor ³ Claudio Dias Junior (Focus Consultoria)  | Data ³ 31/10/13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Mensagem a ser apresentada caso as requisiçõe da OP a ser produzida não       ³±±
±±           ³ possua saldo.                                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ n_Mes 		=> Numero referente ai mês 1,2,3...12                            ³±±
±±³          ³ c_NomeMes	=> Nome do Mês                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil                                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI-Consulting                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function NomeMes1(n_Mes)

Local c_NomeMes := ""

If n_Mes >= 1 .Or. n_Mes <= 12

	a_Mes := {	"Janeiro",;
			    "Fevereiro",;
			    "Marco",;
			    "Abril",;
			    "Maio",;
			    "Junho",;
			    "Julho",;
		        "Agosto",;
		        "Setembro",;
		        "Outubro",;
		        "Novembro",;
		        "Dezembro"}
		        
	c_NomeMes := a_Mes[n_Mes]
	
Else

	c_NomeMes := "Nao Existe"
	
EndIf
              
Return c_NomeMes

//*************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ValidPerg | Autor ³ Claudio Dias JR     (Focus Consultoria) | Data ³ 21/06/18 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Responsável em criar o SX1.                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_Perg -> Grupo de perguntas a ser criado.                              		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI-Consulting                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function ValidPerg(c_Perg)

Local a_AreaATU := GetArea()
Local a_Regs 	:= {}
Local i,j

DbSelectArea("SX1")
DbSetOrder(1)

c_Perg := c_Perg + Replicate(" ", 10 - Len(c_Perg))
aAdd(a_Regs,{c_Perg,"01","Dt.NF Inclusao De             ","","","MV_CH1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(a_Regs,{c_Perg,"02","Dt.NF Inclusao Ate            ","","","MV_CH2","D",08,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(a_Regs,{c_Perg,"03","Fornecedor De               	","","","MV_CH3","C",06,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","SA2"})
aAdd(a_Regs,{c_Perg,"04","Loja De                       ","","","MV_CH4","C",02,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(a_Regs,{c_Perg,"05","Fornecedor Ate              	","","","MV_CH5","C",06,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","SA2"})
aAdd(a_Regs,{c_Perg,"06","Loja Ate                      ","","","MV_CH6","C",02,0,0,"G","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(a_Regs,{c_Perg,"07","Produto De                    ","","","MV_CH7","C",15,0,0,"G","","MV_PAR07","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
aAdd(a_Regs,{c_Perg,"08","Produto Ate                   ","","","MV_CH8","C",15,0,0,"G","","MV_PAR08","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
aAdd(a_Regs,{c_Perg,"09","C.Custo De                    ","","","MV_CH9","C",10,0,0,"G","","MV_PAR09","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
aAdd(a_Regs,{c_Perg,"10","C.Custo Ate                   ","","","MV_CHA","C",10,0,0,"G","","MV_PAR00","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
aAdd(a_Regs,{c_Perg,"11","Sair Cód USGAAP ?             ","","","MV_CHB","N",01,0,0,"C","","MV_PAR11","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(a_Regs,{c_Perg,"12","Sair Depto CC ?               ","","","MV_CHC","N",01,0,0,"C","","MV_PAR12","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(a_Regs,{c_Perg,"13","Extensão relatório ?          ","","","MV_CHD","N",01,0,0,"C","","MV_PAR13","XLS","","","","","CSV","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(a_Regs)
	If !DbSeek(c_Perg+a_Regs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(a_Regs[i])
				FieldPut(j,a_Regs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

RestArea(a_AreaATU)

Return Nil

//*************************************************************************************************************************//