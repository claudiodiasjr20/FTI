#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � FTIVerTAB| Autor � Claudio Dias Junior (Focus Consultoria)  | Data � 26/01/15 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Verifica de tabelas do Arquivo ".CSV"                                         ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� Nil                                                                     		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI                                                                     		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

User Function FTIVerTAB()
             
	Local oDlg
	Local c_Title 		:= OemToAnsi("Verifica utiliza��o das tabelas")
	Local n_Opca 		:= 0
	Local a_CA			:= { OemToAnsi("Confirma"), OemToAnsi("Abandona")}
	Local a_Says		:= {}
	Local a_Buttons		:= {}
	Local c_Perg		:= "FTITAB"
	Private l_Ret		:= .T.
	Private a_RelDiver	:= {}  // Array com divergencias

	ValidPerg(c_Perg)	
	
	c_Texto	:= "Este programa tem como objetivo verificar no Microsiga"
	aAdd(a_Says, OemToAnsi(c_Texto)) 		
	c_Texto	:= "utiliza��o das tabelas do arquivo .CSV"
	aAdd(a_Says, OemToAnsi(c_Texto)) 	
	c_Texto	:= ""
	aAdd(a_Says, OemToAnsi(c_Texto)) 	
	aAdd(a_Buttons, { 1,.T.,{|o| n_Opca:= 1, If( .T., o:oWnd:End(), n_Opca:=0 ) }} )
	aAdd(a_Buttons, { 2,.T.,{|o| o:oWnd:End() }} )
	aAdd(a_Buttons, { 5,.T.,{|o| Pergunte(c_Perg, .T.) }} )
	FormBatch( c_Title, a_Says, a_Buttons ,,220,380)
	
	If n_Opca == 1
		Processa({|lend| l_Ret := fGetArq()},"Verificando os dados... Por favor, aguarde.")
		If l_Ret
			fExpCsv()
			MsgInfo("Verifica��o finalizada com sucesso!", "informativo")
		Endif
	Else
		MsgStop("Verifica��o Cancelada!","Abortado")
	Endif

Return Nil

//********************************************************************************************************************************************************//
               
/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fGetArq  | Autor � Claudio Dias Junior (Focus Consultoria)  | Data � 26/01/15 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Organiza dados contidos no arquivo CSV para importa��o no Microsiga.          ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� Nil                                                                     		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI                                                                     		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fGetArq()

Local 	a_LinCabec 	:= ""  
Local 	l_Continua 	:= .T.  
Local 	c_PathFile	:= AllTrim(MV_PAR01) + ".CSV" // Local do arquivo a ser importado
Private a_Dados		:= {}

//----------------------------------//
//   Verifico se o arquivo existe   //
//----------------------------------//
If !File( c_PathFile )
	MsgStop( "N�o foi poss�vel localizar o arquivo: " + AllTrim( c_PathFile ) )
	Return .F.
EndIf

//------------------------------------//
//   Declarando colunas do arquivo    //
//------------------------------------//
Private n_ARQUIVO	:= 0

//-------------------------------------------//
//   Variaveis para cria��o do arquivo       //
//-------------------------------------------//
Private nHdlPrv		:= 0
Private cArquivo        

FT_FUse(c_PathFile)			// Abre o arquivo passado no parametro
Ft_FGoTop()					// Vai para a primeira linha
ProcRegua(Ft_fLastRec()) 	// Numero de registros a processar

//-------------------------------------------//
//    Monta o cabecalho do arquivo           //
//-------------------------------------------//
a_LinCabec 	:= U_GetArr(FT_FReadln(), ";", .T.)
                                               
//---------------------------------------------------------------//
//   Valida se todos os campos obrigatorios estao no arquivo     //
//---------------------------------------------------------------//
n_ARQUIVO	:= aScan(a_LinCabec, "ARQUIVO"	)

//-------------------------------------------------------//
// VALIDA��O DO FORMATO DO ARQUIVO - VERIFICA COLUNAS    //
//-------------------------------------------------------//
If n_ARQUIVO == 0
	l_Continua := .F.
	MsgStop("A coluna X3_ARQUIVO n�o foi localizada no arquivo.", "I N C O N S I S T � N C I A")
