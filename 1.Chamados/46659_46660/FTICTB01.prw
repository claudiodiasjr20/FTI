#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ FTICTB01 | Autor ³ Claudio Dias Junior (Focus Consultoria) | Data ³ 08/05/2020³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Tela para organizar e centralizar o processo de comissão fibr                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametro Nil                                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametro Nil                                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI                                                                     	     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

//a_CCGeral
#DEFINE COLCCPAI 	01
#DEFINE COLARRAY 	02
#DEFINE COLVLDRAT 	03

//a_CCFilhos = a_CCGeral[n][COLARRAY]
#DEFINE COLCCFILHO 	01
#DEFINE COLCCDESC 	02
#DEFINE COLPERRAT 	03

User Function FTICTB01()

Private d_DataRef   := LastDate(MsDate())
Private c_CCRat     := ""
Private a_CCPAI	    := {}
Private a_CCGeral	:= {}
Private c_Observ	:= Space(500)

Private oDlg		:= Nil
Private oLbx		:= Nil
Private oCombo		:= Nil
Private c_Titulo	:= ""
Private c_Query 	:= "" 
Private c_Chr	 	:= Chr(13) + Chr(10)
Private n_Scan		:= 0

fGetCC(d_DataRef, @c_CCRat, @a_CCPAI, @a_CCGeral)
n_Scan := aScan( a_CCGeral,{|x| x[COLCCPAI] == c_CCRat })

c_Titulo := "FTI - Parametrização Rateio CTB Centro de CUSTO | Vr. 12/05/2020 |"

//---------------------------------//
// TELA DE VISUALIZAÇÃO DOS CUSTOS //
//---------------------------------//
DEFINE MSDIALOG oDlg TITLE c_Titulo FROM 000,000 TO 500,710 PIXEL

@ 012,010 SAY "Data Referência "            																SIZE 170,007 OF oDlg PIXEL
@ 012,060 MSGET d_DataRef 		            VALID fVldData( @d_DataRef, @c_CCRat, @a_CCPAI, @a_CCGeral ) 	SIZE 050,008 OF oDlg PIXEL 

@ 027,010 SAY "CC a Ser Rateado"           																			SIZE 170,007 OF oDlg PIXEL
@ 027,060 MSCOMBOBOX oCombo VAR c_CCRat ITEMS a_CCPAI   VALID AtuGrid( c_CCRat, @a_CCGeral) WHEN a_CCGeral[n_Scan][COLVLDRAT]	SIZE 060,012 OF oDlg PIXEL

@ 042,010 SAY "Observação"                  									SIZE 170,007 OF oDlg PIXEL
@ 052,010 MSGET c_Observ                    									SIZE 340,013 PICTURE "@!" OF oDlg PIXEL

@ 072,010 SAY "Listagem de Centro de Custos Filho para Rateio" SIZE 150,007 OF oDlg PIXEL
@ 082,010 LISTBOX oLbx FIELDS HEADER ;
   	"Centro de Custo", "Descrição", "% Rateio"; 
   	ColSizes 050,100,050;
   	SIZE 340,125 OF oDlg PIXEL ON DBLCLICK( fDblClick() )

	oLbx:SetArray( a_CCGeral[n_Scan][COLARRAY] )
	oLbx:bLine := {|| {	a_CCGeral[n_Scan][COLARRAY][oLbx:nAt][COLCCFILHO],;
						a_CCGeral[n_Scan][COLARRAY][oLbx:nAt][COLCCDESC],;
						a_CCGeral[n_Scan][COLARRAY][oLbx:nAt][COLPERRAT]}}
	oLbx:Refresh()

@220,135 BUTTON "LOG/RE-Processo" 	SIZE 65,11 PIXEL ACTION ( fLogSZ2() ) OF oDlg
@220,210 BUTTON "Sair" 				SIZE 65,11 PIXEL ACTION ( oDlg:End() ) OF oDlg
@220,285 BUTTON "Fazer Rateio" 		SIZE 65,11 PIXEL ACTION ( MsgRun("Gravando Rateio..."	,"",{|| CursorWait(), GravaRAT(), CursorArrow()})) OF oDlg

