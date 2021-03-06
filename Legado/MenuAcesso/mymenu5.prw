/*����������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa  | MyMenu5.PRW    � Autor � Flavio Valentin  � Data � 04/06/14 ���
��������������������������������������������������������������������������Ĵ��
���Descricao � Relat�rio de usuarios cadastrados no sistema.               ���
��������������������������������������������������������������������������Ĵ��
���Parametros� Nenhum.                                                     ���
��������������������������������������������������������������������������Ĵ��
���Retorno   � Nil.                                                        ���
��������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                            ���
���������������������������������������������������������������������������ٱ�
���              |        �                                                ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
����������������������������������������������������������������������������*/
User Function MyMenu5()

	Local 	oDlg
	Local 	c_Title 	:= OemToAnsi("Listagem dos usu�rios.")
	Local 	n_Opca 		:= 0
	Local 	a_CA		:= { OemToAnsi("Confirma"), OemToAnsi("Abandona")}
	Local 	a_Says		:= {}
	Local 	a_Buttons	:= {}

	Private c_ArqExcel	:= ""

	c_Texto	:= "Este programa tem como objetivo gerar uma lista com "
	aAdd(a_Says, OemToAnsi(c_Texto)) 		
	c_Texto	:= "informa��es dos usu�rios."
	aAdd(a_Says, OemToAnsi(c_Texto)) 	
	c_Texto	:= "A gera��o dessa lista pode demorar alguns minutos..."
	aAdd(a_Says, OemToAnsi(c_Texto))
	aAdd(a_Buttons, { 1,.T.,{|o| n_Opca:= 1, If( .T., o:oWnd:End(), n_Opca:=0 ) }} )
	aAdd(a_Buttons, { 2,.T.,{|o| o:oWnd:End() }} )
	FormBatch( c_Title, a_Says, a_Buttons ,,220,380)

	If n_Opca == 1

		Processa({|lend| fListUsr()}, "Processando Lista... Por favor aguarde...")

		MsgInfo("Arquivo gerado em: "+c_ArqExcel,"Conclu�do com sucesso.")

	Else

		MsgStop("Lista Cancelada!","Abortado")

	Endif

Return Nil                         

/************************************************************************************************/

Static Function fListUsr()

	Private a_Users	:= AllUsers()

	//GERA ARQUIVO TEMPORARIO PARA MANDAR PRO EXCEL
	c_AliasTR	:= "TRB"
	a_Struct 	:= {}
	aAdd(a_Struct,{"ID"	  		,"C",06,0})
	aAdd(a_Struct,{"LOGIN"		,"C",15,0})
	aAdd(a_Struct,{"NOME"		,"C",30,0})
	aAdd(a_Struct,{"DVALID"		,"D",08,0})
	aAdd(a_Struct,{"EXPSENHA"	,"N",03,0})
	aAdd(a_Struct,{"DEPTO"		,"C",30,0})
	aAdd(a_Struct,{"CARGO"		,"C",30,0})
	aAdd(a_Struct,{"EMAIL"		,"C",130,0})
	aAdd(a_Struct,{"BLOQ"		,"C",03,0})
	aAdd(a_Struct,{"ALTDABASE"  ,"C",03,0})
	aAdd(a_Struct,{"DIASVOLTA"  ,"N",04,0})
	aAdd(a_Struct,{"DIASAVANCA" ,"N",04,0})
	
	If Select("TRB") > 0
		TRB->(DbCloseArea())
	Endif
	
	c_Arq1 := CriaTrab(a_Struct, .T.)
	DbUseArea(.T.,, c_Arq1, "TRB", .T., .F.)
	
	ProcRegua(Len(a_Users))

	For i := 1 To Len(a_Users)
	
		IncProc()
		DbSelectArea("TRB")
		RecLock("TRB", .T.)
		TRB->ID			:= a_Users[i][1][1]
		TRB->LOGIN		:= a_Users[i][1][2]
		TRB->NOME		:= a_Users[i][1][4]
		TRB->DVALID		:= a_Users[i][1][6]
		TRB->EXPSENHA	:= a_Users[i][1][7]
		TRB->DEPTO 		:= a_Users[i][1][12]
		TRB->CARGO 		:= a_Users[i][1][13]
		TRB->EMAIL		:= a_Users[i][1][14]
		TRB->BLOQ		:= IIF(a_Users[i][1][17], "Sim", "Nao") //Coluna acrescenta por Flavio Valentin, conforme solicitacao do Ricardo Malaquias (17/07/13)
		TRB->ALTDABASE  := Iif(a_Users[i][1][23][1],"Sim", "Nao")//Coluna acrescenta por Flavio Valentin, conforme solicitacao do Ricardo Malaquias (17/07/13)
		TRB->DIASVOLTA  := a_Users[i][1][23][2]//Coluna acrescenta por Flavio Valentin, conforme solicitacao do Ricardo Malaquias (17/07/13)
		TRB->DIASAVANCA := a_Users[i][1][23][3]//Coluna acrescenta por Flavio Valentin, conforme solicitacao do Ricardo Malaquias (17/07/13)
		MsUnLock()
		
	Next i

	DbSelectArea("TRB")
	c_ArqExcel := __RELDIR+"Usuarios_"+DTOS(MsDate())+Replace(Time(),":","")+".xls"
	Copy To &c_ArqExcel

Return Nil