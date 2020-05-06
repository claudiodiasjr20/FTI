#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fDePara    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Fun��o De->Para do cadastro de Cliente e Fornecedores, fa�o um depara para    ���
���          � o c�digo alterado, o c�digo antigo caso necess�rio ficar� armazenado nos      ���
���          � campos A1_XCODPAF/A1_XLJPAF e A2_XCODPAF/A2_XLJPAF.                           ���
���          � ------------------------------------------------------------------------------���
���          � Para alterar as tabelas abaixo foi feito um levantamento em TODAS as tabelas  ���
���          � que o sistema faz a altera��o pelo configurador via GRUPOS de campos.         ���
���          � Abaixo s� est�o as tabelas que possuem registros.                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI                                                                     		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

User Function fDePara()

Private c_Query 	:= ""
Private c_Chr 		:= Chr(13) + Chr(10)
Private a_RelDiver 	:= {}

// AGG - AGG_FORNEC / AGG_LOJA
If U_ExistTAB( RetSqlName("AGG") )
	MsgRun("Atualizando Tabelas (AGG), Por favor aguarde...","",{|| CursorWait(), fAtuAGG(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("AGG") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("AGG") + ";" + "N�o Existe" } )
EndIf

// AGH - AGH_FORNEC / AGH_LOJA
If U_ExistTAB( RetSqlName("AGH") )
	MsgRun("Atualizando Tabelas (AGH), Por favor aguarde...","",{|| CursorWait(), fAtuAGH(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("AGH") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("AGH") + ";" + "N�o Existe" } )
EndIf

// CF4 - CF4_CLIFOR	CF4_LOJA
If U_ExistTAB( RetSqlName("CF4") )
	MsgRun("Atualizando Tabelas (CF4), Por favor aguarde...","",{|| CursorWait(), fAtuCF4(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("CF4") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("CF4") + ";" + "N�o Existe" } )
EndIf

// FI8 - FI8_FORORI	FI8_LOJORI	FI8_FORDES	FI8_LOJDES
If U_ExistTAB( RetSqlName("FI8") )
	MsgRun("Atualizando Tabelas (FI8), Por favor aguarde...","",{|| CursorWait(), fAtuFI8(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("FI8") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("FI8") + ";" + "N�o Existe" } )
EndIf

// FI9 - FI9_FORNEC	FI9_LOJA
If U_ExistTAB( RetSqlName("FI9") )
	MsgRun("Atualizando Tabelas (FI9), Por favor aguarde...","",{|| CursorWait(), fAtuFI9(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("FI9") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("FI9") + ";" + "N�o Existe" } )
EndIf

// FIE - FIE_FORNEC	FIE_CLIENT	FIE_LOJA
If U_ExistTAB( RetSqlName("FIE") )
	MsgRun("Atualizando Tabelas (FIE), Por favor aguarde...","",{|| CursorWait(), fAtuFIE(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("FIE") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("FIE") + ";" + "N�o Existe" } )
EndIf

// FIL - FIL_FORNEC	FIL_LOJA
If U_ExistTAB( RetSqlName("FIL") )
	MsgRun("Atualizando Tabelas (FIL), Por favor aguarde...","",{|| CursorWait(), fAtuFIL(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("FIL") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("FIL") + ";" + "N�o Existe" } )
EndIf

// FR3 - FR3_FORNEC	FR3_CLIENT	FR3_LOJA
If U_ExistTAB( RetSqlName("FR3") )
	MsgRun("Atualizando Tabelas (FR3), Por favor aguarde...","",{|| CursorWait(), fAtuFR3(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("FR3") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("FR3") + ";" + "N�o Existe" } )
EndIf

// NNR - NNR_CODCLI	NNR_LOJCLI
If U_ExistTAB( RetSqlName("NNR") )
	MsgRun("Atualizando Tabelas (NNR), Por favor aguarde...","",{|| CursorWait(), fAtuNNR(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("NNR") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("NNR") + ";" + "N�o Existe" } )
EndIf

// SA6 - A6_CODFOR	A6_LOJFOR
If U_ExistTAB( RetSqlName("SA6") )
	MsgRun("Atualizando Tabelas (SA6), Por favor aguarde...","",{|| CursorWait(), fAtuSA6(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SA6") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SA6") + ";" + "N�o Existe" } )
EndIf

// SA7 - A7_CLIENTE	A7_LOJA
If U_ExistTAB( RetSqlName("SA7") )
	MsgRun("Atualizando Tabelas (SA7), Por favor aguarde...","",{|| CursorWait(), fAtuSA7(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SA7") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SA7") + ";" + "N�o Existe" } )
EndIf

// SB1 - B1_PROC	B1_LOJPROC
If U_ExistTAB( RetSqlName("SB1") )
	MsgRun("Atualizando Tabelas (SB1), Por favor aguarde...","",{|| CursorWait(), fAtuSB1(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SB1") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SB1") + ";" + "N�o Existe" } )
EndIf

// SC1 - C1_FABRICA	C1_LOJFABR	C1_FABRLOJ	C1_FORNECE	C1_LOJA
If U_ExistTAB( RetSqlName("SC1") )
	MsgRun("Atualizando Tabelas (SC1), Por favor aguarde...","",{|| CursorWait(), fAtuSC1(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SC1") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SC1") + ";" + "N�o Existe" } )
EndIf

// SDE - DE_FORNECE	DE_LOJA
If U_ExistTAB( RetSqlName("SDE") )
	MsgRun("Atualizando Tabelas (SDE), Por favor aguarde...","",{|| CursorWait(), fAtuSDE(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SDE") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SDE") + ";" + "N�o Existe" } )
EndIf

// SEA - EA_FORNECE	EA_LOJA
If U_ExistTAB( RetSqlName("SEA") )
	MsgRun("Atualizando Tabelas (SEA), Por favor aguarde...","",{|| CursorWait(), fAtuSEA(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SEA") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SEA") + ";" + "N�o Existe" } )
EndIf

// SET - ET_FORNECE	ET_LOJA
If U_ExistTAB( RetSqlName("SET") )
	MsgRun("Atualizando Tabelas (SET), Por favor aguarde...","",{|| CursorWait(), fAtuSET(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SET") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SET") + ";" + "N�o Existe" } )
EndIf

// SEU - EU_CLIENTE	EU_LOJACLI	EU_FORNECE	EU_LOJA
If U_ExistTAB( RetSqlName("SEU") )
	MsgRun("Atualizando Tabelas (SEU), Por favor aguarde...","",{|| CursorWait(), fAtuSEU(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SEU") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SEU") + ";" + "N�o Existe" } )
EndIf

// SEV - EV_CLIFOR	EV_LOJA
If U_ExistTAB( RetSqlName("SEV") )
	MsgRun("Atualizando Tabelas (SEV), Por favor aguarde...","",{|| CursorWait(), fAtuSEV(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SEV") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SEV") + ";" + "N�o Existe" } )
EndIf

// SEZ - EZ_CLIFOR	EZ_LOJA
If U_ExistTAB( RetSqlName("SEZ") )
	MsgRun("Atualizando Tabelas (SEZ), Por favor aguarde...","",{|| CursorWait(), fAtuSEZ(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SEZ") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SEZ") + ";" + "N�o Existe" } )
EndIf

// SFQ - FQ_CFDES	FQ_LOJADES	FQ_CFORI	FQ_LOJAORI
If U_ExistTAB( RetSqlName("SFQ") )
	MsgRun("Atualizando Tabelas (SFQ), Por favor aguarde...","",{|| CursorWait(), fAtuSFQ(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SFQ") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SFQ") + ";" + "N�o Existe" } )
EndIf

// SN1 - N1_FORNEC	N1_LOJA
If U_ExistTAB( RetSqlName("SN1") )
	MsgRun("Atualizando Tabelas (SN1), Por favor aguarde...","",{|| CursorWait(), fAtuSN1(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SN1") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SN1") + ";" + "N�o Existe" } )
EndIf

// CDH - CDH_FORTIT	CDH_LOJTIT
If U_ExistTAB( RetSqlName("CDH") )
	MsgRun("Atualizando Tabelas (CDH), Por favor aguarde...","",{|| CursorWait(), fAtuCDH(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("CDH") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("CDH") + ";" + "N�o Existe" } )
EndIf

// SB6 - B6_CLIFOR	B6_LOJA
If U_ExistTAB( RetSqlName("SB6") )
	MsgRun("Atualizando Tabelas (SB6), Por favor aguarde...","",{|| CursorWait(), fAtuSB6(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SB6") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SB6") + ";" + "N�o Existe" } )
EndIf

// SCH - CH_FORNECE	CH_LOJA
If U_ExistTAB( RetSqlName("SCH") )
	MsgRun("Atualizando Tabelas (SCH), Por favor aguarde...","",{|| CursorWait(), fAtuSCH(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SCH") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SCH") + ";" + "N�o Existe" } )
EndIf

// SC7 - PEDIDO DE COMPRAS - CAMPOS "C7_FORNECE","C7_LOJA"
If U_ExistTAB( RetSqlName("SC7") )
	MsgRun("Atualizando Tabelas (SC7), Por favor aguarde...","",{|| CursorWait(), fAtuSC7(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SC7") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SC7") + ";" + "N�o Existe" } )
EndIf

// SF1 - CABEC NF ENTRADA - CAMPOS "F1_FORNECE","F1_LOJA"
If U_ExistTAB( RetSqlName("SF1") )
	MsgRun("Atualizando Tabelas (SF1), Por favor aguarde...","",{|| CursorWait(), fAtuSF1(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SF1") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SF1") + ";" + "N�o Existe" } )
EndIf

// SD1 - ITENS NF ENTRADA - CAMPOS "D1_FORNECE","D1_LOJA"                   
If U_ExistTAB( RetSqlName("SD1") )
	MsgRun("Atualizando Tabelas (SD1), Por favor aguarde...","",{|| CursorWait(), fAtuSD1(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SD1") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SD1") + ";" + "N�o Existe" } )
EndIf

// SC5 - PEDIDO DE VENDA - CAMPOS "C5_CLIENTE","C5_LOJACLI","C5_CLIENT","C5_LOJAENT"
If U_ExistTAB( RetSqlName("SC5") )
	MsgRun("Atualizando Tabelas (SC5), Por favor aguarde...","",{|| CursorWait(), fAtuSC5(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SC5") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SC5") + ";" + "N�o Existe" } )
EndIf

// SC6 - ITENS DO PEDIDO DE VENDA - CAMPOS "C6_CLI","C6_LOJA"
If U_ExistTAB( RetSqlName("SC6") )
	MsgRun("Atualizando Tabelas (SC6), Por favor aguarde...","",{|| CursorWait(), fAtuSC6(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SC6") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SC6") + ";" + "N�o Existe" } )
EndIf

// SC9 - ITENS LIBERADOS DO PEDIDO DE VENDA - CAMPOS "C9_CLIENTE","C9_LOJA"
If U_ExistTAB( RetSqlName("SC9") )
	MsgRun("Atualizando Tabelas (SC9), Por favor aguarde...","",{|| CursorWait(), fAtuSC9(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SC9") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SC9") + ";" + "N�o Existe" } )
EndIf

// SCY - HISTORICO PEDIDO DE COMPRAS - CAMPOS "CY_FORNECE","CY_LOJA"         
If U_ExistTAB( RetSqlName("SCY") )
	MsgRun("Atualizando Tabelas (SCY), Por favor aguarde...","",{|| CursorWait(), fAtuSCY(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SCY") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SCY") + ";" + "N�o Existe" } )
EndIf

// SF2 - CABEC NF SA�DA - CAMPOS "F2_CLIENTE","F2_LOJA","F2_CLIENT","F2_LOJENT"
If U_ExistTAB( RetSqlName("SF2") )
	MsgRun("Atualizando Tabelas (SF2), Por favor aguarde...","",{|| CursorWait(), fAtuSF2(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SF2") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SF2") + ";" + "N�o Existe" } )
EndIf

// SD2 - ITENS NF SA�DA - CAMPOS "D2_CLIENTE","D2_LOJA"
If U_ExistTAB( RetSqlName("SD2") )
	MsgRun("Atualizando Tabelas (SD2), Por favor aguarde...","",{|| CursorWait(), fAtuSD2(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SD2") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SD2") + ";" + "N�o Existe" } )
EndIf

// CD2 - LIVRO DIGITAL DE IMPOSTOS-SPED - CAMPOS "CD2_CODCLI","CD2_LOJCLI","CD2_CODFOR","CD2_LOJFOR"
If U_ExistTAB( RetSqlName("CD2") )
	MsgRun("Atualizando Tabelas (CD2), Por favor aguarde...","",{|| CursorWait(), fAtuCD2(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("CD2") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("CD2") + ";" + "N�o Existe" } )
EndIf
 
// SF3 - CABEC LIVRO FISCAL - CAMPOS "F3_CLIENT","F3_LOJENT","F3_CLIEFOR","F3_LOJA"
If U_ExistTAB( RetSqlName("SF3") )
	MsgRun("Atualizando Tabelas (SF3), Por favor aguarde...","",{|| CursorWait(), fAtuSF3(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SF3") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SF3") + ";" + "N�o Existe" } )
EndIf
 
// SFT - ITENS LIVRO FISCAL - CAMPOS "FT_CLIENT","FT_LOJENT","FT_CLIEFOR","FT_LOJA"
If U_ExistTAB( RetSqlName("SFT") )
	MsgRun("Atualizando Tabelas (SFT), Por favor aguarde...","",{|| CursorWait(), fAtuSFT(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SFT") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SFT") + ";" + "N�o Existe" } )
EndIf

// SE2 - CONTAS A PAGAR - CAMPOS "E2_FORNECE","E2_LOJA"
If U_ExistTAB( RetSqlName("SE2") )
	MsgRun("Atualizando Tabelas (SE2), Por favor aguarde...","",{|| CursorWait(), fAtuSE2(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SE2") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SE2") + ";" + "N�o Existe" } )
EndIf

// SE1 - CONTAS A RECEBER - CAMPOS "E1_CLIENTE","E1_LOJA"                    
If U_ExistTAB( RetSqlName("SE1") )
	MsgRun("Atualizando Tabelas (SE1), Por favor aguarde...","",{|| CursorWait(), fAtuSE1(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SE1") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SE1") + ";" + "N�o Existe" } )
EndIf

// SE5 - MOVIMENTA��ES BANC�RIAS - CAMPOS  "E5_CLIENTE","E5_CLIFOR","E5_LOJA","E5_FORNADT","E5_LOJAADT"
If U_ExistTAB( RetSqlName("SE5") )
	MsgRun("Atualizando Tabelas (SE5), Por favor aguarde...","",{|| CursorWait(), fAtuSE5(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SE5") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SE5") + ";" + "N�o Existe" } )
EndIf

// SEF - CHEQUES - CAMPOS "EF_FORNECE","EF_LOJA"
If U_ExistTAB( RetSqlName("SEF") )
	MsgRun("Atualizando Tabelas (SEF), Por favor aguarde...","",{|| CursorWait(), fAtuSEF(), CursorArrow()})
	aAdd(a_RelDiver, { RetSqlName("SEF") + ";" + "Feito" } )
Else
	aAdd(a_RelDiver, { RetSqlName("SEF") + ";" + "N�o Existe" } )
EndIf

U_fCriaArq( a_RelDiver, "fDePara", "", ".csv" )

Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuAGG    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA AGG                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => AGG_FORNEC                                                          ���
���          �        => AGG_LOJA                                                            ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuAGG()

c_Query := "UPDATE "+RetSqlName("AGG")+" SET AGG_FORNEC = A1_COD, AGG_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("AGG")+" AGG " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA1 " + c_Chr
c_Query += "	ON  A1_FILIAL		= '' " + c_Chr
c_Query += "	AND A1_XCODPAF		= AGG_FORNEC " + c_Chr
c_Query += "	AND A1_XLJPAF		= AGG_LOJA " + c_Chr
c_Query += "	AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE AGG.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaAGG.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuAGH    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA AGH                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => AGH_FORNEC                                                          ���
���          �        => AGH_LOJA                                                            ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuAGH()

c_Query := "UPDATE "+RetSqlName("AGH")+" SET AGH_FORNEC = A1_COD, AGH_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("AGH")+" AGH " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "	ON  A1_FILIAL		= '' " + c_Chr
c_Query += "	AND A1_XCODPAF		= AGH_FORNEC " + c_Chr
c_Query += "	AND A1_XLJPAF		= AGH_LOJA " + c_Chr
c_Query += "	AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE AGH.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaAGH.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuCF4    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA CF4                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => CF4_CLIFOR                                                          ���
���          �        => CF4_LOJA                                                            ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuCF4()

c_Query := "UPDATE "+RetSqlName("CF4")+" SET CF4_CLIFOR = A1_COD, CF4_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("CF4")+" CF4 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "	ON  A1_XCODPAF 		= CF4_CLIFOR " + c_Chr
c_Query += "	AND A1_XLJPAF 		= CF4_LOJA " + c_Chr
c_Query += "	AND SA1.D_E_L_E_T_ 	= '' " + c_Chr

c_Query += "WHERE CF4.D_E_L_E_T_ = '' " + c_Chr

Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuFI8    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA FI8                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => FI8_FORORI                                                          ���
���          �        => FI8_LOJORI                                                          ���
���          �        => FI8_FORDES                                                          ���
���          �        => FI8_LOJDES                                                          ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuFI8()

c_Query := "UPDATE "+RetSqlName("FI8")+" SET FI8_FORORI = A2_COD, FI8_LOJORI = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("FI8")+" FI8 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= FI8_FORORI " + c_Chr
c_Query += "	AND A2_XLJPAF		= FI8_LOJORI " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE FI8.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaFI8A.SQL", c_Query)
TcSqlExec(c_Query)

//---------------------------

c_Query := "UPDATE "+RetSqlName("FI8")+" SET FI8_FORDES = A2_COD, FI8_LOJDES = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("FI8")+" FI8 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= FI8_FORDES " + c_Chr
c_Query += "	AND A2_XLJPAF		= FI8_LOJDES " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE FI8.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaFI8B.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuFI9    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA FI9                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => FI9_FORNEC                                                          ���
���          �        => FI9_LOJA                                                            ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuFI9()

c_Query := "UPDATE "+RetSqlName("FI9")+" SET FI9_FORNEC = A2_COD, FI9_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("FI9")+" FI9 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= FI9_FORNEC " + c_Chr
c_Query += "	AND A2_XLJPAF		= FI9_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE FI9.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaFI9.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil


/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuFIE    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA FIE                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => FIE_FORNEC                                                          ���
���          �        => FIE_CLIENT                                                            ���
���          �        => FIE_LOJA                                                            ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuFIE()

c_Query := "UPDATE "+RetSqlName("FIE")+" SET FIE_FORNEC = A2_COD, FIE_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("FIE")+" FIE " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= FIE_FORNEC " + c_Chr
c_Query += "	AND A2_XLJPAF		= FIE_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE FIE.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND FIE_CART = 'P'" + c_Chr

MemoWrite("fDeParaFIEa.SQL", c_Query)
TcSqlExec(c_Query)     

//-----------------------

c_Query := "UPDATE "+RetSqlName("FIE")+" SET FIE_CLIENT = A1_COD, FIE_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("FIE")+" FIE " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "	ON  A1_FILIAL		= '' " + c_Chr
c_Query += "	AND A1_XCODPAF		= FIE_CLIENT " + c_Chr
c_Query += "	AND A1_XLJPAF		= FIE_LOJA " + c_Chr
c_Query += "	AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE FIE.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND FIE_CART = 'R'" + c_Chr

MemoWrite("fDeParaFIEb.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil


//*********************************************************************************************************************************************************//


/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuFIL    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA FIL                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => FIL_FORNEC                                                          ���
���          �        => FIL_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuFIL()

c_Query := "UPDATE "+RetSqlName("FIL")+" SET FIL_FORNEC = A2_COD, FIL_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("FIL")+" FIL " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= FIL_FORNEC " + c_Chr
c_Query += "	AND A2_XLJPAF		= FIL_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE FIL.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaFIL.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil


//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuFR3    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA FR3                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => FR3_FORNEC                                                          ���
���          �        => FR3_CLIENT                                                          ���
���          �        => FR3_LOJA                                                            ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuFR3()

c_Query := "UPDATE "+RetSqlName("FR3")+" SET FR3_FORNEC = A2_COD, FR3_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("FR3")+" FR3 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= FR3_FORNEC " + c_Chr
c_Query += "	AND A2_XLJPAF		= FR3_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE FR3.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND FR3_CART = 'P'" + c_Chr

MemoWrite("fDeParaFR3a.SQL", c_Query)
TcSqlExec(c_Query)           

//--------------------

c_Query := "UPDATE "+RetSqlName("FR3")+" SET FR3_FORNEC = A1_COD, FR3_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("FR3")+" FR3 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "	ON  A1_FILIAL		= '' " + c_Chr
c_Query += "	AND A1_XCODPAF		= FR3_FORNEC " + c_Chr
c_Query += "	AND A1_XLJPAF		= FR3_LOJA " + c_Chr
c_Query += "	AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE FR3.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND FR3_CART = 'R'" + c_Chr

MemoWrite("fDeParaFR3b.SQL", c_Query)
TcSqlExec(c_Query)    
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuNNR    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA NNR                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => NNR_CODCLI                                                          ���
���          �        => NNR_LOJCLI                                                          ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
������������������������������������������
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuNNR()

c_Query := "UPDATE "+RetSqlName("NNR")+" SET NNR_CODCLI = A2_COD, NNR_LOJCLI = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("NNR")+" NNR " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= NNR_CODCLI " + c_Chr
c_Query += "	AND A2_XLJPAF		= NNR_LOJCLI " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE NNR.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaNNR.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSA6    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SA6                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => A6_CODFOR                                                          ���
���          �        => A6_LOJFOR                                                          ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSA6()

c_Query := "UPDATE "+RetSqlName("SA6")+" SET A6_CODFOR = A2_COD, A6_LOJFOR = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SA6")+" SA6 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= A6_CODFOR " + c_Chr
c_Query += "	AND A2_XLJPAF		= A6_LOJFOR " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SA6.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaSA6.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSA7    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SA7                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => A7_CLIENTE                                                          ���
���          �        => A7_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSA7()

c_Query := "UPDATE "+RetSqlName("SA7")+" SET A7_CLIENTE = A1_COD, A7_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SA7")+" SA7 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "	ON  A1_FILIAL		= '' " + c_Chr
c_Query += "	AND A1_XCODPAF		= A7_CLIENTE " + c_Chr
c_Query += "	AND A1_XLJPAF		= A7_LOJA " + c_Chr
c_Query += "	AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SA7.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaSA7.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//
/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSB1    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SB1                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => B1_PROC   	                                                         ���
���          �        => B1_LOJPROC                                                          ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSB1()

c_Query := "UPDATE "+RetSqlName("SB1")+" SET B1_PROC = A2_COD, B1_LOJPROC = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SB1")+" SB1 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= B1_PROC " + c_Chr
c_Query += "	AND A2_XLJPAF		= B1_LOJPROC " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SB1.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaSB1.SQL", c_Query)

TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSDE    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SC1                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => DE_FORNECE                                                          ���
���          �        => DE_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSDE()

c_Query := "UPDATE "+RetSqlName("SDE")+" SET DE_FORNECE = A2_COD, DE_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SDE")+" SDE " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= DE_FORNECE " + c_Chr
c_Query += "	AND A2_XLJPAF		= DE_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SDE.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaSDE.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//


/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSEA    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SEA                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => EA_FORNECE                                                          ���
���          �        => EA_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSEA()

c_Query := "UPDATE "+RetSqlName("SEA")+" SET EA_FORNECE = A2_COD, EA_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SEA")+" SEA " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= EA_FORNECE " + c_Chr
c_Query += "	AND A2_XLJPAF		= EA_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SEA.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaSEA.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSET    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SEA                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => ET_FORNECE                                                          ���
���          �        => ET_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSET()

c_Query := "UPDATE "+RetSqlName("SET")+" SET ET_FORNECE = A2_COD, ET_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SET")+" XSET " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= ET_FORNECE " + c_Chr
c_Query += "	AND A2_XLJPAF		= ET_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE XSET.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaSET.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSEU    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SEU                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => EU_FORNECE                                                          ���
���          �        => EU_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSEU()

c_Query := "UPDATE "+RetSqlName("SEU")+" SET EU_FORNECE = A2_COD, EU_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SEU")+" SEU " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= EU_FORNECE " + c_Chr
c_Query += "	AND A2_XLJPAF		= EU_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SEU.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaSEU.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSEV    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SEV                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => EV_CLIFOR                                                           ���
���          �        => EV_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSEV()

c_Query := "UPDATE "+RetSqlName("SEV")+" SET EV_CLIFOR = A2_COD, EV_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SEV")+" SEV " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= EV_CLIFOR " + c_Chr
c_Query += "	AND A2_XLJPAF		= EV_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SEV.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND EV_RECPAG = 'P' " + c_Chr

MemoWrite("fDeParaSEVA.SQL", c_Query)
TcSqlExec(c_Query)

//--------------------------------

c_Query := "UPDATE "+RetSqlName("SEV")+" SET EV_CLIFOR = A1_COD, EV_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SEV")+" SEV " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "	ON  A1_FILIAL		= '' " + c_Chr
c_Query += "	AND A1_XCODPAF		= EV_CLIFOR " + c_Chr
c_Query += "	AND A1_XLJPAF		= EV_LOJA " + c_Chr
c_Query += "	AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SEV.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND EV_RECPAG = 'R' " + c_Chr

MemoWrite("fDeParaSEVB.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSEZ    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SEZ                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => EZ_CLIFOR                                                           ���
���          �        => EZ_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSEZ()

c_Query := "UPDATE "+RetSqlName("SEZ")+" SET EZ_CLIFOR = A2_COD, EZ_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SEZ")+" SEZ " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= EZ_CLIFOR " + c_Chr
c_Query += "	AND A2_XLJPAF		= EZ_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SEZ.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND EZ_RECPAG = 'P' " + c_Chr

MemoWrite("fDeParaSEZA.SQL", c_Query)
TcSqlExec(c_Query)

//--------------------------------

c_Query := "UPDATE "+RetSqlName("SEZ")+" SET EZ_CLIFOR = A1_COD, EZ_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SEZ")+" SEZ " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "	ON  A1_FILIAL		= '' " + c_Chr
c_Query += "	AND A1_XCODPAF		= EZ_CLIFOR " + c_Chr
c_Query += "	AND A1_XLJPAF		= EZ_LOJA " + c_Chr
c_Query += "	AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SEZ.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND EZ_RECPAG = 'R' " + c_Chr

MemoWrite("fDeParaSEZB.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSN1    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SN1                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => N1_FORNEC                                                           ���
���          �        => N1_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSFQ()

c_Query := "UPDATE " + RetSqlName("SFQ") + " SET FQ_CFDES = A2_COD, FQ_LOJADES = A2_LOJA" + c_Chr
c_Query += "FROM " + RetSqlName("SFQ") + " SFQ " + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= FQ_CFDES " + c_Chr
c_Query += "	AND A2_XLJPAF		= FQ_LOJADES " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr

c_Query += "WHERE SFQ.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND FQ_ENTORI =  'SE2'" + c_Chr

c_Query += "WHERE SFQ.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaSFQa.SQL", c_Query)
TcSqlExec(c_Query)

c_Query := "UPDATE " + RetSqlName("SFQ") + " SET FQ_CFDES = A2_COD, FQ_LOJADES = A2_LOJA" + c_Chr
c_Query += "FROM " + RetSqlName("SFQ") + " SFQ " + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= FQ_CFDES " + c_Chr
c_Query += "	AND A2_XLJPAF		= FQ_LOJADES " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr

c_Query += "WHERE SFQ.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND FQ_ENTORI =  'SE2'" + c_Chr
c_Query += "AND FQ_TIPOORI IN ('PA','NCF','NDF')" + c_Chr

c_Query += "WHERE SFQ.D_E_L_E_T_ = '' " + c_Chr
	
MemoWrite("fDeParaSFQb.SQL", c_Query)
TcSqlExec(c_Query)

c_Query := "UPDATE " + RetSqlName("SFQ") + " SET FQ_CFDES = A1_COD, FQ_LOJADES = A1_LOJA " + c_Chr
c_Query += "FROM " + RetSqlName("SFQ") + " SFQ  " + c_Chr

c_Query += "	INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "	ON  A1_FILIAL		= ''  " + c_Chr
c_Query += "	AND A1_XCODPAF		= FQ_CFDES  " + c_Chr
c_Query += "	AND A1_XLJPAF		= FQ_LOJADES  " + c_Chr
c_Query += "	AND SA1.D_E_L_E_T_	= '' 

c_Query += "WHERE SFQ.D_E_L_E_T_ = ''  " + c_Chr
c_Query += "AND FQ_ENTORI =  'SE1' " + c_Chr

MemoWrite("fDeParaSFQc.SQL", c_Query)
TcSqlExec(c_Query)

c_Query := "UPDATE " + RetSqlName("SFQ") + " SET FQ_CFDES = A1_COD, FQ_LOJADES = A1_LOJA " + c_Chr
c_Query += "FROM " + RetSqlName("SFQ") + " SFQ  " + c_Chr

c_Query += "	INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "	ON  A1_FILIAL		= ''  " + c_Chr
c_Query += "	AND A1_XCODPAF		= FQ_CFDES  " + c_Chr
c_Query += "	AND A1_XLJPAF		= FQ_LOJADES  " + c_Chr
c_Query += "	AND SA1.D_E_L_E_T_	= '' 

c_Query += "WHERE SFQ.D_E_L_E_T_ = ''  " + c_Chr
c_Query += "AND FQ_ENTORI =  'SE1' " + c_Chr
c_Query += "AND FQ_TIPOORI IN ('RA','NCC','NDC') " + c_Chr

MemoWrite("fDeParaSFQd.SQL", c_Query)
TcSqlExec(c_Query)


Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSN1    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SN1                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => N1_FORNEC                                                           ���
���          �        => N1_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSN1()

c_Query := "UPDATE "+RetSqlName("SN1")+" SET N1_FORNEC = A2_COD, N1_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SN1")+" SN1 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= N1_FORNECE " + c_Chr
c_Query += "	AND A2_XLJPAF		= N1_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SN1.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaSN1.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuCDH    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA CDH                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => CDH_FORTIT                                                          ���
���          �        => CDH_LOJTIT                                                          ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuCDH()

c_Query := "UPDATE "+RetSqlName("CDH")+" SET CDH_FORTIT = A2_COD, CDH_LOJTIT = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("CDH")+" CDH " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= CDH_FORTIT " + c_Chr
c_Query += "	AND A2_XLJPAF		= CDH_LOJTIT " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE CDH.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaCDH.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSB6    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SB6                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => B6_CLIFOR                                                           ���
���          �        => B6_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSB6()

c_Query := "UPDATE "+RetSqlName("SB6")+" SET B6_CLIFOR = A2_COD, B6_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SB6")+" SB6 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= B6_CLIFOR " + c_Chr
c_Query += "	AND A2_XLJPAF		= B6_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SB6.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND B6_TIPO ='S' " + c_Chr

