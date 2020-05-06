#Include "Protheus.ch"
#Include "RwMake.ch"
#Include "TopConn.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ U_RLCTBR03() |  Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 23/06/15  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatório modelo Elite para imprimir os Saldos de acordo com o Codigo GAAP	 ´±±	                            
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil				                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil				                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs: Usado Fonte padrão do Microsiga como base, alguns Parametros(MV_PARXX) e os STRXXXX  ´±±
±±³		serão usados valores padronizados.													 ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function RLCTBR03()     

Local a_Area 		:= GetArea()
Local oReport
Local l_Ok 			:= .T.
Local a_CtbMoeda	:= {}
Local n_Divide		:= 1   
Local a_Ret         := {}
Local a_Pergs       := {} 

Private c_Filtro	:= ""
Private c_TipoAnt	:= ""
Private c_Perg	 	:= "CTBR03D"
Private c_nomeProg  := "CTBR03D"
Private c_titulo
Private a_SelFil	:= {} 
//Private l_XML       := .T.    
Private c_ContIni	:= ""						//mv_par03
Private c_ContFim	:= "zzzzzzzzzzzzzzzzzzzz"	//mv_par04
Private c_CCustIni	:= ""                		//mv_par05
Private c_CCustFim	:= "zzzzzzzzzz"				//mv_par06
Private c_ImpConta	:= "2"						//mv_par07 - 1 - Sintet/2 - Analit/3 - Ambas
Private c_CodConfL	:= ""						//mv_par08
Private n_SaldZero	:= 2						//mv_par09 - 1 - Sim/2 - Nao
Private n_FolhaIni	:= 2						//mv_par11
Private c_TipSaldo	:= "1"						//mv_par12 - Reais / Orcados	/Gerenciais
Private n_QuebGrup	:= 1						//mv_par13 - Sim/ Nao
Private c_ImpSegm	:= ""						//mv_par14
Private c_FiltSeg   := ""            			//mv_par15
Private c_ContISeg	:= ""						//mv_par16
Private c_ContFSeg	:= ""						//mv_par17
Private c_ContCCta	:= ""						//mv_par18
Private n_ImpColMv	:= 1						//mv_par19
Private n_PulaPag	:= 1                		//mv_par20
Private n_SLinSint	:= 1						//mv_par21
Private n_ImpValZr	:= 1						//mv_par22
Private n_ImpCod	:= 1						//mv_par23
Private n_DividPor	:= 1						//mv_par24
Private n_ImpCCta	:= 1						//mv_par25                
Private n_PosAntLP	:= 2 						//mv_par26
Private c_DtLucPer	:= ""						//mv_par27
Private c_ImpSegCC	:= ""						//mv_par28
Private c_FilSeg	:= ""						//mv_par29
Private c_ContICC	:= ""                		//mv_par30
Private c_ContFCC	:= ""						//mv_par31
Private c_ContCC	:= ""						//mv_par32
Private n_ImpCC		:= 2						//mv_par33	
Private n_IgnAntRD	:= 2						//mv_par34
Private c_GpRecDes	:= ""                		//mv_par35
Private c_DtRecDes	:= ""						//mv_par36
Private n_SelecFil	:= 2						//mv_par37

ValidPerg(c_Perg)

If 	!Pergunte(c_Perg,.T.)
	Return Nil
EndIf

If 	Upper(AllTrim(GetEnvServer())) = "FTI-PRODUCAO"
 	// MsgINFO('Esse relatório precisa ser Validado e Encerrado chamado ID 28735',GetEnvServer())
 	// Não compilar esse relatorio até esse chamado ser validado no ID 28735 // 
 	MsgINFO('Esse relatório precisa ser Validado - LIBERADO EM PRODUCAO ATE 01-DEZ-15',GetEnvServer()) 	
	// Return Nil
Endif

Private c_Path := cGetFile("\", "Selecione o Local para salvar o Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY)

If !ExistDir( c_Path )
	c_Path 	:= __RELDIR                                      
EndIf                                       

If !Empty(c_Path)                       
	RL03R3()
EndIf

RestArea(a_Area)                                                                       
                                                                 
Return Nil

/*******************************************************************************************************************/

