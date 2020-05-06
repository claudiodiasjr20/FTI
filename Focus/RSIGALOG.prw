#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ U_RSIGALOG() |  Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 27/01/15  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio dos registros do SigaLOG.				  						     ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil				                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil 				                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function RSIGALOG()   
                         
Local oDlg
Local a_AreaATU	:= GetArea()                                                  

Private c_Perg	:= "RSIGALOG"   	// Grupo de pergunta que sera criado no SX1
Private aStringP:= {}  				// Array dos textos em portugues
Private a_AllUsers	:= AllUsers()	// Array que retorna dados do Usuário
Private l_Ret	:= .F.

//Tela Inicial
Define MsDialog oDlg Title 'Relatório SIGA LOG - Vr 28-01a' From 7,10 To 15,55		Of oMainWnd              
@ 15 ,15  Say	'Esta Rotina tem como objetivo gerar um Relatório do SIGALOG'  		Of oDlg	Pixel  
@ 25 ,15  Say	'de acordo com o Usuário, Ambiente e a Data digitado pelo Usuário.' Of oDlg Pixel  
Define SButton From 40, 110 Type 01 Action ( l_Ret := .T. , oDlg:End()) 	Enable	Of oDlg   	
Define SButton From 40, 140 Type 02 Action ( l_Ret := .F. , oDlg:End()) 	Enable	Of oDlg   	
Activate MsDialog oDlg Center

If l_Ret
	ValidPerg(c_Perg)
	If !Pergunte(c_Perg,.T.)
		Return Nil
	EndIf   
	MsgRun("Processando, aguarde...", "Relatório SIGA LOG", {|| fMntQry()})
	Processa( {|| fExcelColor() } , "Gerando o relatório, aguarde...")
EndIf
    
RestArea(a_AreaATU)
                               
Return Nil 

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fMntQry   |     Autor ³ Tiago Dias (Focus Consultoria)   | 	Data ³ 13/01/15  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta a Query para selecionar os dados do relatorio.                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil		  		                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil   		    	                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fMntQry()

Local c_Query		:= 	"" 			   		// Query
Local c_QryCnt		:= 	"" 			   		// Count dos Registros para a Contagem do SetRegua
Local c_Chr			:= 	Chr(13)+Chr(10)     // Quebra linha da Query
Local c_FAcesso		:=	""					// Primeira Data de Acesso
Local c_LAcesso		:=	""					// Última Data de Acesso
Local c_Depart		:=	""					// Departamento do Usuário
Local c_CodUsr		:=	""					// Código do Usuário
Local c_Funcao		:=	""					// Função
Local c_NameFunc	:=	""					// Nome da Função
Local n_QtdAcesso	:=	0					// Quantidade de Acessos
Local c_User		:=	RetcodUsr()			// Usuario Corrente
Local c_PUser		:=	""                  // Usuarios Administradores

//Monta String de Usuarios Administradores
For i:= 1 To Len(a_AllUsers)
	If FwIsAdmin(a_AllUsers[i][1][1])
		c_PUser += IIF( i <> Len(a_AllUsers), "'"+a_AllUsers[i][1][1]+"',",  "'"+a_AllUsers[i][1][1]+"'") 
	EndIf
Next i 
c_PUser := AllTrim(LEFT(c_PUser, Len(c_PUser)-1))

//-----------------------------------------  1ª Query  ---------------------------------

c_Query := "SELECT 		CODUSR 					" + c_Chr
c_Query += "		, 	NOMUSR 					" + c_Chr
c_Query += "		, 	MODULO 					" + c_Chr
c_Query += "		, 	FUNCAO 					" + c_Chr
c_Query += "		, 	NOMFUN					" + c_Chr
c_Query += "		, 	AMBIENTE				" + c_Chr
c_Query += "		, 	MIN(DATA) AS F_ACESSO	" + c_Chr
c_Query += "		, 	MAX(DATA) AS L_ACESSO	" + c_Chr
c_Query += "		,	COUNT(*) QTDACESSOS 	" + c_Chr
c_Query += "FROM SIGALOG 						" + c_Chr
c_Query += "WHERE FUNCAO <> '' 					" + c_Chr