ACTIVATE MSDIALOG oDlg CENTER

Return Nil

//*****************************************************************************************************************

Static Function fGetCC(d_DataRef, c_CCRat, a_CCPAI, a_CCGeral)

c_Query := " SELECT CTT_CUSTO, CTT_DESC01 " + c_Chr
c_Query += " FROM CTT050 CTT " + c_Chr
c_Query += " WHERE CTT_XPAI = 'S' " + c_Chr
c_Query += " ORDER BY CTT_CUSTO " + c_Chr

If Select("FTICTB01") > 0
	FTICTB01->(DbCloseArea())
EndIf

MemoWrite("FTICTB01_fGetCC.SQL",c_Query)
TCQUERY c_Query NEW ALIAS "FTICTB01"

If FTICTB01->(!Eof()) 

	c_CCRat	  := AllTrim(FTICTB01->CTT_CUSTO)+"-"+AllTrim(FTICTB01->CTT_DESC01)
	a_CCPAI	  := {}
	a_CCGeral := {}

	While FTICTB01->(!Eof())

        c_CCusto :=	AllTrim(FTICTB01->CTT_CUSTO)+"-"+AllTrim(FTICTB01->CTT_DESC01)
		aAdd( a_CCPAI, c_CCusto )
		fGetGeral(d_DataRef, c_CCusto, @a_CCGeral)

		FTICTB01->(DbSkip())
		
	EndDo

EndIf

Return Nil

//*****************************************************************************************************************

Static Function fGetGeral(d_DataRef, c_CCusto, a_CCGeral)

Local c_CCParam := SubString(c_CCusto,1,At('-',c_CCusto)-1)
Local a_CCFilhos:= {}
Local l_RatOK	:= .F.
Local n_SomaRat	:= 0

c_Query := " SELECT	  CTT_CUSTO " + c_Chr
c_Query += "		, CTT_DESC01 " + c_Chr
c_Query += "		, ISNULL(Z2_RATPER,0) AS Z2_RATPER " + c_Chr

c_Query += "FROM CTT050 CTT " + c_Chr

c_Query += "	LEFT JOIN ( " + c_Chr
c_Query += "				SELECT	  MAX(Z2_ID) AS Z2_ID " + c_Chr
c_Query += "						, Z2_DATAREF " + c_Chr
c_Query += "						, Z2_CCPAI " + c_Chr
c_Query += "						, Z2_CCFILHO " + c_Chr
c_Query += "						, Z2_RATPER " + c_Chr

c_Query += "				FROM SZ2050 " + c_Chr
c_Query += "				WHERE D_E_L_E_T_ = '' " + c_Chr
c_Query += "				AND Z2_ID IN ( SELECT MAX(Z2_ID) FROM SZ2050 WHERE D_E_L_E_T_ = '' AND Z2_DATAREF = '"+DTOS(d_DataRef)+"' ) " + c_Chr
c_Query += "				AND Z2_CCPAI LIKE '%"+c_CCParam+"%' " + c_Chr
c_Query += "				GROUP BY Z2_DATAREF, Z2_CCPAI, Z2_CCFILHO, Z2_RATPER " + c_Chr
c_Query += "	) AS HISTORICO " + c_Chr
c_Query += "	ON HISTORICO.Z2_CCFILHO = CTT.CTT_CUSTO " + c_Chr

c_Query += "WHERE D_E_L_E_T_ = '' " + c_Chr
c_Query += "AND CTT_XCCPAI LIKE '%"+c_CCParam+"%' " + c_Chr

If Select("FTICTB01B") > 0
	FTICTB01B->(DbCloseArea())
EndIf

MemoWrite("FTICTB01B_fGetGeral.SQL",c_Query)
TCQUERY c_Query NEW ALIAS "FTICTB01B"