/*=======================================================
Descricao: Impressão do relatorio em Release 3
=========================================================*/

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

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ U_RL03R3() |  Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 23/06/15  	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatório para impressão dos Saldos do mês de acordo com o Código GAAP	     ´±±	                            
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil				                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil				                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function RL03R3()

Local a_SetOfBook
Local c_SayCC		:= CtbSayApro("CTT")
Local c_Desc1 		:= OemToAnsi("Este programa ira imprimir o Relatório Modelo Elite")
Local c_Desc2 		:= OemToansi("de acordo com os parametros solicitados pelo Usuario")
Local c_String		:= "CT1"
Local l_Ret			:= .T.
Local n_Divide		:= 1
Local wnrel
Local c_titulo 		:= "GENERAL LEDGER TRIAL BALANCE - Vr20082015a"	

Private a_Return 	:= {} 
Private a_Linha		:= {}
Private n_LastKey 	:= 0
Private c_Tamanho	:= "M"

If ( !AMIIn(34) )	// Acesso somente pelo SIGACTB
	Return
EndIf

n_li 				:= 80
m_pag				:= 1
                                             
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros da Pergunta CTBR03 		³
//³ mv_par01				// Data Inicial              	       	³
//³ mv_par02				// Data Final                          	³
//³ mv_par10				// Moeda	                          	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If l_Ret .And. n_SelecFil == 1 .And. Len( a_SelFil ) <= 0
	a_SelFil := AdmGetFil()
	If Len( a_SelFil ) <= 0
		l_Ret := .F.
	EndIf
EndIf

wnrel	:= "CTBR03"            //Nome Default do relatorio em Disco    

If n_LastKey == 27
	Set Filter To
	Return Nil
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(c_CodConfL)
	l_Ret := .F.
Else
	a_SetOfBook := CTBSetOf(c_CodConfL)
Endif

If n_DividPor == 2			// Divide por cem
	n_Divide := 100
ElseIf n_DividPor == 3		// Divide por mil
	n_Divide := 1000
ElseIf n_DividPor == 4		// Divide por milhao
	n_Divide := 1000000
EndIf

If l_Ret
	a_CtbMoeda := CtbMoeda(mv_par03,n_Divide)	
	If Empty(a_CtbMoeda[1])
		Help(" ",1,"NOMOEDA")
		l_Ret := .F.
	Endif
Endif

If l_Ret
	If (n_IgnAntRD == 1) .and. ( Empty(c_GpRecDes) .or. Empty(c_DtRecDes) )
		c_Mensagem	:= "Favor preencher os parametros Grupos Receitas/Despesas e Data Sld Ant. Receitas/Despesas ou "
		c_Mensagem	+= "deixar o parametro Ignora Sl Ant.Rec/Des = Nao "
		MsgAlert(c_Mensagem,"Ignora Sl Ant.Rec/Des")
		l_Ret    	:= .F.
	EndIf
EndIf

If !l_Ret
	Set Filter To
	Return
EndIf

If n_ImpColMv == 1			// Se imprime coluna movimento -> relatorio 220 colunas
	c_tamanho := "G"
EndIf

If n_LastKey == 27
	Set Filter To
	Return
Endif

RptStatus({|l_End| RL03Imp(@l_End,wnRel,c_String,a_SetOfBook,a_CtbMoeda,c_SayCC,n_Divide)})

Return Nil

