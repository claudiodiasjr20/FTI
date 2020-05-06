#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
/******************************************************************************************/

User Function FPREVIRADA(lWizard)

Local aEmpr		:= {}
Local cTxtIntro	:= ""
Local cLog			:= ""
Local lOpen		:= .F.
Local oDlgUpd		:= Nil
Local oProcess	:= Nil

DEFAULT lWizard	:= .F.

Private nModulo		:= 	44
Private lMsFinalAuto	:= 	.F.
Private cDescTitle	:= 'Compatibilizador - Dicionário de Dados - V11 to V12'  //Alterar nesta variável o mês, quando necessário.

Set Deleted On

cTxtIntro += "<table width='100%' border=2 cellpadding='15' cellspacing='5'>"
cTxtIntro += "<tr>"
cTxtIntro += "<td colspan='5' align='center'><font face='Tahoma' size='+2'>"
cTxtIntro += "<b>"+cDescTitle+"</b>"
cTxtIntro += "</font></td>"
cTxtIntro += "</tr>"
cTxtIntro += "<tr>"
cTxtIntro += "<td colspan='5'><font face='Tahoma' color='#000099' size='+1'>"
cTxtIntro += "<b>Este programa tem por objetivo compatibilizar o ambiente do cliente "
cTxtIntro += "em relação ao dicionário de dados, antes de fazer a virada de versão.<br>""
cTxtIntro += "Estas atualizações somente poderão ser realizadas em modo <b>exclusivo!</b><br>"
cTxtIntro += "Faça um backup dos dicionários e da base de dados antes da atualização para eventuais falhas no processo.<br><br>"
//cTxtIntro += "Maiores detalhes sobre o processo de atualização devem ser obtidos no boletim técnico UPDFIS.</b>"
cTxtIntro += "<br><br><br><br><br><br><br><br><br><br>"
cTxtIntro += "</font></td>"
cTxtIntro += "</tr>"
cTxtIntro += "</table>"

If MyOpenSm0Ex(lOpen)

	SM0->( DbEval( {|| If(AScan(aEmpr, {|x| x[1] == FWGrpCompany()}) == 0, AAdd(aEmpr, {FWGrpCompany(),FWCodFil(),RecNo()}), .T.) },, {|| !SM0->(Eof())}) )

	IF !lWizard
		DEFINE MSDIALOG oDlgUpd TITLE cDescTitle FROM 00,00 TO 500,700 PIXEL
	
		TSay():New(005,005,{|| cTxtIntro },oDlgUpd,,,,,,.T.,,,340,200,,,,.T.,,.T.)
		TButton():New( 220,180, '&Processar...', oDlgUpd,{|| RpcClearEnv(), oProcess := MsNewProcess():New( {|| FCProcUpd(aEmpr, oProcess, lWizard) }, 'Aguarde...', 'Iniciando Processamento...', .F.), oProcess:Activate(), oDlgUpd:End()},075,015,,,,.T.,,,,,,)
		TButton():New( 220,270, '&Cancelar', oDlgUpd,{|| RpcClearEnv(), oDlgUpd:End()},075,015,,,,.T.,,,,,,)
	
		ACTIVATE MSDIALOG oDlgUpd CENTERED
	Else
		cLog	:=	FISProcUpd(aEmpr, oProcess,lWizard)
	EndIF

EndIf

RpcClearEnv()

Return (cLog)

/***************************************************************************/

Static Function FCProcUpd(aEmpr, oProcess, lWizard)

Local aArqUpd		:= {}
Local aResumo		:= {}
Local cMsg			:= ""
Local cMsgSPEDC	:= ""
Local cDirFiles	:= ""
Local cTxtIntro	:= ""
Local lOk			:= .F.
Local lOpen		:= .F.
Local lProcAtu	:= .T.
Local nCount		:= 0
Local oDlg			:= Nil
Local aSFV			:= {}
Local aSFW			:= {}
Local aStruct		:= {}
Local cDriver		:= ""
Local cTxt			:= ""

#IFNDEF TOP
	Local cDelInd   := ''
#ENDIF

DEFAULT lWizard	:= .F.

IF !lWizard
	oProcess:SetRegua1(Len(aEmpr)) //Determina a quantidade de processos - da regua superior
Else
	RpcClearEnv()
EndIf

