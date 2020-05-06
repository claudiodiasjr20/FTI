#INCLUDE "DBTREE.CH"
#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"

User Function MYMENU3(lAdmin, cUser)     

Local a_AreaATU	:= GetArea()
Local a_AreaZZR	:= ZZR->(GetArea())
Local a_AreaZZS	:= ZZS->(GetArea())
Local n_Lin		:= 210
Local n_Col		:= 200

Private l_Admin		:= IIF(lAdmin==Nil, .T., lAdmin)
Private n_TamUser	:= 25
Private c_User		:= IIF(cUser==Nil, Space(n_TamUser), cUser)
Private c_Modulo	:= IIF(l_Admin, ZZR->ZZR_MODULO, ZZS->ZZS_MODULO)
Private c_CadTree 	:= "Estrutura do Menu - Módulo "+c_Modulo+" "+IIF(!l_Admin, "- "+IIF(l_GrpMenu, "Grupo", "Usuário")+" "+c_User,"")
Private oDlgTree	:= Nil
Private oTree1		:= Nil
Private cFClose		:= "FOLDER5" //"PMSDOC"  //"FOLDER5" //"PMSMAIS"  //"SHORTCUTPLUS"
Private cFOpen 		:= "FOLDER6" //"PMSEDT3" //"FOLDER6" //"PMSMENOS" //"SHORTCUTMINUS"
Private cBmp2 		:= "PMSDOC" 
Private c_CargOrig	:= ""
Private c_CargDest	:= ""
Private a_Menu		:= {}
Private n_OpcTree	:= 0
Private l_Alterou	:= .F.

DEFINE MSDIALOG oDlgTree TITLE c_CadTree FROM 0,0 TO 500,620 PIXEL

If l_Admin
	MENU oMenu POPUP
		MENUITEM "Recortar" 			ACTION fOptMenu(1)
		MENUITEM "Colar"  				ACTION fOptMenu(2)
		MENUITEM "Incluir Item" 		ACTION fOptMenu(5)
		MENUITEM "Incluir Folder" 		ACTION fOptMenu(10)
		MENUITEM "Editar" 				ACTION fOptMenu(6)
		MENUITEM "Excluir" 				ACTION fOptMenu(7)
		MENUITEM "Todas Utilizações"	ACTION fOptMenu(11)
		MENUITEM "Move p/ cima"  		ACTION fOptMenu(4)
		MENUITEM "Move p/ baixo"  		ACTION fOptMenu(3)
		MENUITEM "Executar" 	 		ACTION fOptMenu(8)
	ENDMENU
Else
	MENU oMenu POPUP
		MENUITEM "Visualizar"			ACTION fOptMenu(12)
		MENUITEM "Executar" 	 		ACTION fOptMenu(8)
	ENDMENU
Endif

MntArray()

//DbTree():New(<nTop>, <nLeft>, <nBottom>, <nRight>, <oWnd>,<{uChange}>, <{uRClick}>, <.lCargo.>, <.lDisable.> )
oTree1 := dbTree():New(25,10,245,300,oDlgTree,,{|o,X,Y| oMenu:Activate(X-n_Lin,Y-n_Col,oTree1 )},.T.)
MntTree(.F.)

@ 15,10 SAY "Utilize o botão direito do mouse. O item selecionado sempre será incluído abaixo do local escolhido." SIZE 350,7 OF oDlgTree PIXEL

//DEFINE SBUTTON oBtnOK FROM 230,230 TYPE 1 ACTION (n_OpcTree := 1, oDlgTree:End()) ENABLE OF oDlgTree
//DEFINE SBUTTON oBtnCa FROM 230,270 TYPE 2 ACTION (Iif(fAviso(), oDlgTree:End(), Nil)) ENABLE OF oDlgTree

//ACTIVATE MSDIALOG oDlgTree CENTER ON INIT EnchoiceBar(oDlgTree,{||(n_OpcTree := 1, oDlgTree:End())},{||(Iif(fAviso(), oDlgTree:End(), Nil))},, a_Buttons)
ACTIVATE MSDIALOG oDlgTree CENTER ON INIT MyEnchoBar(oDlgTree,{||(n_OpcTree := 1, oDlgTree:End())},{||(Iif(fAviso(), oDlgTree:End(), Nil))})
										
