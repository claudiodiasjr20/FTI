#include "topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFTIFAT01  บAutor  ณAlexandre Sousa     บ Data ณ  08/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio de pedidos pendentes de liberacao financeira.     บฑฑ
ฑฑบ          ณEspecifico para processo interno da FTI.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico clientes Focus Consultoria.                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FTIFAT01()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1       := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2       := "de acordo com os parametros informados pelo usuario."
Local cDesc3       := "Relat๓rio de Pedidos Pendentes de aprova็ใo Financeira"
Local cPict        := ""
Local titulo       := "Relat๓rio de Pedidos Pendentes de aprova็ใo Financeira - Vr20082015a"
Local nLin         := 80
Local imprime      := .T.
Local aOrd := {}
//								 10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
//                     1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Local Cabec1       := " #    Cliente Loja                   CNPJ               Tipo       Data de    Condi็ใo de Mensag Nfe               Produto         Timekeeper  Centro   Tipo de   Matter      Valor Bruto Login           Data da    Hora de "
Local Cabec2       := "                                                        Cliente    emissใo    Pagamento                                                        Custo    Opera็ใo                          de cria็ใo      cria็ใo    cria็ใo"
//                     999  999999-99 xxxxxxxxxxxxxxxxxxxx 99.999.999/0001-99 Exporta็ใo 99/99/9999 001-avista  xxxxxxxxxxxxxxxxxxxxxxxx REEMB0000000006 3000000000  99999     99       PEND000079 9.999.999,99 XXXXXXXXXXXXXXX 99/99/9999  99:99
Private a_pos       := {1,  6,                             37,                56,        67,        78,         90,                      115,            131,        143,      153,     162,       173,          186,           202,        214     }
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 220
Private tamanho          := "G"
Private nomeprog         := "FTIFAT01" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 15
Private aReturn          := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey        := 0
Private cPerg       := "FTIFAT01"
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "FTIFAT01" // Coloque aqui o nome do arquivo usado para impressao em disco
Private a_xml		:= {}

Private cString := "SC9"

dbSelectArea("SC9")
dbSetOrder(1)

	PutSx1(cPerg,"01","Libera็ใo De      ",'','',"mv_ch1","D",08,00,00,"G","",""      ,"","","mv_par01","","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"02","Libera็ใo Ate     ",'','',"mv_ch2","D",08,00,00,"G","",""      ,"","","mv_par02","","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"03","Tipo?             ",'','',"mv_ch3","N", 1,00,00,"C","",""      ,"","","mv_par03","Bloqueados","Bloqueados","Bloqueados","","Liberados","Liberados","Liberados","Ambos","Ambos","Ambos","","","","","","","","","","","","","","","")
//	PutSx1(_cPerg,"03","Transportadora De ",'','',"mv_ch3","C",06,00,00,"G","","SA4"   ,"","","mv_par03","","","","","","","","","","","","","","","","")
//	PutSx1(_cPerg,"04","Transportadora Ate",'','',"mv_ch4","C",06,00,00,"G","","SA4"   ,"","","mv_par04","","","","","","","","","","","","","","","","")
//	PutSx1(_cPerg,"05","Cliente de?       ",'','',"mv_ch5","C",06,00,00,"G","","SA1"   ,"","","mv_par05","","","","","","","","","","","","","","","","")
//	PutSx1(_cPerg,"06","Cliente at้?      ",'','',"mv_ch6","C",06,00,00,"G","","SA1"   ,"","","mv_par06","","","","","","","","","","","","","","","","")
//	PutSx1(_cPerg,"07","Loja de?          ",'','',"mv_ch7","C",02,00,00,"G","",""      ,"","","mv_par07","","","","","","","","","","","","","","","","")
//	PutSx1(_cPerg,"08","Loja at้?         ",'','',"mv_ch8","C",02,00,00,"G","",""      ,"","","mv_par08","","","","","","","","","","","","","","","","")
//	PutSx1(_cPerg,"09","Vendedor de?      ",'','',"mv_ch9","C",06,00,00,"G","","SA3"   ,"","","mv_par09","","","","","","","","","","","","","","","","")
//	PutSx1(_cPerg,"10","Vendedor at้?     ",'','',"mv_cha","C",06,00,00,"G","","SA3"   ,"","","mv_par10","","","","","","","","","","","","","","","","")
//	PutSx1(_cPerg,"11","Estado de?        ",'','',"mv_chb","C",02,00,00,"G","","12"    ,"","","mv_par11","","","","","","","","","","","","","","","","")
//	PutSx1(_cPerg,"12","Estado at้?       ",'','',"mv_chc","C",02,00,00,"G","","12"    ,"","","mv_par12","","","","","","","","","","","","","","","","")

