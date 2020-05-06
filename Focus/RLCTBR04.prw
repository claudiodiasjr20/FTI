#Include "Protheus.ch"
#Include "RwMake.ch"
#Include "TopConn.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ RLCTBR04()   |  Autor ณ Ale Martins (Focus Consultoria)  | 	Data ณ 21/07/15  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Relatorio de Conferencia de APROVADOR - CT2									 ดฑฑ	                            
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณObs: Chamado #28713 (Workflow de aprova็ใo de lan็amentos manuais no Protheus)	         ดฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณCampos Utilizados -> Plano de Contas -> CT1_XCTFTI + CT1_XDCFTI							 ดฑฑ
ฑฑณ----------------- -> Movto CT2 -> CT2_USRCNF, CT2_DTCONF, CT2_HRCONF e CT2_TPSALD         ดฑฑ
ฑฑณ  -> Centro de Custos ->  CTT_XFTILC + CTT_XFTIBS + CTT_XFTIDP + CTT_XFTISC e CTT_XGAAP   ดฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function RLCTBR04()     

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relatorio de Conferencia de APROVADOR - Vr20082015a"
Local cPict          := ""
Local titulo       := "Relatorio de Conferencia de APROVADOR"
Local nLin         := 80

Local imprime      := .T.
Local aOrd := {}
//                              10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
//                     01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Local Cabec1       := " Lote   Sub  Nr.   Linha Data       Tipo Lancamento  Conta      USGAAP  CCusto     CC GAAP       Conta      USGAAP  CCusto    CC GAAP              Valor  Historico                      Feito por       Aprovador       Tipo"
Local Cabec2       := "        Lote Doc.        Lan็amento                  Debito     Debito  Debito     Debito        Credito    Credito Credito   Credito                                                    (Usuแrio)       (Usuแrio)       Saldo"
//                      999999 999  999999 999  99/99/9999 Partida Dobrada  999-10-999  9999   9999999999 999999999999 999-10-999   9999  9999999999 999999999999 9,999,999.99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXX  9
Private a_pos      := { 1,     8,   13,    20,  25,        36,              53,         65,    72,        83,          96,          109,  115,       126,         139,          153,                           184,            200,           217}
//                      1      2    3      4    5          6                7           8      9          10           11           12     13        14           15            16                              17             18             19
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 220
Private tamanho          := "G"
Private nomeprog         := "RLCTBR04" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cPerg       	:= "RLCTBR04"
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "RLCTBR04" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString := "CT2"
Private a_xml	:= {}

dbSelectArea("CT2")
dbSetOrder(1)

ValidPerg()

pergunte(cPerg,.F.)

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

fCabecxml()
RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
rdxml()	

Exporta()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  21/07/15   บฑฑ
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

dbSelectArea(cString)
dbSetOrder(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())


c_query := "Select * from "+RetSqlName('CT2')+" "
c_query += "where    CT2_DATA between '"+dtos(mv_par01)+"' and '"+dtos(mv_par02)+"'"
c_query += "and    D_E_L_E_T_ <> '*'"

c_query := " Select     CTTA.CTT_DESC01 as DESCCTTA, CTTB.CTT_DESC01 as DESCCTTB, CT1A.CT1_DESC01 AS DESCDEBITO, CT1B.CT1_DESC01 AS DESCCRED, CTTA.CTT_XFTILC+CTTA.CTT_XFTIBS+CTTA.CTT_XFTIDP+CTTA.CTT_XFTISC AS CCDGAP,  CTTA.CTT_XGAAP AS DCCDGAP, CTTB.CTT_XFTILC+CTTB.CTT_XFTIBS+CTTB.CTT_XFTIDP+CTTB.CTT_XFTISC AS CCCGAP,  CTTB.CTT_XGAAP AS DCCCGAP, CT1A.CT1_XCTFTI as GAPDEB, CT1A.CT1_XDCFTI as DESCGAPD, CT1B.CT1_XCTFTI as GAPCRE, CT1B.CT1_XDCFTI as DESCGAPC, CT2.*"
c_query += " from       "+RetSqlName('CT2')+" CT2"
c_query += " left  join "+RetSqlName('CT1')+" CT1A"
c_query += " on         CT1A.CT1_CONTA = CT2_DEBITO "
c_query += " and        CT1A.D_E_L_E_T_ <> '*'     "
c_query += " left  join "+RetSqlName('CT1')+" CT1B"
c_query += " on         CT1B.CT1_CONTA = CT2_CREDIT"
c_query += " and        CT1B.D_E_L_E_T_ <> '*'"
c_query += " left join  "+RetSqlName('CTT')+" CTTA"
c_query += " on         CTTA.CTT_CUSTO = CT2_CCD"
c_query += " and        CTTA.D_E_L_E_T_ <> '*'"
c_query += " left join  "+RetSqlName('CTT')+" CTTB"
c_query += " on         CTTB.CTT_CUSTO = CT2_CCC"
c_query += " and        CTTB.D_E_L_E_T_ <> '*'"
c_query += " where      CT2_DATA between '"+dtos(mv_par01)+"' and '"+dtos(mv_par02)+"'"
c_query += " and        CT2_LOTE between '"+MV_PAR04+"' and '"+MV_PAR05+"' "
c_query += " and        CT2_SBLOTE between '"+MV_PAR06+"' and '"+MV_PAR07+"' "
c_query += " and        CT2_DOC between '"+MV_PAR08+"' and '"+MV_PAR09+"' "
If !Empty(MV_PAR10)
	c_query += " and        CT2_USRCNF = '"+MV_PAR10+"' "
