//PROGRAMA - ROTINA PARA GERAR O PEDIDO DE VENDA CONFORME A BAIXA DO TITULO NO CONTAS A RECEBER EM OUTRA E1_MOEDA > 1
//SolicitaÁ„o - Maria Paula / Bruno Takao / Juliana Serafim
//Data 01/12/2016 - Andre Salgado / Introde

#include "Protheus.ch"
#include "Rwmake.ch"
#include "Topconn.ch"

User Function R_FIN005()
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Declaracao de Variaveis                                             ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
Private oGeraTxt
Private cString 	:= "SI1"
Private cPerg		:= "CLKFAT07"

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Declaracao de Variaveis                                             ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
CriaSX1(cPerg)
Pergunte("CLKFAT07",.T.)

If Select("CLK") > 0
	CLK->(DbCloseArea())
Endif


//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Montagem da tela de processamento.                                  ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
@ 200,1 TO 370,370 DIALOG oGeraTxt TITLE OemToAnsi("Analise Titulo(s) Baixado(s)")
@ 02,05 TO 080,180
@ 10,018 Say "Rotina vai Apresentar as Invoices j· baixadas Clientes."
@ 20,018 Say "OBS. SÛ sera apresentado Titulos que foram gerados pelo"
@ 30,018 Say "             Faturamento  - FTI"

//@ 65,040 BUTTON "Raz„o Cont·bil" SIZE 40,10 ACTION CTBR400()
@ 65,090 BMPBUTTON TYPE 05 ACTION Pergunte("CLKFAT07",.T.)
@ 65,120 BMPBUTTON TYPE 01 ACTION (Close(oGeraTxt),Processa({|| RunRep() },"Gerando Tela..."))
@ 65,150 BMPBUTTON TYPE 02 ACTION Close(oGeraTxt)

Activate Dialog oGeraTxt Centered
Return



STATIC Function RunRep()

Local _lRetorno := .F. //Validacao da dialog criada oDlg
Local _nOpca 	:= 0 //Opcao da confirmacao
Local bOk 		:= {|| _nOpca:=1,_lRetorno:=.T.,oDlg:End() } //botao de ok
Local bCancel 	:= {|| _nOpca:=0,oDlg:End() } //botao de cancelamento
Local _cArqEmp 	:= "" //Arquivo temporario com as empresas a serem escolhidas
Local _aStruTrb := {} //estrutura do temporario
Local _aBrowse 	:= {} //array do browse para demonstracao das empresas

PUBLIC _aEmpMigr:= {} //array de retorno com as empresas escolhidas

Private lInverte:= .F. //Variaveis para o MsSelect
Private cMarca 	:= GetMark() //Variaveis para o MsSelect
Private oBrwTrb //objeto do msselect
Private oDlg

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// Define campos do TRB
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aadd(_aStruTrb,{"NUM" 		,"C",09,0})
aadd(_aStruTrb,{"CLIENTE"	,"C",06,0})
aadd(_aStruTrb,{"NOMCLI" 	,"C",20,0})
aadd(_aStruTrb,{"EMISSAO"	,"D",08,0})
aadd(_aStruTrb,{"VENCTO"	,"D",08,0})
aadd(_aStruTrb,{"VALOR" 	,"N",17,2})
aadd(_aStruTrb,{"LOJA" 		,"C",02,0})
aadd(_aStruTrb,{"BAIXA" 	,"D",08,0})
aadd(_aStruTrb,{"CTACONT" 	,"C",20,0})
aadd(_aStruTrb,{"OK" 		,"C",02,0})
aadd(_aStruTrb,{"INVOICE" 	,"N",17,2})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// Define campos do MsSelect
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aadd(_aBrowse,{"OK" 	,,"" 			})
aadd(_aBrowse,{"NUM"	,,"TITULO"		})
aadd(_aBrowse,{"CLIENTE",,"CLIENTE"		})
aadd(_aBrowse,{"NOMCLI" ,,"NOM. CLIENTE"})
aadd(_aBrowse,{"EMISSAO",,"DATA EMISSAO"})
aadd(_aBrowse,{"VENCTO"	,,"VENCIMENTO"	})
aadd(_aBrowse,{"VALOR"	,,"VALOR"		})
aadd(_aBrowse,{"LOJA"	,,"LOJA"		})
aadd(_aBrowse,{"BAIXA"	,,"RECEBIMENTO" })
aadd(_aBrowse,{"CTACONT",,"PEDIDO VENDA"})
aadd(_aBrowse,{"INVOICE",,"Vlr Invoice"	})


