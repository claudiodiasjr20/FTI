#include "RWMAKE.CH"
#include "Protheus.Ch"
#include "TopConn.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ MYMENU1  บ Autor ณ Douglas V. Franca  บ Data ณ  07/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Gerenciar os arquivos de menu(xnu) dos usuarios.           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MYMENU1(n_Opc)

	Local x_Ret

	If n_Opc <> Nil
		If n_Opc == 1
			x_Ret := fAltItem()
		ElseIf n_Opc == 2
			fReplCfg()
		ElseIf n_Opc == 3
			fCopyCfg()
		ElseIf n_Opc == 4
			fSelUser()
		ElseIf n_Opc == 5
			fGerXnuLt()
		ElseIf n_Opc == 6
			U_MYMENU3(.F., ZZS->ZZS_USER)
		ElseIf n_Opc == 7
			fImpMenu()
		Endif
		Return x_Ret
	Endif

	//Parametro MV_XTPMENU onde 0=Por Usuแrio ou 1=Por Grupo (Default)
	Private l_GrpMenu	:= (GetMV("MV_XTPMENU", ,"1") == "1")
	Private n_TamUser	:= 25

	Private cCadastro 	:= "Manuten็ใo dos itens dos menus dos "+IIF(l_GrpMenu, "grupos","usuแrios")
	Private aRotina 	:= {}

	aAdd(aRotina, {"Pesquisar" 		, 'AxPesqui'  		,0,1})
	aAdd(aRotina, {"Visualizar"		, 'AxVisual' 		,0,2})
	aAdd(aRotina, {"Importar"		, 'U_MYMENU1(7)'	,0,3})
	aAdd(aRotina, {"Alterar"		, 'U_MYMENU1(1)'	,0,4})
	aAdd(aRotina, {"Manut. Config."	, 'U_MYMENU1(2)'	,0,4})
	aAdd(aRotina, {"Copia Config."	, 'U_MYMENU1(3)'	,0,4})
	aAdd(aRotina, {"Gerar XNU"		, 'U_MYMENU1(4)'	,0,4})
	aAdd(aRotina, {"Gerar em Lote"	, 'U_MYMENU1(5)'	,0,4})
	aAdd(aRotina, {"Vis. มrvore"	, 'U_MYMENU1(6)'	,0,4})

	MBrowse( ,,,,"ZZS")

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfAltItem  ณ Alterar o registro posicionado da tabela ZZS.              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fAltItem()
	
	Local n_Ret := AxAltera("ZZS", ZZS->(Recno()), 4)
	
	If n_Ret == 1
		
		CursorWait()
		
		U_fAtuAces("ZZS")

		c_UpdQry := "UPDATE "+RetSqlName("ZZS")+" "
		c_UpdQry += "SET ZZS_TABELA	= '"+ZZS->ZZS_TABELA+"' "
		c_UpdQry += "	,ZZS_LACE01	= '"+IIF(ZZS->ZZS_LACE01, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE02	= '"+IIF(ZZS->ZZS_LACE02, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE03	= '"+IIF(ZZS->ZZS_LACE03, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE04	= '"+IIF(ZZS->ZZS_LACE04, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE05	= '"+IIF(ZZS->ZZS_LACE05, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE06	= '"+IIF(ZZS->ZZS_LACE06, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE07	= '"+IIF(ZZS->ZZS_LACE07, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE08	= '"+IIF(ZZS->ZZS_LACE08, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE09	= '"+IIF(ZZS->ZZS_LACE09, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE10	= '"+IIF(ZZS->ZZS_LACE10, "T", "F")+"' "
		c_UpdQry += "	,ZZS_ACESSO	= '"+ZZS->ZZS_ACESSO+"' "
		c_UpdQry += "	,ZZS_STATUS	= '"+ZZS->ZZS_STATUS+"' "		
		c_UpdQry += "WHERE ZZS_FILIAL = '"+ZZS->ZZS_FILIAL+"' "
		c_UpdQry += "AND ZZS_FUNCAO = '"+ZZS->ZZS_FUNCAO+"' "
		c_UpdQry += "AND ZZS_USER = '"+ZZS->ZZS_USER+"' "
		c_UpdQry += "AND R_E_C_N_O_ NOT IN ("+AllTrim(Str(ZZS->(Recno())))+") "
		c_UpdQry += "AND D_E_L_E_T_ = ' ' "

		TcSqlExec(c_UpdQry)

		CursorArrow()
		
	Endif

Return(n_Ret)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfReplCfg  ณ Replicar as configuracoes do item posicionado.             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fReplCfg()

	Local oDlg
	Local c_Title 	:= OemToAnsi("Replica็ใo de configura็๕es dos Menus.")
	Local n_Opca 	:= 0
	Local a_CA		:= { OemToAnsi("Confirma"), OemToAnsi("Abandona"), OemToAnsi("Parโmetros")}
	Local a_Says	:={}
	Local a_Buttons	:={}
	Local c_Perg 	:= IIF(l_Grpmenu, "MYXNU5", "MYXNU2")

	ValidPerg(c_Perg)

	If !Pergunte(c_Perg, .T.)
		Return Nil
	Endif

	c_Texto	:= "Este programa tem como objetivo replicar as configura็๕es"
	aAdd(a_Says, OemToAnsi(c_Texto))
	c_Texto	:= "de Acesso [x--- xx xx], Status [H/I/D] e Tabelas para os"
	aAdd(a_Says, OemToAnsi(c_Texto))
	c_Texto	:= "registros, conforme os parametros selecionados."
	aAdd(a_Says, OemToAnsi(c_Texto))
	c_Texto	:= "Aten็ใo.: Para nใo atualizar uma determinada posi็ใo do "
	aAdd(a_Says, OemToAnsi(c_Texto))
	c_Texto	:= "acesso, basta utilizar o caracter MENOS (-).            "
	aAdd(a_Says, OemToAnsi(c_Texto))
	aAdd(a_Buttons, { 1,.T.,{|o| n_Opca:= 1, If( .T., o:oWnd:End(), n_Opca:=0 ) }} )
	aAdd(a_Buttons, { 2,.T.,{|o| o:oWnd:End() }} )
	aAdd(a_Buttons, { 5,.T.,{|o| Pergunte(c_Perg, .T.) }} )
	FormBatch( c_Title, a_Says, a_Buttons ,,220,380)

	If n_Opca == 1
		Processa({|lend| fAtuZZS()},"Atualizando Registros...Por favor aguarde.")
	Else
		MsgStop("Atualizacao Cancelada!","Abortado")
	Endif

Return Nil

Static Function fAtuZZS()

	Local c_QryUpd 	:= ""
	Local c_Status 	:= IIF(MV_PAR04==1, "H", IIF(MV_PAR04==2, "D", "I"))
	Local c_Acesso	:= ""
	Local i			:= 1
	Local c_Aux		:= ""
	Local c_QryLACE	:= ""

	If MV_PAR01 == 2 .And. MV_PAR03 == 2 .And. MV_PAR13 == 2
		MsgStop("Nใo existem registros para atualizar. Verifique os parโmetros.", "Nใo Achou")
	ElseIf MV_PAR01 == 1
		For i := 1 To 10
			c_Aux := SubStr(MV_PAR02, i, 1)
			If c_Aux == "-"
				c_Acesso += IIF(i==1,"","+")+"SUBSTRING(ZZS_ACESSO, "+AllTrim(Str(i))+", 1)"
			Else
				c_Acesso += IIF(i==1,"","+")+"'"+c_Aux+"'"
				c_QryLACE += ", ZZS_LACE"+StrZero(i, 2)+" = '"+IIF(Upper(c_Aux)=="X","T","F")+"' "
			Endif
		Next i
		c_QryUpd := "UPDATE "+RetSqlName("ZZS")+" SET ZZS_ACESSO = "+c_Acesso+" "
		c_QryUpd += c_QryLACE
		If MV_PAR03 == 1
			c_QryUpd += ", ZZS_STATUS = '"+c_Status+"' "
		Endif
		If MV_PAR13 == 1
			c_QryUpd += ", ZZS_TABELA = '"+MV_PAR14+"' "
		Endif
	ElseIf MV_PAR03 == 1
		c_QryUpd := "UPDATE "+RetSqlName("ZZS")+" SET ZZS_STATUS = '"+c_Status+"' "
		If MV_PAR13 == 1
			c_QryUpd += ", ZZS_TABELA = '"+MV_PAR14+"' "
		Endif
	Else
		c_QryUpd := "UPDATE "+RetSqlName("ZZS")+" SET ZZS_TABELA = '"+MV_PAR14+"' "
	Endif

	c_QryUpd += "WHERE ZZS_FILIAL = '  ' "
	c_QryUpd += "AND ZZS_MODULO BETWEEN '"+MV_PAR11+"' AND '"+MV_PAR12+"' "
	c_QryUpd += "AND ZZS_USER BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "
	c_QryUpd += "AND ZZS_CHAVE BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "
	c_QryUpd += "AND ZZS_FUNCAO BETWEEN '"+MV_PAR09+"' AND '"+MV_PAR10+"' "
	c_QryUpd += "AND D_E_L_E_T_ = ' ' "

	//MemoWrite("MYMENU1.SQL", c_QryUpd)

	TcSqlExec(c_QryUpd)

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfCopyCfg  ณ Copia as configuracoes do usuario posicionado para os sele-บฑฑ
ฑฑบ          ณ cionados.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fCopyCfg()

Local a_AreaATU	:= GetArea()
Local cVar     	:= Nil
Local cVar1    	:= Nil
Local oDlg     	:= Nil
Local cTitulo  	:= "Copia configura็ใo do "+IIF(l_GrpMenu, "grupo", "usuแrio")+"."
Local lMark    	:= .F.
Local oOk      	:= LoadBitmap( GetResources(), "LBOK" )
Local oNo      	:= LoadBitmap( GetResources(), "LBNO" )
Local n_Bnt    	:= 0
Local c_Query 	:= ""

Private oLbx 	:= Nil
Private aVetor 	:= {}
Private oLbx1 	:= Nil
Private aVetor1	:= {}

c_Query := "SELECT DISTINCT ZZS_MODULO FROM "+RetSqlName("ZZS")+" "
c_Query += "WHERE D_E_L_E_T_ = ' ' AND ZZS_USER = '"+ZZS->ZZS_USER+"' ORDER BY ZZS_MODULO"

If Select("QRY") > 0
	QRY->(DbCloseArea())
Endif

TCQUERY c_Query NEW ALIAS "QRY"

//+-------------------------------------+
//| Carrega o vetor conforme a condicao |
//+-------------------------------------+
While QRY->(!Eof())

	aAdd( aVetor, { .T.,;
                   QRY->ZZS_MODULO})

	QRY->(DbSkip())
Enddo

If l_GrpMenu
	a_UserTemp := AllGroups()
	For i := 2 To Len(a_UserTemp)
		
		If AllTrim(ZZS->ZZS_USER) <> AllTrim(a_UserTemp[i][1][2])
			aAdd( aVetor1, { .F.,;
			              PADR(a_UserTemp[i][1][2], n_TamUser)})
		Endif
	Next i
	aVetor1 := aSort(aVetor1,,,{ |x,y| x[2] < y[2] } )
Else
	a_UserTemp := AllUsers()
	For i := 2 To Len(a_UserTemp)
	
		If !a_UserTemp[i][1][17] .And. AllTrim(ZZS->ZZS_USER) <> AllTrim(a_UserTemp[i][1][2])
	
			aAdd( aVetor1, { .F.,;
			              PADR(a_UserTemp[i][1][2], n_TamUser),;
			              a_UserTemp[i][1][4]})
	
		Endif
	
	Next i
	aVetor1 := aSort(aVetor1,,,{ |x,y| x[2] < y[2] } )
Endif
//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+

DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 240,500 PIXEL

@ 003,010 SAY OemToAnsi("Este programa irแ replicar os itens do menu do "+IIF(l_GrpMenu, "grupo", "usuแrio")+" ["+ZZS->ZZS_USER+"] conforme os m๓dulos e") Size 250,050 COLOR CLR_RED OF oDlg PIXEL
@ 010,010 SAY OemToAnsi(IIF(l_GrpMenu, "grupos", "usuแrios")+" selecionados abaixo. CUIDADO. Isto irแ sobrepor os registros atuais.") Size 250,050 COLOR CLR_RED OF oDlg PIXEL

@ 020,010 LISTBOX oLbx VAR cVar FIELDS HEADER " ",;
                                      "M๓dulo" SIZE 090,085 OF oDlg PIXEL ;
                                        ON dblClick( Inverter(@aVetor, @oLbx),oLbx:Refresh(.F.) )

oLbx:SetArray( aVetor )
oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo),;
                    aVetor[oLbx:nAt,2]}}