EndIf   
If !Empty(MV_PAR11)
	c_query += " and        SubString(CT2_ORIGEM,33,15) = '"+MV_PAR11+"' 
EndIf   
If MV_PAR03 = 1
	c_query += " and        CT2_TPSALD = '1' "
	titulo  += " - Mvto Manual = APROVADO" //(Mensagem adicionada por Sidnei)
ElseIf MV_PAR03 = 2
	c_query += " and        CT2_TPSALD = '9' " 
	titulo  += " - Mvto Manual = PARA APROVACAO" //(Mensagem adicionada por Sidnei)
ElseIf MV_PAR03 > 2
	titulo  += " - Mvto Manual = TODOS" //(Mensagem adicionada por Sidnei)
EndIf
c_query += " and        CT2_ROTINA like 'CTBA%'"
c_query += " and        CT2.D_E_L_E_T_ <> '*'"
             

If Select("QRY") > 0
	DbSelectArea("QRY")
	DbCloseArea()
EndIf

TcQuery c_Query New Alias "QRY"

//While QRY->(!EOF())
//	n_Ret += QRY->CT2_VALOR
//	QRY->(DbSkip())
//EndDo

QRY->(dbGoTop())
While QRY->(!EOF())

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
      nLin := 9
   Endif

//                              10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
//                     01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//Local Cabec1     := " Lote   Sub  Nr.   Linha Data       Tipo Lancamento  Conta      USGAAP  CCusto     CC GAAP       Conta      USGAAP  CCusto    CC GAAP             Valor  Historico                      Feito por       Aprovador       Tipo"
//Local Cabec2     := "        Lote Doc.        Lan็amento                  Debito     Debito  Debito     Debito        Credito    Credito Credito   Credito                                                   (Usuแrio)       (Usuแrio)       Saldo"
//                      999999 999  999999 999  99/99/9999 Partida Dobrada  999-10-999  9999   9999999999 999999999999 999-10-999   9999  9999999999 999999999999 9,999,999.99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXX  9
   c_desccc := ''

   @nLin,a_pos[01] PSAY QRY->CT2_LOTE
   @nLin,a_pos[02] PSAY QRY->CT2_SBLOTE
   @nLin,a_pos[03] PSAY QRY->CT2_DOC
   @nLin,a_pos[04] PSAY QRY->CT2_LINHA
   @nLin,a_pos[05] PSAY DTOC(STOD(QRY->CT2_DATA))
   @nLin,a_pos[06] PSAY Iif(QRY->CT2_DC = '3', "Partida Dobrada", Iif(QRY->CT2_DC = '1', "Debito", "Credito"))
   @nLin,a_pos[07] PSAY Iif(empty(QRY->CT2_DEBITO), '   -',alltrim(QRY->CT2_DEBITO))
   @nLin,a_pos[08] PSAY QRY->GAPDEB
   @nLin,a_pos[09] PSAY QRY->CT2_CCD
   @nLin,a_pos[10] PSAY alltrim(QRY->CCDGAP)
   @nLin,a_pos[11] PSAY Iif(empty(QRY->CT2_CREDIT), '   -', ALLTRIM(QRY->CT2_CREDIT))
   @nLin,a_pos[12] PSAY QRY->GAPCRE
   @nLin,a_pos[13] PSAY QRY->CT2_CCC
   @nLin,a_pos[14] PSAY alltrim(QRY->CCCGAP)
   @nLin,a_pos[15] PSAY Transform(QRY->CT2_VALOR, "@E 9,999,999.99")
   @nLin,a_pos[16] PSAY Substring(QRY->CT2_HIST,1,30)
   @nLin,a_pos[17] PSAY SubStr(QRY->CT2_ORIGEM,33,15)
   @nLin,a_pos[18] PSAY Iif(QRY->CT2_TPSALD<>'9',QRY->CT2_USRCNF,'') // Caso FOR pre lancamento nใo sai aprovador (alterado por Sidnei) 
   @nLin,a_pos[19] PSAY QRY->CT2_TPSALD

	faddxml()

   nLin := nLin + 1 // Avanca a linha de impressao

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

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณValidPerg บAutor  ณCosme da Silva NunesบData  ณ13.11.2007   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบUso       ณ                              							  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ValidPerg()