If Select("TRB") > 0
	TRB->(DbCloseArea())
Endif

If Select("CLK") > 0
	CLK->(DbCloseArea())
Endif

_cArqEmp := CriaTrab(_aStruTrb)
dbUseArea(.T.,__LocalDriver,_cArqEmp,"TRB")

//Aqui você monta sua query que serve para gravar os dados no arquivo temporario...
cQuery := " SELECT * FROM SE1"+cEmpAnt+"0 "
cQuery += " WHERE SE1"+cEmpAnt+"0.D_E_L_E_T_<>'*'
//cQuery += " 	AND E1_BAIXA BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' "
cQuery += " 	AND E1_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' and E1_SALDO>0 AND E1_TIPO='RA'"
cQuery += " 	AND E1_CLIENTE = '"+CVALTOCHAR(MV_PAR03)+"' AND E1_PEDIDO<>' ' "
//cQuery += " 	AND E1_VEND5=' ' "
cQuery += " ORDER BY E1_NUM, E1_VENCTO "

TCQuery cQuery new Alias (cAlias:=GetNextAlias())

While (cAlias)->(!Eof())
	
	RecLock("TRB",.T.)
	
	TRB->OK 	:= space(2)
	TRB->NUM	:= cValToChar((cAlias)->E1_NUM)
	TRB->CLIENTE:= (cAlias)->E1_CLIENTE
	TRB->NOMCLI := (cAlias)->E1_NOMCLI
	TRB->EMISSAO:= STOD((cAlias)->E1_EMISSAO)
	TRB->VENCTO := STOD((cAlias)->E1_VENCTO)
	TRB->VALOR	:= (cAlias)->E1_VALOR //E1_BASCOM5 	//E1_VALLIQ 	//E1_VLCRUZ 		//E1_VALOR
	TRB->LOJA	:= (cAlias)->E1_LOJA
	TRB->BAIXA	:= IF(!EMPTY(STOD((cAlias)->E1_BAIXA)),STOD((cAlias)->E1_BAIXA),STOD((cAlias)->E1_EMISSAO) )
	TRB->CTACONT:= (cAlias)->E1_PEDIDO
	TRB->INVOICE:= (cAlias)->E1_BASCOM5
	MsUnlock()
	(cAlias)->(DbSkip())
	
Enddo
(cAlias)->(DbCloseArea())


@ 001,001 TO 400,700 DIALOG oDlg TITLE OemToAnsi("TITULOS que foram Baixado(s) no Financeiro")

@ 015,005 SAY OemToAnsi("Selecione os titulos que deseja Gerar Pedido de Venda: ")

oBrwTrb := MsSelect():New("TRB","OK","",_aBrowse,@lInverte,@cMarca,{050,001,170,350})

oBrwTrb:oBrowse:lCanAllmark := .T.

Eval(oBrwTrb:oBrowse:bGoTop)

oBrwTrb:oBrowse:Refresh()

Activate MsDialog oDlg On Init (EnchoiceBar(oDlg,bOk,bCancel,,)) Centered VALID _lRetorno

TRB->(DbGotop())

If _nOpca == 1
	
	Do While TRB->(!Eof())
		
		If !Empty(TRB->OK)	//se usuario marcou o registro
			
			aAdd(_aEmpMigr,{TRB->NUM, TRB->CLIENTE, TRB->NOMCLI, TRB->EMISSAO, TRB->VENCTO, TRB->VALOR, TRB->LOJA, TRB->BAIXA, TRB->CTACONT, TRB->INVOICE})
			
		EndIf
		
		TRB->(DbSkip())
		
	EndDo
	fZZGrid()
Endif