For nCount := 1 To Len(aEmpr)

	If MyOpenSm0Ex(lOpen)
	
		SM0->(DbGoTo(aEmpr[nCount,3]))
		RpcSetType(3)
		RpcSetEnv(aEmpr[nCount,1], aEmpr[nCount,2])
		cDriver	:=	__CRDD
		IF !lWizard
			oProcess:SetRegua2(10) 	//Determina a quantidade de processos - da regua inferior
			oProcess:IncRegua1( 'Processando Empresa: ' + SM0->(M0_CODIGO + ' - ' + AllTrim(M0_NOME))  ) //Incremento da regua superior
		EndIF

		AAdd( aResumo,	{	{ SM0->(M0_CODIGO + ' - ' + AllTrim(M0_NOME))},;
			{/*Atualizacoes SX1*/},;
			{/*SX2*/},;
			{/*SX3*/},;
			{/*SIX*/},;
			{/*SX5*/},;
			{/*SX6*/},;
			{/*SX7*/},;
			{/*SXA*/},;
			{/*SXB*/},;
			{/*Banco de dados*/ } } )
    
		If cPaisLoc == "BRA"
    
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualizando tabela de perguntas, SX1³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//FCAtuSX1(oProcess, @aResumo, lWizard)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualizando tabelas do sistema, SX2 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			FCAtuSX2(oProcess, @aArqUpd, @aResumo, lWizard)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualizando dicionario de dados, SX3³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			FCAtuSX3(oProcess, @aArqUpd, @aResumo, lWizard)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualizacao das Tabelas Genericas (SX5)³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//FCAtuSX5(oProcess, @aResumo, lWizard)
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualizacao dos Parametros (SX6)³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//FCAtuSX6(oProcess, @aResumo, lWizard)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualizacao dos Gatilhos (SX7)³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			FCAtuSX7(oProcess, @aResumo, lWizard)
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualizacao das Folders (SXA)³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//FCAtuSXA(oProcess, @aResumo, lWizard)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualizacao das Consultas Padroes (SXB)³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//FCAtuSXB(oProcess, @aResumo, lWizard)
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualizacao dos Indices do sistema (SIX)³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			FCAtuSIX(oProcess, @aArqUpd, @aResumo, lWizard)
		
		EndIf

		RpcClearEnv()

	EndIf
	
Next nCount

cDirFiles := ''

cTxt += FCShowLog( oProcess, aResumo, !lProcAtu, lWizard ) //Exibe o LOG

Return (cTxt)

/***************************************************************************/

Static Function FCAtuSX3(oProcess, aArqUpd, aResumo, lWizard)

Local aSX3   		:= {}
Local cOrdem 		:= ""
Local nX			:= 0
Local nC			:= 0
Local aArqRet		:= {}

Local a_CposSX3		:= {}
Local n_Cpo    		:= 1

DEFAULT lWizard	:= .F.