/*******************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RL03Imp() |  Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 24/06/15  	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatório para impressão dos Saldos do mês de acordo com o Código GAAP	     ´±±	                            
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 	ExpL1   - A‡ao do Codeblock													 ´±±
±±³				ExpC1   - Titulo do relatorio											     ´±±
±±³				ExpC2   - Mensagem															 ´±±
±±³				ExpA1   - Matriz ref. Config. Relatorio									     ´±±
±±³				ExpA2   - Matriz ref. a moeda												 ´±±
±±³				ExpC3   - Descricao do C.custo utilizada pelo usuario				         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil				                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function RL03Imp(l_End,WnRel,c_String,a_SetOfBook,a_CtbMoeda,c_SayCC,n_Divide)

Local CbTxt			:= Space(10)
Local CbCont		:= 0
Local c_tamanho		:= "M"
Local n_limite		:= 132
Local c_cabec1  	:= ""
Local c_cabec2		:= ""
Local a_Colunas
Local c_Separa1  	:= ""
Local c_Separa2     := ""
Local c_Picture
Local c_DescMoeda
Local c_Mascara1
Local c_Mascara2
Local c_Grupo		:= ""
Local c_GrupoAnt	:= ""
Local c_CCAnt 		:= ""
Local c_CCRes		:= ""
Local c_SegAte   	:= c_ImpSegm
Local cArqTmp		:= ""
Local c_CCSup		:= ""		//Centroadminde Custo Superior do centro de custo atual
Local c_AntCCSup	:= ""		//Centro de Custo Superior do centro de custo anterior
Local d_DataLP		:= c_DtLucPer
Local d_DataFim		:= mv_par02	
Local l_ImpAntLP	:= Iif(n_PosAntLP == 1,.T.,.F.)
Local l_FirstPage	:= .T.
Local l_Pula		:= .F.
Local l_JaPulou		:= .F.
Local l_PrintZero	:= Iif(n_ImpValZr==1,.T.,.F.)
Local l_PulaSint	:= Iif(n_SLinSint==1,.T.,.F.)
Local l_CttSint 	:= Iif(n_ImpCC == 1 .or. n_ImpCC == 3,.T.,.F.)
Local l_132			:= .T.
Local l_ImpCCSint	:= .T.
Local l_VlrZerado	:= Iif(n_SaldZero==1,.T.,.F.)
Local l_ImpDscCC	:= .F.

Local n_Decimais
Local n_TotDeb		:= 0
Local n_TotCrd		:= 0
Local n_TotMov		:= 0
Local n_CCTMov 		:= 0
Local n_TamCC		:= 20
Local n_TotCCDeb	:= 0
Local n_TotCCCrd	:= 0
Local n_CCSldAnt	:= 0
Local n_CCSldAtu	:= 0
Local n_TotSldAnt	:= 0
Local n_TotSldAtu	:= 0
Local n_DigitAte	:= 0
Local n_DigCCAte	:= 0
Local n_RegTmp		:= 0
Local n
Local n_GrpDeb		:= 0
Local n_GrpCrd		:= 0
Local l_RecDesp0	:= Iif(n_IgnAntRD==1,.T.,.F.)
Local c_RecDesp		:= c_GpRecDes
Local d_DtZeraRD	:= c_DtRecDes
Local c_mask1
Local c_mask2
Local a_Saldos		:= {}
Local n_Pos 		:= 0
Local oFwMsEx       := NIL
Local c_Arq         := ""
Local c_Dir         := GetSrvProfString("Startpath","")
Local c_WorkSheet   := ""
Local c_Table       := ""
Local c_DirTmp      := GetTempPath()
        
Private c_CodEmp	:= ""
Private a_Item		:= {}
Private a_Dados		:= {}
Private n_Pos		:= 0

c_DescMoeda 		:= a_CtbMoeda[2]
n_Decimais 			:= DecimalCTB(a_SetOfBook,mv_par03)	

//Mascara da Conta
If Empty(a_SetOfBook[2])
	c_Mascara1 := GetMv("MV_MASCARA")
Else
	c_Mascara1 := RetMasCtb(a_SetOfBook[2],@c_Separa1)
EndIf

// Mascara do Centro de Custo
If Empty(a_SetOfBook[6])
	c_Mascara2 := GetMv("MV_MASCCUS")
Else
	c_Mascara2 := RetMasCtb(a_SetOfBook[6],@c_Separa2)
EndIf

c_Picture := a_SetOfBook[4]

If n_ImpColMv == 1 // Se imprime saldo movimento do periodo
	c_cabec1  	:= "|  CODIGO              |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |    DEBITO     |    CREDITO   | MOVIMENTO DO PERIODO |   SALDO ATUAL    |"
	c_tamanho 	:= "G"
	n_limite	:= 220
	l_132		:= .F.
Else
	c_cabec1 	:= "|  CODIGO               |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |      DEBITO    |      CREDITO   |   SALDO ATUAL     |"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF c_ImpConta == "1"		/// Se imprime somente contas sinteticas
	c_Titulo:=	OemToAnsi("GENERAL LEDGER TRIAL BALANCE") //+ Upper(c_SayCC) + "/" + Upper(OemToAnsi(" Conta "))//STR0007_STR0021
ElseIf c_ImpConta == "2"		/// Se imprime somente contas analiticas
	c_Titulo:= "GENERAL LEDGER TRIAL BALANCE" //OemToAnsi(STR0006) + Upper(cSayCC) + "/" + Upper(OemToAnsi(STR0021))//"BALANCETE ANALITICO DE  "
ElseIf c_ImpConta == "3"
	c_Titulo:=	OemToAnsi("GENERAL LEDGER TRIAL BALANCE") //+ Upper(c_SayCC) +  "/" + Upper(OemToAnsi(" Conta "))//STR0008_STR0021
EndIf


If c_TipSaldo > "1"
	c_Titulo += " (" + Tabela("SL", c_TipSaldo, .F.) + ")"
EndIf

If l_132
	a_Colunas := { 000, 001, 024, 025, 057, 058, 077, 078, 094, 095, 111,    ,    , 112, 131 }
Else
	a_Colunas := { 000, 001, 030, 032, 080, 082, 112, 114, 131, 133, 151, 153, 183, 185, 219 }
Endif

m_pag := n_FolhaIni
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao					     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

MsgMeter({|	oMeter, oText, oDlg, l_End | ;
			CTGerPlan(oMeter, oText, oDlg, @l_End,@cArqTmp,;
			mv_par01,mv_par02,"CT3","",c_ContIni,c_ContFim,c_CCustIni,c_CCustFim,,,,,mv_par03,; 
			c_TipSaldo,a_SetOfBook,c_FiltSeg,c_ContISeg,c_ContFSeg,c_ContCCta,;
			l_132,.T.,,"CTT",l_ImpAntLP,d_DataLP,n_Divide,l_VlrZerado,,,;
			c_FilSeg,c_ContICC,c_ContFCC,c_ContCC,,,,,,,,,c_Filtro,l_RecDesp0,;
			c_RecDesp,d_DtZeraRD,,,,,,,,,a_SelFil,,,,,,,,l_CttSint)},;
			OemToAnsi(OemToAnsi("Criando Arquivo Temporario...")),;
			OemToAnsi("GENERAL LEDGER TRIAL BALANCE")+Upper(c_SayCC)+ "/ "+Upper(OemToAnsi("Cta")))
// Verifica Se existe filtragem Ate o Segmento

If ! Empty(c_ImpSegm)
	c_mask1 := Alltrim( c_Mascara1 )
	
	For n := 1 to Val( c_ImpSegm )
		n_DigitAte += Val( Padl( c_mask1 , 1 ) )
		c_mask1 := Subst( c_mask1 , 2 )
	Next
EndIf

// Verifica Se existe filtragem Ate o Segmento
If ! Empty(c_ImpSegCC)
	c_mask2 := Alltrim( c_Mascara2 )
	
	For n := 1 to Val( c_ImpSegCC )
		n_DigCCAte += Val( Padl( c_mask2 , 1 ) )
		c_mask2 := Subst( c_mask2 , 2 )
	Next
EndIf

dbSelectArea("cArqTmp")
dbGoTop()

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial
//nao esta disponivel e sai da rotina.
If RecCount() == 0 .And. ! Empty(a_SetOfBook[5])
	dbCloseArea()
	FErase(cArqTmp+GetDBExtension())
	FErase("cArqInd"+OrdBagExt())
	Return
Endif

cCCAnt := cArqTmp->CUSTO

dbSelectArea("cArqTmp")
dbGoTop()
                                      
c_Grupo  := GRUPO
a_Saldos := SaldoCC()

While n_ImpCC == 1 .And. cArqTmp->TIPOCC == "2"
	dbSkip()
	c_CCAnt := cArqTmp->CUSTO
EndDo

SetRegua(RecCount())

If !Eof()                                                     
	oFwMsEx := FWMsExcel():New()

	/********************  Gera parametros em XML ********************/ 
	IF GetMv("MV_IMPSX1") == "S"
		U_fCabecXML(oFwMsEx, c_Perg,  "Parameters - GENERAL LEDGER TRIAL BALANCE" )
	EndIf

	c_WorkSheet := "GENERAL LEDGER TRIAL BALANCE"	
	c_Table     := "GENERAL LEDGER TRIAL BALANCE"

    oFwMsEx:AddWorkSheet( c_WorkSheet )
    oFwMsEx:AddTable	( c_WorkSheet, c_Table )	
	oFwMsEx:AddColumn	( c_WorkSheet, c_Table , "Natural"		      					, 1,1)
	oFwMsEx:AddColumn	( c_WorkSheet, c_Table , "?????"		      					, 1,1)
	oFwMsEx:AddColumn	( c_WorkSheet, c_Table , "Legal Entity"	  						, 1,1)
	oFwMsEx:AddColumn	( c_WorkSheet, c_Table , "Location"		   						, 1,1)
	oFwMsEx:AddColumn	( c_WorkSheet, c_Table , "Business Segment"      				, 1,1)
	oFwMsEx:AddColumn	( c_WorkSheet, c_Table , "Department"       					, 1,1)
	oFwMsEx:AddColumn	( c_WorkSheet, c_Table , "Section"	       						, 1,1)
	oFwMsEx:AddColumn	( c_WorkSheet, c_Table , "Desc CC GAAP"     					, 1,1)
	oFwMsEx:AddColumn	( c_WorkSheet, c_Table , "NA Name"								, 1,1)
	oFwMsEx:AddColumn	( c_WorkSheet, c_Table , "Opening Balance Adjustment Books"		, 1,1)
	//oFwMsEx:AddColumn	( c_WorkSheet, c_Table , "Movimento"      						, 1,1)
	oFwMsEx:AddColumn	( c_WorkSheet, c_Table , "Closing Balance Adjustments Books"	, 1,1)
	oFwMsEx:AddColumn	( c_WorkSheet, c_Table , "Variances Adjustments"				, 1,1)
								
	While !Eof()                  
		
		If l_End
			@Prow()+1,0 PSAY OemToAnsi("***** CANCELADO PELO OPERADOR *****")  
			Exit
		EndIF
		
		IncRegua()
		
