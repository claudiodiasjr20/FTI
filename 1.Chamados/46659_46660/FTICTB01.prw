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

User Function FTICTB01()

Private d_DataRef   := LastDate(MsDate())
Private c_CCRat     := ""
Private a_CCPAI	    := {}
Private a_CCGeral	:= {}
Private c_Observ	:= Space(500)

Private oDlg		:= Nil
Private oLbx		:= Nil
Private c_Titulo	:= ""
Private c_Query 	:= "" 
Private c_Chr	 	:= Chr(13) + Chr(10)

fGetCC(d_DataRef, @c_CCRat, @a_CCPAI, @a_CCGeral)
n_Scan := aScan( a_CCGeral,{|x| x[1] == c_CCRat })

c_Titulo := "FTI - Parametrização Rateio CTB Centro de CUSTO | Ult.Vr. 08/05/2020 |"

//---------------------------------//
// TELA DE VISUALIZAÇÃO DOS CUSTOS //
//---------------------------------//
DEFINE MSDIALOG oDlg TITLE c_Titulo FROM 000,000 TO 500,710 PIXEL

@ 012,010 SAY "Data Referência "            							SIZE 170,007 OF oDlg PIXEL
@ 012,060 MSGET d_DataRef 		            							SIZE 050,008 OF oDlg PIXEL 
@ 012,110 SAY "Sempre informar o último dia do mês desejado"      		SIZE 170,007 OF oDlg PIXEL COLOR CLR_HRED

@ 027,010 SAY "CC a Ser Rateado"           										SIZE 170,007 OF oDlg PIXEL
@ 027,060 COMBOBOX  c_CCRat ITEMS a_CCPAI   VALID AtuGrid( c_CCRat, a_CCGeral)	SIZE 060,012 OF oDlg PIXEL

@ 042,010 SAY "Observação"                  SIZE 170,007 OF oDlg PIXEL
@ 052,010 MSGET c_Observ                    SIZE 340,013 PICTURE "@!" OF oDlg PIXEL

@ 072,010 SAY "Listagem de Centro de Custos Filho para Rateio" SIZE 150,007 OF oDlg PIXEL
@ 082,010 LISTBOX oLbx FIELDS HEADER ;
   	"Centro de Custo", "Descrição", "% Rateio"; 
   	ColSizes 050,100,050;
   	SIZE 340,125 OF oDlg PIXEL ON DBLCLICK( IIF(oLbx:ColPos == 3, lEditCell( a_CCGeral[n_Scan][2], oLbx, "@E 999.99", oLbx:ColPos ), NIL ) )

	oLbx:SetArray( a_CCGeral[n_Scan][2] )
	oLbx:bLine := {|| {	a_CCGeral[n_Scan][2][oLbx:nAt][1],;
						a_CCGeral[n_Scan][2][oLbx:nAt][2],;
						a_CCGeral[n_Scan][2][oLbx:nAt][3]}}
	oLbx:Refresh()

@220,210 BUTTON "Sair" 			SIZE 65,11 PIXEL ACTION ( oDlg:End() ) OF oDlg
@220,285 BUTTON "Fazer Rateio" 	SIZE 65,11 PIXEL ACTION ( oDlg:End() ) OF oDlg

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

	c_CCRat	 := AllTrim(FTICTB01->CTT_CUSTO)+"-"+AllTrim(FTICTB01->CTT_DESC01)
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
c_Query += "				AND Z2_DATAREF = '"+DTOS(d_DataRef)+"' " + c_Chr
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
		
		aAdd(a_CCFilhos, {   AllTrim(FTICTB01B->CTT_CUSTO),;
							 AllTrim(FTICTB01B->CTT_DESC01),;
							 Transform(FTICTB01B->Z2_RATPER,"@E 999.99") } )
	
		FTICTB01B->(DbSkip())
		
	EndDo
	
	aAdd( a_CCGeral, { c_CCusto, a_CCFilhos } )

EndIf

Return Nil

//*****************************************************************************************************************

Static Function AtuGrid(c_CCRat, a_CCGeral)

n_Scan  := aScan( a_CCGeral,{|x| x[1] == c_CCRat })

oLbx:SetArray( a_CCGeral[n_Scan][2] )
oLbx:bLine := {|| {	a_CCGeral[n_Scan][2][oLbx:nAt][1],;
					a_CCGeral[n_Scan][2][oLbx:nAt][2],;
					a_CCGeral[n_Scan][2][oLbx:nAt][3]}}
oLbx:Refresh()

Return .T.

//*****************************************************************************************************************