//-------- CAMPOS DE SISTEMA NO SX3 QUE ESTAO COMO CAMPOS DE USUARIO -------------------------------------------------------------------------------------
aAdd(a_CposSX3, "AC1_DTOTAL")
aAdd(a_CposSX3, "AC1_HTOTAL")
aAdd(a_CposSX3, "AC1_TPIMP ")
aAdd(a_CposSX3, "AC2_DDURAC")
aAdd(a_CposSX3, "AC2_HDURAC")
aAdd(a_CposSX3, "AC2_DNOTIF")
aAdd(a_CposSX3, "AC2_HNOTIF")
aAdd(a_CposSX3, "ACO_VLRDES")
aAdd(a_CposSX3, "ACP_VLRDES")
aAdd(a_CposSX3, "ACP_TPDESC")
aAdd(a_CposSX3, "AD0_FILIAL")
aAdd(a_CposSX3, "AD0_CNPJ  ")
aAdd(a_CposSX3, "AD0_SERIE ")
aAdd(a_CposSX3, "AD0_DOC   ")
aAdd(a_CposSX3, "AD1_DTPENC")
aAdd(a_CposSX3, "AD1_HRPENC")
aAdd(a_CposSX3, "ADY_CONDPG")
aAdd(a_CposSX3, "ADY_TES   ")
aAdd(a_CposSX3, "ADY_DESCON")
aAdd(a_CposSX3, "ADY_TPPROD")
aAdd(a_CposSX3, "ADY_LOCAL ")
aAdd(a_CposSX3, "ADY_DTREVI")
aAdd(a_CposSX3, "AGP_DTREVI")
aAdd(a_CposSX3, "AIJ_FILIAL")
aAdd(a_CposSX3, "AIJ_NROPOR")
aAdd(a_CposSX3, "AIJ_REVISA")
aAdd(a_CposSX3, "AIJ_PROVEN")
aAdd(a_CposSX3, "AIJ_STAGE ")
aAdd(a_CposSX3, "AIJ_DSTAGE")
aAdd(a_CposSX3, "AIJ_DTINIC")
aAdd(a_CposSX3, "AIJ_HRINIC")
aAdd(a_CposSX3, "AIJ_DTLIMI")
aAdd(a_CposSX3, "AIJ_HRLIMI")
aAdd(a_CposSX3, "AIJ_DTENCE")
aAdd(a_CposSX3, "AIJ_HRENCE")
aAdd(a_CposSX3, "AIJ_DUREST")
aAdd(a_CposSX3, "AIJ_HISTOR")
aAdd(a_CposSX3, "AIJ_STATUS")
aAdd(a_CposSX3, "DY3_INFCPL")
aAdd(a_CposSX3, "A1_DTCAD  ")
aAdd(a_CposSX3, "A1_TPNFSE ")
aAdd(a_CposSX3, "BZ_TRIBMUN")
aAdd(a_CposSX3, "BZ_CNAE   ")
aAdd(a_CposSX3, "C2_TPPR   ")
aAdd(a_CposSX3, "C5_CLIINT ")
aAdd(a_CposSX3, "C5_CGCINT ")
aAdd(a_CposSX3, "C5_IMINT  ")
aAdd(a_CposSX3, "C6_CCUSTO ")
aAdd(a_CposSX3, "D9_CNPJ   ")
aAdd(a_CposSX3, "D9_FILORI ")
aAdd(a_CposSX3, "E1_CCUSTO ")
aAdd(a_CposSX3, "E2_CCUSTO ")
aAdd(a_CposSX3, "E2_FORBCO ")
aAdd(a_CposSX3, "E2_FORAGE ")
aAdd(a_CposSX3, "E2_FAGEDV ")
aAdd(a_CposSX3, "E2_FORCTA ")
aAdd(a_CposSX3, "E2_FCTADV ")
aAdd(a_CposSX3, "E5_CCUSTO ")
aAdd(a_CposSX3, "F6_MUN    ")
aAdd(a_CposSX3, "GU_FILIAL ")
aAdd(a_CposSX3, "GU_CNPJ   ")
aAdd(a_CposSX3, "GU_TIPONF ")
aAdd(a_CposSX3, "GU_FORCLI ")
aAdd(a_CposSX3, "GU_LOJAFC ")
aAdd(a_CposSX3, "GU_NOMEFC ")
aAdd(a_CposSX3, "GU_CNPJFC ")
aAdd(a_CposSX3, "GU_FILDEST")
aAdd(a_CposSX3, "GU_NOMEFIL")
aAdd(a_CposSX3, "N1_TPCTRAT")
aAdd(a_CposSX3, "NO_FORNEC ")
aAdd(a_CposSX3, "NO_LOJA   ")
aAdd(a_CposSX3, "NP_CBASE  ")
aAdd(a_CposSX3, "NP_ITEM   ")
aAdd(a_CposSX3, "NP_FORNEC ")
aAdd(a_CposSX3, "NP_LOJA   ")
aAdd(a_CposSX3, "NP_STATUS ")
aAdd(a_CposSX3, "NP_VIGINI ")
aAdd(a_CposSX3, "NP_VIGFIM ")
aAdd(a_CposSX3, "NP_CONTATO")

//Ordena os campos pelo nome
a_CposSX3 := aSort(a_CposSX3)

//Determina a quantidade de processos na regua 2
If ( !lWizard )
	oProcess:SetRegua2(Len(a_CposSX3))
Endif

dbSelectArea("SX3")
dbSetOrder(2)
dbGoTop()

For n_Cpo := 1 To Len(a_CposSX3)

	If ( !lWizard )
		oProcess:IncRegua2( 'Atualizando Dicionario de Dados (SX3)' )
	EndIF
	
	If DbSeek(PadR(a_CposSX3[n_Cpo],Len(SX3->X3_CAMPO)))
	
		RecLock("SX3", .F.)
		SX3->X3_PROPRI := "S"
		MsUnLock()
	
		AAdd( aResumo[Len(aResumo)][4], SX3->X3_ARQUIVO + ' - ' + SX3->X3_CAMPO )

	EndIf
	