If l_GrpMenu
	@ 020,105 LISTBOX oLbx1 VAR cVar1 FIELDS HEADER " ",;
	                                      	"Grupo" SIZE 135,085 OF oDlg PIXEL ;
	                                        ON dblClick( Inverter(@aVetor1, @oLbx1),oLbx1:Refresh(.F.) )
	
	oLbx1:SetArray( aVetor1 )
	oLbx1:bLine := {|| {Iif(aVetor1[oLbx1:nAt,1],oOk,oNo),;
	                    aVetor1[oLbx1:nAt,2]}}
Else
	@ 020,105 LISTBOX oLbx1 VAR cVar1 FIELDS HEADER " ",;
	                                      	"Login",;
	                                      	"Nome" SIZE 135,085 OF oDlg PIXEL ;
	                                        ON dblClick( Inverter(@aVetor1, @oLbx1),oLbx1:Refresh(.F.) )
	
	oLbx1:SetArray( aVetor1 )
	oLbx1:bLine := {|| {Iif(aVetor1[oLbx1:nAt,1],oOk,oNo),;
	                    aVetor1[oLbx1:nAt,2],;
	                    aVetor1[oLbx1:nAt,3]}}
Endif
	
DEFINE SBUTTON FROM 107,180 TYPE 1 ACTION (n_Bnt:=1,oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 107,213 TYPE 2 ACTION oDlg:End() ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg CENTERED

If n_Bnt == 1

	l_Gerou := .F.

	oProcess := MsNewProcess():New({|| l_Gerou := fCopyUsr(aVetor, aVetor1, ZZS->ZZS_USER) },"Copiando itens do menu.","Aguarde...",.F.)
	oProcess:Activate()

	If l_Gerou
		MsgInfo("C๓pia realizada com sucesso!", "Processo OK!")
	Else
		MsgStop("Nenhum registro foi copiado.", "Nใo Gerou!")
	Endif

Endif

RestArea( a_AreaATU )
DeleteObject(oOk)
DeleteObject(oNo)

Return Nil
Static Function fCopyUsr(a_Modulo, a_Usuario, c_UsrPrinc)

	Local l_Gerou := .F.
	
	oProcess:SetRegua1(Len(a_Modulo))

	For i := 1 To Len(a_Modulo)

		oProcess:IncRegua1("M๓dulo ...: "+a_Modulo[i][2])
	
		If a_Modulo[i][1]

			c_Query := "SELECT * FROM "+RetSqlName("ZZS")+" "
			c_Query += "WHERE ZZS_FILIAL = '  ' "
			c_Query += "AND ZZS_MODULO = '"+a_Modulo[i][2]+"' "
			c_Query += "AND ZZS_USER = '"+c_UsrPrinc+"' "
			c_Query += "AND D_E_L_E_T_ = ' ' "
			
			If Select("QRY") > 0
				QRY->(DbCloseArea())
			Endif
					
			TCQUERY c_Query NEW ALIAS "QRY"
			
			oProcess:SetRegua2(Len(a_Usuario))

			For j := 1 To Len(a_Usuario)
		
				oProcess:IncRegua2(IIF(l_GrpMenu, "Grupo....:", "Usuแrio...: ")+a_Usuario[j][2])
	
				If a_Usuario[j][1]

					c_Query := "UPDATE "+RetSqlName("ZZS")+" SET D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ "
					c_Query += "WHERE ZZS_FILIAL = '  ' "
					c_Query += "AND ZZS_MODULO = '"+a_Modulo[i][2]+"' "
					c_Query += "AND ZZS_USER = '"+a_Usuario[j][2]+"' "
					c_Query += "AND D_E_L_E_T_ = ' ' "

					TcSqlExec(c_Query)
					
					l_Gerou := .T.
					DbSelectArea("QRY")
					DbGoTop()
					While QRY->(!Eof())
						DbSelectArea("ZZS")
						RecLock("ZZS", .T.)
							ZZS->ZZS_USER	:= a_Usuario[j][2]
							ZZS->ZZS_FUNCAO	:= QRY->ZZS_FUNCAO
							ZZS->ZZS_ACESSO	:= QRY->ZZS_ACESSO
							ZZS->ZZS_STATUS	:= QRY->ZZS_STATUS
							ZZS->ZZS_TITULO	:= QRY->ZZS_TITULO
							ZZS->ZZS_CHAVE	:= QRY->ZZS_CHAVE
							ZZS->ZZS_MODULO	:= QRY->ZZS_MODULO
							ZZS->ZZS_TABELA	:= QRY->ZZS_TABELA
							ZZS->ZZS_DACE01	:= QRY->ZZS_DACE01
							ZZS->ZZS_LACE01	:= IIF(QRY->ZZS_LACE01=="T", .T., .F.)
							ZZS->ZZS_DACE02	:= QRY->ZZS_DACE02
							ZZS->ZZS_LACE02	:= IIF(QRY->ZZS_LACE02=="T", .T., .F.)
							ZZS->ZZS_DACE03	:= QRY->ZZS_DACE03
							ZZS->ZZS_LACE03	:= IIF(QRY->ZZS_LACE03=="T", .T., .F.)
							ZZS->ZZS_DACE04	:= QRY->ZZS_DACE04
							ZZS->ZZS_LACE04	:= IIF(QRY->ZZS_LACE04=="T", .T., .F.)
							ZZS->ZZS_DACE05	:= QRY->ZZS_DACE05
							ZZS->ZZS_LACE05	:= IIF(QRY->ZZS_LACE05=="T", .T., .F.)
							ZZS->ZZS_DACE06	:= QRY->ZZS_DACE06
							ZZS->ZZS_LACE06	:= IIF(QRY->ZZS_LACE06=="T", .T., .F.)
							ZZS->ZZS_DACE07	:= QRY->ZZS_DACE07
							ZZS->ZZS_LACE07	:= IIF(QRY->ZZS_LACE07=="T", .T., .F.)
							ZZS->ZZS_DACE08	:= QRY->ZZS_DACE08
							ZZS->ZZS_LACE08	:= IIF(QRY->ZZS_LACE08=="T", .T., .F.)
							ZZS->ZZS_DACE09	:= QRY->ZZS_DACE09
							ZZS->ZZS_LACE09	:= IIF(QRY->ZZS_LACE09=="T", .T., .F.)
							ZZS->ZZS_DACE10	:= QRY->ZZS_DACE10
							ZZS->ZZS_LACE10	:= IIF(QRY->ZZS_LACE10=="T", .T., .F.)
						MsUnLock()
						QRY->(DbSkip())
					Enddo
				Endif
			
			Next j
		
		Endif
		
	Next i

Return l_Gerou
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfGerXnuLt ณ Gera os arquivos de menu conforme os parametros informados บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fGerXnuLt()

	Local c_Perg 	:= IIF(l_Grpmenu, "MYXNU6", "MYXNU3")
	Local c_Query	:= ""
	Local a_Menu	:= {}

	ValidPerg(c_Perg)
	
	If !Pergunte(c_Perg, .T.)
		Return Nil
	Endif
	
	c_Query += "SELECT ZZS_FILIAL, ZZS_USER, ZZS_MODULO "+Chr(13)
	c_Query += "FROM "+RetSqlName("ZZS")+" "+Chr(13)
	c_Query += "WHERE ZZS_FILIAL = '  ' "+Chr(13)
	c_Query += "AND ZZS_USER BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "+Chr(13)
	c_Query += "AND ZZS_FUNCAO BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "+Chr(13)
	c_Query += "AND ZZS_MODULO BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+Chr(13)
	c_Query += "AND D_E_L_E_T_ = ' ' "+Chr(13)
	c_Query += "GROUP BY ZZS_FILIAL, ZZS_USER, ZZS_MODULO "+Chr(13)
	
	If Select("QRY") > 0
		QRY->(DbCloseArea())
	Endif
	
	TCQUERY c_Query NEW ALIAS "QRY"
	
	While QRY->(!Eof())
		aAdd(a_Menu, {QRY->ZZS_MODULO, QRY->ZZS_USER})
		QRY->(DbSkip())
	Enddo

	If Len(a_Menu) > 0

		Processa({|| fXnuLote(a_Menu) },"Gerando menu(s) do "+IIF(l_grpMenu, "grupo", "usuแrio")+".")
		MsgInfo("Foram gerados [ "+AllTrim(Str(Len(a_Menu)))+" ] arquivos de menu no diret๓rio "+AllTrim(GetMV("MV_XPATMNU"))+" com sucesso!", "Processo Finalizado!")
	
	Else
		MsgStop("Nใo foi localizado nenhum registro conforme os parametros selecionados.", "Sem registro")
	Endif

	
Return Nil
Static Function fXnuLote(a_Menu)

	Local c_NomMenu := ""
	ProcRegua(Len(a_Menu))
	
	For n_Menu := 1 To Len(a_Menu)
		IncProc(IIF(l_GrpMenu, "Grupo ...:", "Usuแrio ...: ")+AllTrim(a_Menu[n_Menu][2])+ "   - M๓dulo ...: "+a_Menu[n_Menu][1])
		c_NomMenu := SubStr(AllTrim(a_Menu[n_Menu][1]), 5)+"_"+AllTrim(a_Menu[n_Menu][2])
		U_GerMenu(.F., a_Menu[n_Menu][1], a_Menu[n_Menu][2], c_NomMenu)
	Next n_Menu

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfSelUser  ณ Monta tela para selecionar os modulos.                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fSelUser()
	
Local a_AreaATU	:= GetArea()
Local a_AreaZZR	:= ZZR->(GetArea())
Local a_AreaZZS	:= ZZS->(GetArea())
Local cVar     	:= Nil
Local oDlg     	:= Nil
Local cTitulo  	:= "M๓dulos utilizados pela empresa ["+AllTrim(SM0->M0_NOME)+"]."
Local lMark    	:= .F.
Local oOk      	:= LoadBitmap( GetResources(), "LBOK" )
Local oNo      	:= LoadBitmap( GetResources(), "LBNO" )
Local oChk     	:= Nil
Local n_Bnt    	:= 0
Local c_Query 	:= ""

c_Query := "SELECT DISTINCT ZZR_MODULO, ZZR_TITMOD "
c_Query += "FROM "+RetSqlName("ZZR")+" "
c_Query += "INNER JOIN "+RetSqlName("ZZS")+" "
c_Query += "	ON ZZS_FILIAL = ZZR_FILIAL "
c_Query += "	AND ZZS_MODULO = ZZR_MODULO "
c_Query += "	AND ZZS_USER = '"+ZZS->ZZS_USER+"' "
c_Query += "	AND "+RetSqlName("ZZS")+".D_E_L_E_T_ = ' ' "
c_Query += "WHERE "+RetSqlName("ZZR")+".D_E_L_E_T_ = ' ' "
c_Query += "ORDER BY ZZR_TITMOD "

Private lChk	:= .F.

Private oLbx 	:= Nil
Private aVetor 	:= {}

If Select("QRY") > 0
	QRY->(DbCloseArea())
Endif

TCQUERY c_Query NEW ALIAS "QRY"

//+-------------------------------------+
//| Carrega o vetor conforme a condicao |
//+-------------------------------------+
While QRY->(!Eof())

	aAdd( aVetor, { lMark,;
                   QRY->ZZR_MODULO,;
                   QRY->ZZR_TITMOD})

	QRY->(DbSkip())
Enddo

//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+
If Len( aVetor ) == 0
   Aviso( cTitulo, "Nao existem menus principais a consultar", {"Ok"} )
   Return Nil
Endif

DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 240,500 PIXEL

@ 003,010 SAY OemToAnsi("Este programa irแ gerar os menus para o "+IIF(l_GrpMenu, "grupo", "usuแrio")+" ["+ZZS->ZZS_USER+"] conforme os m๓dulos") Size 250,050 COLOR CLR_RED OF oDlg PIXEL
@ 010,010 SAY OemToAnsi("selecionados abaixo.") Size 250,050 COLOR CLR_RED OF oDlg PIXEL

@ 020,010 LISTBOX oLbx VAR cVar FIELDS HEADER " ",;           
                                      "M๓dulo",;
                                      "Descri็ใo" SIZE 230,085 OF oDlg PIXEL ;
                                        ON dblClick( Inverter(@aVetor, @oLbx),oLbx:Refresh(.F.) )

oLbx:SetArray( aVetor )
oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo),;
                    aVetor[oLbx:nAt,2],;
                    aVetor[oLbx:nAt,3]}}
	 
