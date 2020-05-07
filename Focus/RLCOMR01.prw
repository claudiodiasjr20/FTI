#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH"                           

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � RLCOMR01  | Autor � Claudio Dias JR     (Focus Consultoria) | Data � 06/05/20 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Relat�rio CHAMADO 46596                                                       ���
���          � FTI - NOVO Relat�rio de Inclus�o de Fornecedores (Log de Aprova��o).          ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� Parametros -> Nil                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Parametros -> Nil                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI-Consulting                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

User Function RLCOMR01()

Local   o_Dlg                 
Local   c_Perg	 	:= "RLCOMR01" 
Local   c_Titulo 	:= ""
Private c_Chr 		:= Chr(13)+Chr(10)
Private c_Versao 	:= "Vr.06/05/2020"

c_Titulo := "| FTI - LOG Fornecedores Inclus�o/Arpova��o/Altera��o | " + c_Versao + " | "

DEFINE MSDIALOG o_Dlg TITLE c_Titulo;
FROM 000,000 TO 300,390 PIXEL

@015,010 SAY   "Este programa tem como objetivo gerar relat�rio em .XLS ou .CSV	     "  OF o_Dlg PIXEL
@025,010 SAY   "A base das informa��es � apenas da tabela SA2                        "  OF o_Dlg PIXEL

@045,010 SAY   "IMPORTANTE                                                           "  OF o_Dlg PIXEL COLOR CLR_RED
@055,010 SAY   "Caso haja a necessidade de extrair um per�odo muito longo, verifique "  OF o_Dlg PIXEL
@065,010 SAY   "a op��o do par�metro 'Tipo relat�rio' e deixe o mesmo como 'CSV'     "  OF o_Dlg PIXEL
@085,010 SAY   "ID 46596 - Relat�rio de Inclus�o de Fornecedores (Log de Aprova��o). "  OF o_Dlg PIXEL COLOR CLR_RED

@115,025 BUTTON oBut1 PROMPT "&Sair"  		SIZE 44,12 OF o_Dlg PIXEl Action (n_Opcao := 0,o_Dlg:End())
@115,075 BUTTON oBut1 PROMPT "&Parametros"  SIZE 44,12 OF o_Dlg PIXEl Action (n_Opcao := 1,o_Dlg:End())
@115,125 BUTTON oBut1 PROMPT "&Exportar"  	SIZE 44,12 OF o_Dlg PIXEl Action (n_Opcao := 2,o_Dlg:End())
ACTIVATE MSDIALOG o_Dlg CENTERED

If n_Opcao == 1
	ValidPerg(c_Perg)
	Pergunte(c_Perg,.T.)
	U_RLCOMR01()
ElseIf n_Opcao == 2
	Pergunte(c_Perg,.F.)
	Processa({|lend| fProcess()},"Efetuando a sele��o dos dados... Por favor, aguarde.")
Else
	MsgStop("Exporta��o cancelada!","CANCELADO - RLCOMR01.PRW")
EndIf

Return Nil

//*************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fProcess  | Autor � Claudio Dias JR     (Focus Consultoria) | Data � 06/05/20 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Respons�vel buscar as informa��es que ser�o exibidas no relatorio             ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� Parametros -> Nil                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Parametros -> Nil                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI-Consulting                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fProcess()

Local   c_Query := ""
Private a_Meses	:= fGetMeses()
Private a_Dados	:= {}