Next n_Cpo

//-------- CAMPOS QUE ESTAO COM O GRUPO DE CAMPOS ERRADO -------------------------------------------------------------------------------------------------
a_CposSX3 := {}
aAdd(a_CposSX3, {"CDQ_CLIENT", "   "})
aAdd(a_CposSX3, {"CL2_PARTI ", "   "})
aAdd(a_CposSX3, {"CVD_CTAREF", "   "})
aAdd(a_CposSX3, {"FIM_CODMUN", "   "})
aAdd(a_CposSX3, {"CKY_DTEMIS", "   "})
aAdd(a_CposSX3, {"EF_NUM    ", "   "})
aAdd(a_CposSX3, {"CLY_GRUPO ", "   "})
aAdd(a_CposSX3, {"E1_LOTE   ", "   "})
aAdd(a_CposSX3, {"E2_LOTE   ", "   "})
aAdd(a_CposSX3, {"E5_LOTE   ", "   "})
aAdd(a_CposSX3, {"EE_LOTE   ", "   "})
aAdd(a_CposSX3, {"EE_LOTECP ", "   "})
aAdd(a_CposSX3, {"F02_VLTOTN", "   "})
aAdd(a_CposSX3, {"F02_VLDEDU", "   "})
aAdd(a_CposSX3, {"F0M_CONTA ", "   "})
aAdd(a_CposSX3, {"CYP_CDLO  ", "   "})
aAdd(a_CposSX3, {"CYV_CDLOSR", "   "})
aAdd(a_CposSX3, {"CZP_CDLO  ", "   "})
aAdd(a_CposSX3, {"WV_LOTE   ", "   "})
aAdd(a_CposSX3, {"QEK_LOTE  ", "   "})
aAdd(a_CposSX3, {"QEL_LOTE  ", "   "})
aAdd(a_CposSX3, {"QEM_LOTE  ", "   "})
aAdd(a_CposSX3, {"QEP_LOTE  ", "   "})
aAdd(a_CposSX3, {"QER_LOTE  ", "   "})
aAdd(a_CposSX3, {"QEY_LOTE  ", "   "})
aAdd(a_CposSX3, {"QEZ_LOTE  ", "   "})
aAdd(a_CposSX3, {"QF2_LOTE  ", "   "})
aAdd(a_CposSX3, {"QF3_LOTE  ", "   "})
aAdd(a_CposSX3, {"QF7_LOTE  ", "   "})
aAdd(a_CposSX3, {"QPK_LOTE  ", "   "})
aAdd(a_CposSX3, {"QPL_LOTE  ", "   "})
aAdd(a_CposSX3, {"QPM_LOTE  ", "   "})
aAdd(a_CposSX3, {"QPR_LOTE  ", "   "})
aAdd(a_CposSX3, {"QPY_LOTE  ", "   "})
aAdd(a_CposSX3, {"QPZ_LOTE  ", "   "})
aAdd(a_CposSX3, {"QQ2_LOTE  ", "   "})
aAdd(a_CposSX3, {"QQG_LOTE  ", "   "})
aAdd(a_CposSX3, {"QQI_LOTE  ", "   "})

//Ordena os campos pelo nome
a_CposSX3 := aSort(a_CposSX3,,,{|x,y| x[1] < y[1]})

//Determina a quantidade de processos na regua 2
If ( !lWizard )
	oProcess:SetRegua2(Len(a_CposSX3))
Endif

dbSelectArea("SX3")
dbSetOrder(2)
dbGoTop()

For n_Cpo := 1 To Len(a_CposSX3)

	If ( !lWizard )
		oProcess:IncRegua2( 'Atualizando Dicionario de Dados (SX3)' )
	EndIF
	
	If DbSeek(PadR(a_CposSX3[n_Cpo][1],Len(SX3->X3_CAMPO)))
	
		RecLock("SX3", .F.)
		SX3->X3_GRPSXG := a_CposSX3[n_Cpo][2]
		MsUnLock()
	
		AAdd( aResumo[Len(aResumo)][4], SX3->X3_ARQUIVO + ' - ' + SX3->X3_CAMPO )

	EndIf
	
Next n_Cpo

/*----------------------------------------------------------------------------*/

DbSelectArea("SX3")
DbSetOrder(2)
DbGoTop()

If ( DbSeek("SG5_USER  ", .F.) )

	RecLock("SX3", .F.)
	DbDelete()
	MsUnLock()

	AAdd( aResumo[Len(aResumo)][4], "SG5 - SG5_USER" )