//		******************** "FILTRAGEM" PARA IMPRESSAO *************************
		If n_ImpCC == 1					// So imprime Sinteticas
			If TIPOCC == "2"
				dbSkip()
				Loop
			EndIf
		ElseIf n_ImpCC == 2				// So imprime Analiticas
			If TIPOCC == "1"
				dbSkip()
				Loop
			EndIf
		EndIf
		
		If c_ImpConta == "1"			// So imprime Sinteticas
			If TIPOCONTA == "2"
				dbSkip()
				Loop
			EndIf
		ElseIf c_ImpConta == "2"		// So imprime Analiticas
			If TIPOCONTA == "1"
				dbSkip()
				Loop
			EndIf
		EndIf
		
		//Filtragem ate o Segmento da Conta( antigo nivel do SIGACON)
		If !Empty(c_SegAte)
			If Len(Alltrim(CONTA)) > n_DigitAte
				dbSkip()
				Loop
			Endif
		EndIf
		
		//Filtragem ate o Segmento do CC( antigo nivel do SIGACON)
		If !Empty(c_ImpSegCC)
			If Len(Alltrim(CUSTO)) > n_DigCCAte
				dbSkip()
				Loop
			Endif
		EndIf
		
		//Inicialização de Variáveis e Arrays com informações do Relatório
		a_Item := {}		
		c_CodConta 	:= IIf(n_ImpCCta == 2 .And. cArqTmp->TIPOCONTA == '2', cArqTmp->CTARES, cArqTmp->CONTA)
		c_CodEmp	:= U_RetEntit(SM0->M0_CODIGO) //Função criada para Retornar o número da Empresa de acordo com o Código do M0_CODIGO 			                                                          