//------ Verifica Código do usuário ----------------------------------------------------

If AllTrim(MV_PAR01) <> ''
	c_Query += "AND  CODUSR  BETWEEN '"+ MV_PAR01 +"' AND '"+ MV_PAR02 +"'  " + c_Chr
EndIf

//------ Verifica Ambiente desejado ----------------------------------------------------

If AllTrim(MV_PAR03) <> ''
	c_Query += "AND  AMBIENTE IN ('"+UPPER(AllTrim(MV_PAR03))+"') 			" + c_Chr
EndIf

//------ Data dos acessos --------------------------------------------------------------

c_Query += "AND  DATA BETWEEN '"+DTOS(MV_PAR04)+"' AND '"+DTOS(MV_PAR05)+"' " + c_Chr   

//------ Verifica Se for Usuario do Grupo de Admin -------------------------------------
                            

If !(c_User $ c_PUser)
	c_Query += "AND	CODUSR NOT IN ("+c_PUser+") 							" + c_Chr   
EndIf    

//--------------------------------------------------------------------------------------


c_Query += "GROUP BY MODULO, CODUSR, AMBIENTE, NOMUSR, FUNCAO, NOMFUN		" + c_Chr
c_Query += "ORDER BY MODULO													" + c_Chr

//---------------------------------------  Fim - 1ª Query  -----------------------------
	
IF Select("RSIGALOG") > 0
	RSIGALOG->(dbCloseArea())
ENDIF

MemoWrite("RSIGALOG.SQL", c_Query)

TcQuery c_Query New Alias "RSIGALOG"	                              

Return Nil	

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fExcelColor  |  Autor ³ Tiago Dias (Focus Consultoria)  |  Data ³ 21/08/14 	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta o Excel em formato colorido                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fExcelColor()

Local oExcel 		:= FWMSEXCEL():New() 
Local c_Dia 		:= STRTRAN(DTOC(MSDATE()),"/","_")+"_"+Replace(Time(),":","_")
Local c_Arq			:= ""
Local c_ExtArq	 	:= ".xls"
Local c_Path 		:= cGetFile("\", "Selecione o Local para salvar o Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY)

If !ExistDir( c_Path )
	c_Path 	:= __RELDIR
EndIf
 
//Verificar o uso dessas definições
oExcel:SetTitleFrColor	("#0000FF")	// Cor do Texto da Primeira Linha - Título
oExcel:SetTitleBgColor	("#FFFFFF") // Cor de Fundo da Primeira Linha - Título
oExcel:SetFrColorHeader	("#FFFFFF") // Texto do Titulo das Colunas
oExcel:SetBgColorHeader	("#4682B4") // Background do Titulo das Colunas
oExcel:SetLineBGColor	("#B8CCE4") // Background das linhas de texto
oExcel:Set2LineBGColor	("#DBE5F1")	// Background das linhas de texto 	

c_DataQ := DTOS(dDataBase)

//Planilha de Parametros do Relatório
oExcel:AddworkSheet	( "Parametros_SIGALOG" , "Parametros_SIGALOG_" 			 )
oExcel:AddTable 	( "Parametros_SIGALOG" , "Parametros_SIGALOG_" 			 )
oExcel:AddColumn	( "Parametros_SIGALOG" , "Parametros_SIGALOG_" , "" , 1,1)
oExcel:AddColumn	( "Parametros_SIGALOG" , "Parametros_SIGALOG_" , "" , 1,1)
For n:=1 To Len(aStringP)
    
    c_PergSX1 := aStringP[n]
	DO CASE
	CASE n == 1
	    c_PrmtSx1 := mv_par01
	CASE n == 2
		c_PrmtSx1 := mv_par02
	CASE n == 3
		c_PrmtSx1 := mv_par03
	CASE n == 4
		c_PrmtSx1 := mv_par04
	CASE n == 5
		c_PrmtSx1 := mv_par05
	ENDCASE    
    
	oExcel:AddRow 	( "Parametros_SIGALOG" , "Parametros_SIGALOG_" , {c_PergSX1,c_PrmtSx1} )    
