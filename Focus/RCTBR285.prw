#Include "Protheus.ch"
#Include "RwMake.ch"
#Include "TopConn.ch"
//#Include "Ctbr285.Ch"

#define STR0001 "Este programa ira imprimir o Balancete Comparativo "
#define STR0002 "de acordo com os parametros solicitados pelo usuario. "
#define STR0003  "Comparativo de "
#define STR0004 "|CODIGO            |DESCRICAO          |  PERIODO 01  |  PERIODO 02  |  PERIODO 03  |  PERIODO 04  |  PERIODO 05  |  PERIODO 06  |  PERIODO 07  |  PERIODO 08  |  PERIODO 09  |  PERIODO 10  |  PERIODO 11  |  PERIODO 12  |"
#define STR0005 "COMPARATIVO ANALITICO DE "
#define STR0006 "COMPARATIVO SINTETICO DE "
#define STR0007 "COMPARATIVO DE "
#define STR0008 " DE "
#define STR0009 " ATE "
#define STR0010 " EM "
#define STR0011" CONTA "
#define STR0012 "O plano gerencial ainda näo esta disponivel para este relatorio. "
#define STR0013 "Criando Arquivo Temporario... "
#define STR0014 "Zebrado"
#define STR0015 "Administracäo"
#define STR0016 "***** CANCELADO PELO OPERADOR *****"
#define STR0017 "T O T A I S  D O  P E R I O D O: "
#define STR0018 "TOTAIS DO "
#define STR0019 "O periodo solicitado ultrapassa o limite de 6 meses."
#define STR0020 "Sera impresso somente os 6 meses a partir da data inicial."
#define STR0021 "Caso nao atualize os saldos compostos na"
#define STR0022 "emissao dos relatorios(MV_SLDCOMP ='N'),"
#define STR0023 "rodar a rotina de atualizacao de saldos "
#define STR0024 "Altere a configuracäo de livros..."
#define STR0025 "Config. de Livros..."
#define STR0026 "TOTAIS: "
#define STR0027 "TOTAIS DO PERIODO:"
#define STR0028 "TOTAL PERIODO"
#define STR0029 "ACUMULADO"
#define STR0030 "GRUPO ("
#define STR0031 "PERIODO "
#define STR0032  "Total - "
#define STR0033 "Total Geral - "
#define STR0034  " Superior"
#define STR0035  "Grupo"

#DEFINE 	COL_SEPARA1			1
#DEFINE 	COL_CONTA 			2
#DEFINE 	COL_SEPARA2			3
#DEFINE 	COL_DESCRICAO		4
#DEFINE 	COL_SEPARA3			5
#DEFINE 	COL_COLUNA1       	6
#DEFINE 	COL_SEPARA4			7
#DEFINE 	COL_COLUNA2       	8
#DEFINE 	COL_SEPARA5			9 
#DEFINE 	COL_COLUNA3       	10
#DEFINE 	COL_SEPARA6			11
#DEFINE 	COL_COLUNA4   		12
#DEFINE 	COL_SEPARA7			13                                                                                       
#DEFINE 	COL_COLUNA5   		14
#DEFINE 	COL_SEPARA8			15
#DEFINE 	COL_COLUNA6   		16
#DEFINE 	COL_SEPARA9			17
#DEFINE 	COL_COLUNA7			18
#DEFINE 	COL_SEPARA10		19
#DEFINE 	COL_COLUNA8			20
#DEFINE 	COL_SEPARA11		21
#DEFINE 	COL_COLUNA9			22
#DEFINE 	COL_SEPARA12		23
#DEFINE 	COL_COLUNA10		24
#DEFINE 	COL_SEPARA13		25
#DEFINE 	COL_COLUNA11		26
#DEFINE 	COL_SEPARA14		27
#DEFINE 	COL_COLUNA12		28
#DEFINE 	COL_SEPARA15		29

//Tradução PTG 20080721

// 17/08/2009 -- Filial com mais de 2 caracteres
Static nTamCdoCusto := 20
Static nTamConta    := 18                                                                                                                        

User Function RCTBR285()

Private lXML := .T.              

//CtAjustSx1("CTR285") - Função descontinuada no Protheus 12

Private c_Path 		:= cGetFile("\", "Selecione o Local para salvar o Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY)

If !ExistDir( c_Path )
	c_Path 	:= __RELDIR                                      
EndIf                                       

If !Empty(c_Path)
	R285R3() // Executa versão anterior do fonte 
EndIf    

Return()                              

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr285R3³ Autor ³ Simone Mie Sato   	³ Data ³ 29.04.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Comparativo de C.Custo x Cta  s/ 6 meses. 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ Ctbr285R3      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       							  				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 		 ³ SIGACTB      							  				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum									  				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R285R3()

Local aSetOfBook
Local aCtbMoeda	:= {}
Local cSayCC		:= CtbSayApro("CTT")
Local cDesc1 		:= STR0001			//"Este programa ira imprimir o Balancete Comparativo "
Local cDesc2 		:= Upper(Alltrim(cSayCC)) +" / "+ STR0011	// " Conta "
Local cDesc3 		:= "Vr20082015a"
Local cNomeArq
LOCAL wnrel
LOCAL cString		:= "CTT"
Local titulo 		:= STR0003+Upper(Alltrim(cSayCC))+" / "+ STR0011 	//"Comparativo de" " Conta "
Local lRet			:= .T.    
Local nDivide		:= 1
Local cMensagem		:= ""
Local lAtSlComp		:= Iif(GETMV("MV_SLDCOMP") == "S",.T.,.F.)

PRIVATE nLastKey 	:= 0
PRIVATE cPerg	 	:= "CTR285"
PRIVATE aReturn 	:= { STR0015, 1,STR0016, 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE aLinha		:= {}
PRIVATE nomeProg  	:= "CTBR285"
PRIVATE Tamanho		:="G"

MsgInfo("Relatório em validação - Vr 06-05 l","ctr285")

If TamSx3("CTT_CUSTO")[1]> 9
	nTamCdoCusto := 25
EndIf			
If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

li 		:= 80
m_pag		:= 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mostra tela de aviso - Atualizacao de saldos				 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cMensagem := STR0021+chr(13)  		//"Caso nao atualize os saldos compostos na"
cMensagem += STR0022+chr(13)  		//"emissao dos relatorios(MV_SLDCOMP ='N'),"
cMensagem += STR0023+chr(13)  		//"rodar a rotina de atualizacao de saldos "

IF !lAtSlComp
	IF !MsgYesNo(cMensagem,STR0009)	//"ATEN€ŽO"
		Return
	Endif
EndIf

//lPerg := Pergunte("CTR285",.T.)
//If lPerg == .F.
//	Return() 
//EndIf   

ValidPerg(cPerg)
If !Pergunte(cPerg,.T.)
	Return Nil
EndIf  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					       ³
//³ mv_par01				// Data Inicial              	       ³
//³ mv_par02				// Data Final                          ³
//³ mv_par03				// C.C. Inicial         		       ³
//³ mv_par04				// C.C. Final   					   ³
//³ mv_par05				// Conta Inicial                       ³
//³ mv_par06				// Conta Final   					   ³
//³ mv_par07				// Imprime Contas:Sintet/Analit/Ambas  ³
//³ mv_par08				// Set Of Books				    	   ³
//³ mv_par09				// Saldos Zerados?			     	   ³
//³ mv_par10				// Moeda?          			     	   ³
//³ mv_par11				// Pagina Inicial  		     		   ³
//³ mv_par12				// Saldos? Reais / Orcados/Gerenciais  ³
//³ mv_par13				// Imprimir ate o Segmento?			   ³
//³ mv_par14				// Filtra Segmento?					   ³
//³ mv_par15				// Conteudo Inicial Segmento?		   ³
//³ mv_par16				// Conteudo Final Segmento?		       ³
//³ mv_par17				// Conteudo Contido em?				   ³
//³ mv_par18				// Pula Pagina                         ³
//³ mv_par19				// Imprime Cod. C.Custo? Normal/Red.   ³
//³ mv_par20				// Imprime Cod. Conta? Normal/Reduzido ³
//³ mv_par21				// Salta linha sintetica?              ³
//³ mv_par22 				// Imprime Valor 0.00?                 ³
//³ mv_par23 				// Divide por?                         ³
//³ mv_par24				// Posicao Ant. L/P? Sim / Nao         ³
//³ mv_par25				// Data Lucros/Perdas?                 ³
//³ mv_par26				// Totaliza periodo ?                  ³
//³ mv_par27				// Se Totalizar ?                  	   ³
//³ mv_par28				// Imprime C.C?Sintet/Analit/Ambas 	   ³
//³ mv_par29				// Imprime Totalizacao de C.C. Sintet. ³
//³ mv_par30				// Tipo de Comparativo?(Movimento/Acumulado)  ³
//³ mv_par31				// Quebra por Grupo Contabil?		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel	:= "CTBR285"            //Nome Default do relatorio em Disco   
If lXML == .F.
	wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,,.F.,"",,Tamanho)
EndIf

If nLastKey == 27
	Set Filter To
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par08)
	lRet := .F.
Else
   aSetOfBook := CTBSetOf(mv_par08)
Endif

If mv_par23 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par23 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par23 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lRet
	aCtbMoeda  	:= CtbMoeda(mv_par10,nDivide)
	If Empty(aCtbMoeda[1])                        
      Help(" ",1,"NOMOEDA")
      lRet := .F.
   Endif
Endif

If !lRet
	Set Filter To
	Return
EndIf

If lXML == .F.
	SetDefault(aReturn,cString)
EndIf                                        

If nLastKey == 27
	Set Filter To
	Return
Endif

RptStatus({|lEnd| R285Imp(@lEnd,wnRel,cString,aSetOfBook,aCtbMoeda,cSayCC,nDivide)})

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³CTR285IMP ³ Autor ³ Simone Mie Sato       ³ Data ³ 29.04.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio -> Balancete C.Custo/Conta               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CTR285Imp(lEnd,wnRel,cString,aSetOfBook,aCtbMoeda,cSayCC)  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd 		= Acao do CodeBlock                           ³±±
±±³			 ³ WnRel 		= Titulo do Relatorio				          ³±±
±±³			 ³ cString		= Mensagem						              ³±±
±±³			 ³ aSetOfBook 	= Registro de Config. Livros   		          ³±±
±±³			 ³ aCtbMoeda	= Registro ref. a moeda escolhida             ³±±
±±³			 ³ cSayCC		= Descric.C.Custo utilizado pelo usuario. 	  ³±±
±±³			 ³ nDivide		= Fator de div.dos valores a serem impressos. ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R285Imp(lEnd,WnRel,cString,aSetOfBook,aCtbMoeda,cSayCC,nDivide)

Local aColunas		:= {}
Local CbTxt			:= Space(10)
Local CbCont		:= 0
Local limite		:= 220
Local cabec1  		:= ""
Local cabec2		:= ""
Local cPicture
Local cDescMoeda
Local cCodMasc		:= ""
Local cMascara		:= ""
Local cMascCC		:= ""           
Local cSepara1		:= ""
Local cSepara2		:= ""
Local cGrupo		:= ""
Local cGrupoAnt	:= ""
Local lFirstPage	:= .T.
Local nDecimais
Local cCustoAnt		:= ""
Local cCCResAnt		:= ""
Local l132			:= .T.
Local lImpConta		:= .F.
Local lImpCusto		:= .T.
Local cCtaIni		:= mv_par05
Local cCtaFim		:= mv_par06
Local nPosAte		:= 0
Local nDigitAte		:= 0
Local cSegAte   	:= mv_par13
Local cArqTmp   	:= ""
Local cCCSup		:= ""//Centro de Custo Superior do centro de custo atual
Local cAntCCSup		:= ""//Centro de Custo Superior do centro de custo anterior