MemoWrite("fDeParaSB6a.SQL", c_Query)
TcSqlExec(c_Query)

//-------------------

c_Query := "UPDATE "+RetSqlName("SB6")+" SET B6_CLIFOR = A1_COD, B6_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SB6")+" SB6 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "	ON  A1_FILIAL		= '' " + c_Chr
c_Query += "	AND A1_XCODPAF		= B6_CLIFOR " + c_Chr
c_Query += "	AND A1_XLJPAF		= B6_LOJA " + c_Chr
c_Query += "	AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SB6.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND B6_TIPO ='E' " + c_Chr

MemoWrite("fDeParaSB6b.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuCDH    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA CDH                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => CH_FORNECE                                                          ���
���          �        => CH_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSCH()

c_Query := "UPDATE "+RetSqlName("SCH")+" SET CH_FORNECE = A2_COD, CH_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SCH")+" SCH " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= CH_FORNECE " + c_Chr
c_Query += "	AND A2_XLJPAF		= CH_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SCH.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaSCH.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSC1    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SC1                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => C1_FORNECE                                                          ���
���          �        => C1_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSC1()

c_Query := "UPDATE "+RetSqlName("SC1")+" SET C1_FORNECE = A2_COD, C1_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SC1")+" SC1 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= C1_FORNECE " + c_Chr
c_Query += "	AND A2_XLJPAF		= C1_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SC1.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaSC1.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//