//fecha area de trabalho e arquivo temporário criados
If Select("TRB") > 0
	//DbSelectArea("TRB")
	DbCloseArea("TRB")
	//Ferase(_cArqEmp+OrdBagExt())
Endif
Return(_aEmpMigr)



STATIC FUNCTION GRAVASZ2()

LOCAL CTITULO := ""
Local aLogErr      := {}
Local aCab := {}
Local aItem:= {}
//Local cNumPed      := GetSX8Num("SC5","C5_NUM")
private x := 0
Private lMsErroAuto := .F.
Private lMsHelpAuto := .T.


Dbselectarea("SE1")
SE1->(DBSETORDER(1))
//SE1->(DBGOTOP())
_ni := 1
cPed1 := "'" 	//FILTRO DOS PEDIDOS
cPed2 := "" 	//MENSAGEM NOTA
cPed3 := "" 	//MENSAGem Informa Numero da Invoice
cClie := space(06)
cLoja := space(02)
nTotPe	:= 0	//Total Recebido
nTotInv	:= 0	//Total Invoice Selecionadas

//Monta Estrutura dos Pedidos
WHILE _ni<=Len(oGetDados:aCols)
	
	cClie := TRIM(aCols[_ni][2])
	cLoja := TRIM(aCols[_ni][9])
	nTotPe += aCols[_ni][6]		//Valor TOTAL Recebido - Selecionado
	nTotInv+= aCols[_ni][10]	//Valor TOTAL Invoice - Selecionado
	
	If !(TRIM(aCols[_ni][8]) $ cPed1)
		cPed1 := cPed1+TRIM(aCols[_ni][8])+"','"
		cPed2 := cPed2+TRIM(aCols[_ni][8]) + " "
		cPed3 := cPed3+TRIM(aCols[_ni][1]) + " "
//		nTotInv+= aCols[_ni][10]	//Valor TOTAL Invoice - Selecionado
	Endif
	
	_ni++
ENDDO


//Ajuste de Variveis
//cPed1 := cPed1+"'"
cPed1 := Substr(cPed1,1,len(cPed1)-2)
//cPed2 := "Ref.Pedido(s): "+cPed2
cPed3 := "Ref.Invoice: "+cPed3+" - Pedido: "+cPed2

//Busca os Pedidos
cQuery := " SELECT"
cQuery += " 	C5_FILIAL, C5_CLIENTE, C5_LOJACLI, C5_TIPO, C5_CONDPAG, '"+cPed3+"' C5_MENNOTA,"
cQuery += " 	C6_PRODUTO, C6_DESCRI, C6_TES,"
cQuery += " 	C6_XCLVL, C6_XITECTB,"
//cQuery += " 		SUM(C6_QTDVEN) C6_QTDVEN, SUM(E1_BASCOM5) C6_VALOR"
//cQuery += " 		SUM(C6_QTDVEN) C6_QTDVEN, "+str(nTotPe)+" C6_VALOR"
//cQuery += " 		SUM(C6_QTDVEN) C6_QTDVEN, ROUND((C6_VALOR/"+str(nTotInv)+")*  "+str(nTotPe)+",2) C6_VALOR"
cQuery += " 		SUM(C6_QTDVEN) C6_QTDVEN, ROUND((REC_SE1/"+str(nTotInv)+")*  "+str(nTotPe)+",2) C6_VALOR"
//cQuery += " 		SUM(C6_QTDVEN) C6_QTDVEN, ROUND(ROUND(C6_VALOR/TOTPED,2)* "+str(nTotPe)+",2) C6_VALOR"

