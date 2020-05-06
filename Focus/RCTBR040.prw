#Include "Protheus.ch"
#Include "RwMake.ch"
#Include "TopConn.ch"
//#Include "Ctbr040.Ch"

#define STR0001 "Este programa ira imprimir o Balancete de Verificacao Modelo 1 (132 Colunas), a"
#define STR0002 "conta eh impressa limitando-se a 20 caracteres e sua descricao 30 caracteres,"
#define STR0003 "Balancete Auxiliar de Verificacao"
#define STR0004 "|  CODIGO                     |      D E S C R I C A O                          |    SALDO ANTERIOR             |     DEBITO       |      CREDITO      |    MOVIMENTO DO PERIODO       |         SALDO ATUAL               |"
#define STR0005 "|  CODIGO               |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |      DEBITO    |      CREDITO   |   SALDO ATUAL     |"
#define STR0006 "BALANCETE DE VERIFICACAO ANALITICO DE "
#define STR0007 " ATE "
#define STR0008 " EM "
#define STR0009 "BALANCETE DE VERIFICACAO SINTETICO DE "
#define STR0010 "***** CANCELADO PELO OPERADOR *****"
#define STR0011 "T O T A I S  D O  P E R I O D O: "
#define STR0012 "Selecionando Registros..."
#define STR0013 "Zebrado"
#define STR0014 "Administracao"
#define STR0015 "Criando Arquivo Temporario..."
Static  STR0016 :=  "os valores impressos sao saldo anterior, debito, credito e saldo atual do periodo."
#define STR0017 "BALANCETE DE VERIFICACAO DE "
#define STR0018 " (ORCADO)"
#define STR0019 " (GERENCIAL)"
#define STR0020 "T O T A I S  D O  G R U P O ("
#define STR0021 "DIV."
#define STR0022 "|  CODIGO                     |      D E S C R I C A O                          |        SALDO ANTERIOR             |           DEBITO             |            CREDITO                |         SALDO ATUAL               |"
#define STR0023 "Microsiga Software S/A"
#define STR0024 "Hora Termino: "
#define STR0025 "Favor preencher os parametros Grupos Receitas/Despesas e "
#define STR0026 "Data Sld Ant. Receitas/Desp. "

#DEFINE 	COL_SEPARA1			1
#DEFINE 	COL_CONTA 			2
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
#DEFINE 	TAM_VALOR			20

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr040	³ Autor ³ Pilar S Albaladejo	³ Data ³ 12.09.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Analitico Sintetico Modelo 1			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Ctbr040()                               			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso    	 ³ Generico     											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function RCTBR040()

Private titulo		:= ""
Private nomeprog	:= "CTBR040"
Private lXML        := .T. 

//CtAjustSx1('CTR040') - Função descontinuada no Protheus 12

Private c_Path 		:= cGetFile("\", "Selecione o Local para salvar o Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY)

If !ExistDir( c_Path )
	c_Path 	:= __RELDIR
EndIf

If !Empty(c_Path)
	R040R3()
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr040R3³ Autor ³ Pilar S Albaladejo	³ Data ³ 12.09.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Analitico Sintetico Modelo 1			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Ctbr040()                               			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso    	 ³ Generico     											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R040R3(wnRel)

Local aSetOfBook
Local aCtbMoeda	:= {}
LOCAL cDesc1 		:= OemToAnsi("Este programa ira imprimir o Balancete de Verificacao Modelo 1") 
LOCAL cDesc2 		:= OemToansi("os valores impressao sao saldo anterior, debito, credito e saldo atual do periodo.") 
LOCAL cDesc3		:= OemToansi("Vr20082015a") 
LOCAL cString		:= "CT1"
Local cTitOrig		:= ""
Local lRet			:= .T.
Local nDivide		:= 1
Local lExterno 	:= .F.
Local nQuadro
Local lPerg			:= .T.
PRIVATE nLastKey 	:= 0
PRIVATE cPerg	 	:= "CTR040"
PRIVATE aLinha		:= {}
PRIVATE nomeProg  	:= "CTBR040"
PRIVATE titulo 		:= OemToAnsi(STR0003) + " - Vr20082015a"	//"Balancete de Verificacao"
Private aSelFil		:= {}

Default wnRel := ""

lExterno := !Empty(wnRel)