/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSC7    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SC7                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => C7_FORNECE                                                          ���
���          �        => C7_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSC7()

c_Query := "UPDATE "+RetSqlName("SC7")+" SET C7_FORNECE = A2_COD, C7_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SC7")+" SC7 " + c_Chr + c_Chr

c_Query += "	INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "	ON  A2_FILIAL		= '' " + c_Chr
c_Query += "	AND A2_XCODPAF		= C7_FORNECE " + c_Chr
c_Query += "	AND A2_XLJPAF		= C7_LOJA " + c_Chr
c_Query += "	AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SC7.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaSC7.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSF1    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SF1                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => F1_FORNECE                                                          ���
���          �        => F1_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSF1()

c_Query := "UPDATE "+RetSqlName("SF1")+" SET F1_FORNECE = A1_COD, F1_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SF1")+" SF1 " + c_Chr + c_Chr

c_Query += "INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "ON  A1_FILIAL		= '' " + c_Chr
c_Query += "AND A1_XCODPAF		= F1_FORNECE " + c_Chr
c_Query += "AND A1_XLJPAF		= F1_LOJA " + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SF1.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND F1_TIPO IN ('D','B') " + c_Chr

MemoWrite("fDeParaSF1_A.SQL", c_Query)
TcSqlExec(c_Query)      

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SF1")+"  SET F1_FORNECE = A2_COD, F1_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SF1")+" SF1 " + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "ON  A2_FILIAL		= '' " + c_Chr
c_Query += "AND A2_XCODPAF		= F1_FORNECE " + c_Chr
c_Query += "AND A2_XLJPAF		= F1_LOJA " + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SF1.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND F1_TIPO NOT IN ('D','B') " + c_Chr