Local aRegs   := {}
                        
cPerg := PADR(cPerg,10)
//			Grupo 	/Ordem	/Pergunta				/Pergunta Espanhol	/Pergunta Ingles	/Variavel	/Tipo	/Tamanho	/Decimal/Presel	/GSC	/Valid	/Var01		/Def01	    /DefSpa1/DefEng1/Cnt01	/Var02	/Def02	      /DefSpa2/DefEng2/Cnt02	/Var03	/Def03	/DefSpa3/DefEng3/Cnt03	/Var04	/Def04	/DefSpa4/DefEng4/Cnt04	/Var05	/Def05	/DefSpa5/DefEng5/Cnt05	/F3		/GRPSX6
Aadd(aRegs,{cPerg	,"01"	,"Da Data          ?"	,""					,""					,"mv_ch1"	,"D"	,08			,00		,0		,"G"	,""		,"mv_par01"	,""		    ,""		,""		,""		,""		,""		     ,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""	,""		})
Aadd(aRegs,{cPerg	,"02"	,"At้ Data         ?"	,""					,""					,"mv_ch2"	,"D"	,08			,00		,0		,"G"	,""		,"mv_par02"	,""		    ,""		,""		,""		,""		,""		     ,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""	,""		})
Aadd(aRegs,{cPerg	,"03"	,"Tipo Movimento   ?"	,""					,""					,"mv_ch3"	,"C"	,01			,00		,0		,"C"	,""		,"MV_PAR03"	,"Aprovado" ,"Aprovado",""	,""		,""		,"Para Aprovar","Para Aprovar","",""	,""		,"Ambas",""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		})
Aadd(aRegs,{cPerg	,"04"	,"Do Lote          ?"	,""					,""					,"mv_ch4"	,"C"	,06			,00		,0		,"G"	,""		,"MV_PAR04"	,""		    ,""		,""		,""		,""		,""		     ,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		})
Aadd(aRegs,{cPerg	,"05"	,"At้ Lote         ?"	,""					,""					,"mv_ch5"	,"C"	,06			,00		,0		,"G"	,""		,"MV_PAR05"	,""		    ,""		,""		,""		,""		,""		     ,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		})
Aadd(aRegs,{cPerg	,"06"	,"Do SubLote       ?"	,""					,""					,"mv_ch6"	,"C"	,03			,00		,0		,"G"	,""		,"MV_PAR06"	,""		    ,""		,""		,""		,""		,""		     ,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		})
Aadd(aRegs,{cPerg	,"07"	,"At้ SubLote      ?"	,""					,""					,"mv_ch7"	,"C"	,03			,00		,0		,"G"	,""		,"MV_PAR07"	,""		    ,""		,""		,""		,""		,""		     ,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		})
Aadd(aRegs,{cPerg	,"08"	,"Do N๚mero        ?"	,""					,""					,"mv_ch8"	,"C"	,06			,00		,0		,"G"	,""		,"MV_PAR08"	,""		    ,""		,""		,""		,""		,""		     ,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		})
Aadd(aRegs,{cPerg	,"09"	,"Ao N๚mero        ?"	,""					,""					,"mv_ch9"	,"C"	,06			,00		,0		,"G"	,""		,"MV_PAR09"	,""		    ,""		,""		,""		,""		,""		     ,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		})
Aadd(aRegs,{cPerg	,"10"	,"Aprovador        ?"	,""					,""					,"mv_cha"	,"C"	,15			,00		,0		,"G"	,""		,"MV_PAR10"	,""		    ,""		,""		,""		,""		,""		     ,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,"US3"	,""		})
Aadd(aRegs,{cPerg	,"11"	,"Feito por        ?"	,""					,""					,"mv_chb"	,"C"	,15			,00		,0		,"G"	,""		,"MV_PAR11"	,""		    ,""		,""		,""		,""		,""		     ,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,""		,"US3"	,""		})

