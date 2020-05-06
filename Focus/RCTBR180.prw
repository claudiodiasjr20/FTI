#Include "Protheus.ch"
#Include "RwMake.ch"
#Include "TopConn.ch"
//#Include "CTBR180.Ch"

#DEFINE 	COL_SEPARA1			1
#DEFINE 	COL_CONTA  			2
#DEFINE 	COL_SEPARA2			3
#DEFINE 	COL_DESCRICAO		4
#DEFINE 	COL_SEPARA3			5
#DEFINE 	COL_SALDO_ANT    	6
#DEFINE 	COL_SEPARA4			7
#DEFINE 	COL_VLR_DEBITO   	8
#DEFINE 	COL_SEPARA5			9
#DEFINE 	COL_VLR_CREDITO  	10
#DEFINE 	COL_SEPARA6			11
#DEFINE 	COL_MOVIMENTO 		12
#DEFINE 	COL_SEPARA7			13
#DEFINE 	COL_SALDO_ATU 		14
#DEFINE 	COL_SEPARA8			15

/*=======================================================
Autor: Cintia Araujo
Data:	01.2015
---------------------------------------------------------
Descricao: Balancete Centro de Custo/Conta em XML
=========================================================*/
User Function RCTBR180()     

Local aArea := GetArea()
Local oReport                                 	
Local lOk 			:= .T.
Local aCtbMoeda		:= {}
Local nDivide		:= 1   
Local aRet          := {}
Local aPergs        := {}

Private cTipoAnt	:= ""
Private cPerg	 	:= "CTR180"
Private nomeProg    := "CTBR180"
Private titulo
Private aSelFil	    := {} 
Private lXML        := .T.    
                                                                          
//CtAjustSx1(cPerg) - Função descontinuada no Protheus 12

Private c_Path 		:= cGetFile("\", "Selecione o Local para salvar o Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY)

If !ExistDir( c_Path )
	c_Path 	:= __RELDIR                                      
EndIf                                       

If !Empty(c_Path)                       
	FTIR180R3()
EndIf

RestArea(aArea)                                                                       
                                                                 
Return Nil

/*=======================================================
Autor: Cintia Araujo
Data:	01.2015
---------------------------------------------------------
Descricao: Impressão do relatorio em Release 3
=========================================================*/
Static Function FTIR180R3()

Local aSetOfBook
Local aCtbMoeda		:= {}

Local cSayCC		:= CtbSayApro("CTT")
Local cDesc1 		:= OemToAnsi("Este programa ira imprimir o Balancete de  / Conta ")
Local cDesc2 		:= OemToansi("de acordo com os parametros solicitados pelo Usuario")
Local cString		:= "CT1"
Local lRet			:= .T.
Local nDivide		:= 1
Local wnrel
Local titulo 		:= "Balancete de Verificacao  / Conta - Vr20082015a"	//"Balancete de Verificacao  / Conta"

Private aReturn 	:= { OemToAnsi("Zebrado"), 1,OemToAnsi("Administracao"), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
Private aLinha		:= {}
Private cPerg	 	:= "CTR180"
Private nLastKey 	:= 0
Private nomeProg  	:= "CTBR180"
Private Tamanho		:= "M"

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

li 		:= 80
m_pag	:= 1

//lPerg := Pergunte("CTR180",.T.)
//If lPerg == .F.
//	Return()
//EndIf

ValidPerg(cPerg)
If !Pergunte(cPerg,.T.)
	Return Nil
EndIf   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					  	   	³
//³ mv_par01				// Data Inicial              	       	³
//³ mv_par02				// Data Final                          	³
//³ mv_par03				// Conta Inicial                       	³
//³ mv_par04				// Conta Final  					   	³
//³ mv_par05				// Do Centro de Custo                  	³
//³ mv_par06				// Ate Centro de Custo                 	³
//³ mv_par07				// Imprime Contas: Sintet/Analit/Ambas 	³
//³ mv_par08				// Set Of Books				    	   	³
//³ mv_par09				// Saldos Zerados?			     	  	³
//³ mv_par10				// Moeda?          			     	   	³
//³ mv_par11				// Pagina Inicial  		     		   	³
//³ mv_par12				// Saldos? Reais / Orcados	/Gerenciais	³
//³ mv_par13				// Quebra por Grupo Contabil?		   	³
//³ mv_par14				// Imprimir ate o Segmento?			   	³
//³ mv_par15				// Filtra Segmento?					   	³
//³ mv_par16				// Conteudo Inicial Segmento?		   	³
//³ mv_par17				// Conteudo Final Segmento?		       	³
//³ mv_par18				// Conteudo Contido em?				   	³
//³ mv_par19				// Imprime Coluna Mov ?				   	³
//³ mv_par20				// Pula Pagina                         	³
//³ mv_par21				// Salta linha sintetica ?			    ³
//³ mv_par22				// Imprime valor 0.00    ?			    ³
//³ mv_par23				// Imprimir CC?Normal / Reduzido       	³
//³ mv_par24				// Divide por ?                   		³
//³ mv_par25				// Imprime Cod. Conta ? Normal/Reduzido ³
//³ mv_par26				// Posicao Ant. L/P? Sim / Nao         	³
//³ mv_par27 				// Data Lucros/Perdas?                	³
//³ mv_par28				// C.Custo ate o Segmento?			   	³
//³ mv_par29				// Filtra Segmento?					   	³
//³ mv_par30				// Conteudo Inicial Segmento?		   	³
//³ mv_par31				// Conteudo Final Segmento?		       	³
//³ mv_par32				// Conteudo Contido em?				   	³
//³ mv_par33				// Imprime C.C: Sintet/Analit/Ambas 	³
//³ mv_par34				// Rec./Desp. Anterior Zeradas?			³
//³ mv_par35				// Grupo Receitas/Despesas?      		³
//³ mv_par36				// Data de Zeramento Receita/Despesas?	³
//³ mv_par37				// Selecao de Filiais					³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lRet .And. mv_par37 == 1 .And. Len( aSelFil ) <= 0
	aSelFil := AdmGetFil()
	If Len( aSelFil ) <= 0
		lRet := .F.
	EndIf
EndIf

wnrel	:= "CTBR180"            //Nome Default do relatorio em Disco    
If lXML == .F.
	wnrel := SetPrint(cString,wnrel,,@titulo,cDesc1,cDesc2,,.F.,"",,Tamanho)
EndIf

If nLastKey == 27
	Set Filter To
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par08)
	lRet := .F.