MemoWrite("fDeParaSF1_B.SQL", c_Query)
TcSqlExec(c_Query)

Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSD1    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SD1                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => D1_FORNECE                                                          ���
���          �        => D1_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSD1()

c_Query := "UPDATE "+RetSqlName("SD1")+" SET D1_FORNECE = A1_COD, D1_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SD1")+" SD1 " + c_Chr + c_Chr

c_Query += "INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "ON  A1_FILIAL		= '' " + c_Chr
c_Query += "AND A1_XCODPAF		= D1_FORNECE " + c_Chr
c_Query += "AND A1_XLJPAF		= D1_LOJA " + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SD1.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND D1_TIPO IN ('D','B') " + c_Chr

MemoWrite("fDeParaSD1_A.SQL", c_Query)
TcSqlExec(c_Query)      
                  
//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SD1")+"  SET D1_FORNECE = A2_COD, D1_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SD1")+" SD1 " + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "ON  A2_FILIAL		= '' " + c_Chr
c_Query += "AND A2_XCODPAF		= D1_FORNECE " + c_Chr
c_Query += "AND A2_XLJPAF		= D1_LOJA " + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SD1.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND D1_TIPO NOT IN ('D','B') " + c_Chr

MemoWrite("fDeParaSD1_B.SQL", c_Query)
TcSqlExec(c_Query)      

Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSC5    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SC5                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => C5_CLIENTE                                                          ���
���          �        => C5_LOJACLI                                                          ���
���          �        => C5_CLIENT                                                           ���
���          �        => C5_LOJAENT                                                          ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSC5()