//		If GetAdvFval("CT1","CT1_XCTFTI", xFilial("CT1") + c_CodConta, 1, 0) == '2015' .And. Empty(GetAdvFval("CTT","CTT_XFTILC", xFilial("CTT") + cArqTmp->CUSTO, 1, 0))
		
		//*************************** Gravando informações no Array - Inicio *****************************//
		Aadd(a_Item, GetAdvFval("CT1","CT1_XCTFTI", xFilial("CT1") + c_CodConta, 1, 0)												 	 ) //1
		Aadd(a_Item, "00000000"														 												 	 ) //2                                                             
	  	Aadd(a_Item, c_CodEmp											 												 			 	 ) //3
		Aadd(a_Item, GetAdvFval("CTT","CTT_XFTILC", xFilial("CTT") + cArqTmp->CUSTO, 1, 0)											 	 ) //4
		Aadd(a_Item, GetAdvFval("CTT","CTT_XFTIBS", xFilial("CTT") + cArqTmp->CUSTO, 1, 0)											 	 ) //5
		Aadd(a_Item, GetAdvFval("CTT","CTT_XFTIDP", xFilial("CTT") + cArqTmp->CUSTO, 1, 0) 											 	 ) //6
	    Aadd(a_Item, GetAdvFval("CTT","CTT_XFTISC", xFilial("CTT") + cArqTmp->CUSTO, 1, 0)  										 	 ) //7
		Aadd(a_Item, GetAdvFval("CTT","CTT_XGAAP ", xFilial("CTT") + cArqTmp->CUSTO, 1, 0)  										 	 ) //8
		Aadd(a_Item, GetAdvFval("CT1","CT1_XDCFTI", xFilial("CT1") + c_CodConta, 1, 0) 												 	 ) //9
		Aadd(a_Item, cArqTmp->SALDOANT * -1                                           												 	 ) //10
		Aadd(a_Item, cArqTmp->SALDOATU * -1                                           	    										 	 ) //11
		Aadd(a_Item, (cArqTmp->SALDOANT * -1) - (cArqTmp->SALDOATU * -1)                                                             	 ) //12
		//*************************** Gravando informações no Array - Fim                                                                     
		
		n_Pos := aScan( a_Dados, { |x| 	x[1] == a_Item[1] .And.;
										x[4] == a_Item[4] .And.;
										x[5] == a_Item[5] .And.;
										x[6] == a_Item[6] .And.;
										x[7] == a_Item[7] })
        
		If n_Pos <= 0
			Aadd(a_Dados, a_Item)		
		Else
		    a_Dados[n_pos][10] += a_Item[10]
		    a_Dados[n_pos][11] += a_Item[11]
		    a_Dados[n_pos][12] += a_Item[12]
		EndIf 				