Else
	aSetOfBook := CTBSetOf(mv_par08)
Endif

If mv_par24 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par24 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par24 == 4		// Divide por milhao
	nDivide := 1000000
EndIf

If lRet
	aCtbMoeda  	:= CtbMoeda(mv_par10,nDivide)
	If Empty(aCtbMoeda[1])
		Help(" ",1,"NOMOEDA")
		lRet := .F.
	Endif
Endif

If lRet
	If (mv_par34 == 1) .and. ( Empty(mv_par35) .or. Empty(mv_par36) )
		cMensagem	:= "Favor preencher os parametros Grupos Receitas/Despesas e Data Sld Ant. Receitas/Despesas ou "	// "Favor preencher os parametros Grupos Receitas/Despesas e Data Sld Ant. Receitas/Despesas ou "
		cMensagem	+= "deixar o parametro Ignora Sl Ant.Rec/Des = Nao "	// "deixar o parametro Ignora Sl Ant.Rec/Des = Nao "
		MsgAlert(cMensagem,"Ignora Sl Ant.Rec/Des") //"Ignora Sl Ant.Rec/Des"
		lRet    	:= .F.
	EndIf
EndIf

If !lRet
	Set Filter To
	Return
EndIf

If mv_par19 == 1			// Se imprime coluna movimento -> relatorio 220 colunas
	tamanho := "G"
EndIf

If nLastKey == 27
	Set Filter To
	Return
Endif

RptStatus({|lEnd| R180Imp(@lEnd,wnRel,cString,aSetOfBook,aCtbMoeda,cSayCC,nDivide)})

Return

/*================================================================
Autor: Cintia Araujo
Data:	01.2015
------------------------------------------------------------------
Descricao :  Imprime relatorio -> Balancete Conta/Centro de Custo.
------------------------------------------------------------------
Parametros: ExpL1   - A‡ao do Codeblock
ExpC1   - T¡tulo do relat¢rio
ExpC2   - Mensagem
ExpA1   - Matriz ref. Config. Relatorio
ExpA2   - Matriz ref. a moeda
ExpC3   - Descricao do C.custo utilizada pelo usuario
==================================================================*/

Static Function R180Imp(lEnd,WnRel,cString,aSetOfBook,aCtbMoeda,cSayCC,nDivide)

LOCAL CbTxt			:= Space(10)
Local CbCont		:= 0
LOCAL tamanho		:= "M"
LOCAL limite		:= 132
Local cabec1  		:= ""
Local cabec2		:= ""
Local aColunas
Local cSepara1  	:= ""
Local cSepara2      := ""
Local cPicture
Local cDescMoeda
Local cMascara1
Local cMascara2
Local cGrupo		:= ""
Local cGrupoAnt		:= ""
Local cCCAnt 		:= ""
Local cCCRes		:= ""
Local cSegAte   	:= mv_par14
Local cArqTmp		:= ""
Local cCCSup		:= ""//Centro de Custo Superior do centro de custo atual
Local cAntCCSup		:= ""//Centro de Custo Superior do centro de custo anterior

Local dDataLP		:= mv_par27
Local dDataFim		:= mv_par02

Local lImpAntLP		:= Iif(mv_par26 == 1,.T.,.F.)
Local lFirstPage	:= .T.
Local lPula			:= .F.
Local lJaPulou		:= .F.
Local lPrintZero	:= Iif(mv_par22==1,.T.,.F.)
Local lPulaSint		:= Iif(mv_par21==1,.T.,.F.)
Local lCttSint 		:= Iif(mv_par33 == 1 .or. mv_par33 == 3,.T.,.F.)
Local l132			:= .T.
Local lImpCCSint	:= .T.
Local lVlrZerado	:= Iif(mv_par09==1,.T.,.F.)
Local lImpDscCC	:= .F.

Local nDecimais
Local nTotDeb		:= 0
Local nTotCrd		:= 0
Local nTotMov		:= 0
Local nCCTMov 		:= 0
Local nTamCC		:= 20
Local nTotCCDeb		:= 0
Local nTotCCCrd		:= 0
Local nCCSldAnt		:= 0
Local nCCSldAtu		:= 0
Local nTotSldAnt	:= 0
Local nTotSldAtu	:= 0
Local nDigitAte		:= 0
Local nDigCCAte		:= 0
Local nRegTmp		:= 0
Local n
Local nGrpDeb		:= 0
Local nGrpCrd		:= 0
Local lRecDesp0		:= Iif(mv_par34==1,.T.,.F.)
Local cRecDesp		:= mv_par35
Local dDtZeraRD		:= mv_par36
Local cmask1,cmask2
Local aSaldos		:= {}
Local nPos 			:= 0

Local oFwMsEx       := NIL
Local cArq          := ""
Local cDir          := GetSrvProfString("Startpath","")
Local cWorkSheet    := ""
Local cTable        := ""
Local cDirTmp       := GetTempPath()

cDescMoeda 	:= aCtbMoeda[2]
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par10)

//Mascara da Conta
If Empty(aSetOfBook[2])
	cMascara1 := GetMv("MV_MASCARA")
Else
	cMascara1 	:= RetMasCtb(aSetOfBook[2],@cSepara1)
EndIf

// Mascara do Centro de Custo
If Empty(aSetOfBook[6])
	cMascara2 := GetMv("MV_MASCCUS")
Else
	cMascara2 := RetMasCtb(aSetOfBook[6],@cSepara2)
EndIf

cPicture 		:= aSetOfBook[4]