pergunte(cPerg,.T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	fCabecHTML()	

	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

//	Processa({|| GeraQry() },"Gerando comunicao Banco de Dados...!!")
	fRodaHTML()

	Exporta()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  04/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local c_EOL		:= chr(13)

a_itens		:= {}

dbSelectArea(cString)
dbSetOrder(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())


	c_query := " select C9_BLCRED, C9_BLWMS, C9_BLTMS, * from "+RetSqlName('SC9')+" "+c_EOL
	c_query += " where  C9_DATALIB between '"+Dtos(MV_PAR01)+"' and '"+Dtos(MV_PAR02)+"' "+c_EOL
	c_query += " and    not(C9_BLCRED = '10' and C9_BLEST = '10') "+c_EOL       
	If mv_par03 = 1
		c_query += " and    C9_BLCRED <> '' "+c_EOL
	ElseIf mv_par03 = 2
		c_query += " and    C9_BLCRED = '' "+c_EOL
	EndIf
	c_query += " and    D_E_L_E_T_ <> '*'"+c_EOL

	If Select("QRY") > 0
		QRY->(DbCloseArea())
	EndIf
	DbUseArea(.T.,"TOPCONN",TCGENQRY(,,c_query),"QRY",.F.,.T.) 

	DbSelectArea("QRY")
	QRY->(dbGoTop()) 
	
	n_reg := 1

	While QRY->(!EOF())

		a_itens	:= {}
		DbSelectArea('SC5')
		DbSetOrder(1)
		DbSeek(xFilial('SC5')+QRY->C9_PEDIDO)
		
		DbSelectArea('SC6')
		DbSetOrder(1)
		DbSeek(xFilial('SC6')+QRY->C9_PEDIDO)
		
		While SC6->(!EOF()) .and. SC6->C6_NUM = QRY->C9_PEDIDO
			Aadd(a_itens, {SC6->C6_PRODUTO, SC6->C6_XCLVL , SC6->C6_XCC ,SC6->C6_OP ,SC6->C6_XITECTB ,SC6->C6_VALOR})
//			Aadd(a_itens, {SC6->C6_PRODUTO, SC6->C6_XCLVL , SC6->C6_XCC ,SC6->C6_OPER ,SC6->C6_XITECTB ,SC6->C6_VALOR})
			SC6->(DbSkip())
		EndDo

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Verifica o cancelamento pelo usuario...                             ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Impressao do cabecalho do relatorio. . .                            ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
		If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		Endif

//Local Cabec1       := "#    Cliente Loja                   CNPJ               Tipo       Data de  Condi็ใo de Mensag Nfe                  Produto          Timekeeper  Centro   Tipo de   Matter      Valor Bruto  Login           Data da  Horแrio de "
//Local Cabec2       := "                                                       Cliente 	 emissใo  Pagamento                                                            Custo    Opera็ใo                           de cria็ใo      cria็ใo  cria็ใo"
//                     999  999999-99 xxxxxxxxxxxxxxxxxxxx 99.999.999/0001-99 Exporta็ใo 99/99/99 001-avista  xxxxxxxxxxxxxxxxxxxxxxxxx   REEMB0000000006  3000000000  99999     99       PEND000079 9.999.999,99  XXXXXXXXXXXXXXX 99/99/99  99:99
		For n_x := 1 to len(a_itens)
			@nLin,a_pos[01] PSAY StrZero(n_reg,3)
			@nLin,a_pos[02] PSAY SC5->C5_CLIENTE+"-"+SC5->C5_LOJACLI+' '+SubStr(GetAdvFval('SA1', 'A1_NOME', xFilial('SA1')+SC5->(C5_CLIENTE+SC5->C5_LOJACLI), 1, ''),1,20)
			@nLin,a_pos[03] PSAY GetAdvFval('SA1', 'A1_CGC', xFilial('SA1')+SC5->(C5_CLIENTE+SC5->C5_LOJACLI), 1, '')
			@nLin,a_pos[04] PSAY SubStr(Iif(SC5->C5_TIPOCLI='F', "Cons.Final",IIf(SC5->C5_TIPOCLI='L',"Prod.Rural",Iif(SC5->C5_TIPOCLI='R',"Revendedor",Iif(SC5->C5_TIPOCLI='S',"Solidแrio","Exporta็ใo/Importa็ใo")))),1,10)
			@nLin,a_pos[05] PSAY DtoC(SC5->C5_EMISSAO)
			@nLin,a_pos[06] PSAY SC5->C5_CONDPAG + '-'+SUBSTR(Alltrim(GetAdvFval('SE4','E4_DESCRI',xFilial('SE4')+SC5->C5_CONDPAG, 1, '')),1,7)
			@nLin,a_pos[07] PSAY Iif(Empty(SC5->C5_XMENNOT), " - ", Substr(alltrim(replace( REPLACE(Replace(SC5->C5_XMENNOT,'	',''), CHR(13),' ') , chr(10), '')) ,1,23))

			@nLin,a_pos[08] PSAY a_itens[n_x,1] //produto
			@nLin,a_pos[09] PSAY a_itens[n_x,2] //timekeeper
			@nLin,a_pos[10] PSAY a_itens[n_x,3] //ccusto
			@nLin,a_pos[11] PSAY a_itens[n_x,4] //tp operacao
			@nLin,a_pos[12] PSAY a_itens[n_x,5] //Matter
			@nLin,a_pos[13] PSAY Transform(a_itens[n_x,6], "@E 9,999,999.99" )//Valor
	                  
			@nLin,a_pos[14] PSAY SC5->C5_XUSRINC
			@nLin,a_pos[15] PSAY DtoC(SC5->C5_XDTINC)
			@nLin,a_pos[16] PSAY SC5->C5_XHRINC

			nLin := nLin + 1 // Avanca a linha de impressao
		Next

		faddxml()
	
		n_reg++
		QRY->(dbSkip()) // Avanca o ponteiro do registro no arquivo

	EndDo

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Finaliza a execucao do relatorio...                                 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	SET DEVICE TO SCREEN

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	If aReturn[5]==1
	   dbCommitAll()
	   SET PRINTER TO
	   OurSpool(wnrel)
	Endif
	
	MS_FLUSH()

Return
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ CabecHTML   |   Autor ณ Tiago Dias (Focus Consultoria)  | 	Data ณ 26/12/14  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Monta o E-mail para o envio do Status das informa็๕es divergentes do arquivo  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nil                                                             				 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ c_Cabec	                                                     				 ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function fCabecHTML()

Local c_EOL			:= chr(13)

//**********************************************************************************
//                             CABECALHO DO EMAIL
//**********************************************************************************             
Aadd(a_xml, '<HTML><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'+c_EOL)
Aadd(a_xml, '	<html xmlns="http://www.w3.org/1999/xhtml">'+c_EOL)
Aadd(a_xml, '	<style type="text/css">'+c_EOL)
Aadd(a_xml, '		.tituloPag { FONT-SIZE: 20px; COLOR: #666699; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'+c_EOL)
Aadd(a_xml, '		.formulario { FONT-SIZE: 10px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'+c_EOL)
Aadd(a_xml, '		.formulario5 { FONT-SIZE: 13px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'+c_EOL)
Aadd(a_xml, '		.formulario4 { FONT-SIZE: 13px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'+c_EOL)
Aadd(a_xml, '		.formulario2 { FONT-SIZE: 11px; COLOR: #333333; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; }'+c_EOL)
Aadd(a_xml, '		.formulario6 { FONT-SIZE: 12px; COLOR: #333333; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; }'+c_EOL)
Aadd(a_xml, '		.formulario7 { FONT-SIZE: 12px; COLOR: #FF0000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; }'+c_EOL)
Aadd(a_xml, '		.formulario3 { FONT-SIZE: 10px; COLOR: #FFFFFF; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'+c_EOL)
Aadd(a_xml, '		.formularioTit { FONT-SIZE: 13px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none;  }'+c_EOL)
Aadd(a_xml, '		.formularioTit2 { FONT-SIZE: 15px; COLOR: #FFFFFF; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'+c_EOL)
Aadd(a_xml, '		.formularioTit3 { FONT-SIZE: 13px; COLOR: #FFFFFF; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none;  }'+c_EOL)
Aadd(a_xml, '	</style>'+c_EOL)
Aadd(a_xml, '<head>'+c_EOL)
Aadd(a_xml, '	<title> '+SM0->M0_NOMECOM+' - Relat๓rio de pedido de vendas </title>'+c_EOL)
Aadd(a_xml, '</head>'+c_EOL)
Aadd(a_xml, '<table width="95%" border="0" align="center">'+c_EOL)
Aadd(a_xml, '<tr>'+c_EOL)
Aadd(a_xml, '	<td colspan="15" bgcolor="#000066">'+c_EOL)
Aadd(a_xml, '		<div align="center"><span class="formularioTit2"><H2>'+SM0->M0_NOMECOM+' - Relat๓rio de pedidos de vendas</H2></span></div>'+c_EOL)
Aadd(a_xml, '	</td>'+c_EOL)
Aadd(a_xml, '</tr>'+c_EOL)
Aadd(a_xml, '<tr>'+c_EOL)
Aadd(a_xml, '	<td colspan="10">&nbsp;</td>'+c_EOL)
Aadd(a_xml, '</tr>'+c_EOL)
Aadd(a_xml, '<tr>'+c_EOL)
Aadd(a_xml, '</tr>'+c_EOL)

Aadd(a_xml, '<tr>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">#</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">Cliente</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">CNPJ</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">Tipo Cliente</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">Cond.Pagto</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">Msg NFe</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">Produto</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">TimeKeeper</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">Centro de Custo</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">Tipo de Opera็ใo</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">Matter</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">Valor Bruto</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">Login de Cria็ใo</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">Data de Cria็ใo</td>'+c_EOL)
Aadd(a_xml, '	<td bgcolor="#ECF0EE" class="formulario5">Horแrio de Cria็ใo</td>'+c_EOL)
Aadd(a_xml, '</tr>'+c_EOL)
	         
Return 
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ fRodaHTML   |   Autor ณ Tiago Dias (Focus Consultoria)  | 	Data ณ 26/12/14  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Monta o E-mail para o envio do Status das informa็๕es divergentes do arquivo  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nil                                                             				 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ c_Rodape                                                     				 ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function fRodaHTML()  

Local c_Rodape 		:= "" 
Local c_Ambiente	:= Upper(AllTrim(GetEnvServer()))
Local c_Rotina		:= ALLTRIM(FUNNAME())
Local c_EOL			:= chr(13)

//**********************************************************************************
//                             RODAPE DO EMAIL
//**********************************************************************************

Aadd(a_xml, '<tr>' +c_EOL)
Aadd(a_xml, '</tr>'+c_EOL)
Aadd(a_xml, '<tr>'+c_EOL)
Aadd(a_xml, '</tr>'+c_EOL)
Aadd(a_xml, '<tr>'+c_EOL)
Aadd(a_xml, '</tr>' +c_EOL)
Aadd(a_xml, '<tr>'+c_EOL)
Aadd(a_xml, '</tr>'+c_EOL)
Aadd(a_xml, '<tr>'+c_EOL)
Aadd(a_xml, '</tr>'+c_EOL)
Aadd(a_xml, '<tr>'+c_EOL)
Aadd(a_xml, '</tr>'+c_EOL)
Aadd(a_xml, '</table>'+c_EOL)
Aadd(a_xml, '</body>'+c_EOL)
Aadd(a_xml, '</html>'+c_EOL)

Return 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfaddxml   บAutor  ณAlexandre Sousa     บ Data ณ  07/25/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณInclui a linha do excel xml.                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function faddxml()

	Local c_Ret			:= ''
	Local c_EOL			:= chr(13)
	
	DbSelectArea('SC6')
	
	For n_x := 1 to len(a_itens)
		//	Aadd(a_xml, "   <tr>"+c_EOL)
		Aadd(a_xml, '<tr>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ StrZero(n_reg,3) +'</td>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ SC5->C5_CLIENTE+'-'+SC5->C5_LOJACLI + ' - ' +Alltrim(GetAdvFval('SA1', 'A1_NOME', xFilial('SA1')+SC5->(C5_CLIENTE+C5_LOJACLI),1,''))+'</td>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+GetAdvFval('SA1', 'A1_CGC', xFilial('SA1')+SC5->(C5_CLIENTE+C5_LOJACLI),1,'')+'</td>'			+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ Iif(SC5->C5_TIPOCLI='F', "Cons.Final",IIf(SC5->C5_TIPOCLI='L',"Prod.Rural",Iif(SC5->C5_TIPOCLI='R',"Revendedor",Iif(SC5->C5_TIPOCLI='S',"Solidแrio","Exporta็ใo/Importa็ใo")))) + '</td>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ SC5->C5_CONDPAG		+	'</td>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ SC5->C5_XMENNOT		+	'</td>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_itens[n_x,1]	+	'</td>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_itens[n_x,2]	+	'</td>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_itens[n_x,3]	+	'</td>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_itens[n_x,4]	+	'</td>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_itens[n_x,5]	+	'</td>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ Transform(a_itens[n_x,6], "@E 999,999.99")	+		'</td>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ SC5->C5_XUSRINC		+ '</td>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ DtoC(SC5->C5_XDTINC)	+ '</td>'+c_EOL)
		Aadd(a_xml,  '	<td bgcolor="#F7F9F8" class="formulario6">'+ SC5->C5_XHRINC			+ '</td>'+c_EOL)
		Aadd(a_xml, "	</tr>"+c_EOL)
	Next

Return c_Ret
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFGEN002   บAutor  ณAlexandre Martins   บ Data ณ  03/17/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao generica para exportacao de dados para o Excel.      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico ACTUAL TREND                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Exporta()
	
	Processa({||ExpXML()}, "Exportando Dados")

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExpXML    บAutor  ณMicrosiga           บ Data ณ  09/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para exportar registros do relatorio para excel      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExpXML()

	Private _cNome   := CriaTrab(,.F.)
	Private cArqSaida	:= AllTrim(GetTempPath())+_cNome+".xls"
//	Private cArqSaida	:= AllTrim(GetTempPath())+_cNome+".html"
    
	If msgyesno('Deseja informar o local para salvar o arquivo?')
		cArqSaida := cGetFile("\", "Selecione o Diretorio p/ Gerar o Arquivo",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY/*128+GETF_NETWORKDRIVE*/) //
		cArqSaida += _cNome+".xls"
//		cArqSaida += _cNome+".html"
	EndIf

	Private nHdlSaida	:= fCreate(cArqSaida)

	If nHdlSaida == -1
		MsgAlert("O arquivo de nome "+cArqSaida+" nao pode ser executado! Verifique os parametros.","Atencao!")
		Return
	Endif

	ProcRegua(len(a_xml))

	For n_t := 1 to len(a_xml)
		FWRITE(nHdlSaida,a_xml[n_t]+chr(13))
		IncProc("Concluindo ..."+AllTrim(Str((n_t/len(a_xml))*100, 5))+" %")
	Next
	
	FCLOSE(nHdlSaida)
	
	ShellExecute("open",cArqSaida,"","",5)
	
Return