If l_Admin .And. n_OpcTree == 1 .And. l_Alterou
	CursorWait()
	Processa( {|| fGrava() }, "Gravando..." )
	CursorArrow()
Endif

RestArea(a_AreaZZS)
RestArea(a_AreaZZR)
RestArea(a_AreaATU)

Return Nil

Static Function fAviso()

	Local l_Ret := .T.
	
	If l_Admin .And. l_Alterou
		l_Ret := MsgYesNo("Todas as alterações feitas serão perdidas. Deseja encerrar assim mesmo?", cCadastro)
	Endif

Return l_Ret

Static Function MntArray()
	
	Local i 			:= 0
	Local l_DelItem 	:= .F.
	Local a_FComFunc	:= {}
	
	a_Menu := {}

	DbSelectArea("ZZR")
	DbSetOrder(1) //ZZR_FILIAL, ZZR_MODULO, ZZR_CHAVE, R_E_C_N_O_, D_E_L_E_T_
	DbGoTop()
	DbSeek(xFilial("ZZR")+c_Modulo, .F.)

	While ZZR->(!Eof()) .And. ZZR->(ZZR_FILIAL + ZZR_MODULO) == xFilial("ZZR")+c_Modulo

		aAdd(a_Menu, {ZZR->ZZR_CHAVE, 0, ZZR->ZZR_FUNCAO, ZZR->ZZR_TITPOR, ZZR->(Recno())})
		ZZR->(DbSkip())
		
	Enddo
	
	///////////////////////////////////////////////////////
	// Se nao for menu do Admin, monta o menu do usuario //
	///////////////////////////////////////////////////////
	If !l_Admin
		DbSelectArea("ZZS")
		DbSetOrder(1) //ZZS_FILIAL, ZZS_USER, ZZS_FUNCAO, ZZS_MODULO, R_E_C_N_O_, D_E_L_E_T_
		i := 1
		While i <= Len(a_Menu)
			l_DelItem := .F.
			If AllTrim(a_Menu[i][3]) <> ""
				If DbSeek(xFilial("ZZS")+c_User+a_Menu[i][3], .F.)
					If ZZS->ZZS_STATUS <> "H"
						l_DelItem := .T.
					Else
						a_Menu[i][2] := ZZS->(Recno())
					Endif
				Else
					l_DelItem := .T.
				Endif
			Endif
			If l_DelItem
				aDel(a_Menu, i)
				aSize(a_Menu, Len(a_Menu)-1)
			Else
				i++
			Endif
		Enddo
		
		//////////////////////////////////////////////
		// Removo as pastas que nao possuem Funcoes //
		//////////////////////////////////////////////
		For i := Len(a_Menu) To 1 Step -1
			If AllTrim(a_Menu[i][3]) <> ""
				aAdd(a_FComFunc, Left(a_Menu[i][1], Len(AllTrim(a_Menu[i][1]))-3))
			Else
				n_PosAux := aScan(a_FComFunc, AllTrim(a_Menu[i][1]))
				If n_PosAux == 0
					aDel(a_Menu, i)
					aSize(a_Menu, Len(a_Menu)-1)
				Endif
			Endif
		Next i
		
	Endif
	
Return Nil
	