c_Query := "SELECT    A2_COD CODIGO" + c_Chr
c_Query += "		, A2_LOJA LOJA " + c_Chr
c_Query += "		, A2_NOME NOME " + c_Chr
c_Query += "		, A2_NREDUZ NREDUZ " + c_Chr
c_Query += "		, A2_CGC CGC " + c_Chr
c_Query += "		, CASE WHEN(A2_MSBLQL='1') THEN ('Sim') ELSE('N�o') END AS SA2BLQ " + c_Chr
c_Query += "		, A2_XUSRINC USRINC " + c_Chr
c_Query += "		, A2_XDTINC DTINC " + c_Chr
c_Query += "		, A2_XHRINC HRINC " + c_Chr
c_Query += "		, A2_XUSRALT USRALT " + c_Chr
c_Query += "		, A2_XDTALT DTALT " + c_Chr
c_Query += "		, A2_XHRALT HRALT " + c_Chr
c_Query += "		, A2_XUSRAPR USRAPR " + c_Chr
c_Query += "		, A2_XDTAPR DTAPR " + c_Chr
c_Query += "		, A2_XHRAPR HRAPR " + c_Chr

c_Query += "FROM SA2050 SA2 " + c_Chr

c_Query += "WHERE SA2.D_E_L_E_T_ = '' " + c_Chr
c_Query += " AND   A2_COD		BETWEEN '" +MV_PAR01+ "' AND '" +MV_PAR03+ "'" + c_Chr
c_Query += " AND   A2_LOJA 		BETWEEN '" +MV_PAR02+ "' AND '" +MV_PAR04+ "'" + c_Chr
c_Query += " AND   A2_XDTINC 	BETWEEN '" +DTOS(MV_PAR05)+ "' AND '" +DTOS(MV_PAR06)+ "'" + c_Chr
c_Query += " AND   A2_XDTALT 	BETWEEN '" +DTOS(MV_PAR07)+ "' AND '" +DTOS(MV_PAR08)+ "'" + c_Chr
If !Empty(MV_PAR09)
	c_Query += " AND   A2_CGC = '" +MV_PAR09+ "'" + c_Chr
EndIf

c_Query += "ORDER BY A2_COD, A2_LOJA " + c_Chr

If Select("RLCOMR01") > 0
	RLCOMR01->(DbCloseArea())
EndIf

MemoWrite("RLCOMR01_Query",c_Query)
TCQUERY c_Query NEW ALIAS "RLCOMR01"

If RLCOMR01->(!Eof()) 

	While RLCOMR01->(!Eof())
			
		aAdd(a_Dados,{  RLCOMR01->CODIGO,;
						RLCOMR01->LOJA ,;
						RLCOMR01->NOME ,;
						RLCOMR01->NREDUZ ,;
						RLCOMR01->CGC ,;
						RLCOMR01->SA2BLQ ,;
						RLCOMR01->USRINC ,;
						DTOC(STOD(RLCOMR01->DTINC)) ,;
						RLCOMR01->HRINC ,;
						RLCOMR01->USRALT ,;
						DTOC(STOD(RLCOMR01->DTALT)) ,;
						RLCOMR01->HRALT ,;
						RLCOMR01->USRAPR ,;
						DTOC(STOD(RLCOMR01->DTAPR)) ,;
						RLCOMR01->HRAPR } )

		RLCOMR01->(DbSkip())
		
	EndDo

	ExpXLS(a_Dados)
	
Else

	MsgStop("N�o existe registros para extra��o, verifique os par�metros","A V I S O ! ! !")

EndIf

RLCOMR01->(DbCloseArea())

Return Nil

//*************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � ExpXLS    | Autor � Claudio Dias JR     (Focus Consultoria) | Data � 21/06/18 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Gera��o de relat�rio XLS                                                      ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� a_Dados -> Array com dados para impress�o                                     ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Parametros -> Nil                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI-Consulting                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function ExpXLS(a_Dados)
          
Local c_Dia 	:= STRTRAN(DTOC(MSDATE()),"/","_")+"_"+Replace(Time(),":","_")
Local c_Arq		:= ""
Local c_ExtArq 	:= ".xls"
Local c_Path 	:= "" 
Private c_Nome 	:= "RLCOMR01_" + c_Dia
Private oExcel	:= FWMSEXCEL():New() 

c_Path := cGetFile("\", "Selecione o Local para salvar a Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY)