Endif

/*----------------------------------------------------------------------------*/

DbSelectArea("SX3")
DbSetOrder(2)
DbGoTop()

If ( DbSeek("CTB_FILORI", .F.) )

	RecLock("SX3", .F.)
	X3_TAMANHO := 2
	MsUnLock()

	AAdd( aResumo[Len(aResumo)][4], "CTB - CTB_FILORI" )

Endif

DbSelectArea("SX3")
DbSetOrder(2)
DbGoTop()

/*----------------------------------------------------------------------------*/

DbSelectArea("SXG")
DbSetOrder(1)
DbGoTop()

If ( DbSeek("023", .F.) )

	RecLock("SXG", .F.)
	SXG->XG_SIZEMIN := 9
	SXG->XG_SIZE := 9
	MsUnLock()

	AAdd( aResumo[Len(aResumo)][4], "SXG - 023" )

Endif

Return Nil

/*--ATUALIZACOES NA BASE EM GERAL---------------------------------------------*/
c_QryUpd := "UPDATE TOP_FIELD SET FIELD_PREC = 6 WHERE FIELD_TABLE LIKE '%100%' AND FIELD_NAME LIKE 'A1_NROPAG'"
TcSqlExec(c_QryUpd)


/***************************************************************************/

Static Function FCAtuSX7(oProcess, aResumo, lWizard)

Local aSX7   := {}
Local aEstrut:= {}
Local aClient:= {}
Local cCampo := ""
Local nX     := 0
Local nY     := 0
Local nPos   := 0

Local a_GatSX7		:= {}
Local n_Gat    		:= 1

DEFAULT lWizard	:= .F.

//--------- REMOVE GATILHOS DUPLICADOS ---------------------------------------
aAdd(a_GatSX7, "ED_CGE    001")
aAdd(a_GatSX7, "ED_CGG    001")
aAdd(a_GatSX7, "ED_TABCCZ 001")
aAdd(a_GatSX7, "ED_TABCCZ 002")
aAdd(a_GatSX7, "ED_TABCCZ 003")

a_GatSX7 := aSort(a_GatSX7)

IF !lWizard
	oProcess:SetRegua2(Len(a_GatSX7))
EndIF

dbSelectArea("SX7")
dbSetOrder(1)

For n_Gat := 1 To Len(a_GatSX7)
	
	c_Chave := ""
	SX7->(DbGoTop())
	DbSeek(a_GatSX7[n_Gat])

	IF !lWizard
		oProcess:IncRegua2('Atualizando Gatilhos (SX7)' )
	EndIF

	While ( SX7->(!Eof()) .And. SX7->(X7_CAMPO+X7_SEQUENC) == a_GatSX7[n_Gat] )

		If ( SX7->(X7_CAMPO+X7_SEQUENC) == c_Chave )

			AAdd( aResumo[Len(aResumo)][8], SX7->X7_CAMPO + ' - ' + SX7->X7_SEQUENC)

			RecLock("SX7", .F.)
			Dbdelete()
			MsUnLock()

		Else
			c_Chave := SX7->(X7_CAMPO+X7_SEQUENC)
		Endif

		SX7->(DbSkip())
	Enddo

Next n_Gat 

Return Nil

/***************************************************************************/

Static Function FCAtuSIX(oProcess, aArqUpd, aResumo, lWizard)

Local aSix      := {}
Local aEstrut   := {}
Local aOld      := {}
Local lDelInd   := .F.
Local nOld      := 0
Local nI        := 0
Local nJ        := 0

Local a_IndSix	:= {}
Local n_Six

DEFAULT lWizard	:= .F.

//---- INDICES QUE DEVEM SER EXCLUIDOS APENAS NO ARQUIVO SIX --------------------------------------------------
aAdd(a_IndSix, "BMA2")
aAdd(a_IndSix, "FRF2")
aAdd(a_IndSix, "EJZ1")
aAdd(a_IndSix, "EJZ2")
aAdd(a_IndSix, "ELB1")
aAdd(a_IndSix, "ELB2")
aAdd(a_IndSix, "ELB3")
aAdd(a_IndSix, "TJG1")
aAdd(a_IndSix, "TJG2")

a_IndSix := aSort(a_IndSix)

IF !lWizard
	oProcess:SetRegua2(Len(a_IndSix))//Atualiza barra de progresso
EndIF