Static Function MntTree(l_Reset)
	
	Local n_LenKey 	:= 0
	Local n_LenOKey	:= 0
	Local i			:= 0
	
	Local l_Fld1Niv	:= .F.
	Local l_Fld2Niv	:= .F.
	Local l_Fld3Niv	:= .F.
	Local l_Fld4Niv	:= .F.

	If l_Reset
		oTree1:Reset()
		l_Alterou := .T.
	Endif
	
	oTree1:BeginUpdate()

	For i := 1 To Len(a_Menu)

		n_LenKey := Len(AllTrim(a_Menu[i][1]))
		
		If AllTrim(a_Menu[i][3]) == ""
			If n_LenKey == 1
				If l_Fld4Niv
					oTree1:EndTree()
					l_Fld4Niv := .F.
				Endif
				If l_Fld3Niv
					oTree1:EndTree()
					l_Fld3Niv := .F.
				Endif
				If l_Fld2Niv
					oTree1:EndTree()
					l_Fld2Niv := .F.
				Endif
				If l_Fld1Niv
					oTree1:EndTree()
				Endif
				l_Fld1Niv := .T.
			ElseIf n_LenKey == 4
				If l_Fld4Niv
					oTree1:EndTree()
					l_Fld4Niv := .F.
				Endif
				If l_Fld3Niv
					oTree1:EndTree()
					l_Fld3Niv := .F.
				Endif
				If l_Fld2Niv
					oTree1:EndTree()
				Endif
				l_Fld2Niv := .T.
			ElseIf n_LenKey == 7
				If l_Fld4Niv
					oTree1:EndTree()
					l_Fld4Niv := .F.
				Endif
				If l_Fld3Niv
					oTree1:EndTree()
				Endif
				l_Fld3Niv := .T.
			ElseIf n_LenKey == 10
				If l_Fld4Niv
					oTree1:EndTree()
				Endif
				l_Fld4Niv := .T.
			Endif

			//<oTree>:AddTree( <cLabel>, <.lOpen.>, <cResOpen>, <cResClose>, <cBmpOpen>, <cBmpClose>, <cCargo> )
			oTree1:AddTree(a_Menu[i][4],.T.,cFClose,cFOpen,,,a_Menu[i][1])

		Else
			If n_LenOKey > n_LenKey
				oTree1:EndTree()
				If n_LenKey == 10
					l_Fld4Niv := .F.
				ElseIf n_LenKey == 7
					l_Fld3Niv := .F.
				ElseIf n_LenKey == 4
					l_Fld2Niv := .F.
				Endif
			Endif
			//<oTree>:AddTreeItem( <cLabel>, <cResOpen>, <cBmpOpen>, <cCargo>)
			oTree1:AddTreeItem(a_Menu[i][4],cBmp2,,a_Menu[i][1])
		Endif
		
		n_LenOKey := Len(AllTrim(a_Menu[i][1]))
		
	Next i
	
	If l_Fld4Niv
		oTree1:EndTree()
	Endif
	If l_Fld3Niv
		oTree1:EndTree()
	Endif
	If l_Fld2Niv
		oTree1:EndTree()
	Endif
	If l_Fld1Niv
		oTree1:EndTree()
	Endif

	oTree1:EndUpdate()
	
Return Nil