If mv_par19 == 1 // Se imprime saldo movimento do periodo
	cabec1 := OemToAnsi("|  CODIGO              |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |    DEBITO     |    CREDITO   | MOVIMENTO DO PERIODO |   SALDO ATUAL    |")  //"|  CODIGO              |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |    DEBITO     |    CREDITO   | MOVIMENTO DO PERIODO |   SALDO ATUAL    |"
	tamanho := "G"
	limite	:= 220
	l132	:= .F.
Else
	cabec1 := OemToAnsi("|  CODIGO               |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |      DEBITO    |      CREDITO   |   SALDO ATUAL     |")  //"|  CODIGO               |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |      DEBITO    |      CREDITO   |   SALDO ATUAL     |"
Endif

If lXML == .F.
	SetDefault(aReturn,cString,,,Tamanho,If(Tamanho="G",2,1))
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par07 == 1		/// Se imprime somente contas sinteticas
	Titulo:=	OemToAnsi("BALANCETE SINTETICO DE  ") + Upper(cSayCC) + "/" + OemToAnsi(" CONTA ")//"BALANCETE SINTETICO DE  "
ElseIf mv_par07 == 2		/// Se imprime somente contas analiticas
	Titulo:=	OemToAnsi("BALANCETE ANALITICO DE  ") + Upper(cSayCC) + "/" + OemToAnsi(" CONTA ")//"BALANCETE ANALITICO DE  "
ElseIf mv_par07 == 3
	Titulo:=	OemToAnsi("BALANCETE DE  ") + Upper(cSayCC)	+  "/" + OemToAnsi(" CONTA ")//"BALANCETE DE  "
EndIf

Titulo += 	OemToAnsi(" DE ") + DTOC(mv_par01) + OemToAnsi(" ATE ") + Dtoc(mv_par02) + ;
OemToAnsi(" EM ") + cDescMoeda

If mv_par12 > "1"
	Titulo += " (" + Tabela("SL", mv_par12, .F.) + ")"
EndIf

If nDivide > 1
	Titulo += " (" + OemToAnsi("DIV.") + Alltrim(Str(nDivide)) + ")"
EndIf

If l132
	aColunas := { 000, 001, 024, 025, 057, 058, 077, 078, 094, 095, 111,    ,    , 112, 131 }
Else
	aColunas := { 000, 001, 030, 032, 080, 082, 112, 114, 131, 133, 151, 153, 183, 185, 219 }
Endif

m_pag := mv_par11
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao					     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
			mv_par01,mv_par02,"CT3","",mv_par03,mv_par04,mv_par05,mv_par06,,,,,mv_par10,;
			mv_par12,aSetOfBook,mv_par15,mv_par16,mv_par17,mv_par18,;
			l132,.T.,,"CTT",lImpAntLP,dDataLP, nDivide,lVlrZerado,,,;
			mv_par29,mv_par30,mv_par31,mv_par32,,,,,,,,,aReturn[7],lRecDesp0,;
			cRecDesp,dDtZeraRD,,,,,,,,,aSelFil,,,,,,,,lCttSint)},;
			OemToAnsi(OemToAnsi("Criando Arquivo Temporário...")),;  //"Criando Arquivo Temporário..."
			OemToAnsi("Balancete Verificacao ")+Upper(cSayCC)+ " / "+OemToAnsi(" CONTA "))     //"Balancete Verificacao "
			

// Verifica Se existe filtragem Ate o Segmento
If ! Empty(mv_par14)
	cmask1 := Alltrim( cMascara1 )
	
	For n := 1 to Val( mv_par14 )
		nDigitAte += Val( Padl( cmask1 , 1 ) )
		cmask1 := Subst( cmask1 , 2 )
	Next
EndIf

// Verifica Se existe filtragem Ate o Segmento
If ! Empty(mv_par28)
	cmask2 := Alltrim( cMascara2 )
	
	For n := 1 to Val( mv_par28 )
		nDigCCAte += Val( Padl( cmask2 , 1 ) )
		cmask2 := Subst( cmask2 , 2 )
	Next
EndIf

dbSelectArea("cArqTmp")
dbGoTop()

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial
//nao esta disponivel e sai da rotina.
If RecCount() == 0 .And. ! Empty(aSetOfBook[5])
	dbCloseArea()
	FErase(cArqTmp+GetDBExtension())
	FErase("cArqInd"+OrdBagExt())
	Return
Endif


cCCAnt := cArqTmp->CUSTO

dbSelectArea("cArqTmp")
dbGoTop()
                                      
cGrupo  := GRUPO
aSaldos := SaldoCC()

While mv_par33 == 1 .And. cArqTmp->TIPOCC == "2"
	dbSkip()
	cCCAnt := cArqTmp->CUSTO
EndDo

SetRegua(RecCount())