If FTICTB01B->(!Eof()) 

	While FTICTB01B->(!Eof())
		
		n_SomaRat += FTICTB01B->Z2_RATPER
		aAdd(a_CCFilhos, {   AllTrim(FTICTB01B->CTT_CUSTO),;
							 AllTrim(FTICTB01B->CTT_DESC01),;
							 Transform(FTICTB01B->Z2_RATPER,"@E 99.99") } )
	
		FTICTB01B->(DbSkip())
		
	EndDo

	If n_SomaRat == 100
		l_RatOK := .T.
	EndIf
	
	aAdd( a_CCGeral, { c_CCusto, a_CCFilhos, l_RatOK } )

EndIf

Return Nil

//*****************************************************************************************************************

Static Function AtuGrid(c_CCRat, a_CCGeral)

n_Scan  := aScan( a_CCGeral,{|x| x[COLCCPAI] == c_CCRat })

oLbx:SetArray( a_CCGeral[n_Scan][COLARRAY] )
oLbx:bLine := {|| {	a_CCGeral[n_Scan][COLARRAY][oLbx:nAt][COLCCFILHO],;
					a_CCGeral[n_Scan][COLARRAY][oLbx:nAt][COLCCDESC],;
					a_CCGeral[n_Scan][COLARRAY][oLbx:nAt][COLPERRAT]}}
oLbx:Refresh()

Return .T.

//*****************************************************************************************************************

Static Function fVldData( d_DataRef, c_CCRat, a_CCPAI, a_CCGeral  )

If d_DataRef > LastDate(MsDate())
	MsgInfo("Não é possível fazer rateios de datas acima do mês vigente."+ c_Chr +;
			"Data será alterada: "+ c_Chr +;
			"De....: "+DTOC(d_DataRef)+ c_Chr +;
			"Para.: "+DTOC(LastDate(MsDate())),"A V I S O")

	d_DataRef := LastDate(MsDate())
ElseIf d_DataRef <> LastDate(d_DataRef)
	MsgInfo("Por se tratar de um Rateio Mensal, será atribuído o útimo dia do Mês."+ c_Chr +;
			"Data será alterada: "+ c_Chr +;
			"De....: "+DTOC(d_DataRef)+ c_Chr +;
			"Para.: "+DTOC(LastDate(d_DataRef)),"A V I S O")
	d_DataRef := LastDate(d_DataRef)
EndIf

fGetCC(d_DataRef, @c_CCRat, @a_CCPAI, @a_CCGeral)
n_Scan := aScan( a_CCGeral,{|x| x[COLCCPAI] == c_CCRat })
AtuGrid( c_CCRat, a_CCGeral)

Return .T.

//*****************************************************************************************************************

Static Function fDblClick()

Local n_ColPos 	:= oLbx:ColPos
Local n_TotalRat:= 0
Local n_ValorRat:= 0

If n_ColPos == COLVLDRAT
	
	If lEditCell( a_CCGeral[n_Scan][COLARRAY], oLbx, "@E 99.99", oLbx:ColPos )
		
		n_ValorRat := Val(a_CCGeral[n_Scan][COLARRAY][oLbx:nAt][COLPERRAT])	
		a_CCGeral[n_Scan][COLARRAY][oLbx:nAt][COLPERRAT] := Transform(n_ValorRat,"@E 99.99")

		For n_Nx := 1 TO Len(a_CCGeral[n_Scan][COLARRAY])
			n_TotalRat += Val(a_CCGeral[n_Scan][COLARRAY][n_Nx][COLPERRAT])
		Next n_Nx

		If !(n_TotalRat == 100)
			a_CCGeral[n_Scan][COLVLDRAT] := .F.
		Else
			a_CCGeral[n_Scan][COLVLDRAT] := .T.
		EndIf
		
		oCombo:Refresh()
//		oDlg:Refresh()
//		objectMethod(oDlg,"Refresh()")

	EndIf

EndIf

Return Nil

//*****************************************************************************************************************

Static Function GravaRAT()

Local l_Grava	 := .T.
Local c_ID 		 := StrZero( 1, 6)

For n_Pai := 1 TO Len(a_CCGeral)
	If !a_CCGeral[n_Pai][COLVLDRAT]
		l_Grava	 := .F.
		MsgInfo("Por favor verifique C.Custo.: "+a_CCGeral[n_Pai][COLCCPAI] + c_Chr +;
				"O total do rateio precisa ser 100%.","A V I S O")
	EndIf