Static Function fOptMenu(n_Opcao)
	
	Local n_KeyOrig := 0
	Local n_KeyDest := 0
	Local n_RecZZR	:= 0
	Local l_Continua:= .T.
	
	If n_Opcao == 1 //Recortar

		c_CargOrig := ""
		c_CargDest := ""
		
		If AllTrim(oTree1:GetCargo()) $ "1#2#3#4#"
			MsgStop("Não é possível mover o primeiro nível da estrutura.", cCadastro)
		Else
			c_CargOrig := oTree1:GetCargo()
		Endif

	ElseIf n_Opcao == 2 //Colar

		c_CargDest := oTree1:GetCargo()
		
		n_KeyOrig := aScan(a_Menu, {|x| x[1]==c_CargOrig})
		n_KeyDest := aScan(a_Menu, {|x| x[1]==c_CargDest})
		
		If n_KeyOrig == 0 .Or. n_KeyDest == 0
			MsgStop("Não foi possível localizar a chave de origem e/ou destino.", cCadastro)
		ElseIf AllTrim(a_Menu[n_KeyOrig][3]) == "" .And. AllTrim(a_Menu[n_KeyDest][3]) <> ""
			MsgStop("Não é possível mover uma pasta para dentro de uma função.", cCadastro)	
		ElseIf AllTrim(c_CargOrig) $ "1#2#3#4#"
			MsgStop("Não é possível mover o primeiro nível da estrutura.", cCadastro)	
		ElseIf MsgYesNo("Verifique com atenção as informações abaixo."+Chr(13)+Chr(10)+Chr(13)+Chr(10)+;
						"Remover.....: "+fPathTree(c_CargOrig)+Chr(13)+Chr(10)+;
						"Inserir em .: "+fPathTree(c_CargDest)+Chr(13)+Chr(10)+Chr(13)+Chr(10)+;
						"O sistema também irá confirmar todas as alterações feitas até o momento."+Chr(13)+Chr(10)+Chr(13)+Chr(10)+;
						"Confirma a alteração?", cCadastro)
			fMoveItem(c_CargOrig, n_KeyOrig, c_CargDest, n_KeyDest, .T.)
			c_CargOrig := ""
			c_CargDest := ""
		Endif
	
	ElseIf n_Opcao == 3 .Or. n_Opcao == 4 //Mover para Baixo //Mover para cima

		c_CargOrig 	:= oTree1:GetCargo()
		If n_Opcao == 3
			c_CargDest	:= Soma1(c_CargOrig)
		Else
			c_CargDest	:= fTira1(c_CargOrig)
		Endif
		n_KeyOrig 	:= aScan(a_Menu, {|x| x[1]==c_CargOrig})
		n_KeyDest 	:= aScan(a_Menu, {|x| x[1]==c_CargDest})
		If AllTrim(c_CargOrig) $ "1#2#3#4#"
			MsgStop("Não é possível mover o primeiro nível da estrutura.", cCadastro)
		ElseIf n_KeyDest == 0
			If n_Opcao == 3
				MsgStop("Último item/Pasta. Não é possível movê-lo para baixo.", cCadastro)
			Else
				MsgStop("Primeiro item/Pasta. Não é possível movê-lo para cima.", cCadastro)
			Endif
		ElseIf n_KeyOrig == 0 .Or. n_KeyDest == 0
			MsgStop("Não foi possível localizar a chave de origem e/ou destino.", cCadastro)
		Else
			fMoveItem(c_CargOrig, n_KeyOrig, c_CargDest, n_KeyDest, .F.)
		Endif
		
	ElseIf n_Opcao == 5 .Or. n_Opcao == 6 .Or. n_Opcao == 7 .Or. n_Opcao == 10 //Incluir - Alterar - Excluir - New Folder
		
		c_CargOrig 	:= oTree1:GetCargo()
		n_KeyOrig 	:= aScan(a_Menu, {|x| x[1]==c_CargOrig})
		
		If n_KeyOrig > 0 
			
			n_RecZZR := a_Menu[n_KeyOrig][5]
			l_Continua := .T.
			
			If n_Opcao == 6 .And. AllTrim(a_Menu[n_KeyOrig][3]) == "" .And. !l_Admin
				MsgStop("Só é possível alterar pastas através do menu do administrador.", "Inconsistência")
				l_Continua := .F.
			ElseIf l_Alterou 
				If MsgYesNo("Todas as alterações feitas até agora serão confirmadas. Deseja continuar?", "ATENÇÃO")
					CursorWait()
					Processa( {|| fGrava() }, "Gravando..." )
					CursorArrow()
				Else
					l_Continua := .F.
				Endif
			Endif

			If l_Continua
			
				DbSelectArea("ZZR")
				DbGoTo(n_RecZZR)
				
				If n_Opcao == 10
					l_Continua := U_MYMENU(4)
				Else
					l_Continua := U_MYMENU(n_Opcao)
				Endif
				
				If l_Continua

					MntArray()
					MntTree(.T.)
					
					l_Alterou := .F.
					
					DbSelectArea(oTree1:cArqTree)
					DbSetOrder(4)
					oTree1:TreeSeek(c_CargOrig)
					oTree1:SetFocus()
        		
        		Endif
        		
        	Endif
        	
		Endif

	ElseIf n_Opcao == 9 //Executar

		c_CargOrig 	:= oTree1:GetCargo()
		n_KeyOrig 	:= aScan(a_Menu, {|x| x[1]==c_CargOrig})
		
		If n_KeyOrig > 0 
			
			DbSelectArea("ZZR")
			DbGoTo(a_Menu[n_KeyOrig][5])
			
			U_MYMENU(n_Opcao)
		
		Endif

	ElseIf n_Opcao == 11 //Todas as utilizacoes
		
		c_CargOrig 	:= oTree1:GetCargo()
		n_KeyOrig 	:= aScan(a_Menu, {|x| x[1]==c_CargOrig})
		
		If n_KeyOrig > 0 
			
			DbSelectArea("ZZR")
			DbGoTo(a_Menu[n_KeyOrig][5])
			
			U_MYMENU(10)
		
		Endif
	
	ElseIf n_Opcao == 12 //Visualiza Acesso do Usuario/Grupo
	
		c_CargOrig 	:= oTree1:GetCargo()
		n_KeyOrig 	:= aScan(a_Menu, {|x| x[1]==c_CargOrig})
		
		If n_KeyOrig > 0 
			
			DbSelectArea("ZZS")
			DbGoTo(a_Menu[n_KeyOrig][2])
			
			AxVisual("ZZS", ZZS->(Recno()), 2)
		
		Endif
	
	Endif	
	