If !Eof()                                                     
	If lXML == .T.
		oFwMsEx    := FWMsExcel():New()

		/********************  Gera parametros em XML ********************/ 
		IF GetMv("MV_IMPSX1") == "S"
			U_fCabecXML(oFwMsEx, cPerg,  "Parâmetros - Balancete de Centro de Custo" )   
		EndIf

		cWorkSheet := "Balancete de Centro de Custo"
		cTable     := "Balancete Centro de Custo/Conta"

	    oFwMsEx:AddWorkSheet( cWorkSheet )
	    oFwMsEx:AddTable( cWorkSheet, cTable )	
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Conta"            , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Descrição"        , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Código C.Custo"   , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Descrição C.Custo", 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Status"           , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Saldo Anterior"   , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Débito"           , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Credito"          , 1,1)
		If !l132
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Movimento"        , 1,1)
		EndIf
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Saldo Atual"      , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Cod US Gaap"      , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Desc US Gaap"     , 1,1)
		//Alterações 25/04/15
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Location"		   , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Bus.Segment"      , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Department"       , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Section"	       , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Desc CC Gaap"     , 1,1)

	EndIf
			
					
	While !Eof()                  
		
		If lEnd
			@Prow()+1,0 PSAY OemToAnsi("***** CANCELADO PELO OPERADOR *****")   //"***** CANCELADO PELO OPERADOR *****"
			Exit
		EndIF
		
		IncRegua()
		
	   //	******************** "FILTRAGEM" PARA IMPRESSAO *************************
		If mv_par33 == 1					// So imprime Sinteticas
			If TIPOCC == "2"
				dbSkip()
				Loop
			EndIf
		ElseIf mv_par33 == 2				// So imprime Analiticas
			If TIPOCC == "1"
				dbSkip()
				Loop
			EndIf
		EndIf
		
		If mv_par07 == 1					// So imprime Sinteticas
			If TIPOCONTA == "2"
				dbSkip()
				Loop
			EndIf
		ElseIf mv_par07 == 2				// So imprime Analiticas
			If TIPOCONTA == "1"
				dbSkip()
				Loop
			EndIf
		EndIf
		
		//Filtragem ate o Segmento da Conta( antigo nivel do SIGACON)
		If !Empty(cSegAte)
			If Len(Alltrim(CONTA)) > nDigitAte
				dbSkip()
				Loop
			Endif
		EndIf
		
		//Filtragem ate o Segmento do CC( antigo nivel do SIGACON)
		If !Empty(mv_par28)
			If Len(Alltrim(CUSTO)) > nDigCCAte
				dbSkip()
				Loop
			Endif
		EndIf
		
		//************************* ROTINA DE IMPRESSAO *************************
		nPos := aScan( aSaldos, { |x| x[1] == cCCAnt})
		
		nCCSldAnt 	:= aSaldos[nPos][2]
		nTotCCDeb 	:= aSaldos[nPos][3]
		nTotCCCrd 	:= aSaldos[nPos][4]
		nCCSldAtu 	:= aSaldos[nPos][5]
		
		nTotDeb 	:= aSaldos[nPos][3]
		nTotCrd 	:= aSaldos[nPos][4]
		nTotSldAnt	:= aSaldos[nPos][2]
		nTotSldAtu	:= aSaldos[nPos][5]
		nGrpDeb 	:= aSaldos[nPos][3]
		nGrpCrd 	:= aSaldos[nPos][4]
		
		If mv_par13 == 1							// Grupo Diferente - Totaliza e Quebra
			If cGrupo != GRUPO
				@li,00 PSAY REPLICATE("-",limite)
				li+=2
				@li,00 PSAY REPLICATE("-",limite)
				li++
				@li,aColunas[COL_SEPARA1] PSAY "|"
				@li,01 PSAY "T O T A I S  D O  G R U P O: " + cGrupo + ") : "  		//"T O T A I S  D O  G R U P O: "
				@li,aColunas[COL_SEPARA4] PSAY "|"
				ValorCTB(nGrpDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
				@li,aColunas[COL_SEPARA5] PSAY "|"
				ValorCTB(nGrpCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)
				@li,aColunas[COL_SEPARA6] PSAY "|"
				@li,aColunas[COL_SEPARA8] PSAY "|"
				li++
				li			:= 60
				cGrupo		:= GRUPO
			EndIf
		Else
			If (cCCAnt <> cArqTmp->CUSTO) .And. !lFirstPage
				
				@li,00 PSAY	Replicate("-",limite)
				li++
				@li,0 PSAY "|"
				// Imprime Totalizador do Centro de Custo
				@li, 1 PSAY OemToAnsi("Totais do ")+ PadR(Upper(cSayCC),13) + " : "
				dbSelectArea("CTT")
				dbSetOrder(1)
				If MsSeek(xFilial("CTT")+cArqTmp->CUSTO)
					cCCSup	:= CTT->CTT_CCSUP	//Centro de Custo Superior
				Else
					cCCSup	:= ""
				EndIf
				If MsSeek(xFilial("CTT")+cCCAnt)
					cAntCCSup := CTT->CTT_CCSUP	//Centro de Custo Superior do Centro de custo anterior.
					cCCRes	  := CTT->CTT_RES
				Else
					cAntCCSup := ""
				EndIf
				dbSelectArea("cArqTmp")
				If mv_par23 == 2 //Se Impr. Cod. Red. C.C
					If CTT->CTT_CUSTO == cCCAnt .And. CTT->CTT_CLASSE == '2' //Se for analitico
						EntidadeCTB(cCCRes,li,27,nTamCC,.F.,cMascara2,cSepara2,"CTT")
					Else
						EntidadeCTB(cCCAnt,li,27,nTamCC,.F.,cMascara2,cSepara2,"CTT")
					EndIf
				Else//Se Imprime Cod. normal do C.Custo
					EntidadeCTB(cCCAnt,li,27,nTamCC,.F.,cMascara2,cSepara2,"CTT")
				Endif
				
				// Busca Natureza do Centro de Custo para utilizar nos totais por centro de custo
				cCCNormal := Posicione("CTT" , 1 , xFilial("CTT") + cCCAnt , "CTT_NORMAL")
				
				@ li,aColunas[COL_SEPARA3] PSAY "|"
				ValorCTB(nCCSldAnt,li,aColunas[COL_SALDO_ANT],17,nDecimais,.T.,cPicture,cCCNormal, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA4] PSAY "|"
				ValorCTB(nTotCCDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA5] PSAY "|"
				ValorCTB(nTotCCCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA6] PSAY "|"
				
				If !l132
					nTotMov := (nTotCCCrd - nTotCCDeb)
					ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,cCCNormal, , , , , ,lPrintZero)
					@ li,aColunas[COL_SEPARA7] PSAY "|"
				Endif
				
				ValorCTB(nCCSldAtu,li,aColunas[COL_SALDO_ATU],17,nDecimais,.T.,cPicture,cCCNormal, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA8] PSAY "|"
				li++
				@li,00 PSAY REPLICATE("-",limite)
				li++
			EndIf
		EndIf
		
		If mv_par13 == 1				// Grupo Diferente
			If cGrupo != GRUPO
				lPula := .T.
				li		:= 60
				cGrupo:= GRUPO
			EndIf
		Else
			If mv_par20 == 1
				If cCCAnt <> cArqTmp->CUSTO //Se o item atual for diferente do item anterior
					lPula := .T.
					li 	:= 60
				EndIf
			Endif
		EndIf
		
		If li > 58
			If !lFirstPage
				@ Prow()+1,00 PSAY	Replicate("-",limite)
			EndIf
			
			CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
			li++
			
			If mv_par20 == 1 .or. lFirstPage
				@ li,000 PSAY REPLICATE("-",limite)
				li++
				@ li,000 PSAY "|"
				@ li,001 PSAY PadR(Upper(cSayCC),13) + " : "
				
				If mv_par23 == 2 .And. cArqTmp->TIPOCC == '2' //Se Imprime Cod. Red. CC e se for analitico
					EntidadeCTB(CCRES,li,17,nTamCC,.F.,cMascara2,cSepara2,"CTT")
				Else
					EntidadeCTB(CUSTO,li,17,nTamCC,.F.,cMascara2,cSepara2,"CTT")
				Endif
				
				lImpDscCC	:= .T.
				@ li,aColunas[COL_CONTA]+ Len(CriaVar("CTT_DESC01")) PSAY " - " +cArqTMP->DESCCC
				@ li,aColunas[COL_SEPARA8] PSAY "|"
				li++
				@ li,000 PSAY REPLICATE("-",limite)
				li+=1
				lImpDscCC	:= .T.
			Endif
			
			lFirstPage := .F.
		Endif
		
		If  !lImpDscCC .And. ((mv_par20 == 2 .And. cCCAnt <> cArqTmp->CUSTO	) .Or. li > 58 .Or. ( mv_par20 == 1 .And. cCCant <> cArqTmp->CUSTO) .Or. ;
			(mv_par13 == 1 .And. cGrupoAnt <> cArqTmp->GRUPO))
			@ li,000 PSAY REPLICATE("-",limite)
			li++
			@ li,000 PSAY "|"
			@ li,001 PSAY PadR(Upper(cSayCC),13) + " : "
			If mv_par23 == 2 .And. cArqTmp->TIPOCC == '2' //Se Imprime Cod. Red.CC e se for analitico
				EntidadeCTB(CCRES,li,17,nTamCC,.F.,cMascara2,cSepara2,"CTT")
			Else
				EntidadeCTB(CUSTO,li,17,nTamCC,.F.,cMascara2,cSepara2,"CTT")
			Endif
			@ li,aColunas[COL_CONTA]+ Len(CriaVar("CTT_DESC01")) PSAY " - " +cArqTMP->DESCCC
			@ li,131 PSAY "|"
			li++
			@ li,000 PSAY REPLICATE("-",limite)
			li+=1
		Endif
		
		lImpDscCC	:= .F.
		
		@ li,aColunas[COL_SEPARA1] PSAY "|"
		If mv_par25 == 2 .And. cArqTmp->TIPOCONTA == '2' //Se imprime Cod. Red. conta e se for analitico
			EntidadeCTB(CTARES,li,aColunas[COL_CONTA],If(l132,22,25),.F.,cMascara1,cSepara1)
		Else
			EntidadeCTB(CONTA,li,aColunas[COL_CONTA],If(l132,22,25),.F.,cMascara1,cSepara1)
		EndIf
		dbSelectArea("cArqTmp")
		@ li,aColunas[COL_SEPARA2] PSAY "|"
		
		If l132
			@ li,aColunas[COL_DESCRICAO] PSAY Substr(DESCCTA,1,29)
		Else
			@ li,aColunas[COL_DESCRICAO] PSAY DESCCTA
		Endif
		@ li,aColunas[COL_SEPARA3] PSAY "|"
		ValorCTB(SALDOANT,li,aColunas[COL_SALDO_ANT],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA4] PSAY "|"
		ValorCTB(SALDODEB,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA5] PSAY "|"
		ValorCTB(SALDOCRD,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA6] PSAY "|"
		If !l132
			ValorCTB(MOVIMENTO,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA7] PSAY "|"
		Endif
		ValorCTB(SALDOATU,li,aColunas[COL_SALDO_ATU],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA8] PSAY "|"
		
		lJaPulou := .F.
		If lPulaSint .And. TIPOCONTA == "1"				// Pula linha entre sinteticas
			li++
			@ li,aColunas[COL_SEPARA1] PSAY "|"
			@ li,aColunas[COL_SEPARA2] PSAY "|"
			@ li,aColunas[COL_SEPARA3] PSAY "|"
			@ li,aColunas[COL_SEPARA4] PSAY "|"
			@ li,aColunas[COL_SEPARA5] PSAY "|"
			@ li,aColunas[COL_SEPARA6] PSAY "|"
			If !l132
				@ li,aColunas[COL_SEPARA7] PSAY "|"
				@ li,aColunas[COL_SEPARA8] PSAY "|"
			Else
				@ li,aColunas[COL_SEPARA8] PSAY "|"
			EndIf
			li++
			lJaPulou := .T.
		Else
			li++
		EndIf
		
		//*************************** Gravando linha no XML - Inicio
		If lXML == .T.
			cCodConta := Iif(mv_par25 == 2 .And. cArqTmp->TIPOCONTA == '2', cArqTmp->CTARES, cArqTmp->CONTA)
			                                                         
			If !l132
				oFwMsEx:AddRow( cWorkSheet, cTable, {                             		 ;
				cCodConta                                                        		,;
				cArqTmp->DESCCTA                                                 		,;
				IIf(Empty(cArqTmp->CUSTO), "", cArqTmp->CUSTO)                   		,;
				cArqTmp->DESCCC                                                  		,;
				IIf(cArqTmp->SALDOANT < 0, "D", "C")                             		,;
				cArqTmp->SALDOANT * -1                                           		,;
				cArqTmp->SALDODEB * IIf(cArqTmp->SALDODEB < 0, -1, 1)            		,;
				cArqTmp->SALDOCRD * IIf(cArqTmp->SALDOCRD > 0, -1, 1)            		,;				 
				(cArqTmp->SALDOCRD* IIf(cArqTmp->SALDOCRD > 0, -1, 1)) + (cArqTmp->SALDODEB * IIf(cArqTmp->SALDODEB < 0, -1, 1)) ,;
				cArqTmp->SALDOATU * -1                                           		,;
				GetAdvFval("CT1","CT1_XCTFTI", xFilial("CT1") + cCodConta, 1, 0) 		,;
				GetAdvFval("CT1","CT1_XDCFTI", xFilial("CT1") + cCodConta, 1, 0) 		,;
				GetAdvFval("CTT","CTT_XFTILC", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 	,;
				GetAdvFval("CTT","CTT_XFTIBS", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 	,;
				GetAdvFval("CTT","CTT_XFTIDP", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 	,;
				GetAdvFval("CTT","CTT_XFTISC", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 	,;
				GetAdvFval("CTT","CTT_XGAAP ", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 	})
			Else
				
				oFwMsEx:AddRow( cWorkSheet, cTable, {                             		 ;
				cCodConta                                                        		,;
				cArqTmp->DESCCTA                                                 		,;
				cArqTmp->CUSTO                                                   		,;
				cArqTmp->DESCCC                                                  		,;
				IIf(cArqTmp->SALDOANT < 0, "D", "C")                             		,;
				cArqTmp->SALDOANT * -1                                           		,;
				cArqTmp->SALDODEB * IIf(cArqTmp->SALDODEB < 0, -1, 1)            		,;
				cArqTmp->SALDOCRD * IIf(cArqTmp->SALDOCRD > 0, -1, 1)            		,;				 
				cArqTmp->SALDOATU * -1                                           		,;
				GetAdvFval("CT1","CT1_XCTFTI", xFilial("CT1") + cCodConta, 1, 0) 		,;
				GetAdvFval("CT1","CT1_XDCFTI", xFilial("CT1") + cCodConta, 1, 0) 		,;
				GetAdvFval("CTT","CTT_XFTILC", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 	,;
				GetAdvFval("CTT","CTT_XFTIBS", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 	,;
				GetAdvFval("CTT","CTT_XFTIDP", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 	,;
				GetAdvFval("CTT","CTT_XFTISC", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 	,;
				GetAdvFval("CTT","CTT_XGAAP ", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 	})
			EndIf
		EndIf
		//*************************** Gravando linha no XML - Fim
				
		
		//************************* FIM   DA  IMPRESSAO *************************
		
		cCCAnt := cArqTmp->CUSTO
		cGrupoAnt	:= cArqTmp->GRUPO
		
		nPos := aScan( aSaldos, { |x| x[1] == cCCAnt})
		
		nCCSldAnt 	:= aSaldos[nPos][2]
		nTotCCDeb 	:= aSaldos[nPos][3]
		nTotCCCrd 	:= aSaldos[nPos][4]
		nCCSldAtu	:= aSaldos[nPos][5]
		
		nTotDeb 	:= aSaldos[nPos][3]
		nTotCrd 	:= aSaldos[nPos][4]
		nTotSldAnt	:= aSaldos[nPos][2]
		nTotSldAtu	:= aSaldos[nPos][5]
		nGrpDeb 	:= aSaldos[nPos][3]
		nGrpCrd 	:= aSaldos[nPos][4]
		
		dbSkip()
		
		If lPulaSint .And. TIPOCONTA == "1" 			// Pula linha entre sinteticas
			If !lJaPulou
				@ li,aColunas[COL_SEPARA1] PSAY "|"
				@ li,aColunas[COL_SEPARA2] PSAY "|"
				@ li,aColunas[COL_SEPARA3] PSAY "|"
				@ li,aColunas[COL_SEPARA4] PSAY "|"
				@ li,aColunas[COL_SEPARA5] PSAY "|"
				@ li,aColunas[COL_SEPARA6] PSAY "|"
				If !l132
					@ li,aColunas[COL_SEPARA7] PSAY "|"
					@ li,aColunas[COL_SEPARA8] PSAY "|"
				Else
					@ li,aColunas[COL_SEPARA8] PSAY "|"
				EndIf
				li++
			EndIf
		EndIf                        
	EndDO
	                                                                                    
	If lXML == .T.
		oFwMsEx:Activate()
		
		cArq := CriaTrab( NIL, .F. ) + ".xml"
		LjMsgRun( "Gerando o arquivo, aguarde...", "Balancete CC", {|| oFwMsEx:GetXMLFile( cArq ) } )

		cArqXML := c_Path + "CC_"+ DtoS(Date()) +"_"+ StrTran(Time(),":","")+".XML"
		
		If __CopyFile( cArq,  cArqXML)                 
			If ApOleClient("MsExcel")
				oExcelApp := MsExcel():New()                        
				oExcelApp:WorkBooks:Open( cArqXML )
				oExcelApp:SetVisible(.T.)
			Else
				MsgInfo( "Arquivo " + StrTran(cArqXML, c_path, "") + " gerado com sucesso no diretório " + c_Path )
			Endif
		Else
			MsgInfo( "Arquivo não copiado para temporário do usuário." )
		Endif
	EndIf
Else
	If lXML == .T.
		MsgInfo( "Não há dados para impressão, verifique parâmetros" )
	EndIf
EndIf

If lXML == .F.
	If mv_par13 == 1							// Grupo Diferente - Totaliza e Quebra
		@li,00 PSAY REPLICATE("-",limite)
		li+=2
		@li,00 PSAY REPLICATE("-",limite)
		li++
		@li,aColunas[COL_SEPARA1] PSAY "|"
		@li,01 PSAY "T O T A I S  D O  G R U P O: " + cGrupo + ") : "  		//"T O T A I S  D O  G R U P O: "
		@li,aColunas[COL_SEPARA4] PSAY "|"
		ValorCTB(nGrpDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
		@li,aColunas[COL_SEPARA5] PSAY "|"
		ValorCTB(nGrpCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)
		@li,aColunas[COL_SEPARA6] PSAY "|"
		@li,aColunas[COL_SEPARA8] PSAY "|"
		li++
		
		cGrupo		:= GRUPO
	Else
		//Imprime o total do ultimo item a ser impresso.
		@li,00 PSAY	Replicate("-",limite)
		li++
		@li,0 PSAY "|"
		// T O T A I S  D O
		@li, 1 PSAY OemToAnsi("Totais do ")+ PadR(Upper(cSayCC),13) + " : "
		
		dbSelectArea("CTT")
		dbSetOrder(1)
		If MsSeek(xFilial("CTT")+cArqTmp->CUSTO)
			cCCSup	:= CTT->CTT_CCSUP	//Centro de Custo Superior
		Else
			cCCSup	:= ""
		EndIf
		
		If MsSeek(xFilial("CTT")+cCCAnt)
			cAntCCSup := CTT->CTT_CCSUP	//Centro de Custo Superior do Centro de custo anterior.
			cCCRes	  := CTT->CTT_RES
		Else
			cAntCCSup := ""
		EndIf
		
		dbSelectArea("cArqTmp")
		
		If mv_par23 == 2 //Se Imprime Cod. Red. C.custo
			If  CTT->CTT_CUSTO == cCCAnt .And. CTT->CTT_CLASSE == '2'//Se for analitico, imprime cod. reduzido.
				EntidadeCTB(cCCRes,li,27,nTamCC,.F.,cMascara2,cSepara2,"CTT")
			Else
				EntidadeCTB(cCCAnt,li,27,nTamCC,.F.,cMascara2,cSepara2,"CTT")
			Endif
		Else
			EntidadeCTB(cCCAnt,li,27,nTamCC,.F.,cMascara2,cSepara2,"CTT")
		Endif
		
		// Busca Natureza do Centro de Custo para utilizar nos totais por centro de custo
		cCCNormal := Posicione("CTT" , 1 , xFilial("CTT") + cCCAnt , "CTT_NORMAL")
		
		@ li,aColunas[COL_SEPARA3] PSAY "|"
		ValorCTB(nCCSldAnt,li,aColunas[COL_SALDO_ANT],17,nDecimais,.T.,cPicture,cCCNormal, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA4] PSAY "|"
		ValorCTB(nTotCCDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA5] PSAY "|"
		ValorCTB(nTotCCCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA6] PSAY "|"
		
		If !l132
			nCCtMov := (nTotCCCrd - nTotCCDeb)
			ValorCTB(nCCtMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,cCCNormal, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA7] PSAY "|"
		Endif
		ValorCTB(nCCSldAtu,li,aColunas[COL_SALDO_ATU],17,nDecimais,.T.,cPicture,cCCNormal, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA8] PSAY "|"
		
	EndIf
	
	IF li != 80 .And. !lEnd
		
		nPos := aScan( aSaldos, { |x| x[1] == "TOTGERAL"})
		
		nCCSldAnt 	:= aSaldos[nPos][2]
		nTotCCDeb 	:= aSaldos[nPos][3]
		nTotCCCrd 	:= aSaldos[nPos][4]
		nCCSldAtu	:= aSaldos[nPos][5]
		
		nTotDeb 	:= aSaldos[nPos][3]
		nTotCrd 	:= aSaldos[nPos][4]
		nTotSldAnt	:= aSaldos[nPos][2]
		nTotSldAtu	:= aSaldos[nPos][5]
		nGrpDeb 	:= aSaldos[nPos][3]
		nGrpCrd 	:= aSaldos[nPos][4]
		
		IF li > 58
			@Prow()+1,00 PSAY	Replicate("-",limite)
			CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
			li++
		End
		li++
		@li,00 PSAY REPLICATE("-",limite)
		li++
		@li,0 PSAY "|"
		@li,1 PSAY OemToAnsi("T O T A I S  D O  P E R I O D O : ")  		//"T O T A I S  D O  P E R I O D O : "
		@ li,aColunas[COL_SEPARA3] PSAY "|"
		ValorCTB(nTotSldAnt,li,aColunas[COL_SALDO_ANT],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA4] PSAY "|"
		ValorCTB(nTotDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA5] PSAY "|"
		ValorCTB(nTotCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA6] PSAY "|"
		If !l132
			nTotMov := (nTotCrd - nTotDeb)
			ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA7] PSAY "|"
		Endif
		ValorCTB(nTotSldAtu,li,aColunas[COL_SALDO_ATU],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA8] PSAY "|"
		li++
		@li,00 PSAY REPLICATE("-",limite)
		li++
		@li,0 PSAY " "
		If !lExterno .and. li < 59
			roda(cbcont,cbtxt,"M")
			Set Filter To
		EndIf
	EndIF
	
	If aReturn[5] = 1
		Set Printer To
		Commit
		Ourspool(wnrel)
	EndIf
	MS_FLUSH()
EndIf

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
FErase(cArqTmp+GetDBExtension())
FErase("cArqInd"+OrdBagExt())
dbselectArea("CT2")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SldCCusto ºAutor  ³TOTVS               º Data ³  25/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function SaldoCC()

Local aSaldos := {}
Local aCcusto := {}
Local cCusto  := ""
Local nSldDeb := 0
Local nSldCrd := 0
Local nSldAnt := 0
Local nSldAtu := 0
Local nTotAnt := 0
Local nTotDeb := 0
Local nTotCrd := 0
Local nTotAtu := 0

While mv_par33 == 1 .And. cArqTmp->TIPOCC == "2"
	dbSkip()
EndDo

cCusto := cArqTmp->CUSTO

While !Eof()
	
	If cArqTmp->TIPOCONTA == "2"
		
		If cCusto == cArqTmp->CUSTO
			nSldAnt	+= cArqTmp->SALDOANT
			nSldDeb += cArqTmp->SALDODEB
			nSldCrd += cArqTmp->SALDOCRD
			nSldAtu += cArqTmp->SALDOATU
			
			If cArqTmp->TIPOCC == "2"
				nTotAnt	+= cArqTmp->SALDOANT
				nTotDeb += cArqTmp->SALDODEB
				nTotCrd += cArqTmp->SALDOCRD
				nTotAtu += cArqTmp->SALDOATU
			Endif
		Else
			AADD(aCCusto, cCusto)
			AADD(aCCusto, nSldAnt)
			AADD(aCCusto, nSldDeb)
			AADD(aCCusto, nSldCrd)
			AADD(aCCusto, nSldAtu)
			
			AADD(aSaldos,aCCusto)
			aCCusto := {}
			
			cCusto  := cArqTmp->CUSTO
			nSldAnt := cArqTmp->SALDOANT
			nSldDeb := cArqTmp->SALDODEB
			nSldCrd := cArqTmp->SALDOCRD
			nSldAtu := cArqTmp->SALDOATU
			
			If cArqTmp->TIPOCC == "2"
				nTotAnt	+= cArqTmp->SALDOANT
				nTotDeb += cArqTmp->SALDODEB
				nTotCrd += cArqTmp->SALDOCRD
				nTotAtu += cArqTmp->SALDOATU
			Endif
		Endif
		
	Endif
	
	dbSkip()
EndDo

AADD(aCCusto, cCusto)
AADD(aCCusto, nSldAnt)
AADD(aCCusto, nSldDeb)
AADD(aCCusto, nSldCrd)
AADD(aCCusto, nSldAtu)
AADD(aSaldos, aCCusto)
aCCusto := {}

AADD(aCCusto, "TOTGERAL")
AADD(aCCusto, nTotAnt)
AADD(aCCusto, nTotDeb)
AADD(aCCusto, nTotCrd)
AADD(aCCusto, nTotAtu)
AADD(aSaldos,aCCusto)

dbGoTop()

Return aSaldos

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
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
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function ValidPerg(c_Perg)

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
c_Perg := PADR(c_Perg,6)
aRegs:={}

c_Perg := c_Perg + Replicate(" ", 10 - Len(c_Perg))               

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

aAdd(aRegs,{c_Perg,"01","Data Inicial 					?","","","mv_ch1","D",8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"02","Data Final 					?","","","mv_ch2","D",8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"03","Conta Inicial 					?","","","mv_ch3","C",20,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","CT1"})
aAdd(aRegs,{c_Perg,"04","Conta Final 					?","","","mv_ch4","C",20,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","CT1"})
aAdd(aRegs,{c_Perg,"05","Do Centro de Custo 			?","","","mv_ch5","C",10,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
aAdd(aRegs,{c_Perg,"06","Ate Centro de Custo 			?","","","mv_ch6","C",10,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
aAdd(aRegs,{c_Perg,"07","Imprime Contas 				?","","","mv_ch7","N",1,0,2,"C","","mv_par07","Sinteticas","","","","","Analiticas","","","","","Ambas","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"08","Cod. Config. Livros 			?","","","mv_ch8","C",3,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","CTN"})
aAdd(aRegs,{c_Perg,"09","Saldos Zerados 				?","","","mv_ch9","N",1,0,1,"C","","mv_par09","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"10","Moeda 							?","","","mv_cha","C",2,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","CTO"})
aAdd(aRegs,{c_Perg,"11","Folha  Inicial 				?","","","mv_chb","N",6,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"12","Tipo de Saldo 					?","","","mv_chc","C",1,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","SLD"})
aAdd(aRegs,{c_Perg,"13","Quebra por Grupo 				?","","","mv_chd","N",1,0,2,"C","","mv_par13","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"14","Imprimir ate Segmen (Conta)	?","","","mv_che","C",2,0,0,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"15","Filtra Segmento No. (Conta) 	?","","","mv_chf","C",2,0,0,"G","","mv_par15","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"16","Conteudo Ini Segmen (Conta) 	?","","","mv_chg","C",20,0,0,"G","","mv_par16","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"17","Conteudo Fim Segmen (Conta) 	?","","","mv_chh","C",20,0,0,"G","","mv_par17","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"18","Conteudo Contido em (Conta) 	?","","","mv_chi","C",30,0,0,"G","","mv_par18","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"19","Imprime Coluna Mov. 			?","","","mv_chj","N",1,0,1,"C","","mv_par19","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"20","Pula Pagina 					?","","","mv_chl","N",1,0,2,"C","","mv_par20","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"21","Salta Linha Sintet. 			?","","","mv_chm","N",1,0,2,"C","","mv_par21","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"22","Imprime Valor 0.00 			?","","","mv_chn","N",1,0,1,"C","","mv_par22","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"23","Imprime Codigo 				?","","","mv_cho","N",1,0,1,"C","","mv_par23","Normal","","","","","Reduzido","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"24","Divide por 					?","","","mv_chp","N",1,0,1,"C","","mv_par24","Nao se aplica","","","","","Cem","","","","","Mil","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"25","Impr Cod Conta 				?","","","mv_chq","N",1,0,1,"C","","mv_par25","Normal","","","","","Reduzido","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"26","Posicao Ant. L/P 				?","","","mv_chr","N",1,0,2,"C","","mv_par26","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"27","Data Lucros/Perdas 			?","","","mv_chs","D",8,0,0,"G","","mv_par27","","","","","","","","","","","","","","","","","","","","","","","","","CTZ"})
aAdd(aRegs,{c_Perg,"28","Imprimir ate Segmen (CCusto) 	?","","","MV_CHT","C",2,0,0,"G","","mv_par28","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"29","Filtra Segmen No. (CCusto) 	?","","","MV_CHU","C",2,0,0,"G","","mv_par29","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"30","Conteudo Ini Segmen (CCusto) 	?","","","MV_CHV","C",20,0,0,"G","","mv_par30","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"31","Conteudo Fim Segmen (CCusto) 	?","","","MV_CHW","C",20,0,0,"G","","mv_par31","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"32","Conteudo Contido em (CCusto) 	?","","","MV_CHX","C",30,0,0,"G","","mv_par32","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"33","Imprime C Custo 				?","","","MV_CHY","N",1,0,2,"C","","mv_par33","Sinteticos","","","","","Analiticos","","","","","Ambos","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"34","Ignora Sl Ant.Rec/Des 			?","","","MV_CHZ","N",1,0,2,"C","","mv_par34","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"35","Grupo Receitas/Desp. 			?","","","MV_CHZ","C",5,0,0,"G","","mv_par35","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"36","Data Sld Ant.Rec/Desp 			?","","","MV_CHZ","D",8,0,0,"G","","mv_par36","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"37","Seleciona Filiais 				?","","","MV_CHZ","N",1,0,2,"C","","mv_par37","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(c_Perg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

DbSelectArea(_sAlias)

Return Nil

//**********************************************************************************************************************************************************//