If ! lExterno
	PRIVATE Tamanho		:= "M"
	PRIVATE aReturn 	:= { OemToAnsi(STR0013), 1,OemToAnsi(STR0014), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
EndIf

cTitOrig	:= titulo

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

li	:= 60 //80

Private aQuadro := { "","","","","","","",""}

For nQuadro :=1 To Len(aQuadro)
	aQuadro[nQuadro] := Space(Len(CriaVar("CT1_CONTA")))
Next
                        	
CtbCarTxt()

//ValidPerg(cPerg)
//If !Pergunte(cPerg,.T.)
//	Return Nil
//EndIf   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros								  ³
//³ mv_par01				// Data Inicial                  	  		  ³
//³ mv_par02				// Data Final                        		  ³
//³ mv_par03				// Conta Inicial                         	  ³
//³ mv_par04				// Conta Final  							  ³
//³ mv_par05				// Imprime Contas: Sintet/Analit/Ambas   	  ³
//³ mv_par06				// Set Of Books				    		      ³
//³ mv_par07				// Saldos Zerados?			     		      ³
//³ mv_par08				// Moeda?          			     		      ³
//³ mv_par09				// Pagina Inicial  		     		    	  ³
//³ mv_par10				// Saldos? Reais / Orcados	/Gerenciais   	  ³
//³ mv_par11				// Quebra por Grupo Contabil?		    	  ³
//³ mv_par12				// Filtra Segmento?					    	  ³
//³ mv_par13				// Conteudo Inicial Segmento?		   		  ³
//³ mv_par14				// Conteudo Final Segmento?		    		  ³
//³ mv_par15				// Conteudo Contido em?				    	  ³
//³ mv_par16				// Imprime Coluna Mov ?				    	  ³
//³ mv_par17				// Salta linha sintetica ?			    	  ³
//³ mv_par18				// Imprime valor 0.00    ?			    	  ³
//³ mv_par19				// Imprimir Codigo? Normal / Reduzido  		  ³
//³ mv_par20				// Divide por ?                   			  ³
//³ mv_par21				// Imprimir Ate o segmento?			   		  ³
//³ mv_par22				// Posicao Ant. L/P? Sim / Nao         		  ³
//³ mv_par23				// Data Lucros/Perdas?                 		  ³
//³ mv_par24				// Imprime Quadros Contábeis?				  ³
//³ mv_par25				// Rec./Desp. Anterior Zeradas?				  ³
//³ mv_par26				// Grupo Receitas/Despesas?      			  ³
//³ mv_par27				// Data de Zeramento Receita/Despesas?		  ³
//³ mv_par28                // Num.linhas p/ o Balancete Modelo 1		  ³
//³ mv_par29				// Descricao na moeda?						  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If ! lExterno
	lPerg :=  Pergunte("CTR040",.T.)
	If lPerg == .F.
		Return()
	EndIf
	
	If mv_par30 == 1 .And. Len( aSelFil ) <= 0 .And. !IsBlind()
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			Return
		EndIf
	EndIf
	
	wnrel	:= "CTBR040"            //Nome Default do relatorio em Disco
	If lXML == .F.
		wnrel := SetPrint(cString,wnrel,,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)
	EndIf
	
Endif

If wnRel == "CTBR110"
	If mv_par30 == 1 .And. Len( aSelFil ) <= 0 .And. !IsBlind()
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			Return
		EndIf
	EndIf
Endif

If lXML == .F.
	If nLastKey == 27
		Set Filter To
		Return
	Endif
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)		     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !R040Valid(mv_par06)
	lRet := .F.
Else
	aSetOfBook := CTBSetOf(mv_par06)
Endif

If mv_par20 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par20 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par20 == 4		// Divide por milhao
	nDivide := 1000000
EndIf

If lRet
	aCtbMoeda  	:= CtbMoeda(mv_par08,nDivide)
	If Empty(aCtbMoeda[1])
		Help(" ",1,"NOMOEDA")
		lRet := .F.
	Endif
Endif

If lRet
	If (mv_par25 == 1) .and. ( Empty(mv_par26) .or. Empty(mv_par27) )
		cMensagem	:= STR0025	//"Favor preencher os parametros Grupos Receitas/Despesas e "
		cMensagem	+= STR0026	//"Data Sld Ant. Receitas/Desp. "
		MsgAlert(cMensagem,"Ignora Sl Ant.Rec/Des")
		lRet    	:= .F.
	EndIf