Next n_Pai

If l_Grava

	c_Query := "SELECT MAX(Z2_ID) AS ID " + c_Chr
	c_Query += "FROM SZ2050 SZ2 " + c_Chr
	c_Query += "WHERE SZ2.D_E_L_E_T_ = '' " + c_Chr

	If Select("GRVSZ2") > 0
		GRVSZ2->(DbCloseArea())
	EndIf

	MEMOWRITE("FTICTB01C_fGravaSZ2.SQL",c_Query)
	c_Query := ChangeQuery(c_Query)
	MEMOWRITE("FTICTB01C_fGravaSZ2_Change.SQL",c_Query)

	TCQUERY c_Query NEW ALIAS "GRVSZ2"

	If !Empty(GRVSZ2->ID)
		c_ID := StrZero( Val(GRVSZ2->ID)+1, 6)
	EndIf

	GRVSZ2->(DbCloseArea())

	For n_Pai := 1 TO Len(a_CCGeral)
		For n_Filho := 1 TO Len(a_CCGeral[n_Pai][COLARRAY])
			RecLock("SZ2", .T.)
			SZ2->Z2_FILIAL 	:= xFilial("SZ2")
			SZ2->Z2_ID		:= c_ID
			SZ2->Z2_DATAREF := d_DataRef
			SZ2->Z2_CCPAI	:= SubString(a_CCGeral[n_Pai][COLCCPAI],1,At('-',a_CCGeral[n_Pai][COLCCPAI])-1)
			SZ2->Z2_CCFILHO	:= a_CCGeral[n_Pai][COLARRAY][n_Filho][COLCCFILHO]
			SZ2->Z2_RATPER	:= Val(a_CCGeral[n_Pai][COLARRAY][n_Filho][COLPERRAT])
			SZ2->Z2_LOGUSER	:= cUserName
			SZ2->Z2_LOGDATA := MsDate()
			SZ2->Z2_LOGHORA := Left(Time(),5)
			SZ2->Z2_OBS		:= c_Observ
			SZ2->(MsUnlock())
		Next n_Filho
	Next n_Pai

	U_FTICTB1C(c_ID)

EndIf

Return Nil

//*****************************************************************************************************************

User Function FTICTB1C(c_ID, l_Reprocesso)

Private c_Query 	:= "" 
Private c_Chr		:= Chr(13) + Chr(10)
Private a_CCRat 	:= {}
Private a_CCAuxRat 	:= {}

Default c_ID 		:= ""
Default l_Reprocesso:= .F.

c_Query := " SELECT	  Z2_DATAREF " + c_Chr
c_Query += "		, Z2_CCPAI " + c_Chr
c_Query += "		, Z2_CCFILHO " + c_Chr
c_Query += "		, Z2_RATPER " + c_Chr

c_Query += " FROM SZ2050 " + c_Chr
c_Query += " WHERE D_E_L_E_T_ = '' " + c_Chr
c_Query += " AND Z2_ID =  '" + c_ID + "' " + c_Chr
c_Query += " GROUP BY Z2_DATAREF, Z2_CCPAI, Z2_CCFILHO, Z2_RATPER " + c_Chr

If Select("FTICTB01C") > 0
	FTICTB01C->(DbCloseArea())
EndIf

MemoWrite("FTICTB01C_Processo_CT2.SQL",c_Query)
TCQUERY c_Query NEW ALIAS "FTICTB01C"

If FTICTB01C->(!Eof()) 

	While FTICTB01C->(!Eof())
		
		c_Data		:= FTICTB01C->Z2_DATAREF
		c_CCPai 	:= FTICTB01C->Z2_CCPAI
		a_CCAuxRat 	:= {}
		While FTICTB01C->(!Eof()) .And. c_CCPai == FTICTB01C->Z2_CCPAI

			aAdd(a_CCAuxRat, { 	Z2_CCFILHO,;
								Z2_RATPER } )
		
			FTICTB01C->(DbSkip())
		
		EndDo

		aAdd( a_CCRat, { c_Data, c_CCPai, a_CCAuxRat } )

	EndDo