//LValidPerg( aRegs )
U_PutX1ESP(cPerg, aRegs)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCabecxml บAutor  ณAlexandre Sousa     บ Data ณ  07/25/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCabecalho xml para exportacao para o excel.                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCabecxml()

	Local c_Ret := ''
	Local c_EOL := chr(13)

//	Aadd(a_xml,'<html xmlns:v="urn:schemas-microsoft-com:vml"'+c_EOL)
	Aadd(a_xml,'<html xmlns:v="urn:schemas-microsoft-com:vml"'+c_EOL)
	Aadd(a_xml,'xmlns:o="urn:schemas-microsoft-com:office:office"'+c_EOL)
	Aadd(a_xml,'xmlns:x="urn:schemas-microsoft-com:office:excel"'+c_EOL)
	Aadd(a_xml,'xmlns="http://www.w3.org/TR/REC-html40">'+c_EOL)
	Aadd(a_xml,'   <head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">'+c_EOL)
	Aadd(a_xml,'	      <meta http-equiv="Content-Type" content="application/ms-excel;charset=utf-8"/></head>'+c_EOL)
	Aadd(a_xml,'   <body>'+c_EOL)
	Aadd(a_xml,'   '+c_EOL)
	Aadd(a_xml,'   <style type="text/css">	'+c_EOL)
	Aadd(a_xml,'   td.cabeca  {	font-size: 10px;     	'+c_EOL)
	Aadd(a_xml,'   				font-family: verdana,tahoma,arial,sans-serif;     	'+c_EOL)
	Aadd(a_xml,'   				color:#FFFFFF;     	'+c_EOL)
	Aadd(a_xml,'   				border-width: 1px;     	'+c_EOL)
	Aadd(a_xml,'   				padding: 0px;     	'+c_EOL)
	Aadd(a_xml,'   				border-style:solid ;     	'+c_EOL)
	Aadd(a_xml,'   				border-color: gray;     	'+c_EOL)
	Aadd(a_xml,'   				-moz-border-radius: ; 	}	'+c_EOL)
	Aadd(a_xml,'   td.tabela{	font-size: 10px;     	'+c_EOL)
	Aadd(a_xml,'   				font-family: verdana,tahoma,arial,sans-serif;     	'+c_EOL)
	Aadd(a_xml,'   				border-width: 1px;     	'+c_EOL)
	Aadd(a_xml,'   				border-style:solid ;     	'+c_EOL)
	Aadd(a_xml,'   				border-color: gray;     	'+c_EOL)
	Aadd(a_xml,'   				padding: 0px;'+c_EOL)
	Aadd(a_xml,'     				text-align:center;'+c_EOL)
	Aadd(a_xml,'   				-moz-border-radius: ; 	}'+c_EOL)
	Aadd(a_xml,'   td.subitem {	font-size: 10px;     	'+c_EOL)
	Aadd(a_xml,'   				font-family: verdana,tahoma,arial,sans-serif;     	'+c_EOL)
	Aadd(a_xml,'   				border-width: 1px;     	'+c_EOL)
	Aadd(a_xml,'   				border-style:solid ;     	'+c_EOL)
	Aadd(a_xml,'   				border-color: gray;     	'+c_EOL)
	Aadd(a_xml,'   				padding: 0px;'+c_EOL)
	Aadd(a_xml,'     				text-align:center;'+c_EOL)
	Aadd(a_xml,'   				-moz-border-radius: ; 	}'+c_EOL)
	Aadd(a_xml,'   </style>'+c_EOL)
	Aadd(a_xml,'   <font face=verdana,tahoma,arial,sans-serif size=3 color="#000066"><b>FTI - Relatorio de Conferencia de APROVADOR - CT2</b></font>'+c_EOL)
	Aadd(a_xml,'   <table>'+c_EOL)
	Aadd(a_xml,'	<tr>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Lote</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Sub Lote</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Nr. Doc.</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Linha</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Data</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Tipo Lancamento</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Cta.Debito</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Desc. Conta</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>USGAAP Deb.</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Desc. USGAAP Debito</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>CCusto Deb.</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Desc. CC Deb.</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>USGAAP CC Deb.</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Desc. USGAAP CC Deb.</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Cta.Credito</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Desc Conta</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>USGAAP Cred</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Desc USGAAP Credito</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>CCusto Cred.</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Desc. CC Credito</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>USGAAP CC Credito</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Desc. USGAAP CC Credito</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Valor</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Historico</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Feito por (Usuแrio)</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Aprovado Por(usuแrio)</b></td>'+c_EOL)
	Aadd(a_xml,'	   					<td class=cabeca bgcolor=#0000CD><b>Tipo Saldo</b></td>'+c_EOL)
	Aadd(a_xml,'   	</tr>  '+c_EOL)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณrdxml     บAutor  ณAlexandre Sousa     บ Data ณ  07/25/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณInclui o rodape do arquivo excel.                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function rdxml()

	Aadd(a_xml, '  <TR></TR>')

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