DbSelectArea("SIX")
DbSetOrder(1)

For n_Six := 1 To Len(a_IndSix)

	IF !lWizard
		oProcess:IncRegua2( 'Atualizando Indices (SIX)' )//Atualiza barra de progresso
	EndIF


	If ( DbSeek(a_IndSix[n_Six], .F.))
		
		AAdd( aResumo[Len(aResumo)][5], SIX->INDICE + ' - ' + SIX->ORDEM + ' - ' + SIX->CHAVE )

		RecLock("SIX", .F.)
		DbDelete()
		MsUnLock()

	Endif
	
Next n_Six

Return Nil

/***************************************************************************/

Static Function FCAtuSX2(oProcess, aArqUpd, aResumo, lWizard)

Local aSX2   		:= 	{}
Local aEstrut		:= 	{}
Local cPath		:=	""
Local cNome		:=	""
Local nI      	:= 	0
Local nJ      	:= 	0

DEFAULT lWizard	:= .F.

If !lWizard
	oProcess:IncRegua2( 'Atualizando Tabelas (SX2)' )
EndIF

DbSelectArea("SX2")
DbSetOrder(1)
DbGoTop()

If ( DbSeek("EG4", .F.) )

	RecLock("SX2", .F.)
	SX2->X2_ARQUIVO := "EG4" + SubStr(SX2->X2_ARQUIVO, 4, 3)
	MsUnLock()

	AAdd( aResumo[Len(aResumo)][3], SX2->X2_CHAVE + ' - ' + SX2->X2_NOME ) //Atualiza informacoes para montagem-do log de processamento:

Endif

Return Nil

/***************************************************************************/

Static Function FCShowLog( oProcess, aResumo, lProcInt, lWizard )

Local cTxt      := ''
Local cFileLog  := ''
Local cTxtIntro := ''
Local cFile     := ''
Local cMask     := "Arquivos Texto (*.TXT) |*.txt|"

Local nX        := 0
Local nY        := 0

Local oDlgLog   := NIL
Local oMemo     := NIL

Default	lProcInt:=	.F.
DEFAULT lWizard	:= .F.

IF !lWizard
	oProcess:SetRegua1(Len(aResumo))
EndIF