Next n 

//Planilha do Relatório
DbSelectArea("RSIGALOG")
RSIGALOG->(DbGoTop())

oExcel:AddworkSheet	( "Relatório_SIGALOG" , "Relatório_SIGALOG_"+c_DataQ 			 				)
oExcel:AddTable 	( "Relatório_SIGALOG" , "Relatório_SIGALOG_"+c_DataQ 							)
oExcel:AddColumn	( "Relatório_SIGALOG" , "Relatório_SIGALOG_"+c_DataQ , "CODIGO"	   			,1,1)
oExcel:AddColumn	( "Relatório_SIGALOG" , "Relatório_SIGALOG_"+c_DataQ , "NOME DO USUARIO"	,1,1)
oExcel:AddColumn	( "Relatório_SIGALOG" , "Relatório_SIGALOG_"+c_DataQ , "MODULO"				,1,1)
oExcel:AddColumn	( "Relatório_SIGALOG" , "Relatório_SIGALOG_"+c_DataQ , "DEPARTAMENTO"		,1,1)
oExcel:AddColumn	( "Relatório_SIGALOG" , "Relatório_SIGALOG_"+c_DataQ , "NOME DA FUNCAO"		,1,1)
oExcel:AddColumn	( "Relatório_SIGALOG" , "Relatório_SIGALOG_"+c_DataQ , "PERIODO DE ACESSO"	,1,1)
oExcel:AddColumn	( "Relatório_SIGALOG" , "Relatório_SIGALOG_"+c_DataQ , "ACESSOS"			,1,1)

While RSIGALOG->(!EOF()) 

//-- Transformando Data DD/MM/AAAA -----------------------------------------------------

	c_FAcesso	:=	Right(RSIGALOG->F_ACESSO,2) +"/"+ SubStr(RSIGALOG->F_ACESSO,5,2) +"/"+ Left(RSIGALOG->F_ACESSO,4)
	c_LAcesso	:=	Right(RSIGALOG->L_ACESSO,2) +"/"+ SubStr(RSIGALOG->L_ACESSO,5,2) +"/"+ Left(RSIGALOG->L_ACESSO,4)

//-- Busca Departamento do Usuário -----------------------------------------------------

	For i:= 1 To Len(a_AllUsers)
		If	a_AllUsers[i][1][1] == RSIGALOG->CODUSR
			c_Depart := a_AllUsers[i][1][12]
			i		 := Len(a_AllUsers)
		EndIf
	Next i

//--------------------------------------------------------------------------------------		

	c_CodUsr	:= RSIGALOG->CODUSR 		//Codigo do Usuario
	c_Mod		:= RSIGALOG->MODULO			//Modulo
	c_Funcao	:= RSIGALOG->FUNCAO			//Funcao
	c_NameFunc	:= RSIGALOG->NOMFUN			//Nome da Funcao
	n_QtdAcesso	:= RSIGALOG->QTDACESSOS		//Quantidade de acessos
	c_NUsu		:= UPPER(UsrFullName(c_CodUsr))
	c_Dep		:= IIF(AllTrim(c_Depart) == "","..:SEM INFORMAÇÃO:..",AllTrim(c_Depart))	
	c_NFunc		:= AllTrim(c_Funcao) + " - " + AllTrim(c_NameFunc)
	c_PAces		:= AllTrim(c_FAcesso) +" ATE "+ AllTrim(c_LAcesso)
	c_Acesso	:= Transform(n_QtdAcesso, "@E 999999999")
	
	oExcel:AddRow ( "Relatório_SIGALOG" , "Relatório_SIGALOG_"+c_DataQ, {c_CodUsr,c_NUsu,c_Mod,c_Dep,c_NFunc,c_PAces,c_Acesso} )

	RSIGALOG->(DbSkip())

