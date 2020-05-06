User Function A103VLEX()
                         
Local n_PosCod   := aScan(aHeader,{|x| AllTrim(x[2])=="D1_COD"}) 
Local n_Item     := aScan(aHeader,{|x| AllTrim(x[2])=="D1_ITEM"})       
Local l_Ret := .T.

	If (l_Ret) 
		dbSelectArea("SE2")
		SE2->(dbSetOrder(6))  //E2_FILIAL, E2_FORNECE, E2_LOJA, E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, R_E_C_N_O_, D_E_L_E_T_
		SE2->(DbGotop())     
		//MsSeek(xFilial()+cA100For+cLoja+cPrefixo+SF1->F1_DUPL) 
		MsSeek(xFilial("SE2")+SF1->(F1_FORNECE+F1_LOJA+F1_SERIE+F1_DUPL))	
		While (!Eof() .And.;
			xFilial("SE2")  == SE2->E2_FILIAL  .And.;
			SF1->F1_FORNECE == SE2->E2_FORNECE .And.;
			SF1->F1_LOJA    == SE2->E2_LOJA    .And.;
			SF1->F1_SERIE   == SE2->E2_PREFIXO .And.;
			SF1->F1_DUPL	== SE2->E2_NUM )
			If SE2->E2_TIPO == "NF "	
				If !Empty(SE2->E2_BAIXA) 
					MSGSTOP("Este documento não pode ser excluído, pois existe titulos baixados no contas a pagar.","INCONSISTÊNCIA")
					l_Ret := .F.
					Exit
				EndIf    
			EndIf 
			dbSelectArea("SE2")
		 	dbSkip()
		EndDo 
	EndIf		

Return(l_Ret)