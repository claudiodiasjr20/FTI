#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH"

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fCGCCodigo |Autor� Claudio Dias Junior (Focus Consultoria)| Data � 23/05/2013 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Fun��o para Subtrair caracteres Indesejaveis                                  ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� c_CGC      => Campo do CGC ( Ex: M->A1_CGC )                                  ���
���          � c_Alias    => Tabela utilizada ( Ex: "A1" )                                   ���
���          � a_Tabela   => Tabela utilizada + Campo do Codigo ( { "SA1", "A1_COD" } )      ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � c_CGC => Campo do CGC                                                         ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI                                                                     		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

// U_fCGCCodigo( M->A1_CGC, M->A1_PESSOA, "A1", { "SA1", "A1_COD" } )
// U_fCGCCodigo( M->A2_CGC, M->A2_TIPO	, "A2", { "SA2", "A2_COD" } )
User Function fCGCCodigo( c_CGC, c_Tipo, c_Alias, a_Tabela ) 

Local c_Query 	:= ""
Local c_Chr 	:= ""

If c_Alias ==  "A2"
	oMdlSA2 := FwModelActive()
	oSA2Master := oMdlSA2:getModel("SA2MASTER")
EndIf
		
&("M->"+c_Alias+"_COD") 	:= "000000"
&("M->"+c_Alias+"_LOJA")	:= "00"
		
If c_Tipo == "J" .And. !Empty(c_CGC) .And. Left(c_CGC,8) <> "00000000"

	c_Query := "SELECT MAX("+c_Alias+"_COD) COD, MAX("+c_Alias+"_LOJA) LOJA " + c_Chr
	c_Query += "FROM  S"+c_Alias+"050 " + c_Chr
	c_Query += "WHERE D_E_L_E_T_ = '' " + c_Chr
	c_Query += "AND LEFT("+c_Alias+"_CGC,8) = '"+Left(c_CGC,8)+"' " + c_Chr
	
	If Select("CODLJ") > 0
		CODLJ->(DbCloseArea())
	EndIf
		
	c_Query := ChangeQuery(c_Query)

	TCQUERY c_Query NEW ALIAS "CODLJ"	

	If !Empty(CODLJ->(COD+LOJA))
	
		If c_Alias ==  "A2"
			//Preenche o A2_COD com um valor.
			oSA2Master:loadValue("A2_COD", CODLJ->COD)
			oSA2Master:loadValue("A2_LOJA", Soma1(CODLJ->LOJA))
		Else
		
			&("M->"+c_Alias+"_COD") 	:= CODLJ->COD
			&("M->"+c_Alias+"_LOJA")	:= Soma1(CODLJ->LOJA)
		
		EndIf
	
	Else
		
		c_Query := "SELECT MAX("+c_Alias+"_COD) COD " + c_Chr
		c_Query += "FROM  S"+c_Alias+"050 " + c_Chr
		c_Query += "WHERE D_E_L_E_T_ = '' " + c_Chr
		c_Query += "AND "+c_Alias+"_COD <= '999999'" + c_Chr
		
		If Select("CODLJ") > 0
			CODLJ->(DbCloseArea())
		EndIf
			
		c_Query := ChangeQuery(c_Query)
	
		TCQUERY c_Query NEW ALIAS "CODLJ"	
	
		If !Empty(CODLJ->(COD))
		
			If c_Alias ==  "A2"
				//Preenche o A2_COD com um valor.
				oSA2Master:loadValue("A2_COD", Soma1(CODLJ->COD ))
				oSA2Master:loadValue("A2_LOJA", "01" )
			Else
				&("M->"+c_Alias+"_COD") 	:= Soma1(CODLJ->COD)
				&("M->"+c_Alias+"_LOJA")	:= "01"
		
			EndIf		

		EndIf
		
	EndIf
	
Else    

	c_Query := "SELECT MAX("+c_Alias+"_COD) COD " + c_Chr
	c_Query += "FROM  S"+c_Alias+"050 " + c_Chr
	c_Query += "WHERE D_E_L_E_T_ = '' " + c_Chr
	c_Query += "AND "+c_Alias+"_COD <= '999999'" + c_Chr

	If Select("CODLJ") > 0
		CODLJ->(DbCloseArea())
	EndIf

	c_Query := ChangeQuery(c_Query)

	TCQUERY c_Query NEW ALIAS "CODLJ"	

	If !Empty(CODLJ->(COD))
		
		If c_Alias ==  "A2"
			//Preenche o A2_COD com um valor.
			oSA2Master:loadValue("A2_COD", Soma1(CODLJ->COD ))
			oSA2Master:loadValue("A2_LOJA", "01" )
		Else
			&("M->"+c_Alias+"_COD") 	:= Soma1(CODLJ->COD)
			&("M->"+c_Alias+"_LOJA")	:= "01"
		EndIf

	EndIf