@107, 010 CHECKBOX oChk VAR lChk PROMPT "Marca/Desmarca" SIZE 80,10 PIXEL OF oDlg;
         ON CLICK(Iif(lChk,Marca(lChk),Marca(lChk)))

DEFINE SBUTTON FROM 107,180 TYPE 1 ACTION (n_Bnt:=1,oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 107,213 TYPE 2 ACTION oDlg:End() ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg CENTERED

If n_Bnt == 1
	
	l_Gerou := .F.
	
	Processa({|| l_Gerou := fGerMenu(aVetor, ZZS->ZZS_USER) },"Gerando menu(s) do "+IIF(l_GrpMenu, "grupo", "usuแrio")+".")

	If l_Gerou
		MsgInfo("Arquivo(s) gerado(s) com sucesso!", "Processo OK!")
	Else
		MsgStop("Nenhum arquivo de menu foi gerado.", "Nใo Gerou!")
	Endif

Endif

RestArea( a_AreaZZS )
RestArea( a_AreaZZR )
RestArea( a_AreaATU )
DeleteObject(oOk)
DeleteObject(oNo)

Return Nil
Static Function fGerMenu(a_Mod, c_User)

	Local l_Gerou := .F.
	Local c_NomMenu	:= ""
	
	ProcRegua(Len(a_Mod))
	
	For n_Mod := 1 To Len(a_Mod)
		If a_Mod[n_Mod][1]
			IncProc(IIF(l_GrpMenu, "Grupo ...: ", "Usuแrio ...: ")+AllTrim(c_User)+ "   - M๓dulo ...: "+a_Mod[n_Mod][2])
			c_NomMenu := SubStr(AllTrim(a_Mod[n_Mod][2]), 5)+"_"+AllTrim(c_User)
			U_GerMenu(.F., a_Mod[n_Mod][2], c_User, c_NomMenu)
			l_Gerou := .T.
		Endif
	Next n_Mod

Return l_Gerou
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบInverter  ณ Inverte, marca / desmarca o item.                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ aVet   => Vetor do objeto lista                            บฑฑ
ฑฑบ          ณ oObj   => Objeto lista                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Inverter(aVet, oObj)

	aVet[oObj:nAt][1] := !aVet[oObj:nAt][1]
	oObj:Refresh()

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบMarca     ณ Inverte a marcacao de todos os itens.                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ lMarca  ==> Item marcado = .T., nao marcado = .F.          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Marca(lMarca)
	
	Local i := 0
	For i := 1 To Len(aVetor)
	   aVetor[i][1] := lMarca
	Next i
	oLbx:Refresh()
	
Return Nil
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ fImpMenu   ณ Autor ณ Douglas Viegas Franca     ณ Data ณ 24/02/11 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Este programa tem por objetivo habilitar todas as funcionalidadesณฑฑ
ฑฑณ          ณque o usuario ja utiliza no modelo de menu padrao.                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nil => Nenhum                                                    ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ Nil => Nenhum                                                    ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤยฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณAnalista Resp.ณ  Data  ณ Manutencao Efetuada                                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ              ณ  /  /  ณ                                                     ณฑฑ
ฑฑณ              ณ  /  /  ณ                                                     ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function fImpMenu()

Local l_ImpOK 	:= .F.
Local n_ArqImp	:= 0                    
Local c_Modulo	:= ""                            
Local c_User	:= ""               
Local a_UsrGrp	:= {}
Local n_UsrGrp	:= 1
Local l_AllUser	:= MsgNoYes("Deseja processar todos os Usuแrios/Grupos ativos de uma ๚nica vez?", "Confirma็ใo")

If ( l_AllUser )

	If l_GrpMenu
		//Carrego todos os Grupos
		MsgRun("Selecionando os grupos... Por favor, aguarde", "Menu de Acesso", { || a_UsrGrp := AllGroups()})
	Else
		//Carrego todos os usuarios ATIVOS
		MsgRun("Selecionando os usuแrios... Por favor, aguarde", "Menu de Acesso", { || a_UsrGrp := AllUsers()})
	Endif

Else
	a_UsrGrp := {{""}}
Endif

For n_UsrGrp := 1 To Len(a_UsrGrp)
	
	//Montar tela para selecionar usuario e menus que serao importados
	Private a_USRxMOD := fGetInfoUsr(l_AllUser, a_UsrGrp[n_UsrGrp])
	
	//a_USRxMOD[1][1] => Nome do Usuario
	//a_USRxMOD[1][2] => Array com os modulos selecionados
	//a_USRxMOD[1][2][1][1] => Nome do Modulo
	//a_USRxMOD[1][2][1][2] => Caminho do arquivo xnu
	
	//Private a_USRxMOD := { {"DVFTESTE", {{"SIGAFAT", "\SYSTEM\TSTMENU\DVF_FAT.xnu"}, {"SIGAEST", "\SYSTEM\TSTMENU\DVF_EST.xnu"}}} }
	
	//Verifico se foi selecionado algum usuแrio
	If !Empty(a_USRxMOD[1][1])
	
		n_QtdArq := Len(a_USRxMOD[1][2])
		
		For n_Files := 1 To n_QtdArq
		
			l_ImpOK := .F.
			
			c_Arq	:= a_USRxMOD[1][2][n_Files][2]
			
			If File(c_Arq) 
				
				c_User := PADR(a_USRxMOD[1][1], n_TamUser)
				c_Modulo := PADR(a_USRxMOD[1][2][n_Files][1], 10)
				
				//Verifico se ja existe ZZS para este usuario / modulo, se nao existir gero nesse momento
				DbSelectArea("ZZS")
				DbSetOrder(3) //ZZS_FILIAL, ZZS_MODULO, ZZS_USER, ZZS_CHAVE, ZZS_FUNCAO, R_E_C_N_O_, D_E_L_E_T_
				If ( !DbSeek(xFilial("ZZS")+c_Modulo+c_User, .F.) )
			
					U_fGrvZZS({{.T., c_Modulo}}, {{.T., c_User}})
			
				Endif
			
				Processa({|| l_ImpOK := LeArqUsr(c_Arq, a_USRxMOD[1][1], a_USRxMOD[1][2][n_Files][1]) },"Arquivo" + Str(n_Files,2) + " de " + Str(n_QtdArq,2) + " - " + c_Arq)
				
				If l_ImpOK
					n_ArqImp++
				Endif
	
			Endif
			
		Next n_Files
	
	Endif

Next n_UsrGrp

If n_ArqImp == 0
	MsgAlert("ATENวยO.: Nenhum arquivo de menu foi importado.", "Nใo Importou")
Else
	MsgInfo("Arquivo(s) Importado(s).: "+StrZero(n_ArqImp, 2), "Resumo")
Endif

Return Nil           
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบLeArqUsr  ณ Ler o arquivo *.xnu informado atraves dos parametros e gra-บฑฑ
ฑฑบ          ณ var os registros na tabela ZZS.                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ c_File    ==> Caminho completo do arquivo XNU.             บฑฑ
ฑฑบ          ณ c_UserMnu ==> Login do Usuario.                            บฑฑ
ฑฑบ          ณ c_Modulo  ==> Modulo do sistema.                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function LeArqUsr(c_File, c_UserMnu, c_Modulo)

Local c_NomMod 	:= Space(10)
Local c_Mod		:= ""
Local c_File	:= AllTrim(c_File)

a_Xnu := XNULoad(c_File)

If Len(a_Xnu) == 0
	MsgStop("Arquivo(s) nใo localizado(s). Verifique os parโmetros.", "Importa็ใo cancelada.")
	Return .F.
Endif

a_RetMod := RetModName()

aAdd(a_RetMod, {99, "SIGACFG", "Configurador", .T.})

n_Pos := aScan(a_RetMod, {|x| Upper(AllTrim(x[2])) == Upper(AllTrim(c_Modulo))})

If n_Pos == 0
	MsgStop("M๓dulo ["+AllTrim(c_Modulo)+"] nใo localizado.", "Inconsist๊ncia")
	Return .F.
Endif

c_NumMod := StrZero(a_RetMod[n_Pos][1], 2)
c_NomMod := a_RetMod[n_Pos][2]+Replicate(" ", 10 - Len(a_RetMod[n_Pos][2]))
c_TitMod := a_RetMod[n_Pos][3]

DbSelectArea("ZZR")
DbSetOrder(1) //ZZR_FILIAL, ZZR_MODULO, ZZR_CHAVE, R_E_C_N_O_, D_E_L_E_T_
If !DbSeek(xFilial("ZZR") + c_NomMod, .F.)
	MsgAlert("Nใo foi localizado o m๓dulo "+c_NomMod+" no menu [Matriz].", "Importa็ใo Cancelada")
	Return .F.
Endif

ProcRegua(Len(a_Xnu))

Begin Transaction

For n_N1 := 1 To Len(a_Xnu)
	
	c_Chave	 := StrZero(n_N1,1)
	c_TitPor := a_Xnu[n_N1][1][1]
	c_TitEsp := a_Xnu[n_N1][1][2]
	c_TitEng := a_Xnu[n_N1][1][3]
	
	IncProc("Gravando...: "+c_TitPor)
	
	For n_N2 := 1 To Len(a_Xnu[n_N1][3])
		
		If ValType(a_Xnu[n_N1][3][n_N2][3]) == "A"
			
			c_Chave	 := StrZero(n_N1,1)+"."+StrZero(n_N2,2)
			c_TitPor := a_Xnu[n_N1][3][n_N2][1][1]
			c_TitEsp := a_Xnu[n_N1][3][n_N2][1][2]
			c_TitEng := a_Xnu[n_N1][3][n_N2][1][3]
			
			For n_N3 := 1 To Len(a_Xnu[n_N1][3][n_N2][3])
				
				If ValType(a_Xnu[n_N1][3][n_N2][3][n_N3][3]) == "A"
					
					c_Chave	 := StrZero(n_N1,1)+"."+StrZero(n_N2,2)+"."+StrZero(n_N3,2)
					c_TitPor := a_Xnu[n_N1][3][n_N2][3][n_N3][1][1]
					c_TitEsp := a_Xnu[n_N1][3][n_N2][3][n_N3][1][2]
					c_TitEng := a_Xnu[n_N1][3][n_N2][3][n_N3][1][3]
					
					For n_N4 := 1 To Len(a_Xnu[n_N1][3][n_N2][3][n_N3][3])
						
						If ValType(a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3]) == "A"
							
							c_Chave	 := StrZero(n_N1,1)+"."+StrZero(n_N2,2)+"."+StrZero(n_N3,2)
							c_TitPor := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][1][1]
							c_TitEsp := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][1][2]
							c_TitEng := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][1][3]
							
							For n_N5 := 1 To Len(a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3])
								
								c_TitPor := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][1][1]
								c_TitEsp := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][1][2]
								c_TitEng := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][1][3]
								
								c_Status := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][2]
								c_Funcao := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][3]
								
								c_Access := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][5]
								c_Tipo   := AllTrim(Str(a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][7]))
								
								c_Tabela := ""
								
								For n_Tabela := 1 To Len(a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][4])
									
									c_Tabela += a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][4][n_Tabela]
									
								Next n_Tabela
								
								c_Chave := StrZero(n_N1,1)+"."+StrZero(n_N2,2)+"."+StrZero(n_N3,2)+"."+StrZero(n_N4,2)+"."+StrZero(n_N5,2)
								
								fUpdZZSUsr(c_UserMnu, c_Funcao, c_NomMod, c_Tabela, c_Access, c_Status)
								
							Next n_N5
							
						Else
							
							c_TitPor := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][1][1]
							c_TitEsp := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][1][2]
							c_TitEng := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][1][3]
							
							c_Status := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][2]
							c_Funcao := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3]
							
							c_Access := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][5]
							c_Tipo   := AllTrim(Str(a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][7]))
							
							c_Tabela := ""
							
							For n_Tabela := 1 To Len(a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][4])
								
								c_Tabela += a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][4][n_Tabela]
								
							Next n_Tabela
							
							c_Chave := StrZero(n_N1,1)+"."+StrZero(n_N2,2)+"."+StrZero(n_N3,2)+"."+StrZero(n_N4,2)
							
							fUpdZZSUsr(c_UserMnu, c_Funcao, c_NomMod, c_Tabela, c_Access, c_Status)
							
						Endif

					Next n_N4
					
				Else
					
					c_TitPor := a_Xnu[n_N1][3][n_N2][3][n_N3][1][1]
					c_TitEsp := a_Xnu[n_N1][3][n_N2][3][n_N3][1][2]
					c_TitEng := a_Xnu[n_N1][3][n_N2][3][n_N3][1][3]
					
					c_Status := a_Xnu[n_N1][3][n_N2][3][n_N3][2]
					c_Funcao := a_Xnu[n_N1][3][n_N2][3][n_N3][3]
					
					c_Access := a_Xnu[n_N1][3][n_N2][3][n_N3][5]
					c_Tipo   := AllTrim(Str(a_Xnu[n_N1][3][n_N2][3][n_N3][7]))
					
					c_Tabela := ""
					
					For n_Tabela := 1 To Len(a_Xnu[n_N1][3][n_N2][3][n_N3][4])
						
						c_Tabela += a_Xnu[n_N1][3][n_N2][3][n_N3][4][n_Tabela]
						
					Next n_Tabela
					
					c_Chave := StrZero(n_N1,1)+"."+StrZero(n_N2,2)+"."+StrZero(n_N3,2)
					
					fUpdZZSUsr(c_UserMnu, c_Funcao, c_NomMod, c_Tabela, c_Access, c_Status)
					
				Endif
				
			Next n_N3
			
		Else
			
			c_TitPor := a_Xnu[n_N1][3][n_N2][1][1]
			c_TitEsp := a_Xnu[n_N1][3][n_N2][1][2]
			c_TitEng := a_Xnu[n_N1][3][n_N2][1][3]
			
			c_Status := a_Xnu[n_N1][3][n_N2][2]
			c_Funcao := a_Xnu[n_N1][3][n_N2][3]
			
			c_Access := a_Xnu[n_N1][3][n_N2][5]
			c_Tipo   := AllTrim(Str(a_Xnu[n_N1][3][n_N2][7]))
			
			c_Tabela := ""
			
			For n_Tabela := 1 To Len(a_Xnu[n_N1][3][n_N2][4])
				
				c_Tabela += a_Xnu[n_N1][3][n_N2][4][n_Tabela]
				
			Next n_Tabela
			
			c_Chave := StrZero(n_N1,1)+"."+StrZero(n_N2,2)
			
			fUpdZZSUsr(c_UserMnu, c_Funcao, c_NomMod, c_Tabela, c_Access, c_Status)
			
		Endif
		
	Next n_N2
	