c_Query := "UPDATE "+RetSqlName("SC5")+" SET C5_CLIENTE = A2_COD, C5_LOJACLI = A2_LOJA, C5_CLIENT = A2_COD, C5_LOJAENT = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SC5")+" SC5 " + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "ON  A2_FILIAL 		= '' " + c_Chr
c_Query += "AND A2_XCODPAF		= C5_CLIENTE " + c_Chr
c_Query += "AND A2_XLJPAF		= C5_LOJACLI " + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= '' " + c_Chr

c_Query += "WHERE SC5.D_E_L_E_T_ = '' " + c_Chr + c_Chr
c_Query += "AND C5_TIPO IN ('D','B') " + c_Chr

MemoWrite("fDeParaSC5_A.SQL", c_Query)
TcSqlExec(c_Query)   
                  
//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SC5")+" SET C5_CLIENTE = A1_COD, C5_LOJACLI = A1_LOJA, C5_CLIENT = A1_COD, C5_LOJAENT = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SC5")+" SC5 " + c_Chr + c_Chr

c_Query += "INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "ON  A1_FILIAL 		= '' " + c_Chr
c_Query += "AND A1_XCODPAF		= C5_CLIENTE " + c_Chr
c_Query += "AND A1_XLJPAF		= C5_LOJACLI " + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SC5.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND C5_TIPO NOT IN ('D','B') " + c_Chr

MemoWrite("fDeParaSC5_B.SQL", c_Query)
TcSqlExec(c_Query)   

Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSC6    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SC6                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => C6_CLI                                                              ���
���          �        => C6_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSC6()

c_Query := "UPDATE "+RetSqlName("SC6")+" SET C6_CLI = A2_COD, C6_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SC5")+" SC5 " + c_Chr + c_Chr

c_Query += "INNER JOIN "+RetSqlName("SC6")+" SC6 " + c_Chr
c_Query += "ON  C6_FILIAL		= C5_FILIAL " + c_Chr
c_Query += "AND C6_NUM			= C5_NUM " + c_Chr
c_Query += "AND SC6.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "ON  A2_XCODPAF		= C6_CLI " + c_Chr
c_Query += "AND A2_XLJPAF		= C6_LOJA " + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SC5.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND C5_TIPO IN ('D','B') " + c_Chr

MemoWrite("fDeParaSC6_A.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//   

c_Query := "UPDATE "+RetSqlName("SC6")+" SET C6_CLI = A1_COD, C6_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SC5")+" SC5 " + c_Chr + c_Chr

c_Query += "INNER JOIN "+RetSqlName("SC6")+" SC6 " + c_Chr
c_Query += "ON  C6_FILIAL		= C5_FILIAL " + c_Chr
c_Query += "AND C6_NUM			= C5_NUM " + c_Chr
c_Query += "AND SC6.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "ON  A1_XCODPAF		= C6_CLI " + c_Chr
c_Query += "AND A1_XLJPAF		= C6_LOJA " + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SC5.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND C5_TIPO NOT IN ('D','B') " + c_Chr

MemoWrite("fDeParaSC6_B.SQL", c_Query)
TcSqlExec(c_Query)   

Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSC9    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SC9                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => C9_CLIENTE                                                          ���
���          �        => C9_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSC9()

c_Query := "UPDATE "+RetSqlName("SC9")+" SET C9_CLIENTE = A2_COD, C9_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SC5")+" SC5 " + c_Chr + c_Chr

c_Query += "INNER JOIN "+RetSqlName("SC9")+" SC9 " + c_Chr
c_Query += "ON  C9_FILIAL		= C5_FILIAL " + c_Chr
c_Query += "AND C9_PEDIDO		= C5_NUM " + c_Chr
c_Query += "AND SC9.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "ON  A2_XCODPAF		= C9_CLIENTE " + c_Chr
c_Query += "AND A2_XLJPAF		= C9_LOJA " + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SC5.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND C5_TIPO IN ('D','B') " + c_Chr

MemoWrite("fDeParaSC9_A.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//   

c_Query := "UPDATE "+RetSqlName("SC9")+" SET C9_CLIENTE = A1_COD, C9_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SC5")+" SC5 " + c_Chr + c_Chr

c_Query += "INNER JOIN "+RetSqlName("SC9")+" SC9 " + c_Chr
c_Query += "ON  C9_FILIAL		= C5_FILIAL " + c_Chr
c_Query += "AND C9_PEDIDO		= C5_NUM " + c_Chr
c_Query += "AND SC9.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "ON  A1_XCODPAF		= C9_CLIENTE " + c_Chr
c_Query += "AND A1_XLJPAF		= C9_LOJA " + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SC5.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND C5_TIPO NOT IN ('D','B') " + c_Chr

MemoWrite("fDeParaSC9_B.SQL", c_Query)
TcSqlExec(c_Query)   

Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSCY    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SCY                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => CY_FORNECE                                                          ���
���          �        => CY_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSCY()

c_Query := "UPDATE "+RetSqlName("SCY")+" SET CY_FORNECE = A2_COD, CY_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SCY")+" SCY " + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "ON  A2_FILIAL		= '' " + c_Chr
c_Query += "AND A2_XCODPAF		= CY_FORNECE " + c_Chr
c_Query += "AND A2_XLJPAF		= CY_LOJA " + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SCY.D_E_L_E_T_ = '' " + c_Chr

MemoWrite("fDeParaSCY.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSF2    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SF2                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => F2_CLIENTE                                                          ���
���          �        => F2_LOJA                                                             ���
���          �        => F2_CLIENT                                                           ���
���          �        => F2_LOJENT                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSF2()

c_Query := "UPDATE "+RetSqlName("SF2")+" SET F2_CLIENTE = A2_COD, F2_LOJA = A2_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SF2")+" SF2 " + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "ON  A2_FILIAL		= '' " + c_Chr
c_Query += "AND A2_XCODPAF		= F2_CLIENTE " + c_Chr
c_Query += "AND A2_XLJPAF		= F2_LOJA " + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SF2.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND F2_TIPO IN ('D','B') " + c_Chr

