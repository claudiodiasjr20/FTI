#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH"

/*=======================================================
Autor: Cintia Araujo
Data:	01.2015
---------------------------------------------------------
Descricao: Função generica - Impressão de Paramtros XML
=========================================================*/

User Function fCabecXML( __oObj, __cPergunta,  __cTitulo )

	__oObj:AddWorkSheet( __cTitulo )
	__oObj:AddTable( __cTitulo, "Parâmetros" )
	__oObj:AddColumn( __cTitulo, "Parâmetros" , ""   , 1,1)
	__oObj:AddColumn( __cTitulo, "Parâmetros" , ""   , 1,1)
	
	SX1->(DbSeek( PadR(__cPergunta, Len(SX1->X1_GRUPO)) ))
	While SX1->X1_GRUPO == PadR(__cPergunta, Len(SX1->X1_GRUPO)) .And. SX1->(!Eof())
		cParam  := "MV_PAR"+StrZero(Val(SX1->X1_ORDEM),2)
		cRetStr := IIF(SX1->X1_GSC = 'C', StrZero(&(cParam),2), "")
		cRetSX1 := IIF(SX1->X1_GSC = 'C', IIF(&(cParam) > 0, SX1->&("X1_DEF"+cRetStr),""), &(cParam))
		
		If ValType(cRetSX1) == "D" .And. Empty(cRetSX1)
			cRetSX1 := Dtoc(cRetSx1)
		EndIf
		
		__oObj:AddRow( __cTitulo, "Parâmetros", {SX1->X1_PERGUNT, cRetSX1 })
		
		SX1->(DbSkip())
	End-While
	
Return()

/*=======================================================
Autor: Cintia Araujo
Data:	01.2015
---------------------------------------------------------
Descricao: Funcao generica - Importar XLS para DBF
=========================================================*/

User Function FXLSIMP()
	Processa( {|| FXLSIMP1() }, "Importando Tabelas", "Processando arquivo, aguarde...", .F. )
Return()