Next n_N1

End Transaction

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfUpdZZSUsrณ Gravar os dados no arquivo ZZR.                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ c_UserMnu   ==> Login do Usuario.                          บฑฑ
ฑฑบ          ณ c_Funcao    ==> Nome da funcao a ser executada no menu.    บฑฑ
ฑฑบ          ณ c_NomMod    ==> Nome simplificado do Modulo. Ex.: SIGAFAT  บฑฑ
ฑฑบ          ณ c_Tabela    ==> Tabelas que devem ser abertas pela funcao. บฑฑ
ฑฑบ          ณ c_Access    ==> Acessos aos itens das funcoes.             บฑฑ
ฑฑบ          ณ c_CodStatus ==> H=Habilitado; I=Inibido ou D=Desabilitado  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
//Static Function fUpdZZSUsr(c_NumMod, c_NomMod, c_TitMod, c_Chave, c_TitPor,c_TitEsp, c_TitEng, c_Funcao, c_Tipo, c_Tabela, c_Access, l_DescAces)
Static Function fUpdZZSUsr(c_UserMnu, c_Funcao, c_NomMod, c_Tabela, c_Access, c_CodStatus)

Local c_FuncSeek	:= c_Funcao + Replicate(" ", 10 - Len(c_Funcao))
Local c_NewAccess	:= ""