MemoWrite("fDeParaSF2_A1.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SF2")+" SET F2_CLIENT = A2_COD, F2_LOJENT = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SF2")+" SF2 " + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "ON  A2_FILIAL		= '' " + c_Chr
c_Query += "AND A2_XCODPAF		= F2_CLIENT " + c_Chr
c_Query += "AND A2_XLJPAF		= F2_LOJENT " + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SF2.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND F2_TIPO IN ('D','B') " + c_Chr

MemoWrite("fDeParaSF2_A2.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SF2")+" SET F2_CLIENTE = A1_COD, F2_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SF2")+" SF2 " + c_Chr + c_Chr

c_Query += "INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "ON  A1_FILIAL		= '' " + c_Chr
c_Query += "AND A1_XCODPAF		= F2_CLIENTE " + c_Chr
c_Query += "AND A1_XLJPAF		= F2_LOJA " + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SF2.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND F2_TIPO NOT IN ('D','B') " + c_Chr

MemoWrite("fDeParaSF2_B1.SQL", c_Query)
TcSqlExec(c_Query)
	                   
//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SF2")+" SET F2_CLIENT = A1_COD, F2_LOJENT = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SF2")+" SF2 " + c_Chr + c_Chr

c_Query += "INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "ON  A1_FILIAL		= '' " + c_Chr
c_Query += "AND A1_XCODPAF		= F2_CLIENT " + c_Chr
c_Query += "AND A1_XLJPAF		= F2_LOJENT " + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SF2.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND F2_TIPO NOT IN ('D','B') " + c_Chr

MemoWrite("fDeParaSF2_B2.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSD2    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SD2                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => D2_CLIENTE                                                          ���
���          �        => D2_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSD2()

c_Query := "UPDATE "+RetSqlName("SD2")+" SET D2_CLIENTE = A2_COD, D2_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SD2")+" SD2 " + c_Chr + c_Chr

c_Query += "INNER JOIN "+RetSqlName("SF2")+" SF2 " + c_Chr
c_Query += "ON  D2_FILIAL		= F2_FILIAL " + c_Chr
c_Query += "AND D2_DOC			= F2_DOC " + c_Chr
c_Query += "AND D2_SERIE		= F2_SERIE " + c_Chr
c_Query += "AND SF2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "ON  A2_FILIAL		= '' " + c_Chr
c_Query += "AND A2_XCODPAF		= D2_CLIENTE " + c_Chr
c_Query += "AND A2_XLJPAF		= D2_LOJA " + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SD2.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND F2_TIPO IN ('D','B') " + c_Chr

MemoWrite("fDeParaSD2_A.SQL", c_Query)
TcSqlExec(c_Query)                                                                                  

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SD2")+" SET D2_CLIENTE = A1_COD, D2_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SD2")+" SD2 " + c_Chr + c_Chr

c_Query += "INNER JOIN "+RetSqlName("SF2")+" SF2 " + c_Chr
c_Query += "ON  D2_FILIAL		= F2_FILIAL " + c_Chr
c_Query += "AND D2_DOC			= F2_DOC " + c_Chr
c_Query += "AND D2_SERIE		= F2_SERIE " + c_Chr
c_Query += "AND SF2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "ON  A1_FILIAL		= '' " + c_Chr
c_Query += "AND A1_XCODPAF		= D2_CLIENTE " + c_Chr
c_Query += "AND A1_XLJPAF		= D2_LOJA " + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE SD2.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND F2_TIPO NOT IN ('D','B') " + c_Chr

MemoWrite("fDeParaSD2_B.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuCD2    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA CD2                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => CD2_CODCLI                                                          ���
���          �        => CD2_LOJCLI                                                          ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuCD2()

c_Query := "UPDATE "+RetSqlName("CD2")+" SET CD2_CODCLI = A1_COD, CD2_LOJCLI = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("CD2")+" CD2" + c_Chr + c_Chr

c_Query += "INNER JOIN SA1050 SA1 " + c_Chr
c_Query += "ON  A1_FILIAL		= '' " + c_Chr
c_Query += "AND A1_XCODPAF		= CD2_CODCLI " + c_Chr
c_Query += "AND A1_XLJPAF		= CD2_LOJCLI " + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE CD2.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND CD2_CODFOR = '' " + c_Chr
c_Query += "AND CD2_LOJFOR = '' " + c_Chr

MemoWrite("fDeParaCD2_A.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("CD2")+" SET CD2_CODFOR = A2_COD, CD2_LOJFOR = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("CD2")+" CD2" + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2 " + c_Chr
c_Query += "ON  A2_FILIAL		= '' " + c_Chr
c_Query += "AND A2_XCODPAF		= CD2_CODFOR " + c_Chr
c_Query += "AND A2_XLJPAF		= CD2_LOJFOR " + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= '' " + c_Chr + c_Chr

c_Query += "WHERE CD2.D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND CD2_CODCLI = '' " + c_Chr
c_Query += "AND CD2_LOJCLI = '' " + c_Chr + c_Chr

MemoWrite("fDeParaCD2_B.SQL", c_Query)
TcSqlExec(c_Query)
	
Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSF3    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SD2                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => F3_CLIENT                                                           ���
���          �        => F3_LOJENT                                                           ���
���          �        => F3_CLIEFOR                                                          ���
���          �        => F3_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSF3()

c_Query := "UPDATE "+RetSqlName("SF3")+" SET F3_CLIENT = A2_COD, F3_LOJENT = A2_LOJA, F3_CLIEFOR = A2_COD, F3_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SF3")+" SF3" + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2" + c_Chr
c_Query += "ON  A2_FILIAL		= ''" + c_Chr
c_Query += "AND A2_XCODPAF		= F3_CLIEFOR" + c_Chr
c_Query += "AND A2_XLJPAF		= F3_LOJA" + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= ''" + c_Chr + c_Chr

c_Query += "WHERE SF3.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND LEFT(F3_CFO,1) > '4'" + c_Chr
c_Query += "AND F3_TIPO IN ('D','B')" + c_Chr

MemoWrite("fDeParaSF3_A.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SF3")+" SET F3_CLIENT = A1_COD, F3_LOJENT = A1_LOJA, F3_CLIEFOR = A1_COD, F3_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SF3")+" SF3" + c_Chr + c_Chr

c_Query += "INNER JOIN SA1050 SA1" + c_Chr
c_Query += "ON  A1_FILIAL		= ''" + c_Chr
c_Query += "AND A1_XCODPAF		= F3_CLIEFOR" + c_Chr
c_Query += "AND A1_XLJPAF		= F3_LOJA" + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= ''" + c_Chr + c_Chr

c_Query += "WHERE SF3.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND LEFT(F3_CFO,1) > '4'" + c_Chr
c_Query += "AND F3_TIPO NOT IN ('D','B')" + c_Chr

MemoWrite("fDeParaSF3_B.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//
	
c_Query := "UPDATE "+RetSqlName("SF3")+" SET F3_CLIENT = A1_COD, F3_LOJENT = A1_LOJA, F3_CLIEFOR = A1_COD, F3_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SF3")+" SF3" + c_Chr + c_Chr

c_Query += "INNER JOIN SA1050 SA1" + c_Chr
c_Query += "ON  A1_FILIAL		= ''" + c_Chr
c_Query += "AND A1_XCODPAF		= F3_CLIEFOR" + c_Chr
c_Query += "AND A1_XLJPAF		= F3_LOJA" + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= ''" + c_Chr + c_Chr

c_Query += "WHERE SF3.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND LEFT(F3_CFO,1) < '4'" + c_Chr
c_Query += "AND F3_TIPO IN ('D','B')" + c_Chr

MemoWrite("fDeParaSF3_C.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SF3")+" SET F3_CLIENT = A2_COD, F3_LOJENT = A2_LOJA, F3_CLIEFOR = A2_COD, F3_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SF3")+" SF3" + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2" + c_Chr
c_Query += "ON  A2_FILIAL		= ''" + c_Chr
c_Query += "AND A2_XCODPAF		= F3_CLIEFOR" + c_Chr
c_Query += "AND A2_XLJPAF		= F3_LOJA" + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= ''" + c_Chr + c_Chr

c_Query += "WHERE SF3.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND LEFT(F3_CFO,1) < '4'" + c_Chr
c_Query += "AND F3_TIPO NOT IN ('D','B')" + c_Chr

MemoWrite("fDeParaSF3_D.SQL", c_Query)
TcSqlExec(c_Query)

Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSFT    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SFT                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => FT_CLIENT                                                           ���
���          �        => FT_LOJENT                                                           ���
���          �        => FT_CLIEFOR                                                          ���
���          �        => FT_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSFT()