If !ExistDir( c_Path )
	c_Path 	:= __RELDIR
EndIf
 
oExcel:SetTitleSizeFont	(13)		// Define o tamanho para a fonte do estilo do T�tulo
oExcel:SetTitleBold		(.T.)		// Define se a fonte ter� a configura��o "Negrito" no estilo do T�tulo 
oExcel:SetTitleFrColor	("#0000FF")	// Cor do Texto da Primeira Linha - T�tulo
oExcel:SetTitleBgColor	("#FFFFFF") // Cor de Fundo da Primeira Linha - T�tulo
oExcel:SetFrColorHeader	("#FFFFFF") // Texto do Titulo das Colunas
oExcel:SetBgColorHeader	("#4682B4") // Background do Titulo das Colunas
oExcel:SetLineBGColor	("#B8CCE4") // Background das linhas de texto
oExcel:Set2LineBGColor	("#DBE5F1")	// Background das linhas de texto 	

c_NomeSheet := "Parametros"
oExcel:AddworkSheet( c_NomeSheet )  
oExcel:AddTable ( c_NomeSheet , c_Nome)
oExcel:AddColumn( c_NomeSheet , c_Nome, "Parametro"		,1,1)
oExcel:AddColumn( c_NomeSheet , c_Nome, "Conte�do"		,1,1)

oExcel:AddRow( c_NomeSheet, c_Nome, { "Fornecedor De"		, MV_PAR01 		})
oExcel:AddRow( c_NomeSheet, c_Nome, { "Loja De"				, MV_PAR02 		})
oExcel:AddRow( c_NomeSheet, c_Nome, { "Fornecedor Ate"		, MV_PAR03 		})
oExcel:AddRow( c_NomeSheet, c_Nome, { "Loja Ate"			, MV_PAR04		 })
oExcel:AddRow( c_NomeSheet, c_Nome, { "DT.Inclusao De"		, DTOC(MV_PAR05) })
oExcel:AddRow( c_NomeSheet, c_Nome, { "DT.Inclusao Ate"		, DTOC(MV_PAR06) })
oExcel:AddRow( c_NomeSheet, c_Nome, { "DT.Alteracao De"		, DTOC(MV_PAR07) })
oExcel:AddRow( c_NomeSheet, c_Nome, { "DT.Alteracao Ate"	, DTOC(MV_PAR08) })
oExcel:AddRow( c_NomeSheet, c_Nome, { "CNPJ"				, MV_PAR09		 })
	
c_NomeSheet := "LOG_Fornecedor"
oExcel:AddworkSheet( c_NomeSheet )  
oExcel:AddTable ( c_NomeSheet , c_Nome)
oExcel:AddColumn( c_NomeSheet , c_Nome, "C�digo do Fornecedor",1,1)	 	// FORNECE
oExcel:AddColumn( c_NomeSheet , c_Nome, "Loja do Fornecedor",1,1) 		// LOJA 
oExcel:AddColumn( c_NomeSheet , c_Nome, "Nome do Fornecedor",1,1) 		// NOME
oExcel:AddColumn( c_NomeSheet , c_Nome, "Nome Reduzido",1,1)	 		// NREDUZ
oExcel:AddColumn( c_NomeSheet , c_Nome, "CNPJ",1,1)						// CGC
oExcel:AddColumn( c_NomeSheet , c_Nome, "Bloqueado?",1,1)				// SA2BLQ
oExcel:AddColumn( c_NomeSheet , c_Nome, "Usuario Inclus�o",1,1)			// USRINC
oExcel:AddColumn( c_NomeSheet , c_Nome, "DT.Inclus�o",1,1)				// DTINC
oExcel:AddColumn( c_NomeSheet , c_Nome, "HR.Inclus�o",1,1)				// HRINC