//	Aadd(a_xml, "   <tr>"+c_EOL)
//	Aadd(a_xml, "	   					<td class=tabela >"+Alltrim(a_dados[1])+"-"+GetAdvFval('CB1', 'CB1_NOME', xFilial('CB1')+a_dados[1], 1, '')+"</td>"+c_EOL)
//	Aadd(a_xml, "	</tr>"+c_EOL)

/*
   @nLin,a_pos[01] PSAY 
   @nLin,a_pos[02] PSAY 
   @nLin,a_pos[03] PSAY 
   @nLin,a_pos[04] PSAY 
   @nLin,a_pos[05] PSAY 
   @nLin,a_pos[06] PSAY 
   @nLin,a_pos[07] PSAY 
   @nLin,a_pos[08] PSAY 
   @nLin,a_pos[09] PSAY 
   @nLin,a_pos[10] PSAY 
   @nLin,a_pos[11] PSAY 
   @nLin,a_pos[12] PSAY 
   @nLin,a_pos[13] PSAY 
   @nLin,a_pos[14] PSAY 
   @nLin,a_pos[15] PSAY 
   @nLin,a_pos[16] PSAY 
   @nLin,a_pos[17] PSAY 
   @nLin,a_pos[18] PSAY 
   @nLin,a_pos[19] PSAY 

*/

	Aadd(a_xml, "   <tr>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>'"+QRY->CT2_LOTE+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>'"+QRY->CT2_SBLOTE+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>'"+QRY->CT2_DOC+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>'"+QRY->CT2_LINHA+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+DTOC(STOD(QRY->CT2_DATA))+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+Iif(QRY->CT2_DC = '3', "Partida Dobrada", Iif(QRY->CT2_DC = '1', "Debito", "Credito"))+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+Iif(empty(QRY->CT2_DEBITO), '   -',alltrim(QRY->CT2_DEBITO))+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+QRY->DESCDEBITO+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+QRY->GAPDEB+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+QRY->DESCGAPD+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+QRY->CT2_CCD+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+QRY->DESCCTTA+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+alltrim(QRY->CCDGAP)+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+alltrim(QRY->DCCDGAP)+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+Iif(empty(QRY->CT2_CREDIT), '   -', ALLTRIM(QRY->CT2_CREDIT))+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+QRY->DESCCRED+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+QRY->GAPCRE+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+QRY->DESCGAPC+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+QRY->CT2_CCC+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+QRY->DESCCTTB+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+alltrim(QRY->CCCGAP)+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+alltrim(QRY->DCCCGAP)+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+Transform(QRY->CT2_VALOR, "@E 9,999,999.99")+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+QRY->CT2_HIST+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+SubStr(QRY->CT2_ORIGEM,33,15)+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+QRY->CT2_USRCNF+"</td>"+c_EOL)
	Aadd(a_xml, "	   					<td class=tabela bgcolor=#FFFFFF>"+QRY->CT2_TPSALD+"</td>"+c_EOL)
	Aadd(a_xml, "	</tr>"+c_EOL)

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