EndIf

If fVldCT2(c_Data)
	
	fProcessCT2()
	
	If l_Reprocesso
		c_Query += " UPDATE SZ2050 SET 	  Z2_REPUSER = '"+cUserName+"'"
		c_Query += " 					, Z2_REPDATA = '"+DTOS(MsDate())+"'"
		c_Query += "					, Z2_REPHORA = '"+Left(Time(),5)+"' "
		c_Query += " WHERE D_E_L_E_T_ = '' "
		c_Query += " AND Z2_ID = '" + c_ID + "' "
		TcSqlExec(c_Query)
	EndIf

EndIf

Return Nil

//*****************************************************************************************************************

Static Function fProcessCT2()

Local c_Data  		:= ""
Local c_CCPai 		:= ""
Local a_CCProces	:= {}
Local l_LCDebCrd	:= .T.

Private cPadrao		:= "RT0"
Private cArquivo 	:= ""
Private nHdlPrv 	:= 0
Private cLote		:= ""

For n_Rat := 1 To Len(a_CCRat)

	cLote		:= "R"+AllTrim(a_CCRat[n_Rat][2])
	cArquivo	:= ""
	nHdlPrv 	:= 0

	c_Data 		:= a_CCRat[n_Rat][1]
	c_CCPai 	:= a_CCRat[n_Rat][2]
	a_CCProces 	:= a_CCRat[n_Rat][3]

	c_Query := " SELECT   CT2TIPO " + c_Chr
	c_Query += "		, CT2CONTA " + c_Chr
	c_Query += "		, CT2CCUSTO " + c_Chr
	c_Query += "		, CT2VALOR " + c_Chr

	c_Query += " FROM " + c_Chr
	c_Query += " ( " + c_Chr
	c_Query += "	SELECT 'DEBITO' AS CT2TIPO, CT2_DEBITO AS CT2CONTA, CT2_CCD AS CT2CCUSTO, SUM(CT2_VALOR) AS CT2VALOR " + c_Chr
	c_Query += "	FROM CT2050 CT2 " + c_Chr
	c_Query += "	WHERE CT2.D_E_L_E_T_='' " + c_Chr
	c_Query += "	AND CT2_FILIAL>=''  " + c_Chr
	//c_Query += "	AND CT2_DATA LIKE '"+Left(c_Data,6)+"%' " + c_Chr 
	c_Query += "	AND CT2_DATA = '20200514' " + c_Chr  // TEMPORARIO
	c_Query += "	AND CT2_MOEDLC = '01'" + c_Chr  
	c_Query += "	AND CT2_CCD LIKE '"+c_CCPai+"' " + c_Chr
	c_Query += "	GROUP BY CT2_DEBITO, CT2_CCD " + c_Chr

	c_Query += "	UNION ALL " + c_Chr

	c_Query += "	SELECT 'CREDITO' AS CT2TIPO, CT2_CREDIT AS CT2CONTA, CT2_CCC AS CT2CCUSTO, SUM(CT2_VALOR) AS CT2VALOR " + c_Chr
	c_Query += "	FROM CT2050 CT2 " + c_Chr
	c_Query += "	WHERE CT2.D_E_L_E_T_='' " + c_Chr
	c_Query += "	AND CT2_FILIAL>='' " + c_Chr
	//c_Query += "	AND CT2_DATA LIKE '"+Left(c_Data,6)+"%' " + c_Chr 
	c_Query += "	AND CT2_DATA = '20200514' " + c_Chr  // TEMPORARIO
	c_Query += "	AND CT2_MOEDLC = '01' " + c_Chr 
	c_Query += "	AND CT2_CCC LIKE '"+c_CCPai+"' " + c_Chr
	c_Query += "	GROUP BY  CT2_CREDIT, CT2_CCC " + c_Chr
	c_Query += " ) AS RESULT " + c_Chr

	If Select("FTICTB01D") > 0
		FTICTB01D->(DbCloseArea())
	EndIf

	MemoWrite("FTICTB01D_Processo_CT2.SQL",c_Query)
	TCQUERY c_Query NEW ALIAS "FTICTB01D"

	If FTICTB01D->(!Eof()) 

		BEGIN TRANSACTION

		nHdlPrv := HeadProva( cLote, "FTICTB01", cUserName, @cArquivo )
		While FTICTB01D->(!Eof())

			l_LCDebCrd  := IIF( FTICTB01D->CT2TIPO == "CREDITO", .T., .F. ) // .T. CREDITO | .F. DEBITO
			c_Conta		:= FTICTB01D->CT2CONTA
			c_CCusto	:= FTICTB01D->CT2CCUSTO
			n_Valor		:= FTICTB01D->CT2VALOR

			fGeraCT2(a_CCProces, l_LCDebCrd, c_Data, c_Conta, c_CCusto, n_Valor)

			FTICTB01D->(DbSkip())
		
		EndDo