c_UserMnu := PADR(c_UserMnu, n_TamUser)

If c_CodStatus == "E" //Enable
	c_CodStatus := "H" //Habilitado
Else //Desabilitado ou Inibido
	c_CodStatus := "I" //Inibido
Endif

DbSelectArea("ZZS")
DbSetOrder(1) //ZZS_FILIAL, ZZS_USER, ZZS_FUNCAO, ZZS_MODULO, R_E_C_N_O_, D_E_L_E_T_
If DbSeek(xFilial("ZZS")+c_UserMnu+c_FuncSeek+c_NomMod, .F.)

	RecLock("ZZS", .F.)
	
	If ZZS->ZZS_STATUS <> "H" //Habilitado
		Replace ZZS_STATUS	With c_CodStatus
	Endif
	
	Replace ZZS_TABELA	With c_Tabela
	
	For a := 1 To 10   
	
		c_CpoAccess := "ZZS_LACE"+StrZero(a,2)
		
		If SubStr(c_Access, a, 1) == "x"
			Replace &(c_CpoAccess)	With .T.
		Endif
		
		If &(c_CpoAccess)
			c_NewAccess += "x"
		Else
			c_NewAccess += " "
		Endif
		
	Next a
	
	Replace ZZS_ACESSO	With c_NewAccess
	MsUnLock()

