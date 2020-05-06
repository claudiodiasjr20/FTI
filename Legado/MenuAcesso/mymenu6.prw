#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"                                                                        
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"                                      
#INCLUDE "TBICODE.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ U_MyMenu6() |  Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 22/11/17  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatório de usuarios cadastrados no sistema.							 	 ´±±
±±³			   Obs: Este Fonte não esta em Produção, apenas no Compila - Chamado 39078		 ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil				                                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil 				                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function MyMenu6()   

	Local 	oDlg
	Local 	c_Title 	:= OemToAnsi("Listagem dos usuários.")
	Local 	n_Opca 		:= 0
	Local 	a_CA		:= { OemToAnsi("Confirma"), OemToAnsi("Abandona")}
	Local 	a_Says		:= {}
	Local 	a_Buttons	:= {}

	Private c_ArqExcel	:= ""

	c_Texto	:= "Este programa tem como objetivo gerar uma lista com "
	aAdd(a_Says, OemToAnsi(c_Texto)) 		
	c_Texto	:= "informações dos usuários. - Versão 2.0 - 20171122."
	aAdd(a_Says, OemToAnsi(c_Texto)) 	
	c_Texto	:= "A geração dessa lista pode demorar alguns minutos..."
	aAdd(a_Says, OemToAnsi(c_Texto))
	aAdd(a_Buttons, { 1,.T.,{|o| n_Opca:= 1, If( .T., o:oWnd:End(), n_Opca:=0 ) }} )
	aAdd(a_Buttons, { 2,.T.,{|o| o:oWnd:End() }} )
	FormBatch( c_Title, a_Says, a_Buttons ,,220,380)

	If n_Opca == 1

		Processa({|lend| fExcelXLS()}, "Processando Lista... Por favor aguarde...")

		MsgInfo("Arquivo gerado em: "+c_ArqExcel,"Concluído com sucesso.")

	Else

		MsgStop("Lista Cancelada!","Abortado")

	Endif

Return Nil                         

//**********************************************************************************************************************************************************//
                                                  
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fExcelXLS  |  Autor ³ Tiago Dias (Focus Consultoria)  |  Data ³ 22/01/16 	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta o Excel em formato colorido                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fExcelXLS()

Local oExcel 		:= FWMSEXCEL():New() 
Local c_Dia 		:= STRTRAN(DTOC(MSDATE()),"/","_")+"_"+Replace(Time(),":","_")
Local c_Arq			:= ""
Local c_ExtArq	 	:= ".xls"
Local c_Path 		:= cGetFile("\", "Selecione o Local para salvar o Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY)

Private a_Users		:= AllUsers() //Obtem Informações do Usuários

If !ExistDir( c_Path )
	c_Path 	:= __RELDIR                                      
EndIf
		
//Configuração Impressão Excel 
oExcel:SetTitleSizeFont	(13)		// Define o tamanho para a fonte do estilo do Título
oExcel:SetTitleBold		(.T.)		// Define se a fonte terá a configuração "Negrito" no estilo do Título 
oExcel:SetTitleFrColor	("#0000FF")	// Cor do Texto da Primeira Linha - Título
oExcel:SetTitleBgColor	("#FFFFFF") // Cor de Fundo da Primeira Linha - Título
oExcel:SetFrColorHeader	("#FFFFFF") // Texto do Titulo das Colunas
oExcel:SetBgColorHeader	("#4682B4") // Background do Titulo das Colunas
oExcel:SetLineBGColor	("#B8CCE4") // Background das linhas de texto
oExcel:Set2LineBGColor	("#DBE5F1")	// Background das linhas de texto 	
                              
//Gerando o Arquivo Excel
c_DataQ := DTOS(dDataBase) 