//----- Envia para Lancamento Contabil
		cA100Incl(cArquivo,nHdlPrv,3,cLote,.T.,.F.)
	
		END TRANSACTION

	EndIf

Next n_Rat

Return Nil

//*****************************************************************************************************************

Static Function fGeraCT2(a_CCFilRat, l_LCDebCrd, c_Data, c_Conta, c_CCusto, n_Valor)

Local n_ValorLC  := 0
Local n_TotalAux := n_Valor

For n_RatCT2 := 1 To Len(a_CCFilRat)

	c_CCFilho	 := a_CCFilRat[n_RatCT2][1]
	l_CCFilhoPai := .F.
	If GetAdvFval("CTT", "CTT_XPAI", xFilial("CTT")+c_CCFilho, 1, "" ) == "S"//CTT_FILIAL, CTT_CUSTO, R_E_C_N_O_, D_E_L_E_T_
		l_CCFilhoPai := .T.
	EndIf

	If Len(a_CCFilRat) == n_RatCT2
		n_ValorLC := n_TotalAux
	Else
		n_ValorLC  := Round(n_Valor * a_CCFilRat[n_RatCT2][2] / 100,2)
		n_TotalAux := n_TotalAux - n_ValorLC
	EndIf

	CREDITO 	:= c_Conta
	DEBITO		:= c_Conta
	CUSTOC		:= IIF( l_LCDebCrd, c_CCFilho, c_CCusto )
	CUSTOD		:= IIF(!l_LCDebCrd, c_CCFilho, c_CCusto )
	HISTORICO	:= "Rateio:" + Left(c_Data,4) + "-" + SubString(c_Data,5,2)+ " CC:" + AllTrim(c_CCusto)
	VALOR		:= n_ValorLC
	dDataBase	:= STOD(c_Data)

	nTotal	:= DetProva(nHdlPrv,cPadrao,"DGCTB01",cLote)

	If l_CCFilhoPai
		n_PosFil := aScan( a_CCRat,{|x| x[2] == c_CCFilho })
		fGeraCT2(a_CCRat[n_PosFil][3], l_LCDebCrd, c_Data, c_Conta, c_CCFilho, n_ValorLC)
	EndIf

Next n_RatCT2

Return Nil

//*****************************************************************************************************************

Static Function fVldCT2(c_Data)

Local l_Ret := .F.

c_Query := " SELECT	 COUNT(*) AS QTD_REG " + c_Chr

c_Query += " FROM CT2050 " + c_Chr
c_Query += " WHERE D_E_L_E_T_ = '' " + c_Chr
c_Query += " AND CT2_DATA LIKE '"+Left(c_Data,6)+"%'  " + c_Chr
c_Query += " AND CT2_ROTINA = 'DGCTB01' " + c_Chr

If Select("FTICTB01E") > 0
	FTICTB01E->(DbCloseArea())
EndIf

MemoWrite("FTICTB01E_fVldCT2.SQL",c_Query)
TCQUERY c_Query NEW ALIAS "FTICTB01E"

