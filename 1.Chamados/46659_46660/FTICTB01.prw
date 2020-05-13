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

@220,210 BUTTON "Sair" 			SIZE 65,11 PIXEL ACTION ( oDlg:End() ) OF oDlg
@220,285 BUTTON "Fazer Rateio" 	SIZE 65,11 PIXEL ACTION ( MsgRun("Gravando Rateio..."	,"",{|| CursorWait(), GravaRAT(), CursorArrow()})) OF oDlg

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

	fProcesCT2(c_ID)

EndIf

Return Nil

//*****************************************************************************************************************

Static Function fProcesCT2(c_ID)

Return Nil

//*****************************************************************************************************************