Return Nil

Static Function fMoveItem(c_CargOrig, n_KeyOrig, c_CargDest, n_KeyDest, l_CutPaste)
	
	Local a_PosOrig := {}
	Local a_PosDest := {}
	Local n_TamOrig	:= Len(AllTrim(c_CargOrig))
	Local n_TamDest	:= Len(AllTrim(c_CargDest))
	Local i := 1
	
	If l_CutPaste
		c_NewChave := AllTrim(c_CargDest)+".01"+Replicate(" ", 10 - (n_TamDest+3))
		While aScan(a_Menu, {|x| x[1]==c_NewChave}) > 0
			c_NewChave := Soma1(c_NewChave)
		Enddo
		For i := 1 To Len(a_Menu)
			If Left(a_Menu[i][1], n_TamOrig) == AllTrim(c_CargOrig)
				a_Menu[i][1] := AllTrim(c_NewChave)+SubStr(a_Menu[i][1],n_TamOrig+1)
			Endif
		Next i
	Else
		//Guardo as chaves de Origem e Destino
		For i := 1 To Len(a_Menu)
			If Left(a_Menu[i][1], n_TamOrig) == AllTrim(c_CargOrig)
				aAdd(a_PosOrig, i)
			ElseIf Left(a_Menu[i][1], n_TamDest) == AllTrim(c_CargDest)
				aAdd(a_PosDest, i)
			Endif
		Next i
		
		//Atualizar a Chave de Origem
		For i := 1 To Len(a_PosOrig)
			a_Menu[a_PosOrig[i]][1] := AllTrim(c_CargDest)+SubStr(a_Menu[a_PosOrig[i]][1],n_TamOrig+1)
		Next i
		
		//Atualizar a Chave de Destino
		For i := 1 To Len(a_PosDest)
			a_Menu[a_PosDest[i]][1] := AllTrim(c_CargOrig)+SubStr(a_Menu[a_PosDest[i]][1],n_TamDest+1)
		Next i
    Endif
	
	a_Menu := aSort(a_Menu,,,{|x,y| x[1] < y[1] } )

	If l_CutPaste
		CursorWait()
		Processa( {|| fGrava() }, "Gravando..." )
		CursorArrow()
		l_Alterou := .F.
		MntArray()
	Endif
	
	MntTree(.T.)

	If l_CutPaste
		l_Alterou := .F.
	Endif
	
	DbSelectArea(oTree1:cArqTree)
	DbSetOrder(4)
	oTree1:TreeSeek(c_CargDest)
	oTree1:SetFocus()

Return Nil

Static Function fGrava()

	Local i 		:= 0
	Local c_QryUpd	:= ""
	
	ProcRegua(Len(a_Menu))
	
	For i := 1 To Len(a_Menu)
		IncProc()
		ZZR->(DbGoTo(a_Menu[i][5]))
		ZZR->(RecLock("ZZR", .F.))
			ZZR->ZZR_CHAVE := a_Menu[i][1]
		ZZR->(MsUnLock())
	Next i
	
	MsgRun("Reordenando a chave. Por favor, aguarde...", "TreeKey", {|| U_OrdTreeKey(ZZR->ZZR_MODULO) })