EndIf

If lXML == .F.
	If !lRet
		Set Filter To
		Return
	EndIf
EndIf

If !lExterno .And. ( mv_par16 == 1 .Or. ( mv_par16 == 2 .And.	aReturn[4] == 2 ))	//Se nao imprime coluna mov. e eh paisagem
	tamanho := "G"
EndIf

If nLastKey == 27
	Set Filter To
	Return
Endif

RptStatus({|lEnd| R040Imp(@lEnd,wnRel,cString,aSetOfBook,aCtbMoeda,nDivide,lExterno,cTitorig)})

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³CTR040IMP ³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 24.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio -> Balancete Verificacao Modelo 1        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³CTR040Imp(lEnd,WnRel,cString,aSetOfBook,aCtbMoeda)          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd       - A‡ao do Codeblock                             ³±±
±±³          ³ WnRel      - T¡tulo do relat¢rio                           ³±±
±±³          ³ cString    - Mensagem                                      ³±±
±±³          ³ aSetOfBook - Matriz ref. Config. Relatorio                 ³±±
±±³          ³ aCtbMoeda  - Matriz ref. a moeda                           ³±±
±±³          ³ nDivide    - Valor para divisao de valores                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R040Imp(lEnd,WnRel,cString,aSetOfBook,aCtbMoeda,nDivide,lExterno,cTitOrig)

Local aColunas		:= {}
LOCAL CbTxt			:= Space(10)
Local CbCont		:= 0
LOCAL limite		:= 132
Local cabec1   	:= ""
Local cabec2   	:= ""
Local cSeparador	:= ""
Local cPicture
Local cDescMoeda
Local cCodMasc
Local cMascara
Local cGrupo		:= ""
Local cArqTmp
Local dDataFim 	:= mv_par02
Local lFirstPage	:= .T.
Local lJaPulou		:= .F.
Local lPrintZero	:= Iif(mv_par18==1,.T.,.F.)
Local lPula			:= Iif(mv_par17==1,.T.,.F.)
Local lNormal		:= Iif(mv_par19==1,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par07==1,.T.,.F.)
Local l132			:= .T.
Local nDecimais
Local nTotDeb		:= 0
Local nTotCrd		:= 0
Local nTotMov		:= 0
Local nGrpDeb		:= 0
Local nGrpCrd		:= 0
Local cSegAte   	:= mv_par21
Local nDigitAte	:= 0
Local lImpAntLP	:= Iif(mv_par22 == 1,.T.,.F.)
Local dDataLP		:= mv_par23
Local lImpSint		:= Iif(mv_par05=1 .Or. mv_par05 ==3,.T.,.F.)
Local lRecDesp0		:= Iif(mv_par25==1,.T.,.F.)
Local cRecDesp		:= mv_par26
Local dDtZeraRD		:= mv_par27
Local n
Local oMeter
Local oText
Local oDlg
Local lImpPaisgm	:= .F.
Local nMaxLin   	:= iif( mv_par28 > 58 , 58 , mv_par28 )
Local cMoedaDsc		:= mv_par29
Local nMasc			:= 0
Local cMasc			:= ""

Local oFwMsEx       := NIL
Local cArq          := ""
Local cDir          := GetSrvProfString("Startpath","")
Local cWorkSheet    := ""
Local cTable        := ""
Local cDirTmp       := GetTempPath()

cDescMoeda 	:= Alltrim(aCtbMoeda[2])
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par08)

If Empty(aSetOfBook[2])
	cMascara := GetMv("MV_MASCARA")
Else
	cMascara 	:= RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf
cPicture 		:= aSetOfBook[4]

If mv_par16 == 2 .And. !lExterno .And. 	aReturn[4] == 2	//Se nao imprime coluna mov. e eh paisagem
	lImpPaisgm	:= .T.
	limite		:= 220
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Alltrim(Titulo) == Alltrim(cTitorig) // Se o titulo do relatorio nao foi alterado pelo usuario
	IF mv_par05 == 1
		Titulo:=	OemToAnsi(STR0009)	//"BALANCETE DE VERIFICACAO SINTETICO DE "
	ElseIf mv_par05 == 2
		Titulo:=	OemToAnsi(STR0006)	//"BALANCETE DE VERIFICACAO ANALITICO DE "
	ElseIf mv_par05 == 3
		Titulo:=	OemToAnsi(STR0017)	//"BALANCETE DE VERIFICACAO DE "
	EndIf