c_Query := "UPDATE "+RetSqlName("SFT")+" SET FT_CLIENT = A1_COD, FT_LOJENT = A1_LOJA, FT_CLIEFOR = A1_COD, FT_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SFT")+" SFT" + c_Chr + c_Chr

c_Query += "INNER JOIN "+RetSqlName("SF3")+" SF3" + c_Chr
c_Query += "ON  FT_FILIAL		= F3_FILIAL" + c_Chr
c_Query += "AND FT_SERIE		= F3_SERIE" + c_Chr
c_Query += "AND FT_NFISCAL		= F3_NFISCAL" + c_Chr
c_Query += "AND SF3.D_E_L_E_T_	= ''" + c_Chr + c_Chr
		
c_Query += "INNER JOIN SA1050 SA1" + c_Chr
c_Query += "ON  A1_FILIAL		= ''" + c_Chr
c_Query += "AND A1_XCODPAF		= FT_CLIEFOR" + c_Chr
c_Query += "AND A1_XLJPAF		= FT_LOJA" + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= ''" + c_Chr + c_Chr

c_Query += "WHERE SFT.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND LEFT(F3_CFO,1) > '4'" + c_Chr
c_Query += "AND F3_TIPO NOT IN ('D','B')" + c_Chr

MemoWrite("fDeParaSFT_A.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SFT")+" SET FT_CLIENT = A2_COD, FT_LOJENT = A2_LOJA, FT_CLIEFOR = A2_COD, FT_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SFT")+" SFT" + c_Chr + c_Chr

c_Query += "INNER JOIN "+RetSqlName("SF3")+" SF3" + c_Chr
c_Query += "ON  FT_FILIAL		= F3_FILIAL" + c_Chr
c_Query += "AND FT_SERIE		= F3_SERIE" + c_Chr
c_Query += "AND FT_NFISCAL		= F3_NFISCAL" + c_Chr
c_Query += "AND SF3.D_E_L_E_T_	= ''" + c_Chr + c_Chr
		
c_Query += "INNER JOIN SA2050 SA2" + c_Chr
c_Query += "ON  A2_FILIAL		= ''" + c_Chr
c_Query += "AND A2_XCODPAF		= FT_CLIEFOR" + c_Chr
c_Query += "AND A2_XLJPAF		= FT_LOJA" + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= ''" + c_Chr + c_Chr

c_Query += "WHERE SFT.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND LEFT(F3_CFO,1) > '4'" + c_Chr
c_Query += "AND F3_TIPO IN ('D','B')" + c_Chr

MemoWrite("fDeParaSFT_B.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SFT")+" SET FT_CLIENT = A2_COD, FT_LOJENT = A2_LOJA, FT_CLIEFOR = A2_COD, FT_LOJA = A2_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SFT")+" SFT" + c_Chr + c_Chr

c_Query += "INNER JOIN "+RetSqlName("SF3")+" SF3" + c_Chr
c_Query += "ON  FT_FILIAL		= F3_FILIAL" + c_Chr
c_Query += "AND FT_SERIE		= F3_SERIE" + c_Chr
c_Query += "AND FT_NFISCAL		= F3_NFISCAL" + c_Chr
c_Query += "AND SF3.D_E_L_E_T_	= ''" + c_Chr + c_Chr
		
c_Query += "INNER JOIN SA2050 SA2" + c_Chr
c_Query += "ON  A2_FILIAL		= ''" + c_Chr
c_Query += "AND A2_XCODPAF		= FT_CLIEFOR" + c_Chr
c_Query += "AND A2_XLJPAF		= FT_LOJA" + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= ''" + c_Chr + c_Chr

c_Query += "WHERE SFT.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND LEFT(F3_CFO,1) < '4'" + c_Chr
c_Query += "AND F3_TIPO NOT IN ('D','B')" + c_Chr

MemoWrite("fDeParaSFT_C.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//
                         
c_Query := "UPDATE "+RetSqlName("SFT")+" SET FT_CLIENT = A1_COD, FT_LOJENT = A1_LOJA, FT_CLIEFOR = A1_COD, FT_LOJA = A1_LOJA " + c_Chr
c_Query += "FROM "+RetSqlName("SFT")+" SFT" + c_Chr + c_Chr

c_Query += "INNER JOIN "+RetSqlName("SF3")+" SF3" + c_Chr
c_Query += "ON  FT_FILIAL		= F3_FILIAL" + c_Chr
c_Query += "AND FT_SERIE		= F3_SERIE" + c_Chr
c_Query += "AND FT_NFISCAL		= F3_NFISCAL" + c_Chr
c_Query += "AND SF3.D_E_L_E_T_	= ''" + c_Chr + c_Chr
		
c_Query += "INNER JOIN SA1050 SA1" + c_Chr
c_Query += "ON  A1_FILIAL		= ''" + c_Chr
c_Query += "AND A1_XCODPAF		= FT_CLIEFOR" + c_Chr
c_Query += "AND A1_XLJPAF		= FT_LOJA" + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= ''" + c_Chr + c_Chr

c_Query += "WHERE SFT.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND LEFT(F3_CFO,1) < '4'" + c_Chr
c_Query += "AND F3_TIPO IN ('D','B')" + c_Chr

MemoWrite("fDeParaSFT_D.SQL", c_Query)
TcSqlExec(c_Query)

Return Nil

//*********************************************************************************************************************************************************//
                                                    
/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSE2    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SE2                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => E2_FORNEC                                                           ���
���          �        => E2_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSE2()

c_Query := "UPDATE "+RetSqlName("SE2")+" SET E2_FORNECE = A2_COD ,E2_LOJA = A2_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE2")+" SE2" + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2" + c_Chr
c_Query += "ON  A2_FILIAL		= ''" + c_Chr
c_Query += "AND A2_XCODPAF		= E2_FORNECE" + c_Chr
c_Query += "AND A2_XLJPAF		= E2_LOJA" + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= ''" + c_Chr + c_Chr

c_Query += "WHERE SE2.D_E_L_E_T_ = ''" + c_Chr

MemoWrite("fDeParaSE2.SQL", c_Query)
TcSqlExec(c_Query)

Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSE1    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SE1                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => E1_CLIENTE                                                          ���
���          �        => E1_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSE1()

c_Query := "UPDATE "+RetSqlName("SE1")+" SET E1_CLIENTE = A1_COD ,E1_LOJA = A1_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE1")+" SE1" + c_Chr + c_Chr

c_Query += "INNER JOIN SA1050 SA1" + c_Chr
c_Query += "ON  A1_FILIAL		= ''" + c_Chr
c_Query += "AND A1_XCODPAF		= E1_CLIENTE" + c_Chr
c_Query += "AND A1_XLJPAF		= E1_LOJA" + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= ''" + c_Chr + c_Chr

c_Query += "WHERE SE1.D_E_L_E_T_ = ''" + c_Chr

MemoWrite("fDeParaSE1.SQL", c_Query)
TcSqlExec(c_Query)

Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSE5    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SE1                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => E5_CLIENTE                                                          ���
���          �        => E5_CLIFOR                                                           ���
���          �        => E5_LOJA                                                             ���
���          �        => E5_FORNADT                                                          ���
���          �        => E5_LOJAADT                                                          ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSE5()

c_Query := "UPDATE "+RetSqlName("SE5")+" SET E5_FORNECE = A2_COD, E5_CLIFOR = A2_COD, E5_LOJA = A2_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE5")+" SE5" + c_Chr

c_Query += "INNER JOIN SA2050 SA2" + c_Chr
c_Query += "ON  A2_FILIAL		=''" + c_Chr
c_Query += "AND A2_XCODPAF		= E5_FORNECE" + c_Chr
c_Query += "AND A2_XLJPAF		= E5_LOJA" + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= ''" + c_Chr

c_Query += "WHERE SE5.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND E5_FORNECE <> ''" + c_Chr
c_Query += "AND E5_RECPAG = 'R' AND E5_TIPODOC = 'ES'" + c_Chr

MemoWrite("fDeParaSE5_A.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SE5")+" SET E5_FORNECE = A2_COD, E5_CLIFOR = A2_COD, E5_LOJA = A2_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE5")+" SE5" + c_Chr

c_Query += "INNER JOIN SA2050 SA2" + c_Chr
c_Query += "ON  A2_FILIAL		=''" + c_Chr
c_Query += "AND A2_XCODPAF		= E5_FORNECE" + c_Chr
c_Query += "AND A2_XLJPAF		= E5_LOJA" + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= ''" + c_Chr

c_Query += "WHERE SE5.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND E5_FORNECE <> ''" + c_Chr
c_Query += "AND E5_TIPO IN ('PA','NCF','NDF')" + c_Chr