EndDo

//Planilha do Relatório por Modulo
DbSelectArea("RSIGALOG")
RSIGALOG->(DbGoTop())

While RSIGALOG->(!EOF())

	c_ModAux := RSIGALOG->MODULO
	
	oExcel:AddworkSheet	( "Modulo_SIGALOG_"+c_ModAux , "Modulo_SIGALOG_"+c_ModAux 			 				)
	oExcel:AddTable 	( "Modulo_SIGALOG_"+c_ModAux , "Modulo_SIGALOG_"+c_ModAux 							)
	oExcel:AddColumn	( "Modulo_SIGALOG_"+c_ModAux , "Modulo_SIGALOG_"+c_ModAux , "CODIGO"	   		,1,1)
	oExcel:AddColumn	( "Modulo_SIGALOG_"+c_ModAux , "Modulo_SIGALOG_"+c_ModAux , "NOME DO USUARIO"	,1,1)
	oExcel:AddColumn	( "Modulo_SIGALOG_"+c_ModAux , "Modulo_SIGALOG_"+c_ModAux , "MODULO"			,1,1)
	oExcel:AddColumn	( "Modulo_SIGALOG_"+c_ModAux , "Modulo_SIGALOG_"+c_ModAux , "DEPARTAMENTO"		,1,1)
	oExcel:AddColumn	( "Modulo_SIGALOG_"+c_ModAux , "Modulo_SIGALOG_"+c_ModAux , "NOME DA FUNCAO"	,1,1)
	oExcel:AddColumn	( "Modulo_SIGALOG_"+c_ModAux , "Modulo_SIGALOG_"+c_ModAux , "PERIODO DE ACESSO"	,1,1)
	oExcel:AddColumn	( "Modulo_SIGALOG_"+c_ModAux , "Modulo_SIGALOG_"+c_ModAux , "ACESSOS"			,1,1)
	
	While RSIGALOG->(!EOF()) .And. RSIGALOG->MODULO == c_ModAux
	
	//-- Transformando Data DD/MM/AAAA -----------------------------------------------------
	
		c_FAcesso	:=	Right(RSIGALOG->F_ACESSO,2) +"/"+ SubStr(RSIGALOG->F_ACESSO,5,2) +"/"+ Left(RSIGALOG->F_ACESSO,4)
		c_LAcesso	:=	Right(RSIGALOG->L_ACESSO,2) +"/"+ SubStr(RSIGALOG->L_ACESSO,5,2) +"/"+ Left(RSIGALOG->L_ACESSO,4)
	
	//-- Busca Departamento do Usuário -----------------------------------------------------
	
		For i:= 1 To Len(a_AllUsers)
			If	a_AllUsers[i][1][1] == RSIGALOG->CODUSR
				c_Depart := a_AllUsers[i][1][12]
				i		 := Len(a_AllUsers)
			EndIf
		Next i
	
	//--------------------------------------------------------------------------------------		
	
		c_CodUsr	:= RSIGALOG->CODUSR 		//Codigo do Usuario
		c_Mod		:= RSIGALOG->MODULO			//Modulo
		c_Funcao	:= RSIGALOG->FUNCAO			//Funcao
		c_NameFunc	:= RSIGALOG->NOMFUN			//Nome da Funcao
		n_QtdAcesso	:= RSIGALOG->QTDACESSOS		//Quantidade de acessos
		c_NUsu		:= UPPER(UsrFullName(c_CodUsr))
		c_Dep		:= IIF(AllTrim(c_Depart) == "","..:SEM INFORMAÇÃO:..",AllTrim(c_Depart))	
		c_NFunc		:= AllTrim(c_Funcao) + " - " + AllTrim(c_NameFunc)
		c_PAces		:= AllTrim(c_FAcesso) +" ATE "+ AllTrim(c_LAcesso)
		c_Acesso	:= Transform(n_QtdAcesso, "@E 999999999")
		
		oExcel:AddRow ( "Modulo_SIGALOG_"+c_ModAux , "Modulo_SIGALOG_"+c_ModAux, {c_CodUsr,c_NUsu,c_Mod,c_Dep,c_NFunc,c_PAces,c_Acesso} )
		
		RSIGALOG->(DbSkip())
	
	EndDo 