EndIf

Return c_CGC

//************************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fTiraPonto |Autor� Sidnei Naconsky                        | Data � 23/05/2013 ���
���Reformulada Por        |Autor� Claudio Dias Junior (Focus Consultoria)| Data � 23/05/2013 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Fun��o para Subtrair caracteres Indesejaveis                                  ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� c_Texto => Campo a ser analisado (e, subtraido)                               ���
���          � c_Conteudo => Caracteres Indesejaveis                                         ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � c_Texto => Sem os caracteres Indesejaveis                                     ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI                                                                     		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

User Function fTiraPonto(c_Texto, c_Conteudo)

c_Conteudo += '	' + Chr(13)

For i := 1 To Len(c_Conteudo) 
	c_Texto := Replace(c_Texto, SubStr(c_Conteudo, i, 1), "")
Next i
           
For y := 2 To 10
	c_Texto := Replace(c_Texto, Space(y), Space(01) )
Next z

Return Alltrim(c_Texto)                 

//************************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � ExistTAB  |Autor� Claudio Dias Junior ( Focus Consultoria )|Data � 05/02/2015 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Fun��o que verifica se a tabela existe                                        ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� c_NomeTAB => Tabela que ser� verificada SA1010                                ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � l_Ret => .T./.F.                                                              ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI                                                                     		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

// U_ExistTAB("AA1990")
User Function ExistTAB(c_NomeTAB)

Local l_Ret := .T.
	
	If Select("QRYTAB") > 0
		QRYTAB->(DbCloseArea())
	EndIf
	DbUseArea(.T., 'TOPCONN', TCGenQry(,,"select id from sysobjects where name like '" + Alltrim(c_NomeTAB)+"' and xtype = 'U'"),'QRYTAB', .F., .T.)
//	DbUseArea(.T., 'TOPCONN', c_NomeTAB	,'QRYTAB'	,.F.,.T.)
//	DbUseArea(.F., "TOPCONN",c_NomeTAB	,"QRYTAB"	,.T.,.F.)
	If QRYTAB->(Eof())
		l_Ret := .F.
	EndIf	        

Return l_Ret

//**********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fCriaArq | Autor � Claudio Dias Junior (Focus Consultoria)  | Data � 26/07/10 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Gera arquivo com base no array passado.                                       ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� 	a_Dados => Array que cont�m os dados para gera��o do arquivo                 ���
���          � 	c_NomeArq => Nome do arquivo                                                 ���
���          � 	c_Local => Local de gera��o do arquivo                                       ���
���          � 	c_Extencao => Extens�o ( CSV, TXT, XLS )                           	         ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Parametros -> Nil                                                             ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FISCHER BRASIL                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                                					 ���
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

User Function fCriaArq( a_Dados, c_NomeArq, c_Local, c_Extencao )

Local c_Arq
Local n_Arq
Local c_Path
                                   	
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
	Return()
EndIf

For i := 1 To Len(a_Dados)
	FWrite( n_Arq, a_Dados[i][1] + Chr(13) + Chr(10) )
Next i

FClose(n_Arq)

Return c_NomeArq

//**********************************************************************************************************************************************************//

User Function VinculoCC()

Private o_Dlg
Private o_Lbx
Private o_Ok        := LoadBitmap( GetResources(), "CHECKED" 	)   
Private o_No        := LoadBitmap( GetResources(), "UNCHECKED" ) 
Private c_Titulo    := "Selecione os Centro de Custo que far� parte do Rateio"
Private a_CCPaiCad  := U_GetArr(CTT->CTT_XCCPAI, "#")
Private a_CCPai	    := {}
Private l_Mark 	    := .F.

If CTT->CTT_CLASSE == "1"
	Alert("N�o � poss�vel fazer vinculo com CCusto Sint�tico OU Bloqueado!")
	Return Nil
EndIf

If CTT->CTT_BLOQ == "1"
	Alert("N�o � poss�vel fazer vinculo com CCusto Sint�tico OU Bloqueado!")
	Return Nil
EndIf