//	U_OrdTreeKey(ZZR->ZZR_MODULO)
	
	c_QryUpd := "UPDATE "+RetSqlName("ZZS")+" SET ZZS_CHAVE = ZZR_CHAVE "
	c_QryUpd += "FROM "+RetSqlName("ZZS")+" "
	c_QryUpd += "INNER JOIN "+RetSqlName("ZZR")+" "
	c_QryUpd += "	ON ZZR_FILIAL = ZZS_FILIAL "
	c_QryUpd += "	AND ZZR_MODULO = ZZS_MODULO "
	c_QryUpd += "	AND ZZR_FUNCAO = ZZS_FUNCAO "
	c_QryUpd += "	AND "+RetSqlName("ZZR")+".D_E_L_E_T_ = ' ' "
	c_QryUpd += "WHERE ZZS_FILIAL = '"+ZZR->ZZR_FILIAL+"' "
	c_QryUpd += "AND ZZS_MODULO = '"+ZZR->ZZR_MODULO+"' "
	c_QryUpd += "AND "+RetSqlName("ZZS")+".D_E_L_E_T_ = ' ' "

	TcSqlExec(c_QryUpd)

Return Nil

Static Function fTira1(c_CargOrig)

	Local c_Ret 	:= ""
	Local c_Chave	:= AllTrim(c_CargOrig)
    
    n_Chave	:= Val(Right(c_Chave, 2))
	n_Chave--
	c_Ret := Left(c_Chave, Len(c_Chave) - 2) + StrZero(n_Chave, 2)
	c_Ret += Replicate(" ", 10-Len(c_Ret))

Return c_Ret