//		EndIf 				
		
		//************************* FIM   DA  IMPRESSAO *************************
		
		DbSkip()
		
	EndDo

	//Retirado a_Dados[i][12] - Movimento	
	For i := 1 To Len(a_Dados)
		oFwMsEx:AddRow( c_WorkSheet , c_Table,  {;
		a_Dados[i][1]							,;
		a_Dados[i][2]							,;
		a_Dados[i][3]							,;
		a_Dados[i][4]							,;
		a_Dados[i][5]							,;
		a_Dados[i][6]							,;
		a_Dados[i][7]							,;
		a_Dados[i][8]							,;
		a_Dados[i][9]							,;
		a_Dados[i][10]							,;
		a_Dados[i][11]							,;
		a_Dados[i][12] 						  	})	
		//*************************** Gravando linha no XML - Fim ***************************
	Next i	
	                                                                                    
	oFwMsEx:Activate()
	
	c_Arq := CriaTrab( NIL, .F. ) + ".xml"
	LjMsgRun( "Gerando o arquivo, aguarde...", "GENERAL LEDGER TRIAL BALANCE", {|| oFwMsEx:GetXMLFile( c_Arq ) } )

	c_ArqXML := c_Path + "CC_"+ DtoS(Date()) +"_"+ StrTran(Time(),":","")+".XML"
	
	If __CopyFile( c_Arq,  c_ArqXML)                 
		If ApOleClient("MsExcel")
			oExcelApp := MsExcel():New()                        
			oExcelApp:WorkBooks:Open( c_ArqXML )
			oExcelApp:SetVisible(.T.)
		Else
			MsgInfo( "Arquivo " + StrTran(c_ArqXML, c_path, "") + " gerado com sucesso no diretório " + c_Path )
		Endif
	Else
		MsgInfo( "Arquivo não copiado para temporário do usuário." )
	Endif