EndIf
Titulo += 	DTOC(mv_par01) + OemToAnsi(STR0007) + Dtoc(mv_par02) + ;
OemToAnsi(STR0008) + cDescMoeda + CtbTitSaldo(mv_par10)

If nDivide > 1
	Titulo += " (" + OemToAnsi(STR0021) + Alltrim(Str(nDivide)) + ")"
EndIf

If mv_par16 == 1 .And. ! lExterno		// Se imprime saldo movimento do periodo
	cabec1 := OemToAnsi("|  CODIGO              |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |    DEBITO     |    CREDITO   | MOVIMENTO DO PERIODO |   SALDO ATUAL    |")
	tamanho := "G"
	limite	:= 220
	l132	:= .F.
Else
	If lImpPaisgm		//Se imprime em formato paisagem
		cabec1 := STR0022  //"|  CODIGO                     |      D E S C R I C A O                          |        SALDO ANTERIOR             |           DEBITO             |            CREDITO                |         SALDO ATUAL               |"
	Else
		cabec1 := OemToAnsi("|  CODIGO               |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |      DEBITO    |      CREDITO   |   SALDO ATUAL     |")
	EndIf
Endif

If ! lExterno .And. lXML == .F.
	SetDefault(aReturn,cString,,,Tamanho,If(Tamanho="G",2,1))
Endif

If l132
	If lImpPaisgm
		aColunas := { 000,001, 030, 032, 080,086, 116, 118, 147, 151, 183, , ,187,219}
	Else
		aColunas := { 000,001, 024, 025, 057,058, 077, 078, 094, 095, 111, , , 112, 131 }
	EndIf
Else
	aColunas := { 000,001, 030, 032, 080,082, 112, 114, 131, 133, 151, 153, 183,185,219}
Endif

If ! lExterno
	m_pag := mv_par09
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lExterno  .or. IsBlind()
	CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
	mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par08,;
	mv_par10,aSetOfBook,mv_par12,mv_par13,mv_par14,mv_par15,;
	.F.,.F.,mv_par11,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,aReturn[7],lRecDesp0,;
	cRecDesp,dDtZeraRD,,,,,,,cMoedaDsc,,aSelFil)
Else
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
	CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
	mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par08,;
	mv_par10,aSetOfBook,mv_par12,mv_par13,mv_par14,mv_par15,;
	.F.,.F.,mv_par11,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,aReturn[7],lRecDesp0,;
	cRecDesp,dDtZeraRD,,,,,,,cMoedaDsc,,aSelFil)},;
	OemToAnsi(OemToAnsi(STR0015)),;  //"Criando Arquivo Tempor rio..."
	OemToAnsi(STR0003))  				//"Balancete Verificacao"
endIf


// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)
	
	//Efetua tratamento da mascara para consegui efetuar o controle do segmento
	For nMasc := 1 to Len( cMascara )
		
		cMasc += SubStr( cMascara,nMasc,1 )
		
	Next nMasc
	
	
	nDigitAte := CtbRelDig(cSegAte,cMasc)
	
EndIf

dbSelectArea("cArqTmp")
dbGoTop()

SetRegua(RecCount())

cGrupo := GRUPO