Static Function fPathTree(c_Cargo)

	Local c_Path 	:= "\"
	Local n_TamOrig	:= Len(AllTrim(c_Cargo))
	Local c_Busca	:= Left(c_Cargo, 1)+Replicate(" ", 9)
	Local n_PosAux	:= aScan(a_Menu, {|x| x[1]==c_Busca})
	Local n_Count	:= 1

	While n_PosAux > 0 .And. n_TamOrig >= n_Count
		c_Path 	+= AllTrim(a_Menu[n_PosAux][4])+IIF(AllTrim(a_Menu[n_PosAux][3])=="", "\", "")
		n_Count += 3
		c_Busca	:= Left(c_Cargo, n_Count)+Replicate(" ", 10 - n_Count)
		n_PosAux := aScan(a_Menu, {|x| x[1]==c_Busca})
	Enddo

Return c_Path

User Function OrdTreeKey(c_Modulo)

	Local c_Query := ""
	
	c_Query := "SELECT R_E_C_N_O_ AS RECZZR, ZZR_CHAVE FROM "+RetSqlName("ZZR")+" " 
	c_Query += "WHERE D_E_L_E_T_ = ' ' "
	c_Query += "AND ZZR_MODULO = '"+c_Modulo+"' "
	c_Query += "AND LEN(ZZR_CHAVE) = '13' "
	c_Query += "ORDER BY ZZR_CHAVE "

	If Select("QRY") > 0
		QRY->(DbCloseArea())
	Endif

	TcQuery c_Query New Alias "QRY"
	
	c_Pai 		:= ""
	c_NewOrder	:= ""
	c_NewPai	:= ""
	
	While QRY->(!Eof())
		If c_Pai == Left(QRY->ZZR_CHAVE, 10)
			c_NewOrder := Soma1(c_NewOrder)
			c_NewPai := c_Pai + "." +c_NewOrder
			If AllTrim(QRY->ZZR_CHAVE) <> c_NewPai
				ZZR->(DbGoTo(QRY->RECZZR))
				ZZR->(RecLock("ZZR", .F.))
					ZZR->ZZR_CHAVE := c_NewPai
				ZZR->(MsUnLock())
			Endif
			QRY->(DbSkip())
		Else
			c_Pai := Left(QRY->ZZR_CHAVE, 10)
			c_NewOrder	:= "00"
		Endif		
	Enddo

	c_Query := "SELECT ZZR_FILIAL, ZZR_MODULO, ZZR_CHAVE, ZZR_FUNCAO, R_E_C_N_O_ AS RECZZR "
	c_Query += "FROM "+RetSqlName("ZZR")+" " 
	c_Query += "WHERE D_E_L_E_T_ = ' ' "
	c_Query += "AND ZZR_MODULO = '"+c_Modulo+"' "
	c_Query += "AND LEN(ZZR_CHAVE) = '10' "
	c_Query += "ORDER BY ZZR_CHAVE "

	If Select("QRY") > 0
		QRY->(DbCloseArea())
	Endif

	TcQuery c_Query New Alias "QRY"
	
	c_Pai 		:= ""
	c_NewOrder	:= ""
	c_NewPai	:= ""
	
	While QRY->(!Eof())
		If c_Pai == Left(QRY->ZZR_CHAVE, 7)
			c_NewOrder := Soma1(c_NewOrder)
			c_NewPai := c_Pai + "." +c_NewOrder
			If AllTrim(QRY->ZZR_CHAVE) <> c_NewPai
				If AllTrim(QRY->ZZR_FUNCAO) == ""
					fChaveDePara(QRY->ZZR_CHAVE, c_NewPai, ZZR->ZZR_FILIAL, ZZR->ZZR_MODULO)
				Else
					ZZR->(DbGoTo(QRY->RECZZR))
					ZZR->(RecLock("ZZR", .F.))
						ZZR->ZZR_CHAVE := c_NewPai
					ZZR->(MsUnLock())
				Endif
			Endif
			QRY->(DbSkip())
		Else
			c_Pai := Left(QRY->ZZR_CHAVE, 7)
			c_NewOrder	:= "00"
		Endif		
	Enddo

	c_Query := "SELECT ZZR_FILIAL, ZZR_MODULO, ZZR_CHAVE, ZZR_FUNCAO, R_E_C_N_O_ AS RECZZR "
	c_Query += "FROM "+RetSqlName("ZZR")+" " 
	c_Query += "WHERE D_E_L_E_T_ = ' ' "
	c_Query += "AND ZZR_MODULO = '"+c_Modulo+"' "
	c_Query += "AND LEN(ZZR_CHAVE) = '7' "
	c_Query += "ORDER BY ZZR_CHAVE "

	If Select("QRY") > 0
		QRY->(DbCloseArea())
	Endif

	TcQuery c_Query New Alias "QRY"
	
	c_Pai 		:= ""
	c_NewOrder	:= ""
	c_NewPai	:= ""
	
	While QRY->(!Eof())
		If c_Pai == Left(QRY->ZZR_CHAVE, 4)
			c_NewOrder := Soma1(c_NewOrder)
			c_NewPai := c_Pai + "." +c_NewOrder
			If AllTrim(QRY->ZZR_CHAVE) <> c_NewPai
				If AllTrim(QRY->ZZR_FUNCAO) == ""
					fChaveDePara(QRY->ZZR_CHAVE, c_NewPai, ZZR->ZZR_FILIAL, ZZR->ZZR_MODULO)
				Else
					ZZR->(DbGoTo(QRY->RECZZR))
					ZZR->(RecLock("ZZR", .F.))
						ZZR->ZZR_CHAVE := c_NewPai
					ZZR->(MsUnLock())
				Endif
			Endif
			QRY->(DbSkip())
		Else
			c_Pai := Left(QRY->ZZR_CHAVE, 4)
			c_NewOrder	:= "00"
		Endif		
	Enddo

	c_Query := "SELECT ZZR_FILIAL, ZZR_MODULO, ZZR_CHAVE, ZZR_FUNCAO, R_E_C_N_O_ AS RECZZR "
	c_Query += "FROM "+RetSqlName("ZZR")+" " 
	c_Query += "WHERE D_E_L_E_T_ = ' ' "
	c_Query += "AND ZZR_MODULO = '"+c_Modulo+"' "
	c_Query += "AND LEN(ZZR_CHAVE) = '4' "
	c_Query += "ORDER BY ZZR_CHAVE "

	If Select("QRY") > 0
		QRY->(DbCloseArea())
	Endif

	TcQuery c_Query New Alias "QRY"
	
	c_Pai 		:= ""
	c_NewOrder	:= ""
	c_NewPai	:= ""
	
	While QRY->(!Eof())
		If c_Pai == Left(QRY->ZZR_CHAVE, 1)
			c_NewOrder := Soma1(c_NewOrder)
			c_NewPai := c_Pai + "." +c_NewOrder
			If AllTrim(QRY->ZZR_CHAVE) <> c_NewPai
				If AllTrim(QRY->ZZR_FUNCAO) == ""
					fChaveDePara(QRY->ZZR_CHAVE, c_NewPai, ZZR->ZZR_FILIAL, ZZR->ZZR_MODULO)
				Else
					ZZR->(DbGoTo(QRY->RECZZR))
					ZZR->(RecLock("ZZR", .F.))
						ZZR->ZZR_CHAVE := c_NewPai
					ZZR->(MsUnLock())
				Endif
			Endif
			QRY->(DbSkip())
		Else
			c_Pai := Left(QRY->ZZR_CHAVE, 1)
			c_NewOrder	:= "00"
		Endif		
	Enddo

Return Nil

Static Function fChaveDePara(c_TreeDe, c_TreePara, c_Fil, c_Mod)

	Local c_QryUpd 	:= ""
	Local c_TreeDe	:= AllTrim(c_TreeDe)
	Local n_TamDeP	:= Len(AllTrim(c_TreeDe))
	
	c_QryUpd += "UPDATE "+RetSqlName("ZZR")+" "
	c_QryUpd += "SET ZZR_CHAVE = '"+c_TreePara+"'+SUBSTRING(ZZR_CHAVE, "+AllTrim(Str(n_TamDeP+1))+", 10) "
	c_QryUpd += "WHERE ZZR_FILIAL = '"+c_Fil+"' "
	c_QryUpd += "AND ZZR_MODULO = '"+c_Mod+"' "
	c_QryUpd += "AND LEFT(ZZR_CHAVE, "+AllTrim(Str(Len(c_TreeDe)))+") = '"+c_TreeDe+"' "
	c_QryUpd += "AND D_E_L_E_T_ = ' ' "

	TcSqlExec(c_QryUpd)

Return Nil

Static Function MyEnchoBar(oObj, bObjOK, bObjCanc)

Local oBar, lOk, oBtnCut, oBtnEdt, oBtnUsr, oBtnExc, oBtnImp, oBtnNp, oBtnOk, oBtnCanc

DEFINE BUTTONBAR oBar SIZE 25,25 3D TOP OF oObj
If l_Admin
	DEFINE BUTTON oBtnCut 	RESOURCE "S4WB006N"  	OF oBar ACTION (fOptMenu(1))			TOOLTIP "Cut"
	DEFINE BUTTON oBtnPast 	RESOURCE "S4WB007N"   	OF oBar ACTION (fOptMenu(2))			TOOLTIP "Paste"
	DEFINE BUTTON oBtnInc 	RESOURCE "BMPINCLUIR"	OF oBar ACTION (fOptMenu(5))			TOOLTIP "New"
	DEFINE BUTTON oBtnInc 	RESOURCE "BMPINCLUIR"	OF oBar ACTION (fOptMenu(10))			TOOLTIP "Folder"
	DEFINE BUTTON oBtnEdit 	RESOURCE "EDIT"		  	OF oBar ACTION (fOptMenu(6))			TOOLTIP "Edit"
	DEFINE BUTTON oBtnExcl 	RESOURCE "EXCLUIR"    	OF oBar ACTION (fOptMenu(7))			TOOLTIP "Erase"
	DEFINE BUTTON oBtnGrp 	RESOURCE "GROUP"	   	OF oBar ACTION (fOptMenu(11))			TOOLTIP "All Utility"
	DEFINE BUTTON oBtnPrev 	RESOURCE "UP" 		   	OF oBar ACTION (fOptMenu(4))			TOOLTIP "Up"
	DEFINE BUTTON oBtnNext 	RESOURCE "DOWN"	 		OF oBar ACTION (fOptMenu(3))			TOOLTIP "Down"
	DEFINE BUTTON oBtExec  	RESOURCE "DBG06"       	OF oBar ACTION (fOptMenu(9))	 		TOOLTIP "Run"
Else
	DEFINE BUTTON oBtnEdit 	RESOURCE "VERNOTA"	  	OF oBar ACTION (fOptMenu(12))			TOOLTIP "Visual"
	DEFINE BUTTON oBtExec  	RESOURCE "DBG06"       	OF oBar ACTION (fOptMenu(9))	 		TOOLTIP "Run"
Endif
DEFINE BUTTON oBtOk   	RESOURCE "OK"        	OF oBar ACTION (lOk:=Eval(bObjOK)) 		TOOLTIP "Ok"
DEFINE BUTTON oBtCanc	RESOURCE "CANCEL"		OF oBar ACTION (lOk:=Eval(bObjCanc)) 	TOOLTIP "Close"
oBar:bRClicked:={||AllwaysTrue()}

Return Nil