//cQuery += " 		ROUND(SUM(C6_VALOR)* C5_CONTCAM,2)  C6_VALOR"
//cQuery += " 		ROUND(SUM(C6_VALOR)* CASE WHEN E1_VALLIQ > E1_VALOR THEN E1_VALLIQ/E1_VALOR ELSE E1_VALOR/E1_VALLIQ END ,2)  C6_VALOR"
cQuery += " FROM "+RetSqlName("SC5")+" C5"
cQuery += " INNER JOIN "+RetSqlName("SC6")+" C6 ON C5_NUM=C6_NUM AND C5_FILIAL=C6_FILIAL AND C6_ITEM='01' AND C6.D_E_L_E_T_=' '"
//cQuery += " INNER JOIN "+RetSqlName("SE1")+" E1 ON E1_PEDIDO=C5_NUM AND E1_TIPO='NF' AND E1.D_E_L_E_T_=' ' and E1_MOEDA>1"
cQuery += " INNER JOIN "+RetSqlName("SB1")+" B1 ON C6_PRODUTO=B1_COD AND B1.D_E_L_E_T_=' '"
cQuery += " INNER JOIN "
cQuery += " 		(SELECT E1_PEDIDO, SUM(E1_BASCOM5) REC_SE1 FROM "+RetSqlName("SE1")+""
cQuery += " 		WHERE D_E_L_E_T_=' '"
cQuery += " 		AND E1_PEDIDO IN ("+cPed1+") AND E1_CLIENTE = '"+cClie+"' 	 AND E1_LOJA='"+cLoja+"'"
cQuery += " 		AND E1_TIPO='RA' AND E1_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"'"
cQuery += " 		GROUP BY E1_PEDIDO)SE1 ON E1_PEDIDO=C5_NUM"

//cQuery += " INNER JOIN (SELECT SUM(C6_VALOR) TOTPED, C6_NUM C6TOTPED FROM "+RetSqlName("SC6")+" WHERE D_E_L_E_T_=' ' AND C6_NUM IN("+cPed1+")"
//cQuery += " GROUP BY C6_NUM)C6TOT ON C6TOTPED=C6_NUM"

cQuery += " WHERE C5.D_E_L_E_T_=' '"
cQuery += " 	AND C5_NUM 		IN ("+cPed1+")"
cQuery += " 	AND C5_CLIENTE	= '"+cClie+"' "
cQuery += " 	AND C5_LOJACLI	= '"+cLoja+"' "
cQuery += " GROUP BY"
cQuery += " 	C5_FILIAL, C5_CLIENTE, C5_LOJACLI, C5_TIPO, C5_CONDPAG,"
cQuery += " 	C6_PRODUTO, C6_DESCRI, C6_TES "
//cQuery += " 	,C6_XCLVL, C6_XITECTB, C5_CONTCAM, C6_VALOR"
cQuery += " 	,C6_XCLVL, C6_XITECTB, C5_CONTCAM, REC_SE1"
//cQuery += " 	,C6_XCLVL, C6_XITECTB, C5_CONTCAM, C6_VALOR,TOTPED"


Memowrite('c:\aa\abrev1.txt',CQuery)

If Select("CLK") > 0
	DbCloseArea("CLK")
Endif

TCQUERY cQuery NEW ALIAS "CLK"
TCSQLEXEC(cQuery)


//Cria o Pedido de Venda
aAdd(aCab ,{"C5_TIPO"	, "N"				,NIL}) // Tipo de Pedido
aAdd(aCab ,{"C5_ESPECI"	, "NFS"				,NIL}) // Mensagem para Pedido
aAdd(aCab ,{"C5_CLIENTE", CLK->C5_CLIENTE	,NIL}) // Cliente
aAdd(aCab ,{"C5_LOJACLI", CLK->C5_LOJACLI 	,NIL}) // Loja
aAdd(aCab, {"C5_CLIENT"	, CLK->C5_CLIENTE	,Nil}) // Codigo do Cliente para entrega
aAdd(aCab, {"C5_LOJAENT", CLK->C5_LOJACLI	,Nil}) // Loja para entrega
aAdd(aCab ,{"C5_TPCTB"	, "3"				,NIL}) // Mensagem para Pedido
aAdd(aCab ,{"C5_TIPOCLI", "X"				,NIL}) // Tipo de Cliente
aAdd(aCab ,{"C5_MOEDA"  , 1					,NIL}) // Moeda
aAdd(aCab ,{"C5_CONTCAM", 1					,NIL}) // Mensagem para Pedido
aAdd(aCab ,{"C5_CONDPAG", CLK->C5_CONDPAG	,NIL}) // CondiÁ„o de Pagamento
aAdd(aCab, {"C5_EMISSAO", dDatabase			,Nil}) // Data de Emissao
aAdd(aCab ,{"C5_MENNOTA", CLK->C5_MENNOTA	,NIL}) // Mensagem para Pedido
aAdd(aCab ,{"C5_NATUREZ", "100002"			,NIL}) // Mensagem para Pedido