Local lPula			:= Iif(mv_par21==1,.T.,.F.) 
Local lPrintZero	:= Iif(mv_par22==1,.T.,.F.)
Local lImpAntLP		:= Iif(mv_par24 == 1,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par09==1,.T.,.F.)
Local dDataLP  		:= mv_par25
Local aMeses		:= {}          
Local dDataFim 		:= mv_par02
Local lJaPulou		:= .F.
Local nMeses		:= 1
Local aTotCol		:= {0,0,0,0,0,0,0,0,0,0,0,0}
Local aTotCC		:= {0,0,0,0,0,0,0,0,0,0,0,0}
Local aTotCCSup		:= {}
Local aSupCC		:= {}
Local nTotLinha		:= 0
Local nCont			:= 0
Local aTotGrupo		:= {0,0,0,0,0,0,0,0,0,0,0,0}
Local nTotLinGrp	:= 0

Local lImpSint 		:= Iif(mv_par07 == 2,.F.,.T.)
Local lImpTotS		:= Iif(mv_par29 == 1,.T.,.F.)
Local lImpCCSint	:= .T.
Local lNivel1		:= .F. 

Local nPos 			:= 0
Local nDigitos 		:= 0
Local n				:= 0
Local nVezes		:= 0
Local nPosCC		:= 0 
Local nTamaTotCC	:= 0
Local nAtuTotCC		:= 0 
Local cTpComp		:= If( mv_par30 == 1,"M","S" )	//	Comparativo : "M"ovimento ou "S"aldo Acumulado
Local lImpCabecCC 	:= .F.

Local oFwMsEx       := NIL
Local cArq          := ""
Local cDir          := GetSrvProfString("Startpath","")
Local cWorkSheet    := ""
Local cTable        := ""
Local cDirTmp       := GetTempPath()
Local lImpresso     := .F.

Local cFtiLc		:= ""							    
Local cFtiBs		:= ""							    
Local cFtiDp		:= ""							    
Local cFtiSc		:= ""							    
Local cFGaap		:= ""							   
                                                                                                                                             
cDescMoeda 	:= aCtbMoeda[2]
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par10)

aPeriodos := ctbPeriodos(mv_par10, mv_par01, mv_par02, .T., .F.)

For nCont := 1 to len(aPeriodos)       
	//Se a Data do periodo eh maior ou igual a data inicial solicitada no relatorio.
	If aPeriodos[nCont][1] >= mv_par01 .And. aPeriodos[nCont][2] <= mv_par02 
		If nMeses <= 12
			AADD(aMeses,{StrZero(nMeses,2),aPeriodos[nCont][1],aPeriodos[nCont][2]})	
		EndIf
		nMeses += 1           					
	EndIf
Next                                                                   

//Mascara do Centro de Custo
If Empty(aSetOfBook[6])
	cMascCC :=  GetMv("MV_MASCCUS")
Else
	cMascCC := RetMasCtb(aSetOfBook[6],@cSepara1)
EndIf

// Mascara da Conta Contabil
If Empty(aSetOfBook[2])
	cMascara := GetMv("MV_MASCARA")
Else
	cMascara := RetMasCtb(aSetOfBook[2],@cSepara2)
EndIf

cPicture 		:= aSetOfBook[4]
cabec1 := STR0004  //"|CODIGO            |DESCRICAO          |  PERIODO 01  |  PERIODO 02  |  PERIODO 03  |  PERIODO 04  |  PERIODO 05  |  PERIODO 06  |  PERIODO 07  |  PERIODO 08  |  PERIODO 09  |  PERIODO 10  |  PERIODO 11  |  PERIODO 12  |
tamanho := "G"
limite	:= 220        
l132	:= .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par07 == 1
	Titulo:=	STR0006+ Upper(Alltrim(cSayCC)) + " / "+ STR0011 		//"COMPARATIVO ANALITICO DE  "
ElseIf mv_par07 == 2
	Titulo:=	STR0005 + Upper(Alltrim(cSayCC)) + " / "+ STR0011		//"COMPARATIVO SINTETICO DE  "
ElseIf mv_par07 == 3
	Titulo:=	STR0007 + Upper(Alltrim(cSayCC)) + " / "+ STR0011		//"COMPARATIVO DE  "
EndIf

Titulo += 	STR0008 + DTOC(mv_par01) + STR0009 + Dtoc(mv_par02) + 	STR0010 + cDescMoeda

If mv_par12 > "1"			
	Titulo += " (" + Tabela("SL", mv_par12, .F.) + ")"
Endif

If mv_par30 = 2
	mv_par26 := 2
	Titulo := AllTrim(Titulo) + " - " + STR0029
EndIf
aColunas := { 000, 001, 019, 020, 039, 040, 054, 055, 069, 070, 084, 085, 099, 100, 114,  115, 129, 130, 144, 145, 159, 160, 174, 175, 189, 190 , 204, 205, 219} 

cabec1 := STR0004  //"|CODIGO            |DESCRICAO          |  PERIODO 01  |  PERIODO 02  |  PERIODO 03  |  PERIODO 04  |  PERIODO 05  |  PERIODO 06  |  PERIODO 07  |  PERIODO 08  |  PERIODO 09  |  PERIODO 10  |  PERIODO 11  |  PERIODO 12  |

If mv_par26 = 1		// Com total, nao imprime descricao
	If mv_par27 = 2
		Cabec1 := Stuff(Cabec1, 2, 10, Subs(Cabec1, 21, 10))
	Endif
	Cabec1 := Stuff(Cabec1, 21, 20, "")
	If mv_par27 == 1
		Cabec1 += " "+STR0028+"     |"	// TOTAL PERIODO
	Else
		Cabec1 += " "+STR0028+"|"	// TOTAL PERIODO
	EndIf	
	

	For nCont := 6 to (Len(aColunas)-1) 
		If mv_par27 == 1 			//Se mostrar conta
			aColunas[nCont] -= 20		
		ElseIf mv_par27 == 2		// Se mostrar a descricao
			aColunas[nCont] -= 15			
		EndIf
	Next         
	
	If mv_par27 = 2
		Cabec1 := Stuff(Cabec1, 19, 0, Space(5))
		cabec2 := "|                       |"
	Else
		cabec2 := "|                  |"
	Endif
Else
	If mv_par20 = 2
		Cabec1 := 	Left(Cabec1, 11) + "|" + Subs(Cabec1, 21, 15) + Space(12) + "|" +;
					Subs(Cabec1, 41)
		Cabec2 := 	"|          |                           |"
	Else
		cabec2 := "|                  |                   |" 
	Endif
Endif
For nCont := 1 to Len(aMeses)
	cabec2 += SPACE(1)+Strzero(Day(aMeses[nCont][2]),2)+"/"+Strzero(Month(aMeses[nCont][2]),2)+ " - "
	cabec2 += Strzero(Day(aMeses[nCont][3]),2)+"/"+Strzero(Month(aMeses[nCont][3]),2)+"|"
Next

For nCont:= Len(aMeses) to 12
	If nCont == 12                           
		//Se totaliza a linha e mostra a conta                  
		If mv_par26 == 1  .And. mv_par27 == 1
			cabec2+=SPACE(19)+"|"			
		Else				
			cabec2+=SPACE(14)+"|"						
		EndIf
	Else
		cabec2+=SPACE(14)+"|"
	EndIf	
Next         

m_pag := mv_par11

// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)
	For n := 1 to Val(cSegAte)
		nDigitAte += Val(Subs(cMascara,n,1))	
	Next
EndIf		

If !Empty(mv_par14)			//// FILTRA O SEGMENTO Nº
	If Empty(mv_par08)		//// VALIDA SE O CÓDIGO DE CONFIGURAÇÃO DE LIVROS ESTÁ CONFIGURADO
		help("",1,"CTN_CODIGO")
		Return
	Else
		If !Empty(aSetOfBook[5])
			MsgInfo(STR0012+CHR(10)+STR0024,STR0025)
			Return
		Endif
	Endif
	dbSelectArea("CTM")
	dbSetOrder(1)
	If MsSeek(xFilial()+aSetOfBook[2])
		While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == aSetOfBook[2]
			nPos += Val(CTM->CTM_DIGITO)
			If CTM->CTM_SEGMEN == STRZERO(val(mv_par14),2)
				nPos -= Val(CTM->CTM_DIGITO)
				nPos ++
				nDigitos := Val(CTM->CTM_DIGITO)
				Exit
			EndIf
			dbSkip()
		EndDo
	Else
		help("",1,"CTM_CODIGO")
		Return
	EndIf
EndIf 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerComp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CT3","",mv_par05,mv_par06,mv_par03,mv_par04,,,,,mv_par10,;
				mv_par12,aSetOfBook,mv_par14,mv_par15,mv_par16,mv_par17,;
				.F.,.F.,,"CTT",lImpAntLP,dDataLP,nDivide,cTpComp,.F.,,.T.,aMeses,lVlrZerado,,,lImpSint,cString,aReturn[7],lImpTotS)},;
				STR0013,;  //"Criando Arquivo Tempor rio..."
				STR0003+Upper(Alltrim(cSayCC)) +" / " +  STR0011 )     //"Balancete Verificacao C.CUSTO / CONTA				

If Select("cArqTmp") == 0
	Return
EndIf          

If mv_par29 == 1	//Se totaliza centro de custo 
	dbSelectArea("cArqTmp")
	dbSetOrder(1)
	dbGotop()
	While!Eof()		       
		If !Empty(cArqTmp->CCSUP) 
			dbSelectArea("CTT")
			dbSetOrder(1)
			If MsSeek(xFilial()+cArqTmp->CCSUP)
				If Empty(CTT->CTT_CCSUP) 
					lNivel1	:= .T.
				Else
					lNivel1	:= .F.
				EndIf
			EndIf
			
			dbSelectArea("cArqTmp")  
//			If (( mv_par28 == 2 .And. TIPOCC == "2" ) .Or. (mv_par28 == 1 .And. TIPOCC == "1" .And. Empty(CCSUP)) .Or. (mv_par28 == 3 ) .Or. lNivel1) .And.;
			If (( mv_par28 == 2 .And. TIPOCC == "2" ) .Or. (mv_par28 == 1 .And. TIPOCC == "1" ) .Or. (mv_par28 == 3 ) .Or. lNivel1) .And.;
				(( mv_par07 == 2 .And. TIPOCONTA == "2" ) .Or. (mv_par07 <> 2 .And. TIPOCONTA == "1" .And. Empty(CTASUP)))                

		
				nPosCC	:= ASCAN(aTotCCSup,{|x| x[1]==CCSUP})			
				If  nPosCC <= 0 				
	   		        aSupCC := {}
					For nVezes := 1 to Len(aMeses)	
		                aAdd(aSupCC,&("COLUNA"+Alltrim(Str(nVezes,2))))
					Next
					If Len(aMeses) < 12
						For nVezes := Len(aMeses)+1 to 12
		                	aAdd(aSupCC,0)				
						Next
					EndIf	                
					AADD(aTotCCSup,{CCSUP,aSupCC})
				Else     
					For nVezes := 1 to Len(aMeses)				
						aTotCCSup[nPosCC][2][nVezes]	+= 	&("COLUNA"+Alltrim(Str(nVezes,2)))
					Next										
				EndIf
			EndIf                
		EndIf
		dbSkip()
	End
EndIf
					
dbSelectArea("cArqTmp")
dbSetOrder(1)
dbGoTop()

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial
//nao esta disponivel e sai da rotina.
If RecCount() == 0 .And. !Empty(aSetOfBook[5])
	dbCloseArea()
	FErase(cArqTmp+GetDBExtension())
	FErase("cArqInd"+OrdBagExt())
	Return
Endif

SetRegua(RecCount())