Else
	MsgInfo( "Não há dados para impressão, verifique parâmetros" )
EndIf

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
FErase(cArqTmp+GetDBExtension())
FErase("c_ArqInd"+OrdBagExt())
dbselectArea("CT2")

/*******************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
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
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function SaldoCC()

Local a_Saldos := {}
Local a_CCusto := {}
Local c_Custo  := ""
Local n_SldDeb := 0
Local n_SldCrd := 0
Local n_SldAnt := 0
Local n_SldAtu := 0
Local n_TotAnt := 0
Local n_TotDeb := 0
Local n_TotCrd := 0
Local n_TotAtu := 0

While n_ImpCC == 1 .And. cArqTmp->TIPOCC == "2"
	dbSkip()
EndDo

cCusto := cArqTmp->CUSTO

While !Eof()
	
	If cArqTmp->TIPOCONTA == "2"
		
		If c_Custo == cArqTmp->CUSTO
			n_SldAnt += cArqTmp->SALDOANT
			n_SldDeb += cArqTmp->SALDODEB
			n_SldCrd += cArqTmp->SALDOCRD
			n_SldAtu += cArqTmp->SALDOATU
			
			If cArqTmp->TIPOCC == "2"
				n_TotAnt += cArqTmp->SALDOANT
				n_TotDeb += cArqTmp->SALDODEB
				n_TotCrd += cArqTmp->SALDOCRD
				n_TotAtu += cArqTmp->SALDOATU
			Endif
		Else
			AADD(a_CCusto, c_Custo)
			AADD(a_CCusto, n_SldAnt)
			AADD(a_CCusto, n_SldDeb)
			AADD(a_CCusto, n_SldCrd)
			AADD(a_CCusto, n_SldAtu)
			
			AADD(a_Saldos,a_CCusto)
			a_CCusto := {}
			
			c_Custo  := cArqTmp->CUSTO
			n_SldAnt := cArqTmp->SALDOANT
			n_SldDeb := cArqTmp->SALDODEB
			n_SldCrd := cArqTmp->SALDOCRD
			n_SldAtu := cArqTmp->SALDOATU
			
			If cArqTmp->TIPOCC == "2"
				n_TotAnt += cArqTmp->SALDOANT
				n_TotDeb += cArqTmp->SALDODEB
				n_TotCrd += cArqTmp->SALDOCRD
				n_TotAtu += cArqTmp->SALDOATU
			Endif
		Endif
		
	Endif
	
	dbSkip()
EndDo

AADD(a_CCusto, c_Custo)
AADD(a_CCusto, n_SldAnt)
AADD(a_CCusto, n_SldDeb)
AADD(a_CCusto, n_SldCrd)
AADD(a_CCusto, n_SldAtu)
AADD(a_Saldos, a_CCusto)
a_CCusto := {}

AADD(a_CCusto, "TOTGERAL")
AADD(a_CCusto, n_TotAnt)
AADD(a_CCusto, n_TotDeb)
AADD(a_CCusto, n_TotCrd)
AADD(a_CCusto, n_TotAtu)
AADD(a_Saldos, a_CCusto)

dbGoTop()

Return a_Saldos

/*******************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ValidPerg | Autor ³ Claudio Dias Junior (Focus Consultoria) | Data ³ 02/02/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatório gerencial de vendas                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_Perg -> Nome da pergunta a ser criada no SX1.                             	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FISCHER BRASIL                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function ValidPerg(c_Perg)

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
aRegs:={}

c_Perg := c_Perg + Replicate(" ", 10 - Len(c_Perg))               

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

aAdd(aRegs,{c_Perg,"01","Data Inicial:	","","","mv_ch1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"02","Data Final:	","","","mv_ch2","D",08,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{c_Perg,"03","Moeda: 		","","","mv_ch3","C",02,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","CTO"})

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

//******************************************************************************************************************