MemoWrite("fDeParaSE5_B.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SE5")+" SET E5_FORNECE = A2_COD, E5_CLIFOR = A2_COD, E5_LOJA = A2_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE5")+" SE5" + c_Chr

c_Query += "INNER JOIN SA2050 SA2" + c_Chr
c_Query += "ON  A2_FILIAL		=''" + c_Chr
c_Query += "AND A2_XCODPAF		= E5_FORNECE" + c_Chr
c_Query += "AND A2_XLJPAF		= E5_LOJA" + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= ''" + c_Chr

c_Query += "WHERE SE5.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND E5_FORNECE <> ''" + c_Chr

MemoWrite("fDeParaSE5_C.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SE5")+" SET E5_CLIENTE = A1_COD, E5_CLIFOR = A1_COD, E5_LOJA = A1_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE5")+" SE5" + c_Chr

c_Query += "INNER JOIN SA1050 SA1" + c_Chr
c_Query += "ON  A1_FILIAL		= ''" + c_Chr
c_Query += "AND A1_XCODPAF		= E5_CLIENTE" + c_Chr
c_Query += "AND A1_XLJPAF		= E5_LOJA" + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= ''" + c_Chr

c_Query += "WHERE SE5.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND E5_CLIENTE <> ''" + c_Chr
c_Query += "AND E5_RECPAG = 'P' AND E5_TIPODOC = 'ES'" + c_Chr

MemoWrite("fDeParaSE5_D.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SE5")+" SET E5_CLIENTE = A1_COD, E5_CLIFOR = A1_COD, E5_LOJA = A1_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE5")+" SE5" + c_Chr

c_Query += "INNER JOIN SA1050 SA1" + c_Chr
c_Query += "ON  A1_FILIAL		= ''" + c_Chr
c_Query += "AND A1_XCODPAF		= E5_CLIENTE" + c_Chr
c_Query += "AND A1_XLJPAF		= E5_LOJA" + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= ''" + c_Chr

c_Query += "WHERE SE5.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND E5_CLIENTE <> ''" + c_Chr
c_Query += "AND E5_TIPO IN ('RA','NCC','NDC')" + c_Chr

MemoWrite("fDeParaSE5_D.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SE5")+" SET E5_CLIENTE = A1_COD, E5_CLIFOR = A1_COD, E5_LOJA = A1_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE5")+" SE5" + c_Chr

c_Query += "INNER JOIN SA1050 SA1" + c_Chr
c_Query += "ON  A1_FILIAL		= ''" + c_Chr
c_Query += "AND A1_XCODPAF		= E5_CLIENTE" + c_Chr
c_Query += "AND A1_XLJPAF		= E5_LOJA" + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= ''" + c_Chr

c_Query += "WHERE SE5.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND E5_CLIENTE <> ''" + c_Chr

MemoWrite("fDeParaSE5_E.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

//***

c_Query := "UPDATE "+RetSqlName("SE5")+"SET E5_FORNADT = A1_COD, E5_FORNADT = A1_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE5")+" SE5" + c_Chr

c_Query += "INNER JOIN SA2050 SA2" + c_Chr
c_Query += "ON  A2_FILIAL		=''" + c_Chr
c_Query += "AND A2_XCODPAF		= E5_FORNADT" + c_Chr
c_Query += "AND A2_XLJPAF		= E5_LOJAADT" + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= ''" + c_Chr

c_Query += "WHERE SE5.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND E5_FORNADT <> ''" + c_Chr
c_Query += "AND E5_RECPAG = 'R' AND E5_TIPODOC = 'ES'" + c_Chr

MemoWrite("fDeParaSE5_F.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SE5")+" SET E5_FORNADT = A1_COD, E5_FORNADT = A1_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE5")+" SE5" + c_Chr

c_Query += "INNER JOIN SA2050 SA2" + c_Chr
c_Query += "ON  A2_FILIAL		=''" + c_Chr
c_Query += "AND A2_XCODPAF		= E5_FORNADT" + c_Chr
c_Query += "AND A2_XLJPAF		= E5_LOJAADT" + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= ''" + c_Chr

c_Query += "WHERE SE5.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND E5_FORNADT <> ''" + c_Chr
c_Query += "AND E5_TIPO IN ('PA','NCF','NDF')" + c_Chr

MemoWrite("fDeParaSE5_G.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SE5")+" SET E5_FORNADT = A1_COD, E5_FORNADT = A1_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE5")+" SE5" + c_Chr

c_Query += "INNER JOIN SA2050 SA2" + c_Chr
c_Query += "ON  A2_FILIAL		=''" + c_Chr
c_Query += "AND A2_XCODPAF		= E5_FORNADT" + c_Chr
c_Query += "AND A2_XLJPAF		= E5_LOJAADT" + c_Chr
c_Query += "AND SA2.D_E_L_E_T_	= ''" + c_Chr

c_Query += "WHERE SE5.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND E5_FORNADT <> ''" + c_Chr

MemoWrite("fDeParaSE5_H.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SE5")+" SET E5_FORNADT = A1_COD, E5_FORNADT = A1_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE5")+" SE5" + c_Chr

c_Query += "INNER JOIN SA1050 SA1" + c_Chr
c_Query += "ON  A1_FILIAL		= ''" + c_Chr
c_Query += "AND A1_XCODPAF		= E5_FORNADT" + c_Chr
c_Query += "AND A1_XLJPAF		= E5_LOJAADT" + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= ''" + c_Chr

c_Query += "WHERE SE5.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND E5_FORNADT <> ''" + c_Chr
c_Query += "AND E5_RECPAG = 'P' AND E5_TIPODOC = 'ES'" + c_Chr

MemoWrite("fDeParaSE5_I.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SE5")+" SET E5_FORNADT = A1_COD, E5_FORNADT = A1_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE5")+" SE5" + c_Chr

c_Query += "INNER JOIN SA1050 SA1" + c_Chr
c_Query += "ON  A1_FILIAL		= ''" + c_Chr
c_Query += "AND A1_XCODPAF		= E5_FORNADT" + c_Chr
c_Query += "AND A1_XLJPAF		= E5_LOJAADT" + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= ''" + c_Chr

c_Query += "WHERE SE5.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND E5_FORNADT <> ''" + c_Chr
c_Query += "AND E5_TIPO IN ('RA','NCC','NDC')" + c_Chr

MemoWrite("fDeParaSE5_J.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

c_Query := "UPDATE "+RetSqlName("SE5")+" SET E5_FORNADT = A1_COD, E5_FORNADT = A1_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SE5")+" SE5" + c_Chr

c_Query += "INNER JOIN SA1050 SA1" + c_Chr
c_Query += "ON  A1_FILIAL		= ''" + c_Chr
c_Query += "AND A1_XCODPAF		= E5_FORNADT" + c_Chr
c_Query += "AND A1_XLJPAF		= E5_LOJAADT" + c_Chr
c_Query += "AND SA1.D_E_L_E_T_	= ''" + c_Chr

c_Query += "WHERE SE5.D_E_L_E_T_ = ''" + c_Chr
c_Query += "AND E5_FORNADT <> ''" + c_Chr

MemoWrite("fDeParaSE5_K.SQL", c_Query)
TcSqlExec(c_Query)

//------------------------------------------------------------------------------------------------//

Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fAtuSEF    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � RESPONS�VEL EM ATUALIZAR A TABELA SE1                                         ���
���          �-------------------------------------------------------------------------------���
���          � CAMPOS => EF_FORNECE                                                          ���
���          �        => EF_LOJA                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fAtuSEF()

c_Query := "UPDATE "+RetSqlName("SEF")+" SET EF_FORNECE = A2_COD ,EF_LOJA = A2_LOJA" + c_Chr
c_Query += "FROM "+RetSqlName("SEF")+" SEF" + c_Chr + c_Chr

c_Query += "INNER JOIN SA2050 SA2" + c_Chr
c_Query += "ON  A2_FILIAL		= ''" + c_Chr
c_Query += "AND A2_XCODPAF		= EF_FORNEC" + c_Chr
c_Query += "AND A2_XLJPAF		= EF_LOJA" + c_Chr
c_Query += "AND SA2.D_E_L_E_T_ 	= ''" + c_Chr + c_Chr

c_Query += "WHERE SEF.D_E_L_E_T_ = ''" + c_Chr

MemoWrite("fDeParaSEF.SQL", c_Query)
TcSqlExec(c_Query)

Return Nil

//*********************************************************************************************************************************************************//