For nX := 1 To Len(aResumo)

	IF !lWizard
		oProcess:IncRegua1( 'LOG -> Empresa: ' + aResumo[nX][1][1]  )
	EndIf
	cTxt += Replicate('=',40) + CHR(13) + CHR(10)
	cTxt += "Atualização: Empresa " + aResumo[nX][1][1] + CHR(13) + CHR(10)
	cTxt += Replicate('=',40) + CHR(13) + CHR(10)
	cTxt += CHR(13) + CHR(10)

	IF !lWizard
		oProcess:SetRegua2(Len(aResumo[nX]))
		oProcess:IncRegua2( 'Atualizações: Grupo de perguntas (SX1)' )
	EndIF

	cTxt += CHR(13) + CHR(10)
	cTxt += "Atualizações: Grupo de perguntas (SX1) - Novos Grupos Criados:" + CHR(13) + CHR(10)
	cTxt += Replicate('-',40) + CHR(13) + CHR(10)
	If Len(aResumo[nX][2]) > 0
		For nY := 1 To Len(aResumo[nX][2])
			cTxt += Iif(!Empty(aResumo[nX][2][nY]),AllTrim(aResumo[nX][2][nY]) + CHR(13) + CHR(10),"")
		Next
	Else
		cTxt += "NENHUMA ATUALIZAÇÃO REALIZADA" + CHR(13) + CHR(10)
	EndIf

	IF !lWizard
		oProcess:IncRegua2( 'Atualizações: Tabelas do Sistema (SX2)' )
	EndIF
	cTxt += CHR(13) + CHR(10)
	cTxt += "Atualizações: Tabelas do Sistema (SX2) - Novas Tabelas:" + CHR(13) + CHR(10)
	cTxt += Replicate('-',40) + CHR(13) + CHR(10)
	If Len(aResumo[nX][3]) > 0
		For nY := 1 To Len(aResumo[nX][3])
			cTxt += Iif(!Empty(aResumo[nX][3][nY]),AllTrim(aResumo[nX][3][nY]) + CHR(13) + CHR(10),"")
		Next
	Else
		cTxt += "NENHUMA ATUALIZAÇÃO REALIZADA" + CHR(13) + CHR(10)
	EndIf

	IF !lWizard
		oProcess:IncRegua2( 'Atualizações: Dicionário de Campos (SX3)' )
	EndIF
	cTxt += CHR(13) + CHR(10)
	cTxt += "Atualizações: Dicionário de Campos (SX3) - Campos Criados/Atualizados:" + CHR(13) + CHR(10)
	cTxt += Replicate('-',40) + CHR(13) + CHR(10)
	If Len(aResumo[nX][4]) > 0
		For nY := 1 To Len(aResumo[nX][4])
			cTxt += Iif(!Empty(aResumo[nX][4][nY]),AllTrim(aResumo[nX][4][nY]) + CHR(13) + CHR(10),"")
		Next
	Else
		cTxt += "NENHUMA ATUALIZAÇÃO REALIZADA" + CHR(13) + CHR(10)
	EndIf

	IF !lWizard
		oProcess:IncRegua2( 'Atualizações: Indíces do Sistema (SIX)' )
	EndIF
	cTxt += CHR(13) + CHR(10)
	cTxt += "Atualizações: Indíces do Sistema (SIX) - Novos Indíces Criados:" + CHR(13) + CHR(10)
	cTxt += Replicate('-',40) + CHR(13) + CHR(10)
	If Len(aResumo[nX][5]) > 0
		For nY := 1 To Len(aResumo[nX][5])
			cTxt += Iif(!Empty(aResumo[nX][5][nY]),AllTrim(aResumo[nX][5][nY]) + CHR(13) + CHR(10),"")
		Next
	Else
		cTxt += "NENHUMA ATUALIZAÇÃO REALIZADA" + CHR(13) + CHR(10)
	EndIf

	IF !lWizard
		oProcess:IncRegua2( 'Atualizações:  Tabelas Genéricas (SX5)' )
	EndIF
	cTxt += CHR(13) + CHR(10)
	cTxt += "Atualizações:  Tabelas Genéricas (SX5) - Novos Tabelas Criadas:" + CHR(13) + CHR(10)
	cTxt += Replicate('-',40) + CHR(13) + CHR(10)
	If Len(aResumo[nX][6]) > 0
		For nY := 1 To Len(aResumo[nX][6])
			cTxt += Iif(!Empty(aResumo[nX][6][nY]),AllTrim(aResumo[nX][6][nY]) + CHR(13) + CHR(10),"")
		Next
	Else
		cTxt += "NENHUMA ATUALIZAÇÃO REALIZADA" + CHR(13) + CHR(10)
	EndIf

	IF !lWizard
		oProcess:IncRegua2( 'Atualizações: Parâmetros (SX6)' )
	EndIF
	cTxt += CHR(13) + CHR(10)
	cTxt += "Atualizações: Parâmetros (SX6) - Novos Parâmetros Criados:" + CHR(13) + CHR(10)
	cTxt += Replicate('-',40) + CHR(13) + CHR(10)
	If Len(aResumo[nX][7]) > 0
		For nY := 1 To Len(aResumo[nX][7])
			cTxt += Iif(!Empty(aResumo[nX][7][nY]),AllTrim(aResumo[nX][7][nY]) + CHR(13) + CHR(10),"")
		Next
	Else
		cTxt += "NENHUMA ATUALIZAÇÃO REALIZADA" + CHR(13) + CHR(10)
	EndIf

	IF !lWizard
		oProcess:IncRegua2( 'Atualizações: Gatilhos (SX7)' )
	EndIF
	cTxt += CHR(13) + CHR(10)
	cTxt += "Atualizações: Gatilhos (SX7) - Novos Gatilhos Criados:" + CHR(13) + CHR(10)
	cTxt += Replicate('-',40) + CHR(13) + CHR(10)
	If Len(aResumo[nX][8]) > 0
		For nY := 1 To Len(aResumo[nX][8])
			cTxt += Iif(!Empty(aResumo[nX][8][nY]),AllTrim(aResumo[nX][8][nY]) + CHR(13) + CHR(10),"")
		Next
	Else
		cTxt += "NENHUMA ATUALIZAÇÃO REALIZADA" + CHR(13) + CHR(10)
	EndIf

	IF !lWizard
		oProcess:IncRegua2( 'Atualizações: Folders (Pastas) (SXA)' )
	EndIF
	cTxt += CHR(13) + CHR(10)
	cTxt += "Atualizações: Folders (Pastas) (SXA) - Novas Pastas Criadas:" + CHR(13) + CHR(10)
	cTxt += Replicate('-',40) + CHR(13) + CHR(10)
	If Len(aResumo[nX][9]) > 0
		For nY := 1 To Len(aResumo[nX][9])
			cTxt += Iif(!Empty(aResumo[nX][9][nY]),AllTrim(aResumo[nX][9][nY]) + CHR(13) + CHR(10),"")
		Next
	Else
		cTxt += "NENHUMA ATUALIZAÇÃO REALIZADA" + CHR(13) + CHR(10)
	EndIf

	IF !lWizard
		oProcess:IncRegua2( 'Atualizações: Consultas Padrões (SXB)' )
	EndIF
	cTxt += CHR(13) + CHR(10)
	cTxt += "Atualizações: Consultas Padrões (SXB) - Novas Consultas Criadas:" + CHR(13) + CHR(10)
	cTxt += Replicate('-',40) + CHR(13) + CHR(10)
	If Len(aResumo[nX][10]) > 0
		For nY := 1 To Len(aResumo[nX][10])
			cTxt += Iif(!Empty(aResumo[nX][10][nY]),AllTrim(aResumo[nX][10][nY]) + CHR(13) + CHR(10),"")
		Next
	Else
		cTxt += "NENHUMA ATUALIZAÇÃO REALIZADA" + CHR(13) + CHR(10)
	EndIf

	IF !lWizard
		oProcess:IncRegua2( 'Atualizações: Banco de Dados' )
	EndIF
	cTxt += CHR(13) + CHR(10)
	cTxt += "Atualizações: Banco de Dados" + CHR(13) + CHR(10)
	cTxt += Replicate('-',40) + CHR(13) + CHR(10)
	If Len(aResumo[nX][11]) > 0
		For nY := 1 To Len(aResumo[nX][11])
			cTxt += Iif(!Empty(aResumo[nX][11][nY][1]),AllTrim(aResumo[nX][11][nY][1]) + CHR(13) + CHR(10),"")
			cTxt += Iif(!Empty(aResumo[nX][11][nY][2]),AllTrim(aResumo[nX][11][nY][2]) + CHR(13) + CHR(10),"")
			cTxt += Iif(!Empty(aResumo[nX][11][nY][3]),AllTrim(aResumo[nX][11][nY][3]) + CHR(13) + CHR(10),"")
		Next
	Else
		cTxt += "NENHUMA ATUALIZAÇÃO REALIZADA" + CHR(13) + CHR(10)
	EndIf
	cTxt += CHR(13) + CHR(10)