If !Eof()
	If lXML == .T.
		oFwMsEx    := FWMsExcel():New()
		
		/********************  Gera parametros em XML ********************/
		If GetMv("MV_IMPSX1") == "S"
			U_fCabecXML(oFwMsEx, cPerg,  "Parâmetros - Balancete Modelo 1" )
		EndIf
		
		cWorkSheet := "Balancete Modelo 1"
		cTable     := "Balancete de Verificação"
		
		oFwMsEx:AddWorkSheet( cWorkSheet )
		oFwMsEx:AddTable( cWorkSheet, cTable )
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Conta"            , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Descrição"        , 1,1)
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
	EndIf
	
	While !Eof()
		
		If lEnd
			@Prow()+1,0 PSAY OemToAnsi(STR0010)   //"***** CANCELADO PELO OPERADOR *****"
			Exit
		EndIF
		
		IncRegua()
		
		******************** "FILTRAGEM" PARA IMPRESSAO *************************
		
		If mv_par05 == 1					// So imprime Sinteticas
			If TIPOCONTA == "2"
				dbSkip()
				Loop
			EndIf
		ElseIf mv_par05 == 2				// So imprime Analiticas
			If TIPOCONTA == "1"
				dbSkip()
				Loop
			EndIf
		EndIf
		
		//Filtragem ate o Segmento ( antigo nivel do SIGACON)
		If !Empty(cSegAte)
			If Len(Alltrim(CONTA)) > nDigitAte
				dbSkip()
				Loop
			Endif
		EndIf
		
		
		************************* ROTINA DE IMPRESSAO *************************
		
		If mv_par11 == 1 							// Grupo Diferente - Totaliza e Quebra
			If cGrupo != GRUPO
				@li,00 PSAY REPLICATE("-",limite)
				li+=2
				@li,00 PSAY REPLICATE("-",limite)
				li++
				@li,aColunas[COL_SEPARA1] PSAY "|"
				@li,39 PSAY OemToAnsi(STR0020) + cGrupo + ") : "  		//"T O T A I S  D O  G R U P O: "
				@li,aColunas[COL_SEPARA4] PSAY "|"
				ValorCTB(nGrpDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
				@li,aColunas[COL_SEPARA5] PSAY "|"
				ValorCTB(nGrpCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)
				@li,aColunas[COL_SEPARA6] PSAY "|"
				@li,aColunas[COL_SEPARA8] PSAY "|"
				li++
				li		:= 60
				cGrupo	:= GRUPO
				nGrpDeb	:= 0
				nGrpCrd	:= 0
			EndIf
			
		ElseIf  mv_par11 == 2
			If NIVEL1				// Sintetica de 1o. grupo
				li := 60
			EndIf
		EndIf
		
		IF li > nMaxLin
			If !lFirstPage
				@Prow()+1,00 PSAY	Replicate("-",limite)
			EndIf
			CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
			lFirstPage := .F.
		EndIf
		
		@ li,aColunas[COL_SEPARA1] 		PSAY "|"
		If lNormal
			If TIPOCONTA == "2" 		// Analitica -> Desloca 2 posicoes
				If l132
					EntidadeCTB(CONTA,li,aColunas[COL_CONTA]+2,21,.F.,cMascara,cSeparador)
				Else
					EntidadeCTB(CONTA,li,aColunas[COL_CONTA]+2,27,.F.,cMascara,cSeparador)
				EndIf
			Else
				If l132
					EntidadeCTB(CONTA,li,aColunas[COL_CONTA],23,.F.,cMascara,cSeparador)
				Else
					EntidadeCTB(CONTA,li,aColunas[COL_CONTA],29,.F.,cMascara,cSeparador)
				EndIf
			EndIf
		Else
			If TIPOCONTA == "2"		// Analitica -> Desloca 2 posicoes
				@li,aColunas[COL_CONTA] PSAY Alltrim(CTARES)
			Else
				@li,aColunas[COL_CONTA] PSAY Alltrim(CONTA)
			EndIf
		EndIf
		
		@ li,aColunas[COL_SEPARA2] 		PSAY "|"
		
		If !l132
			@ li,aColunas[COL_DESCRICAO] 	PSAY Substr(DESCCTA,1,48)
		Else
			@ li,aColunas[COL_DESCRICAO] 	PSAY Substr(DESCCTA,1,30)
		Endif
		
		@ li,aColunas[COL_SEPARA3]		PSAY "|"
		ValorCTB(SALDOANT,li,aColunas[COL_SALDO_ANT],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)
		
		@ li,aColunas[COL_SEPARA4]		PSAY "|"
		ValorCTB(SALDODEB,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,NORMAL, , , , , ,lPrintZero)
		
		@ li,aColunas[COL_SEPARA5]		PSAY "|"
		ValorCTB(SALDOCRD,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,NORMAL, , , , , ,lPrintZero)
		
		@ li,aColunas[COL_SEPARA6]		PSAY "|"
		
		If !l132
			ValorCTB(MOVIMENTO,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA7] PSAY "|"
		Endif
		ValorCTB(SALDOATU,li,aColunas[COL_SALDO_ATU],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)
		
		@ li,aColunas[COL_SEPARA8] PSAY "|"
		
		lJaPulou := .F.
		
		If lPula .And. TIPOCONTA == "1"				// Pula linha entre sinteticas
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
			cCodConta := cArqTmp->CONTA //Iif(cArqTmp->TIPOCONTA == '2', cArqTmp->CTARES, cArqTmp->CONTA)
			
			If !l132
				oFwMsEx:AddRow( cWorkSheet, cTable, {                             ;
				cCodConta                                                        ,;
				cArqTmp->DESCCTA                                                 ,;
				IIf(cArqTmp->SALDOANT < 0, "D", "C")                             ,;
				cArqTmp->SALDOANT * -1                                           ,;
				cArqTmp->SALDODEB * IIf(cArqTmp->SALDODEB < 0, -1, 1)            ,;
				cArqTmp->SALDOCRD * IIf(cArqTmp->SALDOCRD > 0, -1, 1)            ,;
				(cArqTmp->SALDOCRD* IIf(cArqTmp->SALDOCRD > 0, -1, 1)) + (cArqTmp->SALDODEB * IIf(cArqTmp->SALDODEB < 0, -1, 1)) ,;
				cArqTmp->SALDOATU * -1                                           ,;
				GetAdvFval("CT1","CT1_XCTFTI", xFilial("CT1") + cCodConta, 1, 0) ,;
				GetAdvFval("CT1","CT1_XDCFTI", xFilial("CT1") + cCodConta, 1, 0) })
			Else
				
				oFwMsEx:AddRow( cWorkSheet, cTable, {                             ;
				cCodConta                                                        ,;
				cArqTmp->DESCCTA                                                 ,;
				IIf(cArqTmp->SALDOANT < 0, "D", "C")                             ,;
				cArqTmp->SALDOANT * -1                                           ,;
				cArqTmp->SALDODEB * IIf(cArqTmp->SALDODEB < 0, -1, 1)            ,;
				cArqTmp->SALDOCRD * IIf(cArqTmp->SALDOCRD > 0, -1, 1)            ,;
				cArqTmp->SALDOATU *-1                                           ,;
				GetAdvFval("CT1","CT1_XCTFTI", xFilial("CT1") + cCodConta, 1, 0) ,;
				GetAdvFval("CT1","CT1_XDCFTI", xFilial("CT1") + cCodConta, 1, 0) })
			EndIf
		EndIf
		//*************************** Gravando linha no XML - Fim
		
		
		************************* FIM   DA  IMPRESSAO *************************
		
		If mv_par05 == 1					// So imprime Sinteticas - Soma Sinteticas
			If TIPOCONTA == "1"
				If NIVEL1
					nTotDeb += SALDODEB
					nTotCrd += SALDOCRD
					nGrpDeb += SALDODEB
					nGrpCrd += SALDOCRD
				EndIf
			EndIf
		Else									// Soma Analiticas
			If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
				If TIPOCONTA == "2"
					nTotDeb += SALDODEB
					nTotCrd += SALDOCRD
					nGrpDeb += SALDODEB
					nGrpCrd += SALDOCRD
				EndIf
			Else							//Se tiver filtragem, somo somente as sinteticas
				If TIPOCONTA == "1"
					If NIVEL1
						nTotDeb += SALDODEB
						nTotCrd += SALDOCRD
						nGrpDeb += SALDODEB
						nGrpCrd += SALDOCRD
					EndIf
				EndIf
			Endif
		EndIf
		
		dbSkip()
		If lPula .And. TIPOCONTA == "1" 			// Pula linha entre sinteticas
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
		LjMsgRun( "Gerando o arquivo, aguarde...", "Balancete Verificação", {|| oFwMsEx:GetXMLFile( cArq ) } )
		
		cArqXML := c_Path + "Mod_"+ DtoS(Date()) +"_"+StrTran(Time(),":","")+".XML"
		
		If __CopyFile( cArq,  cArqXML )
			If ApOleClient("MsExcel")
				oExcelApp := MsExcel():New()
				oExcelApp:WorkBooks:Open( cArqXML )
				oExcelApp:SetVisible(.T.)
			Else
				MsgInfo( "Arquivo " + StrTran(cArqXML,c_Path, "")+ " gerado com sucesso no diretório " + c_Path )
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
	IF li <= 58 .OR. li >= 58 .And. !lEnd
		IF li > nMaxLin
			@Prow()+1,00 PSAY	Replicate("-",limite)
			CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
			li++
		End
		If mv_par11 == 1							// Grupo Diferente - Totaliza e Quebra
			If cGrupo != GRUPO .Or. Eof()
				@li,00 PSAY REPLICATE("-",limite)
				li++
				@li,aColunas[COL_SEPARA1] PSAY "|"
				@li,39 PSAY OemToAnsi(STR0020) + cGrupo + ") : "  		//"T O T A I S  D O  G R U P O: "
				@li,aColunas[COL_SEPARA4] PSAY "|"
				ValorCTB(nGrpDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
				@li,aColunas[COL_SEPARA5] PSAY "|"
				ValorCTB(nGrpCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)
				@li,aColunas[COL_SEPARA6] PSAY "|"
				If !l132
					nTotMov := nTotMov + (nGrpCrd - nGrpDeb)
					If Round(NoRound(nTotMov,3),2) < 0
						ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero)
					ElseIf Round(NoRound(nTotMov,3),2) > 0
						ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,"2", , , , , ,lPrintZero)
					EndIf
					@ li,aColunas[COL_SEPARA7] PSAY "|"
				Endif
				@li,aColunas[COL_SEPARA8] PSAY "|"
				li++
				@li,00 PSAY REPLICATE("-",limite)
				li+=2
			EndIf
		EndIf
		
		@li,00 PSAY REPLICATE("-",limite)
		li++
		@li,aColunas[COL_SEPARA1] PSAY "|"
		@li,39 PSAY OemToAnsi(STR0011)  		//"T O T A I S  D O  M E S : "
		@li,aColunas[COL_SEPARA4] PSAY "|"
		ValorCTB(nTotDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
		@li,aColunas[COL_SEPARA5] PSAY "|"
		ValorCTB(nTotCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)
		@li,aColunas[COL_SEPARA6] PSAY "|"
		If !l132
			nTotMov := nTotMov + (nTotCrd - nTotDeb)
			If Round(NoRound(nTotMov,3),2) < 0
				ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero)
			ElseIf Round(NoRound(nTotMov,3),2) > 0
				ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,"2", , , , , ,lPrintZero)
			EndIf
			@li,aColunas[COL_SEPARA7] PSAY "|"
		EndIf
		@li,aColunas[COL_SEPARA8] PSAY "|"
		li++
		@li,00 PSAY REPLICATE("-",limite)
		li++
		@li,0 PSAY " "
		
		IF lExterno
			If (li + 3) < 60
				@57,00 PSAY __PrtfatLine()
				@58,01 Psay STR0023   //  "Microsiga Software S/A"
				If Tamanho == "M"
					@58,100 Psay STR0024 + " " + Time()      //"Hora Termino: "
				ElseIf Tamanho == "G"
					@58,190 Psay STR0024 + " "+ Time()  //"Hora Termino: "
				Else
					@58,050 Psay STR0024 + " "+ Time()	   //"Hora Termino: "
				EndIf
				@59,00 PSAY __PrtfatLine()
			EndIf
		Endif
		Set Filter To
	EndIF
	
	If mv_par24 ==1
		ImpQuadro(Tamanho,X3USO("CT2_DCD"),dDataFim,mv_par08,aQuadro,cDescMoeda,nomeprog,(If (lImpAntLP,dDataLP,cTod(""))),cPicture,nDecimais,lPrintZero,mv_par10)
	EndIf
	
	If aReturn[5] = 1 .And. ! lExterno
		Set Printer To
		Commit
		Ourspool(wnrel)
	EndIf
