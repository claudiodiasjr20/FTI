#Include "Protheus.Ch"
#Include "TopConn.Ch"

//******************************************************************************************
// Programa:	ATU_oanda
// Data:		01/08/2015
// Objeto:		Atualiza da Corporation (ONADA)
// Uso:			Modulos Financeiro
//						Protheus 11
// Autor:		Andre Salgado / INTRODE Integrated Solutions
//*******************************************************************************************
/*
Arquivo .CSV(Carteira Desconto)
vazio	curcode	cddate1	cddate2	cdrate	trtype
AED	01/07/2015	31/12/2025	3,67376	A
AED	20/07/2015	31/12/2025	3,673	D
AED	01/07/2015	31/12/2025	3,673	H

Coluna 01 = vazio
Coluna 02 = Pais
Coluna 03 = Data
Coluna 04 = Data
Coluna 05 = Taxa
Coluna 06 = Tipo de Taxa
*/
//"D" podemos entender que é a diária, assim como "H" é a histórica e a "A" a média 

User Function AtuOnada

Local aAmb      := GetArea()
Local cTipo     := 'Arquivos Textos (*.CSV)     | *.CSV | '
Local oFont     := TFont():New("Tahoma",,-11,.F.,,,,,.F.)
Local oDlg      := MSDialog():New(10,10,300,500,"Importa a Taxa da Corporação",,,,,,,,,.T.)
Local oSay1     := TSay():New(2,2,{|| "Esta rotina tem por função importar arquivo .CSV" },oDlg,,oFont,,,,)
Local oSay2     := TSay():New(3,2,{|| "Obs1: .CSV = Excel(separado por vírgulas)" },oDlg,,oFont,,,,)
Local oSay3     := TSay():New(4,2,{|| "Obs2: Sera importado do Planilha moeda 'BRL' " },oDlg,,oFont,,,,)
Local oSay4     := TSay():New(5,2,{|| "Obs3: 'D' Diario / 'H' Historica / 'A' Media " },oDlg,,oFont,,,,)
Local oBtnOK    := TButton() :New(100,130,"Gerar" ,oDlg,{|| rptstatus({|| GeraCSV(nGet1:=cGetFile(cTipo, 'Selecao de Arquivos', 1, 'C:\', .F., ,.F., .T. ))}) },50,15,,,,.T.)
Local oBtnClose := TButton() :New(100,180,"Fechar",oDlg,{||oDlg:End()},50,15,,,,.T.)

/*
cTexto := "Importação arquivo .CSV, aonde na COLUNA(R), podemos ter estas ações:" + CHR(13)+CHR(10)
cTexto += "1  -  Entrada Titulo Transferido para Desconto" + CHR(13)+CHR(10)
cTexto += "2  -  Baixa da Descontada" + CHR(13)+CHR(10)
cTexto += "5  -  Transferencia p/Cart.Imposto - SEM geração de Titulo, SEM atualizar Fluxo de Caixa" + CHR(13)+CHR(10)
cTexto += "6  -  Transferencia p/Cart.Administrativa - SEM geração de Titulo, SEM atualizar Fluxo de Caixa" + CHR(13)+CHR(10)
cTexto += "7  -  Baixa da Normal" + CHR(13)+CHR(10)
cTexto += "B  -  Lançar SE5 (P) Valor da planilha, informada do CSV e no BANCO" + CHR(13)+CHR(10)+ CHR(13)+CHR(10)

cTexto += "H  -  Transferencia p/SERASA - COM geração de Titulo, para enviar ao Serasa" + CHR(13)+CHR(10)
cTexto += "S  -  Transferencia p/SERASA - SEM geração de Titulo, não precisa enviar Serasa" + CHR(13)+CHR(10)
cTexto += "Obs. Para gerar esta ação: PRECISA TER SALDO NO TITULO, Nao pode ter BAIXA Parcial, SITUAÇÃO do Titulo precisa estar '0/1'"+ CHR(13)+CHR(10)+ CHR(13)+CHR(10)

cTexto += "D  -  Estorno da DESCONTADA / Lancto Mov.Bancaria retornando Valor p/ Banco, conforme detalhado:" + CHR(13)+CHR(10)
cTexto += "   (a)Localizar Titulo SE1, se for DESCONTADA (2), fazer lançamento SE5 - (R) com valor E1_SALDO e Dados do Banco que estiver no Titulo SE1"+ CHR(13)+CHR(10)
cTexto += "   (b)Localizar Titulo SE1, se for DESCONTADA (2) será Transferido para Carteira (0) e deixar os dados Bancarios, vazios."+ CHR(13)+CHR(10)
cTexto += "   (c)Lancar SE5 - (P) Valor da planilha, informada do CSV e no BANCO, selecionado no Parametro do CSV."+ CHR(13)+CHR(10)
//	AVISO("ATENCAO",cTexto,{"OK"})
MsgInfo(cTexto)
*/

oDlg:Activate(,,,.T.,,,)


Return



Static Function GeraCSV(cArq)

Private cPath	:= cArq //"C:\temp\alt_cartdesc.csv"
Private nArquivo:= FT_FUSE(cPath)
Private nTotRec := FT_FLASTREC()
Private cLinha 	:= ""
//Private cPerg   := "X_RFIN02"
//mv_par01 = Abrir arquivo ? (C=99)
//mv_par02 = Banco ? (C=3) (Consulta=SA6) (Help=Selecionar o Banco Bradesco conta DESCONTO, da Empresa.)
//mv_par03 = Agencia ? (C=5)
//mv_par04 = Conta ? (C=10)
//mv_par05 = Serie Titulo ? (C=3) (Formato=@!)
//mv_par06 = Data Movimentacao ? (D=8)



If File(cPath)
	If MsgYesNo("Deseja Processar o Arquivo: " + cPath )
		Processa({|| PROCARQ() }, "Processando Arquivo...",,.T.)
		MsgInfo("Processamento concluído!")
	Else
		FClose(nArquivo)
		Alert("Processamento cancelado!")
	EndIf
Else
	Alert("Arquivo não encontrado!")
EndIf

Return




Static Function PROCARQ()

Local nI := 1
Local aResult := {}
Local cVariavel := ""
Local cTransfNum:= ""
Local cTitulo := ""
Local cParcela:= ""
Local cStatus := ""
Local nJuros  := 0
Local nDescont:= 0
Local nValliq := 0
Local nSALATUA:= 0


//txt****************************************************************
Local aRet
Local nCount
// Para retornar a origem da função: FULL, USER, PARTNER, PATCH, TEMPLATE ou NONE
Local aType
// Para retornar o nome do arquivo onde foi declarada a função
Local aFile
// Para retornar o número da linha no arquivo onde foi declarada a função
Local aLine
// Para retornar a data do código fonte compilado
Local aDate
// Para retornar a hora do código fonte compilado
Local aTime
Local cArq, cTxt
Local nHdl
Local cLinha


Local aBaixa   := {}
Local n    := 1
Local cTime := SubStr(Time(),1,2)+SubStr(Time(),4,2)+SubStr(Time(),7,2) //13:08:01


FT_FGOTOP()
ProcRegua(nTotRec)

cTitBxArq:= ""
dData	:= ctod("  /  /  ")
nValM_A	:= 0		//Compra
nValM_D	:= 0		//Venda
nValM_H	:= 0 		//Media


While (!FT_FEOF())
	cLinha := " "
	cLinha := FT_FREADLN()
	
	aLinha := {}
	aLinha := Separa(cLinha,";")

	IncProc("Codigo: " + aLinha[3])
	dbSelectArea("SE1")
//	dbSetOrder(1) //FILIAL+PREFIXO+NUM

	If !Empty(aLinha[2]) .and. val(aLinha[5]) > 0 //.and. aLinha[6] $ "A/H"


		If	aLinha[02] ='BRL' 	//Seleciona o Valor Taxa Brasil
		
			dData	:= Ctod(aLinha[03])

			IF aLinha[6] = "A"		//Compra
				nValM_A	:= VAL(StrTran(aLinha[05],",","."))
			ElseIf aLinha[6] = "D"	//Venda
				nValM_D	:= VAL(StrTran(aLinha[05],",","."))
			ElseIf aLinha[6] = "H"	//Venda
				nValM_H	:= VAL(StrTran(aLinha[05],",","."))
			Endif			

		Endif
		
	Endif


	ProcessMessages()
	FT_FSKIP(1)
EndDo


//Grava dados:
//GravaDados()		//Do Dia
nDiasReg	 := 30	//Projeta proximos 30 dias

For mPass 	 := nDiasReg to 0 step -1				//Seleciona os Ultimos 15 Dias em JOB. Períodos muito grande numa economia estável causa distorções
	dDataRef := dData + mPass

Next


Return
                       


//Grava dados:
Static Function GravaDados()

DbSelectArea("SM2")						//Grava Moedas
SM2->(DbSetorder(1))

//Grava no Banco de Dados do Sistema - SM2
If SM2->(DbSeek(Dtos(dData)))
	Reclock('SM2',.F.)
Else
	Reclock('SM2',.T.)
	SM2->M2_DATA	:= dData
EndIf
                    
//SM2->M2_MOEDA3	:= nValM_A		//Media
//SM2->M2_MOEDA4 	:= nValM_D		//Diaria
//SM2->M2_MOEDA5	:= nValM_H		//Historica
//SM2->M2_INFORM	:= "S"
MsUnlock('SM2')

Return