If FTICTB01E->(!Eof()) 

		If FTICTB01E->QTD_REG > 0 

			If MsgYesNo("Existem "+AllTrim(Str(FTICTB01E->QTD_REG))+" lançamentos de rateio no mês de " + DTOC(STOD(c_Data)) + c_Chr +;
						"Caso de sequência, ele serão excluídos e recriados." + c_Chr + c_Chr +;
						"Deseja prosseguir?" ,"A V I S O")

				c_Query += " UPDATE CT2050 SET D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ "
				c_Query += " WHERE D_E_L_E_T_ = '' "
				c_Query += " AND CT2_DATA LIKE '"+Left(c_Data,6)+"%' "
				c_Query += " AND CT2_ROTINA = 'DGCTB01' "

				TcSqlExec(c_Query)
				l_Ret := .T.

			EndIf

		EndIf

EndIf

Return l_Ret

//*****************************************************************************************************************

Static Function fLogSZ2()

Local c_Query 	:= ""
Local c_Chr 	:= Chr(13)+Chr(10)

Private a_RegSZ2	:= {}
Private a_RegSZ2Rat := {}
Private o_Dlg
Private o_Lbx

c_Query := " SELECT   Z2_ID " + c_Chr
c_Query += "		, Z2_DATAREF " + c_Chr
c_Query += "		, Z2_LOGUSER " + c_Chr
c_Query += "		, Z2_LOGDATA " + c_Chr
c_Query += "		, Z2_LOGHORA " + c_Chr
c_Query += "		, Z2_REPUSER " + c_Chr
c_Query += "		, Z2_REPDATA " + c_Chr
c_Query += "		, Z2_REPHORA " + c_Chr
c_Query += "		, ISNULL(CONVERT(VARCHAR(2047), CONVERT(VARBINARY(2047), Z2_OBS)),'') AS Z2_OBS " + c_Chr
c_Query += "		, Z2_CCPAI " + c_Chr
c_Query += "		, Z2_CCFILHO " + c_Chr
c_Query += "		, Z2_RATPER " + c_Chr + c_Chr

c_Query += "FROM SZ2050 " + c_Chr
c_Query += "WHERE D_E_L_E_T_ = '' " + c_Chr
c_Query += "ORDER BY Z2_LOGDATA+Z2_LOGHORA DESC,  Z2_REPDATA+Z2_REPHORA DESC" + c_Chr

MemoWrite("fLogSZ2.SQL", c_Query)

If Select("TRBSZ2") > 0
	TRBSZ2->(DbCloseArea())
Endif

TCQUERY c_Query NEW ALIAS "TRBSZ2"

While TRBSZ2->(!Eof())

	c_ID 		:= TRBSZ2->Z2_ID
	c_DtRef 	:= DTOC(STOD(TRBSZ2->Z2_DATAREF))
	c_LOGUsr	:= TRBSZ2->Z2_LOGUSER
	c_LOGDt		:= DTOC(STOD(TRBSZ2->Z2_LOGDATA))
	c_LOGHr		:= TRBSZ2->Z2_LOGHORA
	c_REPUsr	:= TRBSZ2->Z2_REPUSER
	c_REPDt 	:= DTOC(STOD(TRBSZ2->Z2_REPDATA))
	c_REPHr		:= TRBSZ2->Z2_REPHORA
	c_ObsSZ2	:= TRBSZ2->Z2_OBS 
	a_RegSZ2Rat := {}

	While c_ID == TRBSZ2->Z2_ID

		aAdd(a_RegSZ2Rat, { AllTrim(Z2_CCPAI),;
							AllTrim(GetAdvFVal("CTT", "CTT_DESC01",xFilial("SZ2")+TRBSZ2->Z2_CCPAI,1,"")),;
							AllTrim(Z2_CCFILHO),;
							AllTrim(GetAdvFVal("CTT", "CTT_DESC01",xFilial("SZ2")+TRBSZ2->Z2_CCFILHO,1,"")),;
							Z2_RATPER })

		TRBSZ2->(DbSkip())

	EndDo

	aAdd(a_RegSZ2, { c_ID, c_DtRef,	c_LOGUsr, c_LOGDt, c_LOGHr,	c_REPUsr, c_REPDt, c_REPHr,	c_ObsSZ2, a_RegSZ2Rat })

