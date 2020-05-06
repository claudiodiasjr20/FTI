#include "TOPCONN.CH"
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MYMENU2  ³ Autor ³ Douglas Viegas Franca ³ Data ³ 05/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio do Menu dos usuarios.                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil => Nenhum                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil => Nenhum                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Erisom P. Tito³01/03/07³ Incluido as colunas de descricao dos acessos. ³±±
±±³              ³  /  /  ³                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MYMENU2()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//Parametro MV_XTPMENU onde 0=Por Usuário ou 1=Por Grupo (Default)
	Private l_GrpMenu	:= (GetMV("MV_XTPMENU", ,"1") == "1")
	Private n_TamUser	:= 25
	Private CbTxt		:= ""
	Private cDesc1      := "Relacao das liberacoes de acessos atraves do menu"
	Private cDesc2      := ""
	Private cDesc3      := "Ult. Rev.: 01/03/07"
	Private Cabec1 		:= ""
	Private Cabec2   	:= ""
	Private cPict       := ""
	Private lEnd      	:= .F.
	Private lAbortPrint	:= .F.
	Private limite    	:= 220
	Private tamanho	    := "G"
	Private nomeprog	:= "MYMENU2" // Coloque aqui o nome do programa para impressao no cabecalho
	Private nTipo		:= 18
	Private aReturn		:= { "Especifico", 1,"Faturamento", 1, 2, 1, "",1 }
	Private nLastKey	:= 0
	Private titulo 		:= "Relacao de acessos através do menu"
	Private nLin   		:= 80
	Private cbcont     	:= 00
	Private CONTFL     	:= 01
	Private m_pag      	:= 01
	Private imprime 	:= .T.
	Private wnrel      	:= "MYMENU2" // Coloque aqui o nome do arquivo usado para impressao em disco
	Private n_TotReg	:= 0
	Private c_Perg		:= IIF(l_GrpMenu, "MYXNU7", "MYXNU4")
	Private cString 	:= "ZZS"
	Private a_Ordem		:= {}

	If l_GrpMenu
		a_Ordem	:= {"Grupo + Módulo + Chave",;
					"Módulo + Função + Grupo",;
					"Função + Grupo + Módulo",;
					"Grupo + Módulo + Função",;
					"Módulo + Grupo + Chave"}
	
	Else
		a_Ordem	:= {"Usuário + Módulo + Chave",;
					"Módulo + Função + Usuário",;
					"Função + Usuário + Módulo",;
					"Usuário + Módulo + Função",;
					"Módulo + User + Chave"}
	Endif

	ValidPerg()

	Pergunte(c_Perg,.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta a interface padrao com o usuario...                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	wnrel := SetPrint(cString,NomeProg,c_Perg,@titulo,cDesc1,cDesc2,cDesc3,.F.,a_Ordem,.F.,Tamanho,,.F.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn, cString, .F.)

	If nLastKey == 27
		Return Nil
	Endif

	nTipo := If(aReturn[4]==1, 15, 18)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RptStatus({|| RunOcorre(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ RunOcorreº Autor ³ AP5 IDE            º Data ³  25/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RunOcorre(Cabec1,Cabec2,Titulo,nLin)

	Local c_Query		:= ""
	Local c_QryCnt		:= ""
	Local c_Access		:= ""
	Local c_Quebra		:= ""
	Local c_AuxQuebra	:= ""
	Local n_Ordem		:= aReturn[8]

	c_Query := "SELECT *  "+Chr(13)
	c_Query += "FROM "+RetSqlName("ZZS")+" "+Chr(13)
	c_Query += "WHERE ZZS_FILIAL = '  ' "+Chr(13)
	c_Query += "AND ZZS_USER BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "+Chr(13)
	c_Query += "AND ZZS_FUNCAO BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "+Chr(13)
	c_Query += "AND ZZS_MODULO BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+Chr(13)
	If MV_PAR07 <> 4 //Todos
		If MV_PAR07 == 1 //Habilitados
			c_Query += "AND ZZS_STATUS IN ('H') "+Chr(13)
		ElseIf MV_PAR07 == 2 //Inibidos
			c_Query += "AND ZZS_STATUS IN ('I') "+Chr(13)
		ElseIf MV_PAR07 == 3 //Desabilitados
			c_Query += "AND ZZS_STATUS IN ('D') "+Chr(13)
		Endif
	Endif
	c_Query += "AND D_E_L_E_T_ = ' ' "+Chr(13)

	If Select("TRB") > 0
		TRB->(DbCloseArea())
	Endif

	c_QryCnt := "SELECT COUNT(*) AS QTDREG FROM ("+c_Query+") AS RESULT "
	
	TCQUERY c_QryCnt NEW ALIAS "TRB"
	
	SetRegua(TRB->QTDREG)
	
	If Select("TRB") > 0
		TRB->(DbCloseArea())
	Endif
	
	If n_Ordem == 1
		c_Query += "ORDER BY ZZS_FILIAL, ZZS_USER, ZZS_MODULO, ZZS_CHAVE "+Chr(13)
		c_Quebra := "ZZS_USER"
	ElseIf n_Ordem == 2
		c_Query += "ORDER BY ZZS_FILIAL, ZZS_MODULO, ZZS_FUNCAO, ZZS_USER "+Chr(13)
		c_Quebra := "ZZS_MODULO"
	ElseIf n_Ordem == 3
		c_Query += "ORDER BY ZZS_FILIAL, ZZS_FUNCAO, ZZS_USER, ZZS_MODULO "+Chr(13)
		c_Quebra := "ZZS_FUNCAO"
	ElseIf n_Ordem == 4
		c_Query += "ORDER BY ZZS_FILIAL, ZZS_USER, ZZS_MODULO, ZZS_FUNCAO "+Chr(13)
		c_Quebra := "ZZS_USER"
	ElseIf n_Ordem == 4
		c_Query += "ORDER BY ZZS_FILIAL, ZZS_MODULO, ZZS_USER, ZZS_CHAVE "+Chr(13)
		c_Quebra := "ZZS_USER"
	Endif
	
	TCQUERY c_Query NEW ALIAS "TRB"
	
	If l_GrpMenu
		c_CabTit := "GRUPO   "
	Else
		c_CabTit := "USUÁRIO "
	Endif
	Cabec1 := c_CabTit+"      MÓDULO     FUNÇÃO     TÍTULO                  CHAVE       ACESSOS                                                                                                           Status"
	Cabec2 := "                                                                        1          2          3          4          5          6          7          8          9          10                  "
	//         XXXXXXXXX        XXXXXXXX XXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXX  X.XX.XX.XX  XXXXXXXXXX XXXXXXXXXX XXXXXXXXXX XXXXXXXXXX XXXXXXXXXX XXXXXXXXXX XXXXXXXXXX XXXXXXXXXX XXXXXXXXXX XXXXXXXXXX     XXXXXXXXXXXXXXX
	//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//         0         1         2         3         4         5         6         7         8         9        10        11        12        13         14        15        16        17        18        19
	
	a_Cols := {0, 15, 26,37, 61, 73, 187}

	While TRB->(!EOF())
		
		IncRegua()
		
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do cabecalho do relatorio. . .                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nLin > 60 // Salto de Página. Neste caso o formulario tem 55 linhas...
			nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin++
		Endif
	
		IIF (TRB->ZZS_LACE01 = "T" ,c_Access := SubStr(TRB->ZZS_DACE01, 1, 10)+space(1) ,c_Access := "           " )
		IIF (TRB->ZZS_LACE02 = "T" ,c_Access += SubStr(TRB->ZZS_DACE02, 1, 10)+space(1) ,c_Access += "           " ) 
		IIF (TRB->ZZS_LACE03 = "T" ,c_Access += SubStr(TRB->ZZS_DACE03, 1, 10)+space(1) ,c_Access += "           " )		
		IIF (TRB->ZZS_LACE04 = "T" ,c_Access += SubStr(TRB->ZZS_DACE04, 1, 10)+space(1) ,c_Access += "           " )		
		IIF (TRB->ZZS_LACE05 = "T" ,c_Access += SubStr(TRB->ZZS_DACE05, 1, 10)+space(1) ,c_Access += "           " )
		IIF (TRB->ZZS_LACE06 = "T" ,c_Access += SubStr(TRB->ZZS_DACE06, 1, 10)+space(1) ,c_Access += "           " )
		IIF (TRB->ZZS_LACE07 = "T" ,c_Access += SubStr(TRB->ZZS_DACE07, 1, 10)+space(1) ,c_Access += "           " )	
		IIF (TRB->ZZS_LACE08 = "T" ,c_Access += SubStr(TRB->ZZS_DACE08, 1, 10)+space(1) ,c_Access += "           " )
		IIF (TRB->ZZS_LACE09 = "T" ,c_Access += SubStr(TRB->ZZS_DACE09, 1, 10)+space(1) ,c_Access += "           " )
		IIF (TRB->ZZS_LACE10 = "T" ,c_Access += SubStr(TRB->ZZS_DACE10, 1, 10)+space(1) ,c_Access += "           " )
                                                         
		/*
		c_Access := SubStr(TRB->ZZS_ACESSO, 1, 1) + " " + SubStr(TRB->ZZS_ACESSO, 2, 1) + " " + SubStr(TRB->ZZS_ACESSO, 3, 1) + " "
		c_Access += SubStr(TRB->ZZS_ACESSO, 4, 1) + " " + SubStr(TRB->ZZS_ACESSO, 5, 1) + " " + SubStr(TRB->ZZS_ACESSO, 6, 1) + " "
		c_Access += SubStr(TRB->ZZS_ACESSO, 7, 1) + " " + SubStr(TRB->ZZS_ACESSO, 8, 1) + " " + SubStr(TRB->ZZS_ACESSO, 9, 1) + " "
		c_Access += Right(TRB->ZZS_ACESSO, 1)
		*/
		@ nLin, a_Cols[01] PSAY TRB->ZZS_USER
		@ nLin, a_Cols[02] PSAY TRB->ZZS_MODULO
		@ nLin, a_Cols[03] PSAY TRB->ZZS_FUNCAO
		@ nLin, a_Cols[04] PSAY Left(TRB->ZZS_TITULO, 30)
		@ nLin, a_Cols[05] PSAY Left(TRB->ZZS_CHAVE, 10)
		@ nLin, a_Cols[06] PSAY c_Access
		@ nLin, a_Cols[07] PSAY IIF(TRB->ZZS_STATUS == "H", "Habilitado", IIF(TRB->ZZS_STATUS == "I", "Inibido", "Desabilitado"))
		nLin++
		
		c_AuxQuebra := &c_Quebra
		
		TRB->(DbSkip())
		
		If &c_Quebra <> c_AuxQuebra
			nLin++
			@ nLin, 000 PSAY __PrtThinLine()
			nLin++
		Endif
		
	Enddo
	
	nLin++
	@ nLin, 000 PSAY __PrtThinLine()
	nLin++
	
	@ nLin, 000 PSAY ""
	
	If lEnd
		@PROW(),00 PSAY "*** CANCELADO PELO OPERADOR!! ***"
	Endif
	
	Set Device To Screen
	
	If aReturn[5] == 1
		Set Printer TO
		dbcommitAll()
		ourspool(wnrel)
	Endif
	
	MS_FLUSH()
	
	TRB->(DbCloseArea())
	
Return Nil
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³VALIDPERG º Autor ³ AP5 IDE            º Data ³  16/01/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Verifica a existencia das perguntas criando-as caso seja   º±±
±±º          ³ necessario (caso nao existam).                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ValidPerg()

Local aRegs := {}


If AllTrim(c_Perg) == "MYXNU4"
	// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{c_Perg,"01","Usuário de        ","Usuário de        ","Usuário de        ","mv_ch1","C",n_TamUser,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","US3"})
	aAdd(aRegs,{c_Perg,"02","Usuário Até       ","Usuário Até       ","Usuário Até       ","mv_ch2","C",n_TamUser,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","US3"})
	aAdd(aRegs,{c_Perg,"03","Função de         ","Função de         ","Função de         ","mv_ch3","C",10,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"04","Função Até        ","Função Até        ","Função Até        ","mv_ch4","C",10,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"05","Módulo de         ","Módulo de         ","Módulo de         ","mv_ch5","C",10,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"06","Módulo Até        ","Módulo Até        ","Módulo Até        ","mv_ch6","C",10,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"07","Status            ","Status            ","Status            ","mv_ch7","N",01,0,1,"C","","mv_par07","Habilitado","","","","","Inibido","","","","","Desabilitado","","","","","Todos","","","","","","","","",""})
ElseIf AllTrim(c_Perg) == "MYXNU7"
	// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{c_Perg,"01","Grupo de          ","Grupo de          ","Grupo de          ","mv_ch1","C",n_TamUser,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","US3"})
	aAdd(aRegs,{c_Perg,"02","Grupo até         ","Grupo até         ","Grupo até         ","mv_ch2","C",n_TamUser,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","US3"})
	aAdd(aRegs,{c_Perg,"03","Função de         ","Função de         ","Função de         ","mv_ch3","C",10,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"04","Função Até        ","Função Até        ","Função Até        ","mv_ch4","C",10,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"05","Módulo de         ","Módulo de         ","Módulo de         ","mv_ch5","C",10,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"06","Módulo Até        ","Módulo Até        ","Módulo Até        ","mv_ch6","C",10,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"07","Status            ","Status            ","Status            ","mv_ch7","N",01,0,1,"C","","mv_par07","Habilitado","","","","","Inibido","","","","","Desabilitado","","","","","Todos","","","","","","","","",""})
Endif

U_PutX1ESP(c_Perg, aRegs)

Return Nil