oExcel:AddworkSheet	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ 			 			)
oExcel:AddTable 	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ 				  		)
oExcel:AddColumn	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ , "ID"			,1,1)
oExcel:AddColumn	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ , "LOGIN"			,1,1)
oExcel:AddColumn	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ , "NOME"			,1,1)
oExcel:AddColumn	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ , "DVALID"		,1,1)
oExcel:AddColumn	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ , "EXPSENHA"		,1,1)
oExcel:AddColumn	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ , "DEPTO"		   	,1,1)
oExcel:AddColumn	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ , "CARGO"			,1,1)
oExcel:AddColumn	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ , "EMAIL"			,1,1)
oExcel:AddColumn	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ , "BLOQ"	 		,1,1)
oExcel:AddColumn	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ , "ALTDABASE"		,1,1)
oExcel:AddColumn	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ , "DIASVOLTA"		,1,1)
oExcel:AddColumn	( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ , "DIASAVANCA"	,1,1)

ProcRegua(Len(a_Users))

For i := 1 To Len(a_Users)
                                   
	IncProc()

	c_id		:= a_Users[i][1][1]
	c_Login		:= a_Users[i][1][2]
	c_Nome		:= a_Users[i][1][4]
	c_DValid	:= a_Users[i][1][6]	
	c_ExpSenha	:= a_Users[i][1][7]	
	c_Depto		:= a_Users[i][1][12]
	c_Cargo		:= a_Users[i][1][13]
	c_Email		:= a_Users[i][1][14]
	c_Bloq		:= IIF(a_Users[i][1][17], "Sim", "Nao") 
	c_AltDB		:= Iif(a_Users[i][1][23][1],"Sim", "Nao")
	c_DiasVolt	:= a_Users[i][1][23][2]
	c_DiasAvan	:= a_Users[i][1][23][3]
	
	oExcel:AddRow ( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ, {	c_id, c_Login, c_Nome, c_DValid, c_ExpSenha, c_Depto, c_Cargo, c_Email, c_Bloq, c_AltDB, c_DiasVolt, c_DiasAvan} )
	
Next i

                                      
//- Linha em Branco
	oExcel:AddRow ( "Relatório_LstUsers" , "Relatório_LstUsers"+c_DataQ, {"","","","","","","","","","","",""} )

	MsUnLock()

	c_Arq := UPPER("USUARIOS_") + c_DataQ + "_" + Left(Time(),2) + SubStr(Time(),4,2) + Right(Time(),2)
	
	oExcel:Activate()
	oExcel:GetXMLFile(UPPER(c_Arq)+c_ExtArq)
	                                        
//- Move Arquivo para Pasta Relato do Usuário
	c_NovoArq	:= AllTrim(c_Path + UPPER(c_Arq) + c_ExtArq)          
	
	If __CopyFile( UPPER(c_Arq)+c_ExtArq, c_NovoArq )
		MsgInfo( "Relatório " + UPPER(c_Arq) + " gerado com sucesso no diretório: " + c_Path, "Relatório Listagem de Usuários" )     
		
		If ApOleClient("MsExcel")
			oExcelApp := MsExcel():New()
			oExcelApp:WorkBooks:Open( c_NovoArq )
			oExcelApp:SetVisible(.T.)
		EndIf
	Else
		MsgAlert( "Relatório não Gerado.", "Relatório Listagem de Usuários" )
	EndIf

//- Limpa variável Configuração Excel
	oExcel:= FWMSEXCEL():New() 
	oExcel:SetTitleSizeFont	(13)		// Define o tamanho para a fonte do estilo do Título
	oExcel:SetTitleBold		(.T.)		// Define se a fonte terá a configuração "Negrito" no estilo do Título 
	oExcel:SetTitleFrColor	("#0000FF")	// Cor do Texto da Primeira Linha - Título
	oExcel:SetTitleBgColor	("#FFFFFF") // Cor de Fundo da Primeira Linha - Título
	oExcel:SetFrColorHeader	("#FFFFFF") // Texto do Titulo das Colunas
	oExcel:SetBgColorHeader	("#4682B4") // Background do Titulo das Colunas
	oExcel:SetLineBGColor	("#B8CCE4") // Background das linhas de texto
	oExcel:Set2LineBGColor	("#DBE5F1")	// Background das linhas de texto 		

Return Nil

//**********************************************************************************************************************************************************//