Endif

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณVALIDPERG บ Autor ณ MKW Windows 2.0    บ Data ณ  06/01/99   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Verifica a existencia das perguntas criando-as caso seja   บฑฑ
ฑฑบ          ณ necessario (caso nao existam).                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ValidPerg(c_Perg)

	c_Perg 	:= PADR(c_Perg, 10)
	aRegs	:= {}
	
	If AllTrim(c_Perg) == "MYXNU2"
		//            Grupo /Ordem /Pergunta                 /PERSPA   / PERENG/Variavel/Tipo   /Tamanho  /Decimal/Presel /GSC /Valid/Var01      /Def01      /DEFSPA1 /DEFENG1 /Cnt01 /Var02     /Def02           /DEFSPA2 /DEFENG2 /Cnt02 /Var03     /Def03          /DEFSPA3 /DEFENG3 /Cnt03 /Var04     /Def04          /DEFSPA4 /DEFENG4 /Cnt04 /Var05     /Def05          /DEFSPA5/DEFENG5  /Cnt05 /F3   /PYME/GRPSXG
		aAdd(aRegs,{c_Perg,"01"  ,"Atualiz. Acesso        ?",""      ,""     ,"MV_CH1","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR01","Sim"      	,""      ,""      ,""   ,""         ,"Nใo"         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"02"  ,"Acesso (- Nใo Atualiza)?",""      ,""     ,"MV_CH2","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR02",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"03"  ,"Atualiz. Status        ?",""      ,""     ,"MV_CH3","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR03","Sim"      	,""      ,""      ,""   ,""         ,"Nใo"         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"04"  ,"Status                 ?",""      ,""     ,"MV_CH4","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR04","Habilitado"   ,""      ,""      ,""   ,""         ,"Desabilitado",""      ,""      ,""    ,""        ,"Inibido"      ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"05"  ,"Usuแrio de             ?",""      ,""     ,"MV_CH5","C"    ,n_TamUser      ,0       ,0     ,"G" ,""    ,"MV_PAR05",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"06"  ,"Usuแrio at้            ?",""      ,""     ,"MV_CH6","C"    ,n_TamUser      ,0       ,0     ,"G" ,""    ,"MV_PAR06",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"07"  ,"Chave(Tree Key) de     ?",""      ,""     ,"MV_CH7","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR07",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"08"  ,"Chave(Tree Key) at้    ?",""      ,""     ,"MV_CH8","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR08",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"09"  ,"Fun็ใo de              ?",""      ,""     ,"MV_CH9","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR09",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"10"  ,"Fun็ใo at้             ?",""      ,""     ,"MV_CHA","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR10",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"11"  ,"M๓dulo de              ?",""      ,""     ,"MV_CHB","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR11",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"12"  ,"M๓dulo at้             ?",""      ,""     ,"MV_CHC","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR12",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"13"  ,"Atualiz. Tabelas       ?",""      ,""     ,"MV_CHD","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR13","Sim"      	,""      ,""      ,""   ,""         ,"Nใo"         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"14"  ,"Tabelas                ?",""      ,""     ,"MV_CHE","C"    ,60      ,0       ,0     ,"G" ,""    ,"MV_PAR14",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
	ElseIf AllTrim(c_Perg) == "MYXNU5"                          
		//            Grupo /Ordem /Pergunta                 /PERSPA   / PERENG/Variavel/Tipo   /Tamanho  /Decimal/Presel /GSC /Valid/Var01      /Def01      /DEFSPA1 /DEFENG1 /Cnt01 /Var02     /Def02           /DEFSPA2 /DEFENG2 /Cnt02 /Var03     /Def03          /DEFSPA3 /DEFENG3 /Cnt03 /Var04     /Def04          /DEFSPA4 /DEFENG4 /Cnt04 /Var05     /Def05          /DEFSPA5/DEFENG5  /Cnt05 /F3   /PYME/GRPSXG
		aAdd(aRegs,{c_Perg,"01"  ,"Atualiz. Acesso        ?",""      ,""     ,"MV_CH1","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR01","Sim"      	,""      ,""      ,""   ,""         ,"Nใo"         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"02"  ,"Acesso (- Nใo Atualiza)?",""      ,""     ,"MV_CH2","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR02",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"03"  ,"Atualiz. Status        ?",""      ,""     ,"MV_CH3","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR03","Sim"      	,""      ,""      ,""   ,""         ,"Nใo"         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"04"  ,"Status                 ?",""      ,""     ,"MV_CH4","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR04","Habilitado"   ,""      ,""      ,""   ,""         ,"Desabilitado",""      ,""      ,""    ,""        ,"Inibido"      ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"05"  ,"Grupo de               ?",""      ,""     ,"MV_CH5","C"    ,n_TamUser      ,0       ,0     ,"G" ,""    ,"MV_PAR05",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"06"  ,"Grupo at้              ?",""      ,""     ,"MV_CH6","C"    ,n_TamUser      ,0       ,0     ,"G" ,""    ,"MV_PAR06",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"07"  ,"Chave(Tree Key) de     ?",""      ,""     ,"MV_CH7","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR07",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"08"  ,"Chave(Tree Key) at้    ?",""      ,""     ,"MV_CH8","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR08",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"09"  ,"Fun็ใo de              ?",""      ,""     ,"MV_CH9","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR09",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"10"  ,"Fun็ใo at้             ?",""      ,""     ,"MV_CHA","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR10",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"11"  ,"M๓dulo de              ?",""      ,""     ,"MV_CHB","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR11",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"12"  ,"M๓dulo at้             ?",""      ,""     ,"MV_CHC","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR12",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"13"  ,"Atualiz. Tabelas       ?",""      ,""     ,"MV_CHD","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR13","Sim"      	,""      ,""      ,""   ,""         ,"Nใo"         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"14"  ,"Tabelas                ?",""      ,""     ,"MV_CHE","C"    ,60      ,0       ,0     ,"G" ,""    ,"MV_PAR14",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
	ElseIf AllTrim(c_Perg) == "MYXNU3"
		//            Grupo /Ordem /Pergunta             /PERSPA   / PERENG/Variavel/Tipo   /Tamanho  /Decimal/Presel /GSC /Valid/Var01      /Def01      /DEFSPA1 /DEFENG1 /Cnt01 /Var02     /Def02           /DEFSPA2 /DEFENG2 /Cnt02 /Var03     /Def03          /DEFSPA3 /DEFENG3 /Cnt03 /Var04     /Def04          /DEFSPA4 /DEFENG4 /Cnt04 /Var05     /Def05          /DEFSPA5/DEFENG5  /Cnt05 /F3   /PYME/GRPSXG
		aAdd(aRegs,{c_Perg,"01"  ,"Usuแrio de         ?",""      ,""     ,"MV_CH1","C"    ,n_TamUser      ,0       ,0     ,"G" ,""    ,"MV_PAR01",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"02"  ,"Usuแrio at้        ?",""      ,""     ,"MV_CH2","C"    ,n_TamUser      ,0       ,0     ,"G" ,""    ,"MV_PAR02",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"03"  ,"Fun็ใo de          ?",""      ,""     ,"MV_CH3","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR03",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"04"  ,"Fun็ใo at้         ?",""      ,""     ,"MV_CH4","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR04",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"05"  ,"M๓dulo de          ?",""      ,""     ,"MV_CH5","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR05",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"06"  ,"M๓dulo at้         ?",""      ,""     ,"MV_CH6","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR06",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
	ElseIf AllTrim(c_Perg) == "MYXNU6"
		//            Grupo /Ordem /Pergunta             /PERSPA   / PERENG/Variavel/Tipo   /Tamanho  /Decimal/Presel /GSC /Valid/Var01      /Def01      /DEFSPA1 /DEFENG1 /Cnt01 /Var02     /Def02           /DEFSPA2 /DEFENG2 /Cnt02 /Var03     /Def03          /DEFSPA3 /DEFENG3 /Cnt03 /Var04     /Def04          /DEFSPA4 /DEFENG4 /Cnt04 /Var05     /Def05          /DEFSPA5/DEFENG5  /Cnt05 /F3   /PYME/GRPSXG
		aAdd(aRegs,{c_Perg,"01"  ,"Grupo de           ?",""      ,""     ,"MV_CH1","C"    ,n_TamUser      ,0       ,0     ,"G" ,""    ,"MV_PAR01",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"02"  ,"Grupo at้          ?",""      ,""     ,"MV_CH2","C"    ,n_TamUser      ,0       ,0     ,"G" ,""    ,"MV_PAR02",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"03"  ,"Fun็ใo de          ?",""      ,""     ,"MV_CH3","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR03",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"04"  ,"Fun็ใo at้         ?",""      ,""     ,"MV_CH4","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR04",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"05"  ,"M๓dulo de          ?",""      ,""     ,"MV_CH5","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR05",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"06"  ,"M๓dulo at้         ?",""      ,""     ,"MV_CH6","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR06",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
	Endif
	
	U_PutX1ESP(c_Perg, aRegs)

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณfGetInfoUsrบ Autor ณ Douglas Franca    บ Data ณ  24/02/11   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Captura as informacoes sobre os menus do usuario que serao บฑฑ
ฑฑบ          ณimportados.                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fGetInfoUsr(l_AllUser, a_User)

Local oDlgMnuUsr
Local cTitulo  		:= "Importa็ใo - Menus do usuแrio"
Local n_Opc 		:= 0

Default l_AllUser	:= .F.

Private oOk      	:= LoadBitmap( GetResources(), "CHECKED" )   //CHECKED    //LBOK  //LBTIK
Private oNo      	:= LoadBitmap( GetResources(), "UNCHECKED" ) //UNCHECKED  //LBNO
Private oChk1
Private oChk2
Private lChk1		:= .F.
Private lChk2		:= .F.
Private oLbx
Private aVetor		:= {}                
Private a_RetMod 	:= RetModName()
Private a_Ret		:= { {"", {}} }
Private c_UserName	:= Space(n_TamUser)

If ( l_AllUser )

	c_UserName := a_User[1][2]                   
	l_Bloqueado := a_User[1][17]
	a_Grupos := a_User[1][10]
	
	n_GrpAdmin := aScan(a_Grupos, "000000")
	
	//Nao esteja bloqueado e nao seja do grupo administrador
	If ( !l_Bloqueado .And. n_GrpAdmin == 0)

		//Carrego os menus do usuario
		fVldNomUsr(c_UserName, l_AllUser)
	
		a_Ret[1][1] := c_UserName
		For b := 1 To Len(aVetor)
			aAdd(a_Ret[1][2], {aVetor[b][2], aVetor[b][3]} )
		Next b
	
	Endif
		
Else

	DEFINE MSDIALOG oDlgMnuUsr TITLE cTitulo FROM 0,0 TO 280,500 PIXEL
	   
	@ 05,10 SAY "Selecione o usuแrio: " Pixel Of oDlgMnuUsr
	@ 04,60 MSGET c_UserName Size 60,08 Pixel Of oDlgMnuUsr F3 "US3" Valid (fVldNomUsr(c_UserName))
	
	@ 20,10 LISTBOX oLbx FIELDS HEADER ;
	   " ", "Modulo", "Caminho do menu";
	   SIZE 230,105 OF oDlgMnuUsr PIXEL ON dblClick(aVetor[oLbx:nAt,1] := !aVetor[oLbx:nAt,1])
	
	fCarrGrid()
		 
	@ 130,10 CHECKBOX oChk1 VAR lChk1 PROMPT "Marca/Desmarca Todos" SIZE 70,7 PIXEL OF oDlgMnuUsr ;
	         ON CLICK( aEval( aVetor, {|x| x[1] := lChk1 } ),oLbx:Refresh() )
	
	@ 130,95 CHECKBOX oChk2 VAR lChk2 PROMPT "Iverter a sele็ใo" SIZE 70,7 PIXEL OF oDlgMnuUsr ;
	         ON CLICK( aEval( aVetor, {|x| x[1] := !x[1] } ), oLbx:Refresh() )
	
	DEFINE SBUTTON FROM 127,183 TYPE 1 ACTION (n_Opc:=1, oDlgMnuUsr:End()) ENABLE OF oDlgMnuUsr
	DEFINE SBUTTON FROM 127,213 TYPE 2 ACTION (oDlgMnuUsr:End()) ENABLE OF oDlgMnuUsr
	ACTIVATE MSDIALOG oDlgMnuUsr CENTER

	//Preenche o array de retorno
	If ( n_Opc == 1 )
	
		a_Ret[1][1] := c_UserName
		For b := 1 To Len(aVetor)
			If aVetor[b][1]
				aAdd(a_Ret[1][2], {aVetor[b][2], aVetor[b][3]} )
			Endif
		Next b
		
	Endif
	
Endif


Return a_Ret

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | ListBoxMark.prw      | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_ListBoxMar()                                         |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Funcao que marca ou desmarca todos os objetos                   |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
/*
Static Function Marca(lMarca)
Local i := 0
For i := 1 To Len(aVetor)
   aVetor[i][1] := lMarca
Next i
oLbx:Refresh()
Return
*/

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | ListBoxMark.prw      | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_ListBoxMar()                                         |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Funcao que inverte a sele็ใo marcada de todos os objetos        |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
/*
Static Function Inverte()
Local i := 0
For i := 1 To Len(aVetor)
   aVetor[i][1] := !aVetor[i][1]
Next i
oLbx:Refresh()
Return
*/

Static Function fCarrGrid()

If Len(aVetor) == 0
	aVetor := {{.F., "", ""}}
Endif

oLbx:SetArray( aVetor )
oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo),;
                       aVetor[oLbx:nAt,2],;
                       aVetor[oLbx:nAt,3]}}

oLbx:Refresh()

Return Nil

/***********************************************/

Static Function fVldNomUsr(c_UserName, l_AllUser)

Local l_Ret 		:= .F.
Local c_NomMod		:= ""
Local c_PathMnu		:= ""
Local c_Auxiliar	:= ""

//aAdd(a_RetMod, {99, "SIGACFG", "Configurador", .T.})

If !Empty(c_UserName)
	
	l_Ret := .T.
	aVetor := {}
	
	PswOrder(2)
	If PswSeek(c_UserName, .T.)

		a_DadUsr := PswRet()

		For c := 1 To Len(a_DadUsr[3])
			
			c_Auxiliar := AllTrim(a_DadUsr[3][c])
			
			If ( SubStr(c_Auxiliar, 3, 1) <> "X" )
				
				n_Pos := aScan(a_RetMod, {|x| x[1] == Val(Left(c_Auxiliar, 2)) })
				If n_Pos > 0
					c_NomMod		:= a_RetMod[n_Pos][2]
					c_PathMnu		:= SubStr(c_Auxiliar, 4)
					
					aAdd(aVetor, {.F., c_NomMod, c_PathMnu})
					
				Endif
				
			Endif
		
		Next c  
		
		If ( !l_AllUser )
			fCarrGrid()
		Endif
		
	Endif

Endif

Return l_Ret