Static Function FXLSIMP1()

	Local aStruct    := {}
	Local aChave     := ""
	Local nLin       := 0
	Local lTabela    := .F.
	Local lRecno     := .T.
	Local cAliasDBF  := "CT1"
	Local cAliasNEW  := cAliasDBF+"NEW"
	Local cNomeXLS   := "Plano.csv"
	Local c_Path     := cGetFile("\", "Selecione o diretório onde estão os arquivos.",,,,GETF_RETDIRECTORY)
	
	Local cEmpAnt    :=  "05"
	
	DbSelectArea("SX3")
	SX3->(DbSeek(cAliasDBF))
	SX3->( DbEval( {|| aadd( aStruct, {SX3->X3_CAMPO, SX3->X3_TIPO, SX3->X3_TAMANHO, SX3->X3_DECIMAL}) },,{ || SX3->( !Eof() ) .And. SX3->X3_ARQUIVO == cAliasDBF .And. SX3->X3_CONTEXT <> "V"} ) )
	
	DbSelectArea("SIX")
	If SIX->(DbSeek(cAliasDBF))
		cChave := SIX->CHAVE
	EndIf
	
	If File(c_Path + cAliasDBF + cEmpAnt + "0.DBF")
		DbUseArea(.T.,__LocalDriver, c_Path + cAliasDBF + cEmpAnt + "0.DBF",cAliasDBF,.T.,.F.)
		IndRegua( cAliasDBF, c_Path + cAliasDBF + cEmpAnt + "0" + OrdBagExt(), cChave,,, "Aguarde selecionando registros....")
		
		lTabela := .T.
	EndIf
	
	cArqTrb := CriaTrab(aStruct,.t.)
	dbUseArea(.T.,,cArqTrb,cAliasNEW,.T.)
	IndRegua(cAliasNEW,cArqTrb,cChave,,,"Criando Arquivo...")
	
	If File(c_Path + cNomeXLS)
		nlHandle := FT_FUSE(c_Path + cNomeXLS)
		
		ProcRegua( FT_FLASTREC() )
		
		FT_FGOTOP()
		While !FT_FEOF()
			
			IncProc( "Realizando leitura da linha -> " + StrZero(++nLin,6) )
			
			lRecno := .T.
			cLin   := FT_FREADLN()
			aLinha := Separa(cLin, ";")
			
			If nLin > 1 .And. !Empty(aLinha[1])
				If lTabela == .T.
					If (cAliasDBF)->(DbSeek( xFilial("CT1") + aLinha[1] ))
						If (cAliasNEW)->(!DbSeek( xFilial("CT1") + aLinha[1] ))
							
							(cAliasNEW)->(DbAppend())
							AvReplace(cAliasDBF,cAliasNEW)
							lRecno := .F.
						EndIf
					EndIf
				EndIf
				
				RecLock(cAliasNEW, lRecno)
				(cAliasNEW)->CT1_DESC01 := aLinha[2]
				(cAliasNEW)->CT1_DESC02 := aLinha[3]
				(cAliasNEW)->CT1_CLASSE := Iif(Upper(aLinha[4]) == "SINTETICA", "1", IIf(Upper(aLinha[4]) == "ANALITICA", "2", ""))
				(cAliasNEW)->CT1_NORMAL := Iif(Upper(aLinha[5]) == "CREDORA", "1", IIf(Upper(aLinha[5]) == "DEVEDORA", "2", ""))
				(cAliasNEW)->CT1_BLOQ   := Iif(Upper(aLinha[9]) == "BLOQUEAR", "1", "2")
				(cAliasNEW)->CT1_XCTFTI := aLinha[7]
				(cAliasNEW)->CT1_XDCFTI := aLinha[8]
				
				If lRecno == .T.
					(cAliasNEW)->CT1_FILIAL := xFilial(cAliasNEW)
					(cAliasNEW)->CT1_CONTA  := aLinha[1]
					(cAliasNEW)->CT1_DC      := "3"
					(cAliasNEW)->CT1_NCUSTO  := 0
					(cAliasNEW)->CT1_CVD02   := "1"
					(cAliasNEW)->CT1_CVD03   := "1"
					(cAliasNEW)->CT1_CVD04   := "1"
					(cAliasNEW)->CT1_CVD05   := "1"
					(cAliasNEW)->CT1_CVC02   := "1"
					(cAliasNEW)->CT1_CVC03   := "1"
					(cAliasNEW)->CT1_CVC04   := "1"
					(cAliasNEW)->CT1_CVC05   := "1"
					(cAliasNEW)->CT1_ACITEM  := "1"
					(cAliasNEW)->CT1_ACCUST  := "1"
					(cAliasNEW)->CT1_ACCLVL  := "1"
					(cAliasNEW)->CT1_DTEXIST := Ctod("01/01/1980")
					(cAliasNEW)->CT1_AGLSLD  := "2"
					(cAliasNEW)->CT1_CCOBRG  := "2"
					(cAliasNEW)->CT1_ITOBRG  := "2"
					(cAliasNEW)->CT1_CLOBRG  := "2"
					(cAliasNEW)->CT1_LALUR   := "0"
					(cAliasNEW)->CT1_CTLALU  := aLinha[1]
					(cAliasNEW)->CT1_LALHIR  := "2"
					(cAliasNEW)->CT1_ACATIV  := "2"
					(cAliasNEW)->CT1_ATOBRG  := "2"
					(cAliasNEW)->CT1_ACET05  := "2"
					(cAliasNEW)->CT1_05OBRG  := "2"
					//(cAliasNEW)->CT1_INTP    := "1"
				EndIf
				
				MsUnLock()
			EndIf                                                                         
			                                                                        
			FT_FSKIP()                                                            
		End-While                                        
		FT_FUSE()
		
		If File(cArqTrb+".DBF")
			If __CopyFile( cArqTrb+".DBF", c_Path + cAliasDBF + cEmpAnt + "0_NOVO.DBF" )
				MsgInfo("Gerado arquivo "+ c_Path + cAliasDBF + cEmpAnt + "0_NOVO.DBF" )
			EndIf
		EndIf
	Else
		MsgInfo("Não encontrado Arquivo: '"+ c_Path + cNomeXLS +"'" )
	EndIf
	DbCloseArea("CT1")              
	
Return()

//*******************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fCGCCodigo |Autor³ Claudio Dias Junior (Focus Consultoria)| Data ³ 23/05/2013 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Função para Subtrair caracteres Indesejaveis                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_CGC      => Campo do CGC ( Ex: M->A1_CGC )                                  ³±±
±±³          ³ c_Alias    => Tabela utilizada ( Ex: "A1" )                                   ³±±
±±³          ³ a_Tabela   => Tabela utilizada + Campo do Codigo ( { "SA1", "A1_COD" } )      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ c_CGC => Campo do CGC                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI                                                                     		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

// U_fCGCCodigo( M->A1_CGC, M->A1_PESSOA, "A1", { "SA1", "A1_COD" } )
// U_fCGCCodigo( M->A2_CGC, M->A2_TIPO	, "A2", { "SA2", "A2_COD" } )
User Function fCGCCodXXX( c_CGC, c_Tipo, c_Alias, a_Tabela ) 

Local c_Query 	:= ""
Local c_Chr 	:= ""
local oModelSA2 := nil
local oField	:= nil

If c_Alias ==  "SA2"
	oModelSA2	:= FwModelActive()
	oField		:= oModel:GetModel("SA2MASTER")
EndIf

&("M->"+c_Alias+"_COD") 	:= "000000"
&("M->"+c_Alias+"_LOJA")	:= "00"
		
If c_Tipo == "J" .And. !Empty(c_CGC) .And. Left(c_CGC,8) <> "00000000"

	c_Query := "SELECT MAX("+c_Alias+"_COD) COD, MAX("+c_Alias+"_LOJA) LOJA " + c_Chr
	c_Query += "FROM  S"+c_Alias+"050 " + c_Chr
	c_Query += "WHERE D_E_L_E_T_ = '' " + c_Chr
	c_Query += "AND LEFT("+c_Alias+"_CGC,8) = '"+Left(c_CGC,8)+"' " + c_Chr
	
	If Select("CODLJ") > 0
		CODLJ->(DbCloseArea())
	EndIf
		
	c_Query := ChangeQuery(c_Query)

	TCQUERY c_Query NEW ALIAS "CODLJ"	

	If !Empty(CODLJ->(COD+LOJA))
	
		If c_Alias ==  "SA2"
			//Preenche o A2_COD com um valor.
			oField:SetValue( "A2_COD"  , CODLJ->COD )
			oField:SetValue( "A2_LOJA" , Soma1(CODLJ->LOJA) )
		Else
			&("M->"+c_Alias+"_COD") 	:= CODLJ->COD
			&("M->"+c_Alias+"_LOJA")	:= Soma1(CODLJ->LOJA)
		EndIf
		
	Else
		
		c_Query := "SELECT MAX("+c_Alias+"_COD) COD " + c_Chr
		c_Query += "FROM  S"+c_Alias+"050 " + c_Chr
		c_Query += "WHERE D_E_L_E_T_ = '' " + c_Chr
		c_Query += "AND "+c_Alias+"_COD <= '999999'" + c_Chr
		
		If Select("CODLJ") > 0
			CODLJ->(DbCloseArea())
		EndIf
			
		c_Query := ChangeQuery(c_Query)
	
		TCQUERY c_Query NEW ALIAS "CODLJ"	
	
		If !Empty(CODLJ->(COD))

			If c_Alias ==  "SA2"		
				//Preenche o A2_COD com um valor.
				oField:SetValue( "A2_COD"  , Soma1(CODLJ->COD ) )
				oField:SetValue( "A2_LOJA" , "01" )
			Else
				&("M->"+c_Alias+"_COD") 	:= Soma1(CODLJ->COD)
				&("M->"+c_Alias+"_LOJA")	:= "01"
			EndIf
	
		EndIf
		
	EndIf
	
Else    

	c_Query := "SELECT MAX("+c_Alias+"_COD) COD " + c_Chr
	c_Query += "FROM  S"+c_Alias+"050 " + c_Chr
	c_Query += "WHERE D_E_L_E_T_ = '' " + c_Chr
	c_Query += "AND "+c_Alias+"_COD <= '999999'" + c_Chr

	If Select("CODLJ") > 0
		CODLJ->(DbCloseArea())
	EndIf

	c_Query := ChangeQuery(c_Query)

	TCQUERY c_Query NEW ALIAS "CODLJ"	

	If !Empty(CODLJ->(COD))
				
		&("M->"+c_Alias+"_COD") 	:= Soma1(CODLJ->COD)
		&("M->"+c_Alias+"_LOJA")	:= "01"

	EndIf

EndIf

Return c_CGC

//************************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fTiraPonto |Autor³ Sidnei Naconsky                        | Data ³ 23/05/2013 ³±±
±±³Reformulada Por        |Autor³ Claudio Dias Junior (Focus Consultoria)| Data ³ 23/05/2013 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Função para Subtrair caracteres Indesejaveis                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_Texto => Campo a ser analisado (e, subtraido)                               ³±±
±±³          ³ c_Conteudo => Caracteres Indesejaveis                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ c_Texto => Sem os caracteres Indesejaveis                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI                                                                     		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function fTirPonto(c_Texto, c_Conteudo)

c_Conteudo += '	' + Chr(13)

For i := 1 To Len(c_Conteudo) 
	c_Texto := Replace(c_Texto, SubStr(c_Conteudo, i, 1), "")
Next i
           
For y := 2 To 10
	c_Texto := Replace(c_Texto, Space(y), Space(01) )
Next z

Return Alltrim(c_Texto)                 

//************************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ExistTAB  |Autor³ Claudio Dias Junior ( Focus Consultoria )|Data ³ 05/02/2015 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Função que verifica se a tabela existe                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_NomeTAB => Tabela que será verificada SA1010                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ l_Ret => .T./.F.                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI                                                                     		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

// U_ExistTAB("AA1990")
User Function ExistTA(c_NomeTAB)

Local l_Ret := .T.
	
	If Select("QRYTAB") > 0
		QRYTAB->(DbCloseArea())
	EndIf
	DbUseArea(.T., 'TOPCONN', TCGenQry(,,"select id from sysobjects where name like '" + Alltrim(c_NomeTAB)+"' and xtype = 'U'"),'QRYTAB', .F., .T.)
//	DbUseArea(.T., 'TOPCONN', c_NomeTAB	,'QRYTAB'	,.F.,.T.)
//	DbUseArea(.F., "TOPCONN",c_NomeTAB	,"QRYTAB"	,.T.,.F.)
	If QRYTAB->(Eof())
		l_Ret := .F.
	EndIf	        

Return l_Ret

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fCriaArq | Autor ³ Claudio Dias Junior (Focus Consultoria)  | Data ³ 26/07/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Gera arquivo com base no array passado.                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 	a_Dados => Array que contém os dados para geração do arquivo                 ³±±
±±³          ³ 	c_NomeArq => Nome do arquivo                                                 ³±±
±±³          ³ 	c_Local => Local de geração do arquivo                                       ³±±
±±³          ³ 	c_Extencao => Extensão ( CSV, TXT, XLS )                           	         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametros -> Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FISCHER BRASIL                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                                					 ³±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function fCriaAr( a_Dados, c_NomeArq, c_Local, c_Extencao )

Local o_Excel
Local c_Arq
Local n_Arq
Local c_Path
                                   	
c_NomeArq 	:= ( c_NomeArq + "_" + DTOS(dDatabase) + "_" + Left(Time(),2) + SubStr(Time(),4,2) + Right(Time(),2) ) + c_Extencao
c_Arq  		:= CriaTrab( Nil, .F. )

If Empty(c_Local)
	c_Path := cGetFile("\", "Selecione o Local para salvar a Arquivo.",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY/*128+GETF_NETWORKDRIVE*/)
Else
	c_Path := c_Local
EndIf

n_Arq  		:= FCreate( c_Path + c_NomeArq )

If ( n_Arq == -1 )
	MsgAlert( "Nao conseguiu criar o arquivo!" , " A T E N C A O !" )
	Return()
EndIf

For i := 1 To Len(a_Dados)
	FWrite( n_Arq, a_Dados[i][1] + Chr(13) + Chr(10) )
Next i

FClose(n_Arq)

Return c_NomeArq

//**********************************************************************************************************************************************************// 
/*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ FTIVldCli  |Autor³ Claudio Dias Junior (Focus Consultoria)| Data ³ 17/08/2017 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Função para OBRIGAR o usaurio refazer a TES quando mudar o CLIENTE            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_CodCliente => Codigo do Cliente                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ c_CodCliente => Codigo do Cliente                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ**/ 
User Function FTIVldCli(c_CodCliente)// Gatilha o Produto novamente 
          
Local 	a_AreaATU 	:= GetArea()

//- Captura posição dos campo no array aCols    
nC6_TES	:= aScan(aHeader,{ |x| UPPER(ALLTRIM(x[2])) == "C6_TES"	})

For n_Prox := 1 To Len(aCols)
	aCols[n_Prox][nC6_TES] := Space(03)
Next n_Prox

RestArea(a_AreaATU)

Return c_CodCliente

//********************************************************************************************************************************************************//