EndDo
                                      
	MsUnLock()

	c_Arq := UPPER("RSIGALOG_")+c_DataQ+Replace(Time(),":", "")
	
	oExcel:Activate()
	oExcel:GetXMLFile(UPPER(c_Arq)+c_ExtArq)
	                                        
//- Move Arquivo para Pasta Relato do Usuário
	c_NovoArq := AllTrim(c_Path + UPPER(c_Arq) + c_ExtArq)         
	
	If __CopyFile( UPPER(c_Arq)+c_ExtArq, c_NovoArq )
		MsgInfo( "Relatório " + UPPER(c_Arq) + " gerado com sucesso no diretório: " + c_Path, "Relatório SIGA LOG" )
	Else
		MsgAlert( "Relatório não Gerado.", "Relatório SIGA LOG" )
	EndIf

//- Limpa variável Excel - Verificar o uso dessas definições
	oExcel:= FWMSEXCEL():New() 
	oExcel:SetTitleFrColor	("#0000FF")	// Cor do Texto da Primeira Linha - Título
	oExcel:SetTitleBgColor	("#FFFFFF") // Cor de Fundo da Primeira Linha - Título
	oExcel:SetFrColorHeader	("#FFFFFF") // Texto do Titulo das Colunas
	oExcel:SetBgColorHeader	("#4682B4") // Background do Titulo das Colunas
	oExcel:SetLineBGColor	("#B8CCE4") // Background das linhas de texto
	oExcel:Set2LineBGColor	("#DBE5F1")	// Background das linhas de texto 		

Return Nil

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ                                                                                                                                                            ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ValidPerg   |   Autor ³ Tiago Dias (Focus Consultoria)   |  	 Data ³ 21/08/14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Responsável em criar o SX1 com o Help.                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_Perg -> Grupo de perguntas a ser criado.                              		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function ValidPerg(c_Perg)

Local a_AreaATU := GetArea()
Local aHelpPor 	:= {}
Local aHelpEsp 	:= {}              
Local aHelpIng 	:= {}

Aadd( aHelpPor, "Informe o Usuário inicial para gerar o " )
Aadd( aHelpPor, "Relatório SIGA LOG.       			    " )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Usuário de: ?")

PutSx1(c_Perg,"01",aStringP[1],"","","mv_ch1","C",06,0,0,"G","","USR","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)                                             

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe a Usuário final para gerar o " )
Aadd( aHelpPor, "Relatório SIGA LOG.               	  " )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Usuário até: ?")

PutSx1(c_Perg,"02",aStringP[2],"","","mv_ch2","C",06,0,0,"G","","USR","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)                                             

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe o Ambiente para gerar o " )
Aadd( aHelpPor, "Relatório SIGA LOG.             " )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Ambiente: ?")

PutSx1(c_Perg,"03",aStringP[3],"","","mv_ch3","C",15,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)                                             

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe a Data inicial para gerar o " )
Aadd( aHelpPor, "Relatório SIGA LOG.            	 " )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Data de: ?")

PutSx1(c_Perg,"04",aStringP[4],"","","mv_ch4","D",08,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)                                             

aHelpPor :={} 
aHelpIng :={} 
aHelpEsp :={} 

Aadd( aHelpPor, "Informe a Data final para gerar o " )
Aadd( aHelpPor, "Relatório SIGA LOG.               " )

aHelpIng := aHelpEsp := aHelpPor 

Aadd(aStringP, "Data até: ?")

PutSx1(c_Perg,"05",aStringP[5],"","","mv_ch5","D",08,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelpPor,aHelpIng,aHelpEsp)                                             

RestArea(a_AreaATU)

Return Nil
//**********************************************************************************************************************************************************//