c_Query := " SELECT CTT_CUSTO, CTT_DESC01 "
c_Query += " FROM CTT050 CTT " 
c_Query += " WHERE D_E_L_E_T_ = '' "
c_Query += " AND CTT_XPAI = 'S'
c_Query += " ORDER BY CTT_CUSTO "

If Select("FTICTT") > 0
	FTICTT->(DbCloseArea())
EndIf

MemoWrite("FTICTT_VinculoCC.SQL",c_Query)
TCQUERY c_Query NEW ALIAS "FTICTT"

While FTICTT->(!Eof())

	n_Scan  := aScan( a_CCPaiCad,{|x| x == AllTrim(FTICTT->CTT_CUSTO) })
	If n_Scan > 0
		l_Mark := .T.
	Else
		l_Mark := .F.
	EndIf
    aAdd( a_CCPAI, { l_Mark, AllTrim(FTICTT->CTT_CUSTO), AllTrim(FTICTT->CTT_DESC01) } )
    FTICTT->(DbSkip())

EndDo

If Len(a_CCPai) == 0
	aAdd( a_CCPai, { l_Mark, Space(09), "N�O POSSUEM CC.PAI CADASTRADA - VEJA CAMPO CTT_XPAI" } )
EndIf

DEFINE MSDIALOG o_Dlg TITLE c_Titulo FROM 0,0 TO 240,500 PIXEL
   
@ 10,10 LISTBOX o_Lbx FIELDS HEADER ;
   "", "C.Custo PAI", "Descri��o" ;
   SIZE 230,095 OF o_Dlg PIXEL ON dblClick( a_CCPai[o_Lbx:nAt][1] := !a_CCPai[o_Lbx:nAt][1] )

o_Lbx:SetArray( a_CCPai )
o_Lbx:bLine := {|| { 	IIF(a_CCPai[o_Lbx:nAt][1],o_Ok,o_No),;
						    a_CCPai[o_Lbx:nAt][2],;
                    	    a_CCPai[o_Lbx:nAt][3] }}
	 
@ 107,135 BUTTON oBut1 PROMPT "&Fechar" 	SIZE 44,12 OF o_Dlg PIXEl Action (Close(o_Dlg))
@ 107,195 BUTTON oBut1 PROMPT "&Vincular" 	SIZE 44,12 OF o_Dlg PIXEl Action (fGrvVinc(a_CCPai),Close(o_Dlg))
ACTIVATE MSDIALOG o_Dlg CENTER

Return .T.

//*******************************************************************************************/

Static Function fGrvVinc(a_CCPai)

Local c_CCAmarra := ""

For n_CCPai := 1 To Len(a_CCPai)

	If a_CCPai[n_CCPai][1]
		c_CCAmarra += a_CCPai[n_CCPai][2]+"#"
	EndIf

Next n_CCPai

RecLock("CTT",.F.)
CTT->CTT_XCCPAI := c_CCAmarra
CTT->(MsUnLock())

MsgInfo("Amarra��o feita com sucesso.")

Return Nil

//*******************************************************************************************/

User Function VldCCPAI(c_CCPai, c_Custo)

Local l_OK 		:= .T.
Local c_Filhos  := ""
Local c_Query   := ""
Local c_Chr     := Chr(13) + Chr(10)

If c_CCPai == "S"
	Return .T.
EndIf

c_Query := " SELECT CTT_CUSTO, CTT_DESC01 " + c_Chr
c_Query += " FROM CTT050 CTT " + c_Chr
c_Query += " WHERE D_E_L_E_T_ = '' " + c_Chr
c_Query += " AND CTT_XCCPAI LIKE '%"+AllTrim(c_Custo)+"%' " + c_Chr

If Select("FTICTT") > 0
	FTICTT->(DbCloseArea())
EndIf

MemoWrite("FTICTT_VinculoCC.SQL",c_Query)
TCQUERY c_Query NEW ALIAS "FTICTT"

While FTICTT->(!Eof())
	c_Filhos += AllTrim(CTT_CUSTO) +"-"+ AllTrim(CTT_DESC01) + c_Chr
	FTICTT->(DbSkip())
EndDo

If !Empty(c_Filhos)
	l_OK := .F.
	MsgInfo( "Antes de alterar, � necess�rio remover os vinculos abaixo:"+ c_Chr +;
			 c_Filhos, "A T E N � � O!")
EndIf

Return l_OK

//*******************************************************************************************/