nItemx := 1
While !Eof()
	
	aAdd(aItem,{;
	{"C6_ITEM"		,STRZERO(nItemx,2)	,Nil},;		// Numero do Item no Pedido
	{"C6_PRODUTO"	,CLK->C6_PRODUTO	,NIL},;		// Codigo do Produto
	{"C6_UM"		,"UN"				,Nil},;     // Unidade de Medida Primar.
	{"C6_QTDVEN"	,CLK->C6_QTDVEN		,NIL},;		// Quantidade Venda
	{"C6_PRCVEN"	,CLK->C6_VALOR/CLK->C6_QTDVEN		,NIL},;	//Valor Unitario
	{"C6_VALOR"		,CLK->C6_VALOR		,NIL},;		// Valor do Pedido
	{"C6_TES"		,CLK->C6_TES	 	,NIL},;		// TES Original - CLK->C6_TES
	{"C6_ENTREG"	,dDataBase			,Nil},;		// Data da Entrega
	{"C6_XCLVL"		,CLK->C6_XCLVL	 	,NIL},;     // TimeKeep
	{"C6_XITECTB"	,CLK->C6_XITECTB 	,NIL},;		// Matter
	{"C6_DTFIMNT"	,CTOD("  /  /  ") 	,NIL},;		// Matter
	{"C6_QTDLIB"	,1.00				,NIL} })
	
	nItemx += 1
	DbSkip()
Enddo


//ExecAuto - Incluir o Pedido de Venda
If nItemx > 1

	dbSelectArea("SC5")
	Begin Transaction
	MsExecAuto({|x,y,z| mata410(x,y,z) }, aCab,    aItem,3)

	If lMsErroAuto
		mostraerro()
		DisarmTransaction()
	Else
		
		cSqlUpd := "UPDATE "+RetSqlName("SE1")+" SET E1_VEND5='X' WHERE E1_PEDIDO IN ("+cPed1+") AND E1_MOEDA>1 AND E1_SALDO=0"
		TcSqlExec(cSqlUpd)
		
		APMSGINFO("Dados GERADOS com Sucessos!!!")
	EndIf
	
	End Transaction

Endif

RETURN




//Perguntas
Static Function CriaSX1(cPerg)

Local aHelp	:= {}