EndIf

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
If Select("cArqTmp") == 0
	FErase(cArqTmp+GetDBExtension())
	FErase(cArqTmp+OrdBagExt())
EndIF
dbselectArea("CT2")

If ! lExterno
	MS_FLUSH()
Endif

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CT040Valid³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 24.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida Perguntas                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Ct040Valid(cSetOfBook)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T./.F.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Codigo da Config. Relatorio                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R040Valid(cSetOfBook)

Local aSaveArea:= GetArea()
Local lRet		:= .T.

If !Empty(cSetOfBook)
	dbSelectArea("CTN")
	dbSetOrder(1)
	If !dbSeek(xfilial()+cSetOfBook)
		aSetOfBook := ("","",0,"","")
		Help(" ",1,"NOSETOF")
		lRet := .F.
	EndIf
EndIf

RestArea(aSaveArea)

Return lRet

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

aAdd(aRegs,{c_Perg,"01","Data Inicial 		  			?","","","mv_ch1","D",8,0,0 ,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"02","Data Final 		   			?","","","mv_ch2","D",8,0,0 ,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"03","Conta Inicial 		   			?","","","mv_ch3","C",20,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","CT1"})
aAdd(aRegs,{c_Perg,"04","Conta Final 		   			?","","","mv_ch4","C",20,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","CT1"})
aAdd(aRegs,{c_Perg,"05","Imprime Contas 	   			?","","","mv_ch5","N",1,0,3 ,"C","","mv_par05","Sinteticas","","","","","Analiticas","","","","","Ambas","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"06","Cod. Config. Livros   			?","","","mv_ch6","C",3,0,0 ,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","CTN"})
aAdd(aRegs,{c_Perg,"07","Saldos Zerados 	   			?","","","mv_ch7","N",1,0,2 ,"C","","mv_par07","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"08","Moeda 				   			?","","","mv_ch8","C",2,0,0 ,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","CTO"})
aAdd(aRegs,{c_Perg,"09","Folha  Inicial 	   			?","","","mv_ch9","N",6,0,0 ,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"10","Tipo de Saldo 		   			?","","","mv_cha","C",1,0,1 ,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","SLD"})
aAdd(aRegs,{c_Perg,"11","Quebra 			   			?","","","mv_chb","N",1,0,2 ,"C","","mv_par11","por Grupo","","","","","por Código","","","","","Não Quebra","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"12","Filtra Segmento No.   			?","","","mv_chc","C",2,0,0 ,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"13","Conteudo Ini Segmen   			?","","","mv_chd","C",20,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"14","Conteudo Fim Segmen   			?","","","mv_che","C",20,0,0,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"15","Conteudo Contido em 			?","","","mv_chf","C",30,0,0,"G","","mv_par15","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"16","Imprime Coluna Mov.   			?","","","mv_chg","N",1,0,2 ,"C","","mv_par16","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"17","Salta Linha Sintet.   			?","","","mv_chh","N",1,0,1 ,"C","","mv_par17","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"18","Imprime Valor 0.00    			?","","","mv_chi","N",1,0,1 ,"C","","mv_par18","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"19","Imprime Codigo 	   			?","","","mv_chj","N",1,0,1 ,"C","","mv_par19","Normal","","","","","Reduzido","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"20","Divide por 		   			?","","","mv_chl","N",1,0,1 ,"C","","mv_par20","Nao se aplica","","","","","Cem","","","","","Mil","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"21","Imprimir ate o seg. 			?","","","mv_chm","C",1,0,0 ,"G","","mv_par21","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"22","Posicao Ant. L/P 				?","","","mv_chn","N",1,0,2 ,"C","","mv_par22","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"23","Data Lucros/Perdas    			?","","","mv_cho","D",8,0,0 ,"G","","mv_par23","","","","","","","","","","","","","","","","","","","","","","","","","CTZ"})
aAdd(aRegs,{c_Perg,"24","Imp Quadros Contabeis 			?","","","MV_CHP","N",1,0,2 ,"C","","mv_par24","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"25","Ignora Sl Ant.Rec/Des 			?","","","MV_CHQ","N",1,0,2 ,"C","","mv_par25","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"26","Grupo Receitas/Desp. 			?","","","mr_chr","C",5,0,0 ,"G","","mv_par26","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"27","Data Sld Ant. Receitas/Desp. 	?","","","MV_CHS","D",8,0,0 ,"G","","mv_par27","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"28","Num.linhas p/ o Balancete 		?","","","MV_CHT","N",2,0,0 ,"G","","mv_par28","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"29","Descricao na Moeda 			?","","","MV_CHU","C",2,0,0 ,"G","","mv_par29","","","","","","","","","","","","","","","","","","","","","","","","","CTO"})
aAdd(aRegs,{c_Perg,"30","Seleciona Filiais 				?","","","MV_CHV","N",1,0,2 ,"C","","mv_par30","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""})

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