Next nX

If lProcInt
	cTxt	:=	"Processo de atualização interrompido!"
EndIf
If !Empty(cTxt)
	cFileLog := MemoWrite(Criatrab(,.f.)+".LOG",cTxt)

	IF !lWizard
		cTxtIntro += "<table width='100%' border=2 cellpadding='15' cellspacing='5'>"
		cTxtIntro += "<tr>"
		cTxtIntro += "<td align='center'>"
		cTxtIntro += "<font face='Tahoma' size='+2'><b>LOG DAS ATUALIZAÇÕES</b></font>"
		cTxtIntro += "</td>"
		cTxtIntro += "</tr>"
		cTxtIntro += "<tr>"
		cTxtIntro += "<td>teste"
		cTxtIntro += "<br><br><br><br><br><br><br><br><br>"
		cTxtIntro += "<br><br><br><br><br><br><br><br><br>"
		cTxtIntro += "</td>"
		cTxtIntro += "</tr>"
		cTxtIntro += "</table>"
	
		DEFINE MSDIALOG oDlgLog TITLE cDescTitle FROM 00,00 TO 500,700 PIXEL

		TSay():New(005,005,{|| cTxtIntro },oDlgLog,,,,,,.T.,,,340,200,,,,.T.,,.T.)
		@ 045,015 GET oMemo VAR cTxt MEMO SIZE 320,150 OF oDlgLog PIXEL READONLY
		TButton():New( 220,180, '&Salvar...', oDlgLog,{|| cFile := cGetFile(cMask,""), If(cFile="", .T., MemoWrite(cFile,cTxt)) },075,015,,,,.T.,,,,,,)
		TButton():New( 220,270, '&Ok', oDlgLog,{|| RpcClearEnv(), oDlgLog:End()},075,015,,,,.T.,,,,,,)
	
		ACTIVATE MSDIALOG oDlgLog CENTERED
	EndIF
EndIf

Return (cTxt)

/***************************************************************************/