//Texto do help em portugues,espanhol e ingles
AADD(aHelp, {{"Data do Recebimento Incial"	}, {""}	, {""} })
AADD(aHelp, {{"Data do Recebimento Final"	}, {""}	, {""} })
AADD(aHelp, {{"CLIENTE:"	}, {""}	, {""} })
PutSX1( cPerg, "01", "Dt Recebimento de: " , "", "", "mv_ch1", "D", 08, 00, 00, "G", "", "", "", "", "mv_Par01", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", aHelp[1,1], aHelp[1,2], aHelp[1,3], "" )
PutSX1( cPerg, "02", "Dt Recebimento ate: ", "", "", "mv_ch2", "D", 08, 00, 00, "G", "", "", "", "", "mv_Par02", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", aHelp[2,1], aHelp[2,2], aHelp[2,3], "" )
PutSX1( cPerg, "03", "Cliente: "    	   , "", "", "mv_ch3", "C", 06, 00, 00, "G", "", "", "", "", "mv_Par03", "", "", "", "", "", "", "", "", "", "", "", "", "SA1", "", "", "", aHelp[1,1], aHelp[1,2], aHelp[1,3], "" )

Return



//Monta Tela
STATIC Function fZZGrid()
Local _nOpca	:= 0 //Opcao da confirmacao
Local bOk		:= {|| _nOpca:=1,_lRetorno:=.T.,oDlg:End() } //botao de ok
Local bCancel	:= {|| _nOpca:=0,oDlg:End() } //botao de cancelamento
Private aHeader	:= {}
PUBLIC aCols	:= {}
Private nUsado	:= 0
Private oDlg	:= nil
Private oGetDados:= nil

Define MsDialog oDlg from 0, 0 to 500,800 title "TITULOS SELECIONADOS" pixel
Aadd(aHeader, {;
"NUMERO",;//X3Titulo()
"E1_NUM",;  //X3_CAMPO
"@C",;		//X3_PICTURE
9,;			//X3_TAMANHO
0,;			//X3_DECIMAL
"",;			//X3_VALID
"",;			//X3_USADO
"C",;			//X3_TIPO
"",;			//X3_F3
"R",;			//X3_CONTEXT
"",;			//X3_CBOX
"",;			//X3_RELACAO
""})			//X3_WHEN

Aadd(aHeader, {"CLIENTE"		, "E1_CLIENTE", "@C", 06, 0, "", "", "C", "", "R", "", "", ""})	//02
Aadd(aHeader, {"NOME CLIENTE"	, "E1_NOMCLI" , "@C", 20, 0, "", "", "C", "", "R", "", "", ""})	//03
Aadd(aHeader, {"EMISSAO"		, "E1_EMISSAO", ""  , 08, 0, "", "", "D", "", "R", "", "", ""})	//04
Aadd(aHeader, {"VENCIMENTO"		, "E1_VENCTO" , ""	, 08, 0, "", "", "D", "", "R", "", "", ""})	//05
Aadd(aHeader, {"VALOR"			, "E1_VALOR"  , "@E 99,999,999.99",17,2,"","","N","","V","","",""})	//06
Aadd(aHeader, {"RECEBIMENTO"	, "E1_BAIXA"  , ""  , 08, 0, "", "", "D", "", "R", "", "", ""})		//07
Aadd(aHeader, {"PEDIDO"			, "E1_PEDIDO" , "@C", 06, 0, "", "", "C", "", "R", "", "", ""})	//08
Aadd(aHeader, {"LOJA"			, "E1_LOJA"   , "@C", 02, 0, "", "", "C", "", "R", "", "", ""})	//09
Aadd(aHeader, {"Vlr Invoice"	, "E1_VALOR"  , "@E 99,999,999.99",17,2,"","","N","","V","","",""})	//10

_ni := 1
WHILE _ni<=len(_aEmpMigr)
	aadd(aCols,{_aEmpMigr[_ni,1],_aEmpMigr[_ni,2],_aEmpMigr[_ni,3],_aEmpMigr[_ni,4],_aEmpMigr[_ni,5],_aEmpMigr[_ni,6],_aEmpMigr[_ni,8],_aEmpMigr[_ni,9],_aEmpMigr[_ni,7],_aEmpMigr[_ni,10],.F.})
	_ni++
ENDDO

oGetDados := MsNewGetDados():New(60,5,224,459,GD_INSERT+GD_DELETE+GD_UPDATE,"AllwaysTrue()","",,,,,,,,oDLG, aHeader,aCols)
oGetDados:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT

ACTIVATE MSDIALOG oDlg On Init (EnchoiceBar(oDlg,bOk,bCancel,,)) CENTERED

IF _nOpca==1 .AND. !EMPTY(_aEmpMigr)
	GRAVASZ2()
ENDIF
Return


USER FUNCTION TESTEOP()
LOCAL NUM	:= 0
LOCAL NUM2	:= 0
LOCAL NUM3	:= 0
LOCAL NUM4	:= 0

NUM 	:= DateDiffDay(aCols[n][5] ,aCols[n][7])
//MsgAlert(CVALTOCHAR(NUM))
NUM2 	:= (0.99/30)*NUM
//MsgAlert(CVALTOCHAR(NUM2))
NUM3 	:= aCols[n][6]
NUM4 	:= ((NUM3*NUM2)/100) + NUM3
//MsgAlert(CVALTOCHAR(NUM4))
aCols[n][9] := (NUM3*NUM2)/100	//COLUNA DE JUROS
oGetDados:oBrowse:Refresh()

oGetDados:Refresh()
RETURN NUM4