Endif

If !l_Continua
	Return .F.
Endif

//----------------------------------------------------------//
//   Avanca para o primeiro registro de dados do arquivo    //
//----------------------------------------------------------//
FT_FSkip()

While !FT_FEof()
	
	IncProc()
	
	aAdd(a_Dados, U_GetArr(FT_FReadln(), ";0;0;", .T.) )
	n_MaxDados 	:= Len(a_Dados)+1

//----------------------------------//	
//  Avanca para o proximo registro  //
//----------------------------------//
	FT_FSkip() 
	
EndDo

//-------------------//
//  Fecha o arquivo  //
//-------------------//
FT_FUse() 
          
//---------------------------------------------------------------------------------//
//  Fun��o que ir� efetuar efetuar a inclus�o na tabela de planejamento de vendas  //
//---------------------------------------------------------------------------------//
l_Ret := fVerTabelas()

Return .T.

//*********************************************************************************************************************************************************//
                                                                                                 
/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fIncPlan | Autor � Claudio Dias Junior (Focus Consultoria)  | Data � 26/01/15 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Fun��o que ir� efetuar a inclus�o do planejamento de vendas.                  ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� Nil                                                                     		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI                                                                     		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fVerTabelas()

Local c_NomeTAB := ""

aAdd(a_RelDiver, { "ARQUIVO" + ";" + "EXISTE" + ";" + "QTD_REGISTRO" } )

For i := 1 To Len(a_Dados)

	c_NomeTAB := AllTrim(a_Dados[i][1]) + SM0->M0_CODIGO + "0"
	
	If U_ExistTAB( c_NomeTAB )
		aAdd(a_RelDiver, { c_NomeTAB + ";" + "Sim" + ";" + Transform(fGetQtd(c_NomeTAB), "999,999,999,999")} )
	Else
		aAdd(a_RelDiver, { c_NomeTAB + ";" + "N�o" + ";" + "0"} )
	EndIf

Next i

Return Nil

//*********************************************************************************************************************************************************//

Static Function fGetQtd(c_NomeTAB)

Local n_Qtd 	:= 0
Local c_QryCnt 	:= ""
                
c_QryCnt := "SELECT COUNT(*) AS QTDREG FROM "+c_NomeTAB+" AS RESULT "
MEMOWRITE("FTIVerTAB.SQL",c_QryCnt)
c_QryCnt := ChangeQuery(c_QryCnt)

If Select("FTIVerTAB") > 0
	FTIVerTAB->(DbCloseArea())
EndIf                  

TCQUERY c_QryCnt NEW ALIAS "FTIVerTAB"

n_Qtd := FTIVerTAB->QTDREG

Return n_Qtd

//*********************************************************************************************************************************************************//

Static Function fExpCsv()

Local c_Arquivo := U_fCriaArq( a_RelDiver, "FTI_"+SM0->M0_CODIGO, "", ".csv" )     

MsgInfo( "Arquivo " + c_Arquivo + " gerado com sucesso!", "A T E N � � O" )

Return Nil

//*********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  �ValidPerg | Autor � Claudio Dias Junior (Focus Consultoria)  | Data � 26/01/15 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Fun��o respons�vel em criar grupo de pergunta no SX1.                         ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� c_Perg => Grupo de pergunta a ser criado                                      ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI                                                                     		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/
 
Static Function ValidPerg(c_Perg)

Local a_AreaATU	:= GetArea()
Local a_Regs 	:= {}
Local i			:= 0
Local j			:= 0

c_Perg := c_Perg + Replicate( " ", 10 - Len(c_Perg) )

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(a_Regs,{c_Perg,"01","Caminho c/ nome do arquivo(s/.CSV)","","","MV_CH1","C",95,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})

DbSelectArea("SX1")
DbSetOrder(1)

For i := 1 To Len(a_Regs)
	If !SX1->(DbSeek(c_Perg+a_Regs[i,2], .F.))
		RecLock("SX1", .T.)
		For j := 1 To FCount()
			If j <= Len(a_Regs[i])
				FieldPut(j,a_Regs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next i

RestArea(a_AreaATU)

Return Nil

//*********************************************************************************************************************************************************//