If !Eof()
	If lXML == .T.
		oFwMsEx    := FWMsExcel():New()

		/********************  Gera parametros em XML ********************/ 
		IF GetMv("MV_IMPSX1") == "S"
			U_fCabecXML(oFwMsEx, cPerg,  "Parâmetros - Comparativo" )   
		EndIf
		                                   
		cWorkSheet := "Comparativo"
		cTable     := "Comparativo de C.Custo / Conta"

	    oFwMsEx:AddWorkSheet( cWorkSheet )
	    oFwMsEx:AddTable( cWorkSheet, cTable )	
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Código C.Custo"    , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Descrição C.Custo" , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Código"            , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Descrição"         , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Periodo 01"        , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Periodo 02"        , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Periodo 03"        , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Periodo 04"        , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Periodo 05"        , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Periodo 06"        , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Periodo 07"        , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Periodo 08"        , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Periodo 09"        , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Periodo 10"        , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Periodo 11"        , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Periodo 12"        , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Total do Periodo"  , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Cod US Gaap"       , 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Desc US Gaap"      , 1,1)
		//Alterações 06/05/15
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Location"		   	, 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Bus.Segment"      	, 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Department"       	, 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Section"	       	, 1,1)
		oFwMsEx:AddColumn( cWorkSheet, cTable , "Desc CC Gaap"     	, 1,1)
	EndIf
	
	cGrupo := GRUPO     
	While !Eof()
		
		If lEnd
			@Prow()+1,0 PSAY STR0016   //"***** CANCELADO PELO OPERADOR *****"
			Exit
		EndIF
		
		IncRegua()
		
		******************** "FILTRAGEM" PARA IMPRESSAO *************************
		If mv_par28 == 1					// So imprime Sinteticas
			If TIPOCC == "2"
				dbSkip()
				Loop
			EndIf
		ElseIf mv_par28 == 2				// So imprime Analiticas
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
		
		//Filtragem ate o Segmento ( antigo nivel do SIGACON)
		If !Empty(cSegAte)
			If Len(Alltrim(CONTA)) > nDigitAte
				dbSkip()
				Loop
			Endif
		EndIf
		
		If lVlrZerado	.And. ;
			(Abs(COLUNA1)+Abs(COLUNA2)+Abs(COLUNA3)+Abs(COLUNA4)+Abs(COLUNA5)+Abs(COLUNA6)+Abs(COLUNA7)+Abs(COLUNA8)+;
			Abs(COLUNA9)+Abs(COLUNA10)+Abs(COLUNA11)+Abs(COLUNA12)) == 0
			If CtbExDtFim("CTT")
				dbSelectArea("CTT")
				dbSetOrder(1)
				If MsSeek(xFilial()+ cArqTmp->CUSTO)
					If !CtbVlDtFim("CTT",mv_par01)
						dbSelectArea("cArqTmp")
						dbSkip()
						Loop
					EndIf
				EndIf
			EndIf
			
			If CtbExDtFim("CT1")
				dbSelectArea("CT1")
				dbSetOrder(1)
				If MsSeek(xFilial()+ cArqTmp->CONTA)
					If !CtbVlDtFim("CT1",mv_par01)
						dbSelectArea("cArqTmp")
						dbSkip()
						Loop
					EndIf
				EndIf
			EndIf
			dbSelectArea("cArqTmp")
		EndIf
		
		//Caso faca filtragem por segmento de Conta,verifico se esta dentro
		//da solicitacao feita pelo usuario.
		If !Empty(mv_par14)
			If Empty(mv_par15) .And. Empty(mv_par16) .And. !Empty(mv_par17)
				If  !(Substr(cArqTMP->CONTA,nPos,nDigitos) $ (mv_par17) )
					dbSkip()
					Loop
				EndIf
			Else
				If Substr(cArqTMP->CONTA,nPos,nDigitos) < Alltrim(mv_par15) .Or. Substr(cArqTMP->CONTA,nPos,nDigitos) > Alltrim(mv_par16)
					dbSkip()
					Loop
				EndIf
			Endif
		EndIf
		
		************************* ROTINA DE IMPRESSAO *************************
		If mv_par31 == 1																	// Quebra por Grupo Contabil
			If (cGrupo <> GRUPO) .Or.;													// Grupo Diferente ou
				((cCustoAnt <> cArqTmp->CUSTO) .And. ! Empty(cCustoAnt))	// Centro de Custo Diferente
				
				@li,00 PSAY REPLICATE("-",limite)
				li+=2
				@li,00 PSAY REPLICATE("-",limite)
				li++
				@li,aColunas[COL_SEPARA1] PSAY "|"
				@li,01 PSAY STR0030 + Left(cGrupo,10) + ")"  		//"GRUPO ("
				@li,aColunas[COL_SEPARA2] PSAY "|"
				
				ValorCTB(aTotGrupo[1],li,aColunas[COL_COLUNA1],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA4]		PSAY "|"
				ValorCTB(aTotGrupo[2],li,aColunas[COL_COLUNA2],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA5]		PSAY "|"
				ValorCTB(aTotGrupo[3],li,aColunas[COL_COLUNA3],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA6]		PSAY "|"
				ValorCTB(aTotGrupo[4],li,aColunas[COL_COLUNA4],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA7] PSAY "|"
				ValorCTB(aTotGrupo[5],li,aColunas[COL_COLUNA5],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA8] PSAY "|"
				ValorCTB(aTotGrupo[6],li,aColunas[COL_COLUNA6],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA9] PSAY "|"
				ValorCTB(aTotGrupo[7],li,aColunas[COL_COLUNA7],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA10] PSAY "|"
				ValorCTB(aTotGrupo[8],li,aColunas[COL_COLUNA8],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA11] PSAY "|"
				ValorCTB(aTotGrupo[9],li,aColunas[COL_COLUNA9],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA12] PSAY "|"
				ValorCTB(aTotGrupo[10],li,aColunas[COL_COLUNA10],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA13] PSAY "|"
				ValorCTB(aTotGrupo[11],li,aColunas[COL_COLUNA11],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA14] PSAY "|"
				ValorCTB(aTotGrupo[12],li,aColunas[COL_COLUNA12],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				If mv_par26 = 1		// Imprime Total
					nTotLinGrp	:= 0
					For nVezes := 1 to Len(aTotGrupo)
						nTotLinGrp	+= aTotGrupo[nVezes]
					Next
					If mv_par27 == 1//Mostrar a conta
						@ li,aColunas[COL_SEPARA15]-20 PSAY "|"
						ValorCTB(nTotLinGrp,li,aColunas[COL_SEPARA15]-18,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
					ElseIf mv_par27 == 2	//Mostrar a descricao
						@ li,aColunas[COL_SEPARA15]-15 PSAY "|"
						ValorCTB(nTotLinGrp,li,aColunas[COL_SEPARA15]-14,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
					EndIf
				Endif
				@ li,aColunas[COL_SEPARA15] PSAY "|"

				//*************************** Gravando linha no XML - Total por Centro de Custo -Inicio
				If lXML == .T.
					nTotLinGrp	:= 0
					For nVezes := 1 to Len(aTotGrupo)
						nTotLinGrp	+= aTotGrupo[nVezes]
					Next                
					
                    cCodGrupo := Iif( !Empty(cGrupo), cGrupo , cCustoAnt)
					cDescGrupo:= Iif( !Empty(cGrupo), GetAdvFval("CTR","CT_DESC"   , xFilial("CTR") + cCodGrupo, 1, 0),;
					                                  GetAdvFval("CTT","CTT_DESC01", xFilial("CTT") + cCodGrupo, 1, 0))

					cFtiLc := GetAdvFval("CTT","CTT_XFTILC", xFilial("CTT") + cCodGrupo, 1, 0) 
					cFtiBs := GetAdvFval("CTT","CTT_XFTIBS", xFilial("CTT") + cCodGrupo, 1, 0) 
					cFtiDp := GetAdvFval("CTT","CTT_XFTIDP", xFilial("CTT") + cCodGrupo, 1, 0) 	
					cFtiSc := GetAdvFval("CTT","CTT_XFTISC", xFilial("CTT") + cCodGrupo, 1, 0) 
					cFGaap := GetAdvFval("CTT","CTT_XGAAP ", xFilial("CTT") + cCodGrupo, 1, 0)  
					                                            
					oFwMsEx:AddRow( cWorkSheet, cTable, { ;
					cCodGrupo                            ,;
					cDescGrupo                           ,;                                                              
					""                                   ,;
					""                                   ,;
					aTotGrupo[1]*-1                      ,;
					aTotGrupo[2]*-1                      ,;
					aTotGrupo[3]*-1                      ,;
					aTotGrupo[4]*-1                      ,;
					aTotGrupo[5]*-1                      ,;
					aTotGrupo[6]*-1                      ,;
					aTotGrupo[7]*-1                      ,;
					aTotGrupo[8]*-1                      ,;
					aTotGrupo[9]*-1                      ,;
					aTotGrupo[10]*-1                     ,;
					aTotGrupo[11]*-1                     ,;
					aTotGrupo[12]*-1                     ,;
					nTotLinGrp*-1                        ,;
					""                                   ,;
					""                                   ,;
					cFtiLc							     ,;
					cFtiBs							     ,;
					cFtiDp							     ,;
					cFtiSc							     ,;
					cFGaap							     })  				
					   					
					oFwMsEx:AddRow( cWorkSheet, cTable, {"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
				EndIf
				//*************************** Gravando linha no XML - Total por Centro de Custo - Fim
				
				li			:= 60           
				cGrupo		:= GRUPO
				aTotGrupo	:= {0,0,0,0,0,0,0,0,0,0,0,0}
			EndIf
		Else
			If (cCustoAnt <> cArqTmp->CUSTO) .And. ! Empty(cCustoAnt)
				@li,00 PSAY	Replicate("-",limite)
				li++
				@li,aColunas[COL_SEPARA1] PSAY "|"
				                                                                  
				If mv_par26 == 2
					@li,aColunas[COL_CONTA] PSAY STR0018+ Upper(Alltrim(cSayCC))+ " : " //"T O T A I S  D O  "
					If mv_par19 == 2	.And. cArqTmp->TIPOCC == '2'//Se Imprime cod. reduzido do centro de Custo e eh analitico
						EntidadeCTB(cCCResAnt,li,aColunas[COL_CONTA]+23,nTamCdoCusto,.F.,cMascCC,cSepara1)
					Else //Se Imprime cod. normal do Centro de Custo
						EntidadeCTB(cCustoAnt,li,aColunas[COL_CONTA]+23,nTamCdoCusto,.F.,cMascCC,cSepara1)
					Endif
					@ li,aColunas[COL_SEPARA15] PSAY "|"
					li++
					@li,00 PSAY	Replicate("-",limite)
					li++
					@ li,aColunas[COL_SEPARA3] PSAY "|"
				Else
					@li,aColunas[COL_CONTA] PSAY STR0026 //"TOTAIS: "
					If mv_par19 == 2	.And. cArqTmp->TIPOCC == '2'//Se Imprime cod. reduzido do centro de Custo e eh analitico
						@li,25 PSAY Subs(cCCResAnt,1,25)
					Else //Se Imprime cod. normal do Centro de Custo
						@li,25 PSAY Subs(cCustoAnt,1,25)
					Endif
					
					@ li,aColunas[COL_SEPARA15] PSAY "|"
					li++
					@li,00 PSAY	Replicate("-",limite)
					li++
					@ li,aColunas[COL_SEPARA2] PSAY "|"
				EndIf
				
				dbSelectArea("CTT")
				dbSetOrder(1)
				If MsSeek(xFilial()+cArqTmp->CUSTO)
					cCCSup	:= CTT->CTT_CCSUP
				Else
					cCCSup	:= ""
				EndIf
				
				dbSelectArea("CTT")
				dbSetOrder(1)
				If MsSeek(xFilial()+cCustoAnt)
					cAntCCSup	:= CTT->CTT_CCSUP
				Else
					cAntCCSup	:= ""
				EndIf
				dbSelectArea("cArqTmp")

				//Total da Linha
				nTotLinha	:= 0     			// Incluso esta linha para impressao dos totais
				For nVezes := 1 to Len(aMeses)	// por periodo em 09/06/2004 por Otacilio
					nTotLinha	+= aTotCC[nVezes]
				Next
		
				//*************************** Gravando linha no XML - Total por Centro de Custo -Inicio
				If lXML == .T.
					cCodCusto := Iif(mv_par19 == 2 .And. cArqTmp->TIPOCC == '2',cCCResAnt,cCustoAnt) 
					cDescCusto:= GetAdvFval("CTT","CTT_DESC01", xFilial("CTT") + cCodCusto, 1, 0)
					
					cFtiLc := GetAdvFval("CTT","CTT_XFTILC", xFilial("CTT") + cCodCusto, 1, 0) 
					cFtiBs := GetAdvFval("CTT","CTT_XFTIBS", xFilial("CTT") + cCodCusto, 1, 0) 
					cFtiDp := GetAdvFval("CTT","CTT_XFTIDP", xFilial("CTT") + cCodCusto, 1, 0) 	
					cFtiSc := GetAdvFval("CTT","CTT_XFTISC", xFilial("CTT") + cCodCusto, 1, 0) 
					cFGaap := GetAdvFval("CTT","CTT_XGAAP ", xFilial("CTT") + cCodCusto, 1, 0) 
					                                                                                
					oFwMsEx:AddRow( cWorkSheet, cTable, { ;
					cCodCusto                            ,;
					cDescCusto                           ,;                                                              
					""                                   ,;
					""                                   ,;
					aTotCC[1]*-1                         ,;
					aTotCC[2]*-1                         ,;
					aTotCC[3]*-1                         ,;
					aTotCC[4]*-1                         ,;
					aTotCC[5]*-1                         ,;
					aTotCC[6]*-1                         ,;
					aTotCC[7]*-1                         ,;
					aTotCC[8]*-1                         ,;
					aTotCC[9]*-1                         ,;
					aTotCC[10]*-1                        ,;
					aTotCC[11]*-1                        ,;
					aTotCC[12]*-1                        ,;
					nTotLinha*-1                         ,;
					""                                   ,;
					""                                   ,;
					cFtiLc							     ,;
					cFtiBs							     ,;
					cFtiDp							     ,;
					cFtiSc							     ,;
					cFGaap							     })   
					
					oFwMsEx:AddRow( cWorkSheet, cTable, {"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
				EndIf
				//*************************** Gravando linha no XML - Total por Centro de Custo - Fim
								
				@li,aColunas[COL_SEPARA1] PSAY "|"
				ValorCTB(aTotCC[1],li,aColunas[COL_COLUNA1],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA4]		PSAY "|"
				ValorCTB(aTotCC[2],li,aColunas[COL_COLUNA2],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA5]		PSAY "|"
				ValorCTB(aTotCC[3],li,aColunas[COL_COLUNA3],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA6]		PSAY "|"
				ValorCTB(aTotCC[4],li,aColunas[COL_COLUNA4],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA7] PSAY "|"
				ValorCTB(aTotCC[5],li,aColunas[COL_COLUNA5],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA8] PSAY "|"
				ValorCTB(aTotCC[6],li,aColunas[COL_COLUNA6],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA9] PSAY "|"
				ValorCTB(aTotCC[7],li,aColunas[COL_COLUNA7],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA10] PSAY "|"
				ValorCTB(aTotCC[8],li,aColunas[COL_COLUNA8],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA11] PSAY "|"
				ValorCTB(aTotCC[9],li,aColunas[COL_COLUNA9],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA12] PSAY "|"
				ValorCTB(aTotCC[10],li,aColunas[COL_COLUNA10],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA13] PSAY "|"
				ValorCTB(aTotCC[11],li,aColunas[COL_COLUNA11],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				@ li,aColunas[COL_SEPARA14] PSAY "|"
				ValorCTB(aTotCC[12],li,aColunas[COL_COLUNA12],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
				If mv_par26 = 1		// Imprime Total
					If mv_par27 == 1//Mostrar a conta
						@ li,aColunas[COL_SEPARA15]-20 PSAY "|"
						ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-18,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
					ElseIf mv_par27 == 2	//Mostrar a descricao
						@ li,aColunas[COL_SEPARA15]-15 PSAY "|"
						ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-14,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
					EndIf
				Endif
				@ li,aColunas[COL_SEPARA15] PSAY "|"
				aTotCC 	:= {0,0,0,0,0,0,0,0,0,0,0,0}
				
				If lImpTotS .And. cCCSup <> cAntCCSup .And. !Empty(cAntCCSup) //Se for centro de custo superior diferente
					li++
					@li,aColunas[COL_SEPARA1] PSAY "|"
					If mv_par26 == 2
						@li,aColunas[COL_CONTA] PSAY STR0018+ Upper(Alltrim(cSayCC))+ " : " //"T O T A I S  D O  "
						If mv_par19 == 2	.And. cArqTmp->TIPOCC == '2'//Se Imprime cod. reduzido do centro de Custo e eh analitico
							EntidadeCTB(cCCResAnt,li,aColunas[COL_CONTA]+23,nTamCdoCusto,.F.,cMascCC,cSepara1)
						Else //Se Imprime cod. normal do Centro de Custo
							EntidadeCTB(cAntCCSup,li,aColunas[COL_CONTA]+23,nTamCdoCusto,.F.,cMascCC,cSepara1)
						Endif
						@ li,aColunas[COL_SEPARA15] PSAY "|"
						li++
						@li,00 PSAY	Replicate("-",limite)
						li++
						@ li,aColunas[COL_SEPARA3] PSAY "|"
					Else
						@li,aColunas[COL_CONTA] PSAY STR0026 //"TOTAIS: "
						If mv_par19 == 2	.And. cArqTmp->TIPOCC == '2'//Se Imprime cod. reduzido do centro de Custo e eh analitico
							@li,25 PSAY Subs(cCCResAnt,1,25)
						Else //Se Imprime cod. normal do Centro de Custo
							@li,25 PSAY Subs(cAntCCSup,1,25)
						Endif
						
						@ li,aColunas[COL_SEPARA15] PSAY "|"
						li++
						@li,00 PSAY	Replicate("-",limite)
						li++
						@ li,aColunas[COL_SEPARA2] PSAY "|"
					EndIf
					
					//Total da Linha
					nTotLinha	:= 0     			// Incluso esta linha para impressao dos totais
					
					nPosCC	:= ASCAN(aTotCCSup,{|x| x[1]== cAntCCSup })
					If  nPosCC > 0
						For nVezes := 1 to Len(aMeses)	// por periodo em 09/06/2004 por Otacilio
							nTotLinha	+= aTotCCSup[nPosCC][2][nVezes]
						Next
						@li,aColunas[COL_SEPARA1] PSAY "|"
						ValorCTB(aTotCCSup[nPosCC][2][1],li,aColunas[COL_COLUNA1],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
						@ li,aColunas[COL_SEPARA4]		PSAY "|"
						ValorCTB(aTotCCSup[nPosCC][2][2],li,aColunas[COL_COLUNA2],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
						@ li,aColunas[COL_SEPARA5]		PSAY "|"
						ValorCTB(aTotCCSup[nPosCC][2][3],li,aColunas[COL_COLUNA3],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
						@ li,aColunas[COL_SEPARA6]		PSAY "|"
						ValorCTB(aTotCCSup[nPosCC][2][4],li,aColunas[COL_COLUNA4],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
						@ li,aColunas[COL_SEPARA7] PSAY "|"
						ValorCTB(aTotCCSup[nPosCC][2][5],li,aColunas[COL_COLUNA5],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
						@ li,aColunas[COL_SEPARA8] PSAY "|"
						ValorCTB(aTotCCSup[nPosCC][2][6],li,aColunas[COL_COLUNA6],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
						@ li,aColunas[COL_SEPARA9] PSAY "|"
						ValorCTB(aTotCCSup[nPosCC][2][7],li,aColunas[COL_COLUNA7],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
						@ li,aColunas[COL_SEPARA10] PSAY "|"
						ValorCTB(aTotCCSup[nPosCC][2][8],li,aColunas[COL_COLUNA8],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
						@ li,aColunas[COL_SEPARA11] PSAY "|"
						ValorCTB(aTotCCSup[nPosCC][2][9],li,aColunas[COL_COLUNA9],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
						@ li,aColunas[COL_SEPARA12] PSAY "|"
						ValorCTB(aTotCCSup[nPosCC][2][10],li,aColunas[COL_COLUNA10],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
						@ li,aColunas[COL_SEPARA13] PSAY "|"
						ValorCTB(aTotCCSup[nPosCC][2][11],li,aColunas[COL_COLUNA11],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
						@ li,aColunas[COL_SEPARA14] PSAY "|"
						ValorCTB(aTotCCSup[nPosCC][2][12],li,aColunas[COL_COLUNA12],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
						If mv_par26 = 1		// Imprime Total
							If mv_par27 == 1//Mostrar a conta
								@ li,aColunas[COL_SEPARA15]-20 PSAY "|"
								ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-18,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
							ElseIf mv_par27 == 2	//Mostrar a descricao
								@ li,aColunas[COL_SEPARA15]-15 PSAY "|"
								ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-14,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
							EndIf
						Endif
						@ li,aColunas[COL_SEPARA15] PSAY "|"
						dbSelectArea("cArqTmp")
						nRegTmp	:= Recno()
						dbSelectArea("CTT")
						lImpCCSint	:= .T.
					EndIf
					While lImpCCSint
						dbSelectArea("CTT")
						If MsSeek(xFilial()+cAntCCSup) .And. !Empty(CTT->CTT_CCSUP)
							cAntCCSup	:= CTT->CTT_CCSUP
							li++
							@li,aColunas[COL_SEPARA1] PSAY "|"
							If mv_par26 == 2
								@li,aColunas[COL_CONTA] PSAY STR0018+ Upper(Alltrim(cSayCC))+ " : " //"T O T A I S  D O  "
								EntidadeCTB(cAntCCSup,li,aColunas[COL_CONTA]+23,nTamCdoCusto,.F.,cMascCC,cSepara1)
								
								@ li,aColunas[COL_SEPARA15] PSAY "|"
								li++
								@li,00 PSAY	Replicate("-",limite)
								li++
								@ li,aColunas[COL_SEPARA3] PSAY "|"
							Else
								@li,aColunas[COL_CONTA] PSAY STR0026 //"TOTAIS: "
								@li,25 PSAY Subs(cAntCCSup,1,25)
								
								@ li,aColunas[COL_SEPARA15] PSAY "|"
								li++
								@li,00 PSAY	Replicate("-",limite)
								li++
								@ li,aColunas[COL_SEPARA2] PSAY "|"
							EndIf
							dbSelectArea("cArqTmp")
							
							//Total da Linha
							nTotLinha	:= 0     			// Incluso esta linha para impressao dos totais
							nPosCC	:= ASCAN(aTotCCSup,{|x| x[1]== cAntCCSup })
							If  nPosCC > 0
								For nVezes := 1 to Len(aMeses)	// por periodo em 09/06/2004 por Otacilio
									nTotLinha	+= aTotCCSup[nPosCC][2][nVezes]
								Next
								@li,aColunas[COL_SEPARA1] PSAY "|"
								ValorCTB(aTotCCSup[nPosCC][2][1],li,aColunas[COL_COLUNA1],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
								@ li,aColunas[COL_SEPARA4]		PSAY "|"
								ValorCTB(aTotCCSup[nPosCC][2][2],li,aColunas[COL_COLUNA2],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
								@ li,aColunas[COL_SEPARA5]		PSAY "|"
								ValorCTB(aTotCCSup[nPosCC][2][3],li,aColunas[COL_COLUNA3],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
								@ li,aColunas[COL_SEPARA6]		PSAY "|"
								ValorCTB(aTotCCSup[nPosCC][2][4],li,aColunas[COL_COLUNA4],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
								@ li,aColunas[COL_SEPARA7] PSAY "|"
								ValorCTB(aTotCCSup[nPosCC][2][5],li,aColunas[COL_COLUNA5],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
								@ li,aColunas[COL_SEPARA8] PSAY "|"
								ValorCTB(aTotCCSup[nPosCC][2][6],li,aColunas[COL_COLUNA6],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
								@ li,aColunas[COL_SEPARA9] PSAY "|"
								ValorCTB(aTotCCSup[nPosCC][2][7],li,aColunas[COL_COLUNA7],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
								@ li,aColunas[COL_SEPARA10] PSAY "|"
								ValorCTB(aTotCCSup[nPosCC][2][8],li,aColunas[COL_COLUNA8],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
								@ li,aColunas[COL_SEPARA11] PSAY "|"
								ValorCTB(aTotCCSup[nPosCC][2][9],li,aColunas[COL_COLUNA9],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
								@ li,aColunas[COL_SEPARA12] PSAY "|"
								ValorCTB(aTotCCSup[nPosCC][2][10],li,aColunas[COL_COLUNA10],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
								@ li,aColunas[COL_SEPARA13] PSAY "|"
								ValorCTB(aTotCCSup[nPosCC][2][11],li,aColunas[COL_COLUNA11],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
								@ li,aColunas[COL_SEPARA14] PSAY "|"
								ValorCTB(aTotCCSup[nPosCC][2][12],li,aColunas[COL_COLUNA12],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
								If mv_par26 = 1		// Imprime Total
									If mv_par27 == 1//Mostrar a conta
										@ li,aColunas[COL_SEPARA15]-20 PSAY "|"
										ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-18,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
									ElseIf mv_par27 == 2	//Mostrar a descricao
										@ li,aColunas[COL_SEPARA15]-15 PSAY "|"
										ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-14,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
									EndIf
								Endif
								@ li,aColunas[COL_SEPARA15] PSAY "|"
								li++
								lImpCCSint	:= .T.
							EndIF
						Else
							lImpCCSint	:= .F.
						EndIf
					End
					cAntCCSup		:= ""
					cCCSup			:= ""
					dbSelectArea("cArqTmp")
					dbGoto(nRegTmp)
				EndIf
				
			Endif
		EndIf
		
		If mv_par31 == 1												// Quebra por Grupo Contabil
			If cGrupo != GRUPO									// Grupo Diferente
				li	:= 60
			EndIf
		Else
			If mv_par18 == 1 .And. ! Empty(cCustoAnt)
				If cCustoAnt <> cArqTmp->CUSTO //Se o CC atual for diferente do CC anterior
					li 	:= 60
				EndIf
			Endif
		EndIf
		
		If li > 58
			If !lFirstPage
				@ Prow()+1,00 PSAY	Replicate("-",limite)
			EndIf
			CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
			If mv_par31 == 2 .And. mv_par28 == 3 .Or. lFirstPage
				If mv_par18 == 1 .or. lFirstPage
					//Imprime titulo do centro de custo
					li++
					@li,00 PSAY REPLICATE("-",limite)
					li++
					@ li,aColunas[COL_SEPARA1] PSAY "|"
					@ li,aColunas[COL_CONTA]+4 PSAY Upper(cSayCC)
					If mv_par19 == 2 .And. cArqTmp->TIPOCC == '2'//Se Imprime Cod Reduzido do C.Custo e eh analitico
						EntidadeCTB(CCRES,li,aColunas[COL_CONTA]+20,25,.F.,cMascCC,cSepara1)
					Else //Se Imprime Cod. Normal do C.Custo
						EntidadeCTB(CUSTO,li,aColunas[COL_CONTA]+20,25,.F.,cMascCC,cSepara1)
					Endif
					@ li,aColunas[COL_CONTA]+ Len(CriaVar("CTT_DESC01")) PSAY SPACE(10)+"  -  " +cArqTMP->DESCCC
					@ li,aColunas[COL_SEPARA15] PSAY "|"
					li++
					@li,00 PSAY REPLICATE("-",limite)
					li++
					lImpCabecCC := .T.
				Endif
			EndIf
			lFirstPage := .F.
		Endif
		
		//Se mudar de centro de custo
		If ! lImpCabecCC
			If	(CUSTO <> cCustoAnt .And. !Empty(cCustoAnt))	.Or.;
				li > 58									    	.Or.;
				(mv_par31 == 1 .And. cGrupoAnt <> cArqTmp->GRUPO)
				
				//Imprime titulo do centro de custo
				li++
				@li,00 PSAY REPLICATE("-",limite)
				li++
				@ li,aColunas[COL_SEPARA1] PSAY "|"
				@ li,aColunas[COL_CONTA]+4 PSAY Upper(cSayCC)
				If mv_par19 == 2 .And. cArqTmp->TIPOCC == '2'//Se Imprime Cod Reduzido do C.Custo e eh analitico
					EntidadeCTB(CCRES,li,aColunas[COL_CONTA]+20,25,.F.,cMascCC,cSepara1)
				Else //Se Imprime Cod. Normal do C.Custo
					EntidadeCTB(CUSTO,li,aColunas[COL_CONTA]+20,25,.F.,cMascCC,cSepara1)
				Endif
				@ li,aColunas[COL_CONTA]+ Len(CriaVar("CTT_DESC01")) PSAY SPACE(10)+"  -  " +cArqTMP->DESCCC
				@ li,aColunas[COL_SEPARA15] PSAY "|"
				li++
				@li,00 PSAY REPLICATE("-",limite)
				li++
			EndIf
		Else
			lImpCabecCC := .F.
		Endif
		
		//Total da Linha
		nTotLinha	:= COLUNA1+COLUNA2+COLUNA3+COLUNA4+COLUNA5+COLUNA6+COLUNA7+COLUNA8+COLUNA9+COLUNA10+COLUNA11+COLUNA12
		
		@ li,aColunas[COL_SEPARA1] PSAY "|"
		//Se totaliza e mostra a descricao
		If mv_par26 = 1 .And. mv_par27 = 2
			@ li,aColunas[COL_CONTA] PSAY Left(DESCCTA,18)
			@ li,aColunas[COL_SEPARA2]+5 PSAY "|"
		Else
			If mv_par20 == 1       //Codigo Normal
				EntidadeCTB(Subs(CONTA,1,nTamConta),li,aColunas[COL_CONTA],nTamConta,.F.,cMascara,cSepara2)
			Else //Codigo Reduzido
				EntidadeCTB(CTARES,li,aColunas[COL_CONTA],nTamConta,.F.,cMascara,cSepara2)
			Endif
			@ li,aColunas[COL_SEPARA2] PSAY "|"
		Endif
		
		// Se nao totalizar ou se totalizar e mostrar a descricao da conta
		If mv_par26 == 2
			@ li,aColunas[COL_DESCRICAO] PSAY Left(DESCCTA,19)
			@ li,aColunas[COL_SEPARA3] PSAY "|"
		Endif
		ValorCTB(COLUNA1,li,aColunas[COL_COLUNA1],12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA4]		PSAY "|"
		ValorCTB(COLUNA2,li,aColunas[COL_COLUNA2],12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA5]		PSAY "|"
		ValorCTB(COLUNA3,li,aColunas[COL_COLUNA3],12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA6]		PSAY "|"
		ValorCTB(COLUNA4,li,aColunas[COL_COLUNA4],12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA7] PSAY "|"
		ValorCTB(COLUNA5,li,aColunas[COL_COLUNA5],12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA8] PSAY "|"
		ValorCTB(COLUNA6,li,aColunas[COL_COLUNA6],12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA9] PSAY "|"
		ValorCTB(COLUNA7,li,aColunas[COL_COLUNA7],12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA10] PSAY "|"
		ValorCTB(COLUNA8,li,aColunas[COL_COLUNA8],12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA11] PSAY "|"
		ValorCTB(COLUNA9,li,aColunas[COL_COLUNA9],12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA12] PSAY "|"
		ValorCTB(COLUNA10,li,aColunas[COL_COLUNA10],12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA13] PSAY "|"
		ValorCTB(COLUNA11,li,aColunas[COL_COLUNA11],12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA14] PSAY "|"
		ValorCTB(COLUNA12,li,aColunas[COL_COLUNA12],12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		If mv_par26 == 1
			If mv_par27 == 1
				@ li,aColunas[COL_SEPARA15]-20 PSAY "|"
				ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-18,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
			ElseIf mv_par27 == 2	//Mostrar a descricao
				@ li,aColunas[COL_SEPARA15]-15 PSAY "|"
				ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-14,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
			EndIf
		EndIf
		@ li,aColunas[COL_SEPARA15] PSAY "|"
		lJaPulou := .F.
		If lPula .And. TIPOCONTA == "1"				// Pula linha entre sinteticas
			li++
			@ li,aColunas[COL_SEPARA1] PSAY "|"
			//Se totaliza e mostra a descricao da conta
			If mv_par26 == 1 .And. mv_par27 == 2
				@ li,aColunas[COL_SEPARA2]+5 PSAY "|"
			Else
				@ li,aColunas[COL_SEPARA2] PSAY "|"
			EndIf
			//Se nao totaliza periodo
			If mv_par26 == 2
				@ li,aColunas[COL_SEPARA3] PSAY "|"
			EndIf
			@ li,aColunas[COL_SEPARA4] PSAY "|"
			@ li,aColunas[COL_SEPARA5] PSAY "|"
			@ li,aColunas[COL_SEPARA6] PSAY "|"
			@ li,aColunas[COL_SEPARA7] PSAY "|"
			@ li,aColunas[COL_SEPARA8] PSAY "|"
			@ li,aColunas[COL_SEPARA9] PSAY "|"
			@ li,aColunas[COL_SEPARA10] PSAY "|"
			@ li,aColunas[COL_SEPARA11] PSAY "|"
			@ li,aColunas[COL_SEPARA12] PSAY "|"
			@ li,aColunas[COL_SEPARA13] PSAY "|"
			@ li,aColunas[COL_SEPARA14] PSAY "|"
			If mv_par26 == 1
				If mv_par27 == 1
					@ li,aColunas[COL_SEPARA15]-20 PSAY "|"
				Else
					@ li,aColunas[COL_SEPARA15]-15 PSAY "|"
				Endif
			EndIf
			@ li,aColunas[COL_SEPARA15] PSAY "|"
			li++
			lJaPulou := .T.
		Else
			li++
		EndIf

		//*************************** Gravando linha no XML - Inicio
		If lXML == .T.
			cCodConta := Iif(mv_par20 == 1, cArqTmp->CONTA, cArqTmp->CTARES)
			                                                            
			//Inicio da manuteção realizada devido ao chamado 36142                                                                                 
			cFtiLc := GetAdvFval("CTT","CTT_XFTILC", xFilial("CTT") + cArqTmp->CUSTO , 1, 0) 
			cFtiBs := GetAdvFval("CTT","CTT_XFTIBS", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 
			cFtiDp := GetAdvFval("CTT","CTT_XFTIDP", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 	
			cFtiSc := GetAdvFval("CTT","CTT_XFTISC", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 
			cFGaap := GetAdvFval("CTT","CTT_XGAAP ", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 
			//Fim da manuteção realizada devido ao chamado 36142	                                                                                
			
			oFwMsEx:AddRow( cWorkSheet, cTable, {                             ;
			cArqTmp->CUSTO                                                   ,;
			cArqTmp->DESCCC                                                  ,;
			cCodConta                                                        ,;
			cArqTmp->DESCCTA                                                 ,;
			cArqTmp->COLUNA1*-1                                              ,;
			cArqTmp->COLUNA2*-1                                              ,;
			cArqTmp->COLUNA3*-1                                              ,;
			cArqTmp->COLUNA4*-1                                              ,;
			cArqTmp->COLUNA5*-1                                              ,;
			cArqTmp->COLUNA6*-1                                              ,;
			cArqTmp->COLUNA7*-1                                              ,;
			cArqTmp->COLUNA8*-1                                              ,;
			cArqTmp->COLUNA9*-1                                              ,;
			cArqTmp->COLUNA10*-1                                             ,;
			cArqTmp->COLUNA11*-1                                             ,;
			cArqTmp->COLUNA12*-1                                             ,;
			nTotLinha*-1                                                     ,;
			GetAdvFval("CT1","CT1_XCTFTI", xFilial("CT1") + cCodConta, 1, 0) ,;
			GetAdvFval("CT1","CT1_XDCFTI", xFilial("CT1") + cCodConta, 1, 0) ,;
			cFtiLc							     							 ,;
			cFtiBs							     							 ,;
			cFtiDp							     							 ,;
			cFtiSc							     							 ,;
			cFGaap							     							 }) 
		EndIf
		//*************************** Gravando linha no XML - Fim
		
		************************* FIM   DA  IMPRESSAO *************************
		
		If mv_par07 != 1					// Imprime Analiticas ou Ambas
			If TIPOCONTA == "2"
				If (mv_par28 != 1 .And. TIPOCC == "2")
					For nVezes := 1 to Len(aMeses)
						aTotCol[nVezes] 	+=&("COLUNA"+Alltrim(Str(nVezes,2)))
						aTotGrupo[nVezes] 	+=&("COLUNA"+Alltrim(Str(nVezes,2)))
					Next
				ElseIf (mv_par28 == 1 .And. cArqTmp->TIPOCC != "2"	)	//Imprime centro de custo sintetico
					If mv_par07 == 2 	//Imprime contas analiticas
						For nVezes := 1 to Len(aMeses)
							If Empty(CCSUP)
								aTotCol[nVezes] 	+=&("COLUNA"+Alltrim(Str(nVezes,2)))
								aTotGrupo[nVezes] 	+=&("COLUNA"+Alltrim(Str(nVezes,2)))
							EndIf
						Next
					ElseIf mv_par07 == 3	//Imprime contas sinteticas e analiticas
						If Empty(CCSUP)      //Somar somente o centro de custo sintetico
							For nVezes := 1 to Len(aMeses)
								aTotCol[nVezes] 	+=&("COLUNA"+Alltrim(Str(nVezes,2)))
								aTotGrupo[nVezes] 	+=&("COLUNA"+Alltrim(Str(nVezes,2)))
							Next
						EndIf
					EndIf
				EndIf
				For nVezes := 1 to Len(aMeses)
					aTotCC[nVezes] 		+=&("COLUNA"+Alltrim(Str(nVezes,2)))
				Next
			Endif
		Else
			If (TIPOCONTA == "1" .And. Empty(CTASUP))
				If (mv_par28 != 1 .And. cArqTmp->TIPOCC == "2")
					For nVezes := 1 to Len(aMeses)
						aTotCol[nVezes] 	+=&("COLUNA"+Alltrim(Str(nVezes,2)))
						aTotGrupo[nVezes] 	+=&("COLUNA"+Alltrim(Str(nVezes,2)))
					Next
				ElseIf (mv_par28 == 1 .And. cArqTmp->TIPOCC != "2"	)
					If Empty(CCSUP)
						For nVezes := 1 to Len(aMeses)
							aTotCol[nVezes] 	+=&("COLUNA"+Alltrim(Str(nVezes,2)))
							aTotGrupo[nVezes] 	+=&("COLUNA"+Alltrim(Str(nVezes,2)))
						Next
					EndIf
				EndIf
				For nVezes := 1 to Len(aMeses)
					aTotCC[nVezes] 		+=&("COLUNA"+Alltrim(Str(nVezes,2)))
				Next
			EndIf
		Endif
		
		cCustoAnt := cArqTmp->CUSTO
		cCCResAnt := cArqTmp->CCRES
		cGrupoAnt := cArqTmp->GRUPO
		
		
		dbSelectarea("cArqTmp")
		dbSkip()
		
		If lPula .And. TIPOCONTA == "1" 			// Pula linha entre sinteticas
			If !lJaPulou
				@ li,aColunas[COL_SEPARA1] PSAY "|"
				//Se totaliza e mostra a descricao da conta
				If mv_par26 == 1 .And. mv_par27 == 2
					@ li,aColunas[COL_SEPARA2]+5 PSAY "|"
				Else
					@ li,aColunas[COL_SEPARA2] PSAY "|"
				EndIf
				//Se nao totaliza periodo
				If mv_par26 == 2
					@ li,aColunas[COL_SEPARA3] PSAY "|"
				EndIf
				@ li,aColunas[COL_SEPARA4] PSAY "|"
				@ li,aColunas[COL_SEPARA5] PSAY "|"
				@ li,aColunas[COL_SEPARA6] PSAY "|"
				@ li,aColunas[COL_SEPARA7] PSAY "|"
				@ li,aColunas[COL_SEPARA8] PSAY "|"
				@ li,aColunas[COL_SEPARA9] PSAY "|"
				@ li,aColunas[COL_SEPARA10] PSAY "|"
				@ li,aColunas[COL_SEPARA11] PSAY "|"
				@ li,aColunas[COL_SEPARA12] PSAY "|"
				@ li,aColunas[COL_SEPARA13] PSAY "|"
				@ li,aColunas[COL_SEPARA14] PSAY "|"
				//Se totaliza linha
				If mv_par26 == 1
					If mv_par27 == 1
						@ li,aColunas[COL_SEPARA15]-20 PSAY "|"
					Else
						@ li,aColunas[COL_SEPARA15]-15 PSAY "|"
					EndIf
				EndIf
				
				@ li,aColunas[COL_SEPARA15] PSAY "|"
				li++
			EndIf
		EndIf
	EndDO             
Else
	If lXML == .T.
		MsgInfo( "Não há dados para impressão, verifique parâmetros" )
	EndIf
EndIf


If mv_par31 == 1				// Quebra por Grupo Contabil
	If (cGrupo <> GRUPO) .Or.;													// Grupo Diferente ou
		((cCustoAnt <> cArqTmp->CUSTO) .And. ! Empty(cCustoAnt))	// Centro de Custo Diferente

		@li,00 PSAY REPLICATE("-",limite)
		li+=2
		@li,00 PSAY REPLICATE("-",limite)
		li++
		@li,aColunas[COL_SEPARA1] PSAY "|"
		@li,01 PSAY STR0030 + Left(cGrupo,10) + ")"  		//"GRUPO ("
		@li,aColunas[COL_SEPARA2] PSAY "|"
		
		ValorCTB(aTotGrupo[1],li,aColunas[COL_COLUNA1],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA4]		PSAY "|"
		ValorCTB(aTotGrupo[2],li,aColunas[COL_COLUNA2],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA5]		PSAY "|"
		ValorCTB(aTotGrupo[3],li,aColunas[COL_COLUNA3],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA6]		PSAY "|"
		ValorCTB(aTotGrupo[4],li,aColunas[COL_COLUNA4],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA7] PSAY "|"
		ValorCTB(aTotGrupo[5],li,aColunas[COL_COLUNA5],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA8] PSAY "|"
		ValorCTB(aTotGrupo[6],li,aColunas[COL_COLUNA6],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA9] PSAY "|"
		ValorCTB(aTotGrupo[7],li,aColunas[COL_COLUNA7],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA10] PSAY "|"
		ValorCTB(aTotGrupo[8],li,aColunas[COL_COLUNA8],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA11] PSAY "|"
		ValorCTB(aTotGrupo[9],li,aColunas[COL_COLUNA9],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA12] PSAY "|"
		ValorCTB(aTotGrupo[10],li,aColunas[COL_COLUNA10],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA13] PSAY "|"
		ValorCTB(aTotGrupo[11],li,aColunas[COL_COLUNA11],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA14] PSAY "|"
		ValorCTB(aTotGrupo[12],li,aColunas[COL_COLUNA12],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
		If mv_par26 = 1		// Imprime Total
			nTotLinGrp	:= 0
			For nVezes := 1 to Len(aTotGrupo)
				nTotLinGrp	+= aTotGrupo[nVezes]
			Next
			If mv_par27 == 1//Mostrar a conta
				@ li,aColunas[COL_SEPARA15]-20 PSAY "|"
				ValorCTB(nTotLinGrp,li,aColunas[COL_SEPARA15]-18,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
			ElseIf mv_par27 == 2	//Mostrar a descricao
				@ li,aColunas[COL_SEPARA15]-15 PSAY "|"
				ValorCTB(nTotLinGrp,li,aColunas[COL_SEPARA15]-14,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
			EndIf
		Endif
		@ li,aColunas[COL_SEPARA15] PSAY "|"
		li++                                 
		
		//*************************** Gravando linha no XML - Total por Centro de Custo -Inicio
		If lXML == .T.  
		    lImpresso := .T.
			nTotLinGrp	:= 0
			For nVezes := 1 to Len(aTotGrupo)
				nTotLinGrp	+= aTotGrupo[nVezes]
			Next                
			
            cCodGrupo := Iif( !Empty(cGrupo), cGrupo , cCustoAnt)
			cDescGrupo:= Iif( !Empty(cGrupo), GetAdvFval("CTR","CT_DESC"   , xFilial("CTR") + cCodGrupo, 1, 0),;
			                                  GetAdvFval("CTT","CTT_DESC01", xFilial("CTT") + cCodGrupo, 1, 0)) 
	                                  
			cFtiLc := GetAdvFval("CTT","CTT_XFTILC", xFilial("CTT") + cCodGrupo, 1, 0) 
			cFtiBs := GetAdvFval("CTT","CTT_XFTIBS", xFilial("CTT") + cCodGrupo, 1, 0) 
			cFtiDp := GetAdvFval("CTT","CTT_XFTIDP", xFilial("CTT") + cCodGrupo, 1, 0) 	
			cFtiSc := GetAdvFval("CTT","CTT_XFTISC", xFilial("CTT") + cCodGrupo, 1, 0) 
			cFGaap := GetAdvFval("CTT","CTT_XGAAP ", xFilial("CTT") + cCodGrupo, 1, 0) 
			                                                                                
			oFwMsEx:AddRow( cWorkSheet, cTable, { ;
			cCodGrupo                            ,;
			cDescGrupo                           ,;                                                              
			""                                   ,;
			""                                   ,;
			aTotGrupo[1]*-1                      ,;
			aTotGrupo[2]*-1                      ,;
			aTotGrupo[3]*-1                      ,;
			aTotGrupo[4]*-1                      ,;
			aTotGrupo[5]*-1                      ,;
			aTotGrupo[6]*-1                      ,;
			aTotGrupo[7]*-1                      ,;
			aTotGrupo[8]*-1                      ,;
			aTotGrupo[9]*-1                      ,;
			aTotGrupo[10]*-1                     ,;
			aTotGrupo[11]*-1                     ,;
			aTotGrupo[12]*-1                     ,;
			nTotLinGrp*-1                        ,;
			""                                   ,;
			""                                   ,;   
			cFtiLc							     ,;
			cFtiBs							     ,;
			cFtiDp							     ,;
			cFtiSc							     ,;
			cFGaap							     })
			  			
			oFwMsEx:AddRow( cWorkSheet, cTable, {"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
		EndIf
		//*************************** Gravando linha no XML - Total por Centro de Custo - Fim

		cGrupo		:= GRUPO
		aTotGrupo	:= {0,0,0,0,0,0,0,0,0,0,0,0}
	EndIf
Else
	
	If li > 50
		If !lFirstPage
			@ Prow()+1,00 PSAY	Replicate("-",limite)
		EndIf
		CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
	Endif
	
	//Imprime o total do ultimo Conta a ser impresso.
	@li,00 PSAY	Replicate("-",limite)
	li++
	@li,aColunas[COL_SEPARA1] PSAY "|"
	
	dbSelectArea("CTT")
	dbSetOrder(1)
	If MsSeek(xFilial("CTT")+cArqTmp->CUSTO)
		cCCSup	:= CTT->CTT_CCSUP	//Centro de Custo Superior
	Else
		cCCSup	:= ""
	EndIf
	
	If MsSeek(xFilial("CTT")+cCustoAnt)
		cAntCCSup := CTT->CTT_CCSUP	//Centro de Custo Superior do Centro de custo anterior.
		cCCRes	  := CTT->CTT_RES
	Else
		cAntCCSup := ""
	EndIf
	
	dbSelectArea("cArqTmp")
	
	If mv_par26 == 2
		@li,aColunas[COL_CONTA] PSAY STR0018+ Upper(cSayCC)+ " : " //"T O T A I S  D O  "
		If mv_par19 == 2	.And. cArqTmp->TIPOCC == '2'//Se Imprime cod. reduzido do centro de Custo e eh analitico
			EntidadeCTB(cCCResAnt,li,aColunas[COL_CONTA]+23,nTamCdoCusto,.F.,cMascCC,cSepara1)
		Else //Se Imprime cod. normal do Centro de Custo
			EntidadeCTB(cCustoAnt,li,aColunas[COL_CONTA]+23,nTamCdoCusto,.F.,cMascCC,cSepara1)
		Endif
		@ li,aColunas[COL_SEPARA15] PSAY "|"
		li++
		@li,00 PSAY	Replicate("-",limite)
		li++
		@ li,aColunas[COL_SEPARA3] PSAY "|"
	Else
		@li,aColunas[COL_CONTA] PSAY STR0026 //"TOTAIS: "
		If mv_par19 == 2	.And. cArqTmp->TIPOCC == '2'//Se Imprime cod. reduzido do centro de Custo e eh analitico
			@li,25 PSAY Subs(cCCResAnt,1,25)
		Else //Se Imprime cod. normal do Centro de Custo
			@li,25 PSAY Subs(cCustoAnt,1,25)
		Endif
		
		@ li,aColunas[COL_SEPARA15] PSAY "|"
		li++
		@li,00 PSAY	Replicate("-",limite)
		li++
		@ li,aColunas[COL_SEPARA2] PSAY "|"
	EndIf
	@li,aColunas[COL_SEPARA1] PSAY "|"
	ValorCTB(aTotCC[1],li,aColunas[COL_COLUNA1],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA4]		PSAY "|"
	ValorCTB(aTotCC[2],li,aColunas[COL_COLUNA2],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA5]		PSAY "|"
	ValorCTB(aTotCC[3],li,aColunas[COL_COLUNA3],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA6]		PSAY "|"
	ValorCTB(aTotCC[4],li,aColunas[COL_COLUNA4],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA7] PSAY "|"
	ValorCTB(aTotCC[5],li,aColunas[COL_COLUNA5],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA8] PSAY "|"
	ValorCTB(aTotCC[6],li,aColunas[COL_COLUNA6],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA9] PSAY "|"
	ValorCTB(aTotCC[7],li,aColunas[COL_COLUNA7],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA10] PSAY "|"
	ValorCTB(aTotCC[8],li,aColunas[COL_COLUNA8],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA11] PSAY "|"
	ValorCTB(aTotCC[9],li,aColunas[COL_COLUNA9],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA12] PSAY "|"
	ValorCTB(aTotCC[10],li,aColunas[COL_COLUNA10],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA13] PSAY "|"
	ValorCTB(aTotCC[11],li,aColunas[COL_COLUNA11],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA14] PSAY "|"
	ValorCTB(aTotCC[12],li,aColunas[COL_COLUNA12],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	
	//Total da Linha
	nTotLinha	:= 0
	For nVezes := 1 to Len(aMeses)
		nTotLinha	+= aTotCC[nVezes]
	Next

	//*************************** Gravando linha no XML - Total por Centro de Custo -Inicio
	If lXML == .T.      
		lImpresso := .T.
		cCodCusto := Iif(mv_par19 == 2 .And. cArqTmp->TIPOCC == '2',cCCResAnt,cCustoAnt) 
		cDescCusto:= GetAdvFval("CTT","CTT_DESC01", xFilial("CTT") + cCodCusto, 1, 0) 
		
		cFtiLc := GetAdvFval("CTT","CTT_XFTILC", xFilial("CTT") + cCodCusto, 1, 0) 
		cFtiBs := GetAdvFval("CTT","CTT_XFTIBS", xFilial("CTT") + cCodCusto, 1, 0) 
		cFtiDp := GetAdvFval("CTT","CTT_XFTIDP", xFilial("CTT") + cCodCusto, 1, 0) 	
		cFtiSc := GetAdvFval("CTT","CTT_XFTISC", xFilial("CTT") + cCodCusto, 1, 0) 
		cFGaap := GetAdvFval("CTT","CTT_XGAAP ", xFilial("CTT") + cCodCusto, 1, 0) 
		                                                                                
		oFwMsEx:AddRow( cWorkSheet, cTable, { ;
		cCodCusto                            ,;
		cDescCusto                           ,;                                                              
		""                                   ,;
		""                                   ,;
		aTotCC[1]*-1                         ,;
		aTotCC[2]*-1                         ,;
		aTotCC[3]*-1                         ,;
		aTotCC[4]*-1                         ,;
		aTotCC[5]*-1                         ,;
		aTotCC[6]*-1                         ,;
		aTotCC[7]*-1                         ,;
		aTotCC[8]*-1                         ,;
		aTotCC[9]*-1                         ,;
		aTotCC[10]*-1                        ,;             
		aTotCC[11]*-1                        ,;
		aTotCC[12]*-1                        ,;
		nTotLinha*-1                         ,;
		""                                   ,;
		""                                   ,;
		cFtiLc							     ,;
		cFtiBs							     ,;
		cFtiDp							     ,;
		cFtiSc							     ,;
		cFGaap							     })   
		
		oFwMsEx:AddRow( cWorkSheet, cTable, {"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
	EndIf
	//*************************** Gravando linha no XML - Total por Centro de Custo - Fim
		
	If mv_par26 == 1
		If mv_par27 == 1	//Mostrar a conta
			@ li,aColunas[COL_SEPARA15]-20 PSAY "|"
			ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-18,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		ElseIf mv_par27 == 2	//Mostrar a descricao
			@ li,aColunas[COL_SEPARA15]-15 PSAY "|"
			ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-14,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		EndIf
	EndIf
	@ li,aColunas[COL_SEPARA15] PSAY "|"
	li++
	@li,00 PSAY	Replicate("-",limite)
	If (cArqTmp->TIPOCC == "1" .And. !Empty(cArqTmp->CCSUP)) .Or. (cArqTmp->TIPOCC == "2")
		aTotCC 	:= {0,0,0,0,0,0,0,0,0,0,0,0}
	EndIf
	li++
	@ li,aColunas[COL_SEPARA15] PSAY "|"
	
	If lImpTotS .And. cCCSup <> cAntCCSup .And. !Empty(cAntCCSup) //Se for centro de custo superior diferente
		
		@li,aColunas[COL_SEPARA1] PSAY "|"
		li++
		@li,aColunas[COL_SEPARA1] PSAY "|"
		If mv_par26 == 2
			@li,aColunas[COL_CONTA] PSAY STR0018+ Upper(Alltrim(cSayCC))+ " : " //"T O T A I S  D O  "
			EntidadeCTB(cAntCCSup,li,aColunas[COL_CONTA]+23,nTamCdoCusto,.F.,cMascCC,cSepara1)
			
			@ li,aColunas[COL_SEPARA15] PSAY "|"
			li++
			@li,00 PSAY	Replicate("-",limite)
			li++
			@ li,aColunas[COL_SEPARA3] PSAY "|"
		Else
			@li,aColunas[COL_CONTA] PSAY STR0026 //"TOTAIS: "
			@li,25 PSAY Subs(cAntCCSup,1,25)
			@ li,aColunas[COL_SEPARA15] PSAY "|"
			li++
			@li,00 PSAY	Replicate("-",limite)
			li++
			@ li,aColunas[COL_SEPARA2] PSAY "|"
		EndIf
		
		//Total da Linha
		nTotLinha	:= 0     			// Incluso esta linha para impressao dos totais
		nPosCC	:= ASCAN(aTotCCSup,{|x| x[1]== cAntCCSup })
		If  nPosCC > 0
			For nVezes := 1 to Len(aMeses)	// por periodo em 09/06/2004 por Otacilio
				nTotLinha	+= aTotCCSup[nPosCC][2][nVezes]
			Next
			@li,aColunas[COL_SEPARA1] PSAY "|"
			ValorCTB(aTotCCSup[nPosCC][2][1],li,aColunas[COL_COLUNA1],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA4]		PSAY "|"
			ValorCTB(aTotCCSup[nPosCC][2][2],li,aColunas[COL_COLUNA2],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA5]		PSAY "|"
			ValorCTB(aTotCCSup[nPosCC][2][3],li,aColunas[COL_COLUNA3],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA6]		PSAY "|"
			ValorCTB(aTotCCSup[nPosCC][2][4],li,aColunas[COL_COLUNA4],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA7] PSAY "|"
			ValorCTB(aTotCCSup[nPosCC][2][5],li,aColunas[COL_COLUNA5],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA8] PSAY "|"
			ValorCTB(aTotCCSup[nPosCC][2][6],li,aColunas[COL_COLUNA6],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA9] PSAY "|"
			ValorCTB(aTotCCSup[nPosCC][2][7],li,aColunas[COL_COLUNA7],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA10] PSAY "|"
			ValorCTB(aTotCCSup[nPosCC][2][8],li,aColunas[COL_COLUNA8],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA11] PSAY "|"
			ValorCTB(aTotCCSup[nPosCC][2][9],li,aColunas[COL_COLUNA9],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA12] PSAY "|"
			ValorCTB(aTotCCSup[nPosCC][2][10],li,aColunas[COL_COLUNA10],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA13] PSAY "|"
			ValorCTB(aTotCCSup[nPosCC][2][11],li,aColunas[COL_COLUNA11],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA14] PSAY "|"
			ValorCTB(aTotCCSup[nPosCC][2][12],li,aColunas[COL_COLUNA12],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
			If mv_par26 = 1		// Imprime Total
				If mv_par27 == 1//Mostrar a conta
					@ li,aColunas[COL_SEPARA15]-20 PSAY "|"
					ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-18,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
				ElseIf mv_par27 == 2	//Mostrar a descricao
					@ li,aColunas[COL_SEPARA15]-15 PSAY "|"
					ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-14,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
				EndIf
			Endif
			@ li,aColunas[COL_SEPARA15] PSAY "|"
			li++
			dbSelectArea("CTT")
			lImpCCSint	:= .T.
		EndIf
		
		While lImpCCSint
			dbSelectArea("CTT")
			If MsSeek(xFilial()+cAntCCSup) .And. !Empty(CTT->CTT_CCSUP)
				cAntCCSup	:= CTT->CTT_CCSUP
				@li,aColunas[COL_SEPARA1] PSAY "|"
				@li,aColunas[COL_SEPARA1] PSAY "|"
				If mv_par26 == 2
					@li,aColunas[COL_CONTA] PSAY STR0018+ Upper(Alltrim(cSayCC))+ " : " //"T O T A I S  D O  "
					EntidadeCTB(cAntCCSup,li,aColunas[COL_CONTA]+23,nTamCdoCusto,.F.,cMascCC,cSepara1)
					
					@ li,aColunas[COL_SEPARA15] PSAY "|"
					li++
					@li,00 PSAY	Replicate("-",limite)
					li++
					@ li,aColunas[COL_SEPARA3] PSAY "|"
				Else
					@li,aColunas[COL_CONTA] PSAY STR0026 //"TOTAIS: "
					@li,25 PSAY Subs(cAntCCSup,1,25)
					
					@ li,aColunas[COL_SEPARA15] PSAY "|"
					li++
					@li,00 PSAY	Replicate("-",limite)
					li++
					@ li,aColunas[COL_SEPARA2] PSAY "|"
				EndIf
				dbSelectArea("cArqTmp")
				
				//Total da Linha
				nTotLinha	:= 0     			// Incluso esta linha para impressao dos totais
				nPosCC	:= ASCAN(aTotCCSup,{|x| x[1]== cAntCCSup })
				If  nPosCC > 0
					For nVezes := 1 to Len(aMeses)	// por periodo em 09/06/2004 por Otacilio
						nTotLinha	+= aTotCCSup[nPosCC][2][nVezes]
					Next
					@li,aColunas[COL_SEPARA1] PSAY "|"
					ValorCTB(aTotCCSup[nPosCC][2][1],li,aColunas[COL_COLUNA1],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
					@ li,aColunas[COL_SEPARA4]		PSAY "|"
					ValorCTB(aTotCCSup[nPosCC][2][2],li,aColunas[COL_COLUNA2],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
					@ li,aColunas[COL_SEPARA5]		PSAY "|"
					ValorCTB(aTotCCSup[nPosCC][2][3],li,aColunas[COL_COLUNA3],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
					@ li,aColunas[COL_SEPARA6]		PSAY "|"
					ValorCTB(aTotCCSup[nPosCC][2][4],li,aColunas[COL_COLUNA4],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
					@ li,aColunas[COL_SEPARA7] PSAY "|"
					ValorCTB(aTotCCSup[nPosCC][2][5],li,aColunas[COL_COLUNA5],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
					@ li,aColunas[COL_SEPARA8] PSAY "|"
					ValorCTB(aTotCCSup[nPosCC][2][6],li,aColunas[COL_COLUNA6],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
					@ li,aColunas[COL_SEPARA9] PSAY "|"
					ValorCTB(aTotCCSup[nPosCC][2][7],li,aColunas[COL_COLUNA7],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
					@ li,aColunas[COL_SEPARA10] PSAY "|"
					ValorCTB(aTotCCSup[nPosCC][2][8],li,aColunas[COL_COLUNA8],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
					@ li,aColunas[COL_SEPARA11] PSAY "|"
					ValorCTB(aTotCCSup[nPosCC][2][9],li,aColunas[COL_COLUNA9],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
					@ li,aColunas[COL_SEPARA12] PSAY "|"
					ValorCTB(aTotCCSup[nPosCC][2][10],li,aColunas[COL_COLUNA10],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
					@ li,aColunas[COL_SEPARA13] PSAY "|"
					ValorCTB(aTotCCSup[nPosCC][2][11],li,aColunas[COL_COLUNA11],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
					@ li,aColunas[COL_SEPARA14] PSAY "|"
					ValorCTB(aTotCCSup[nPosCC][2][12],li,aColunas[COL_COLUNA12],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
					If mv_par26 = 1		// Imprime Total
						If mv_par27 == 1//Mostrar a conta
							@ li,aColunas[COL_SEPARA15]-20 PSAY "|"
							ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-18,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
						ElseIf mv_par27 == 2	//Mostrar a descricao
							@ li,aColunas[COL_SEPARA15]-15 PSAY "|"
							ValorCTB(nTotLinha,li,aColunas[COL_SEPARA15]-14,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
						EndIf
					Endif
					@ li,aColunas[COL_SEPARA15] PSAY "|"
					li++
					lImpCCSint	:= .T.
				EndIf
			Else
				lImpCCSint	:= .F.
			EndIf
		End
		cAntCCSup		:= ""
		cCCSup			:= ""
		dbSelectArea("cArqTmp")
	EndIf
EndIf

IF li != 80 .And. !lEnd
	@li,00 PSAY REPLICATE("-",limite)
	li++
	@li,00 PSAY REPLICATE("-",limite)
	li++
	@li,aColunas[COL_SEPARA1] PSAY "|"
	If mv_par26 == 2
		@li,aColunas[COL_CONTA]   PSAY STR0017  		//"T O T A I S  D O  P E R I O D O : "
		@ li,aColunas[COL_SEPARA3]		PSAY "|"
	Else
		@li,aColunas[COL_CONTA]   PSAY STR0027  		//"TOTAIS  DO  PERIODO: "
		If mv_par27 == 1
			@ li,aColunas[COL_SEPARA2]		PSAY "|"
		Else
			@ li,aColunas[COL_SEPARA2]+4   PSAY "|"
		EndIf
	EndIf
	ValorCTB(aTotCol[1],li,aColunas[COL_COLUNA1],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA4]		PSAY "|"
	ValorCTB(aTotCol[2],li,aColunas[COL_COLUNA2],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA5]		PSAY "|"
	ValorCTB(aTotCol[3],li,aColunas[COL_COLUNA3],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA6]		PSAY "|"
	ValorCTB(aTotCol[4],li,aColunas[COL_COLUNA4],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA7] PSAY "|"
	ValorCTB(aTotCol[5],li,aColunas[COL_COLUNA5],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA8] PSAY "|"
	ValorCTB(aTotCol[6],li,aColunas[COL_COLUNA6],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA9] PSAY "|"
	ValorCTB(aTotCol[7],li,aColunas[COL_COLUNA7],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA10] PSAY "|"
	ValorCTB(aTotCol[8],li,aColunas[COL_COLUNA8],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA11] PSAY "|"
	ValorCTB(aTotCol[9],li,aColunas[COL_COLUNA9],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA12] PSAY "|"
	ValorCTB(aTotCol[10],li,aColunas[COL_COLUNA10],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA13] PSAY "|"
	ValorCTB(aTotCol[11],li,aColunas[COL_COLUNA11],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA14] PSAY "|"
	ValorCTB(aTotCol[12],li,aColunas[COL_COLUNA12],12,nDecimais,CtbSinalMov(),cPicture,, , , , , ,lPrintZero)
	
	//TOTAL GERAL
	nTotGeral	:= aTotCol[1]+aTotCol[2]+aTotCol[3]+aTotCol[4]+aTotCol[5]+aTotCol[6]+aTotCol[7]
	nTotGeral 	+= aTotCol[8]+aTotCol[9]+aTotCol[10]+aTotCol[11]+aTotCol[12]
	
	If mv_par26 = 1		// Imprime Total
		If mv_par27 == 1//Mostrar a conta
			@ li,aColunas[COL_SEPARA15]-20 PSAY "|"
			ValorCTB(nTotGeral,li,aColunas[COL_SEPARA15]-18,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		ElseIf mv_par27 == 2	//Mostrar a descricao
			@ li,aColunas[COL_SEPARA15]-15 PSAY "|"
			ValorCTB(nTotGeral,li,aColunas[COL_SEPARA15]-14,12,nDecimais,CtbSinalMov(),cPicture, NORMAL, , , , , ,lPrintZero)
		EndIf
	Endif                                                                                                                                 
	                                           
	nTotGeral	:= 0
	@ li,aColunas[COL_SEPARA15] PSAY "|"
	
	li++
	@li,00 PSAY REPLICATE("-",limite)
	li++
	@li,0 PSAY " "
	roda(cbcont,cbtxt,"M")
	Set Filter To
EndIF
                                                                                    
If lXML == .T.
	oFwMsEx:Activate()                      
	                                                
	cArq := CriaTrab( NIL, .F. ) + ".xml"
	LjMsgRun( "Gerando o arquivo, aguarde...", "Balancete Comparativo", {|| oFwMsEx:GetXMLFile( cArq ) } ) 
	
	cArqXML :=  c_Path + "Comp_"+ DtoS(Date()) +"_"+ StrTran(Time(),":","")+".XML" 
	
	If __CopyFile( cArq, cArqXML)
		If ApOleClient("MsExcel")
			oExcelApp := MsExcel():New()
			oExcelApp:WorkBooks:Open( cArqXML )
			oExcelApp:SetVisible(.T.)
		Else
			MsgInfo( "Arquivo " + StrTran(cArqXML,c_Path,"") + " gerado com sucesso no diretório " + c_Path )
		Endif
	Else
		MsgInfo( "Arquivo não copiado para temporário do usuário." )
	Endif
Else
	If aReturn[5] = 1                   
		Set Printer To
		Commit
		Ourspool(wnrel)
	EndIf
EndIf

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
Ferase(cArqTmp+GetDBExtension())
Ferase("cArqInd"+OrdBagExt())
dbselectArea("CT2")

MS_FLUSH()

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

aAdd(aRegs,{c_Perg,"01","Data Inicial 					?","","","MV_CH1","D",8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"02","Data Final 					?","","","MV_CH2","D",8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"03","Do Centro de Custo 			?","","","MV_CH3","C",10,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
aAdd(aRegs,{c_Perg,"04","Ate o C.Custo					?","","","mv_ch4","C",10,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
aAdd(aRegs,{c_Perg,"05","Da Conta 						?","","","MV_CH5","C",20,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","CT1"})
aAdd(aRegs,{c_Perg,"06","Ate a Conta 					?","","","MV_CH6","C",20,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","CT1"})
aAdd(aRegs,{c_Perg,"07","Imprime Contas 				?","","","MV_CH7","N",1,0,2,"C","","mv_par07","Sinteticas","","","","","Analiticas","","","","","Ambas","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"08","Cod. Config. Livros 			?","","","MV_CH8","C",3,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","CTN"})
aAdd(aRegs,{c_Perg,"09","Saldos Zerados 				?","","","MV_CH9","N",1,0,2,"C","","mv_par09","Sim","","","","","Não","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"10","Moeda 							?","","","MV_CHA","C",2,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","CTO"})
aAdd(aRegs,{c_Perg,"11","Folha Inicial 					?","","","MV_CHB","N",3,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"12","Tipo de Saldo 					?","","","MV_CHC","C",1,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","SLD"})
aAdd(aRegs,{c_Perg,"13","Imprime ate o Segmento 		?","","","MV_CHD","C",2,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"14","Filtra Segmento Numero 		?","","","MV_CHE","C",2,0,0,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"15","Conteudo Inicial do Segmento	?","","","MV_CHF","C",20,0,0,"G","","mv_par15","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"16","Conteudo Final do Segmento		?","","","MV_CHG","C",20,0,0,"G","","mv_par16","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"17","Conteudo Contido em 			?","","","MV_CHH","C",30,0,0,"G","","mv_par17","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"18","Pula Pagina 					?","","","MV_CHI","N",1,0,1,"C","","mv_par18","Sim","","","","","Não","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"19","Imprime Cod. C.Custo 			?","","","MV_CHJ","N",1,0,1,"C","","mv_par19","Normal","","","","","Reduzido","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"20","Imprime Cod. Conta 			?","","","MV_CHK","N",1,0,1,"C","","mv_par20","Normal","","","","","Reduzido","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"21","Salta linha sintetica 			?","","","MV_CHL","N",1,0,1,"C","","mv_par21","Sim","","","","","Não","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"22","Imprime Valor 0,00 			?","","","MV_CHM","N",1,0,1,"C","","mv_par22","Sim","","","","","Não","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"23","Divide Por 					?","","","MV_CHN","N",1,0,1,"C","","mv_par23","Não se Aplica","","","","","Cem","","","","","Mil","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"24","Posicõo Ant. Lucros/Perdas 	?","","","MV_CHO","N",1,0,2,"C","","mv_par24","Sim","","","","","Não","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"25","Data Lucros/Perdas 			?","","","MV_CHP","D",8,0,0,"G","","mv_par25","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"26","Totaliza Periodo 				?","","","MV_CHQ","N",1,0,1,"C","","mv_par26","Sim","","","","","Não","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"27","Se totalizar, mostra 			?","","","MV_CHR","N",1,0,1,"C","","mv_par27","Conta","","","","","Descricõo","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"28","Imprime C.Custo 				?","","","MV_CHS","N",1,0,2,"C","","mv_par28","Sinteticos","","","","","Analiticos","","","","","Ambos","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"29","Imprime Tot.Sintet. 			?","","","MV_CHT","N",1,0,1,"C","","mv_par29","Sim","","","","","Não","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"30","Comparar 						?","","","MV_CHU","N",1,0,1,"C","","mv_par30","Mov. Periodo","","","","","Saldo Acumulado","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"31","Quebra por Grupo    			?","","","mv_chv","N",1,0,1,"C","","mv_par31","Sim","","","","","Não","","","","","","","","","","","","","","","","","","",""})

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