oExcel:AddColumn( c_NomeSheet , c_Nome, "Usuario Altera��o",1,1)		// USRALT
oExcel:AddColumn( c_NomeSheet , c_Nome, "DT.Altera��o",1,1)				// DTALT
oExcel:AddColumn( c_NomeSheet , c_Nome, "HR.Altera��o",1,1)				// HRALT

oExcel:AddColumn( c_NomeSheet , c_Nome, "Usuario Aprova��o",1,1)		// USRAPR
oExcel:AddColumn( c_NomeSheet , c_Nome, "DT.Aprova��o",1,1)				// DTAPR
oExcel:AddColumn( c_NomeSheet , c_Nome, "HR.Aprova��o",1,1)				// HRAPR

ProcRegua(Len(a_Dados))

For n_Item := 1 To Len(a_Dados)

		IncProc() 
												 		
		oExcel:AddRow( c_NomeSheet, c_Nome, { 	a_Dados[n_Item][01],;
												a_Dados[n_Item][02],;
												a_Dados[n_Item][03],;
												a_Dados[n_Item][04],;
												a_Dados[n_Item][05],;
												a_Dados[n_Item][06],;
												a_Dados[n_Item][07],;
												a_Dados[n_Item][08],;
												a_Dados[n_Item][09],;
												a_Dados[n_Item][10],;
												a_Dados[n_Item][11],;
												a_Dados[n_Item][12],;
												a_Dados[n_Item][13],;
												a_Dados[n_Item][14],;
												a_Dados[n_Item][15] })

Next n_Item
	
//--------------------------------------------------------------------------------------------------------------------------------------------------------//

c_Arq := c_Nome
oExcel:Activate()
oExcel:GetXMLFile(c_Arq+c_ExtArq)
                                        
//- Move Arquivo para Pasta Relato do Usu�rio
c_NovoArq := AllTrim(c_Path + c_Arq + c_ExtArq)           

If __CopyFile( c_Arq+c_ExtArq, c_NovoArq )
	MsgInfo( "Arquivo " + c_NovoArq + " gerado com sucesso no diret�rio " + c_Path, " A V I S O ! " )
Else
	MsgInfo( "Arquivo n�o copiado para tempor�rio do usu�rio." , " A V I S O ! " )
EndIf

Return Nil

//*************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � ValidPerg | Autor � Claudio Dias JR     (Focus Consultoria) | Data � 21/06/18 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Respons�vel em criar o SX1.                                                   ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� c_Perg -> Grupo de perguntas a ser criado.                              		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Parametros -> Nil                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI-Consulting                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function ValidPerg(c_Perg)

Local a_AreaATU := GetArea()
Local a_Regs 	:= {}
Local i,j

DbSelectArea("SX1")
DbSetOrder(1)

c_Perg := c_Perg + Replicate(" ", 10 - Len(c_Perg))
aAdd(a_Regs,{c_Perg,"01","Fornecedor De               	","","","MV_CH1","C",06,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","SA2"})
aAdd(a_Regs,{c_Perg,"02","Loja De                       ","","","MV_CH2","C",02,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(a_Regs,{c_Perg,"03","Fornecedor Ate              	","","","MV_CH3","C",06,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","SA2"})
aAdd(a_Regs,{c_Perg,"04","Loja Ate                      ","","","MV_CH4","C",02,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(a_Regs,{c_Perg,"05","DT.Inclusao De             	","","","MV_CH5","D",08,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(a_Regs,{c_Perg,"06","DT.Inclusao Ate            	","","","MV_CH6","D",08,0,0,"G","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(a_Regs,{c_Perg,"07","DT.Aprovacao De            	","","","MV_CH7","D",08,0,0,"G","","MV_PAR07","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(a_Regs,{c_Perg,"08","DT.Aprovacao Ate           	","","","MV_CH8","D",08,0,0,"G","","MV_PAR08","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(a_Regs,{c_Perg,"09","CNPJ			                ","","","MV_CH9","C",14,0,0,"G","","MV_PAR09","","","","","","","","","","","","","","","","","","","","","","","","",""})

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