EndDo
                                                                           
    
If Len(a_RegSZ2) > 0 

	DEFINE MSDIALOG o_Dlg TITLE "Log - Rateio CTB Centro de CUSTO" FROM 0,0 TO 240,1150 PIXEL
	                                                         
	@ 10,10 LISTBOX o_Lbx FIELDS HEADER ;
	   "ID", "Mês Rateio", "User Processo", "Data Processo", "Hora Processo", "User RE-Processo", "Data RE-Processo", "Hora RE-Processo", "Observação";
	   SIZE 560,095 OF o_Dlg PIXEL 
	
	o_Lbx:SetArray( a_RegSZ2 )
	o_Lbx:bLine := {|| { a_RegSZ2[o_Lbx:nAt][01],;
						 a_RegSZ2[o_Lbx:nAt][02],;
						 a_RegSZ2[o_Lbx:nAt][03],;
						 a_RegSZ2[o_Lbx:nAt][04],;
						 a_RegSZ2[o_Lbx:nAt][05],;
						 a_RegSZ2[o_Lbx:nAt][06],;
						 a_RegSZ2[o_Lbx:nAt][07],;
						 a_RegSZ2[o_Lbx:nAt][08],;
						 a_RegSZ2[o_Lbx:nAt][09] }}
	
	@ 106,010 BUTTON oBut1 PROMPT "&Fechar" 		SIZE 44,12 OF o_Dlg PIXEl Action (Close(o_Dlg))
	@ 106,060 BUTTON oBut2 PROMPT "&Veja %Rateio" 	SIZE 44,12 OF o_Dlg PIXEl Action (fLogRat(a_RegSZ2[o_Lbx:nAt][10]))
	@ 106,110 BUTTON oBut2 PROMPT "&Reprocessar" 	SIZE 44,12 OF o_Dlg PIXEl Action (fReprocesso(a_RegSZ2[o_Lbx:nAt]))
	ACTIVATE MSDIALOG o_Dlg CENTER

Else

	Alert("Existe Registro de LOG's...")

EndIf

Return Nil

//*****************************************************************************************************************

Static Function fLogRat(a_ListRat)

Local o_Dlg2
Local o_Lbx2

	DEFINE MSDIALOG o_Dlg2 TITLE "%Rateio CC Pai X CC Filho" FROM 0,0 TO 240,530 PIXEL
	                                                         
	@ 10,10 LISTBOX o_Lbx2 FIELDS HEADER ;
	   "CC Pai", "Descrição", "CC Filho", "Descrição", "%Rateado";
	   SIZE 240,095 OF o_Dlg2 PIXEL 
	
	o_Lbx2:SetArray( a_ListRat )
	o_Lbx2:bLine := {|| {a_ListRat[o_Lbx2:nAt][01],;
						 a_ListRat[o_Lbx2:nAt][02],;
						 a_ListRat[o_Lbx2:nAt][03],;
						 a_ListRat[o_Lbx2:nAt][04],;
						 a_ListRat[o_Lbx2:nAt][05]}}
	
	@ 106,010 BUTTON oBut1 PROMPT "&Fechar" 		SIZE 44,12 OF o_Dlg2 PIXEl Action (Close(o_Dlg2))
	ACTIVATE MSDIALOG o_Dlg2 CENTER

Return Nil

//*****************************************************************************************************************

Static Function fReprocesso(a_RegSZ2Rep)

	If MsgYesNo("Tem certeza que deseja reprocessar o ID " + a_RegSZ2Rep[1] + c_Chr +;
				"Referente ao mês " + a_RegSZ2Rep[2] + " ?" + c_Chr + c_Chr +;
				"Deseja prosseguir?" ,"A V I S O")
		
		MsgRun("Realizando RE-Processamento..."	,"",{|| CursorWait(), U_FTICTB1C( a_RegSZ2Rep[1], .T. ), CursorArrow()})

	EndIf

Return Nil

//*****************************************************************************************************************
