/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FTICOM01  ºAutor  ³Alexandre Sousa     º Data ³  08/03/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Aprovacao condicional do bloqueio de fornecedores.          º±±
±±º          ³Se A alterar B aprova. Se B alterar C aprova.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico clientes FOCUS Consultoria.                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FTICOM01()

	Local c_aprova := GetMv("MV_XAPRFOR")
	
	If !(__cuserid $ c_aprova)
		msgalert('Sr. Usuário, você não tem acesso para liberar, procure o administrador.', "A T E N Ç Ã O")
		Return
	EndIf

	If SA2->A2_MSBLQL <> '1'
		msgalert('Esse fornecedore já se encontra liberado.', 'A T E N Ç Ã O')
		Return
	EndIf

	If Empty(SA2->A2_XUSRALT)
		If (substr(alltrim(cUserName),1,15) == alltrim(SA2->A2_XUSRINC))
			msgAlert('Essa inclusão foi feita pelo usuário: '+SA2->A2_XUSRINC+'. E não poderá ser liberado pelo mesmo.', 'A T E N Ç Ã O')
			Return
		EndIf
	ElseIf (substr(alltrim(cUserName),1,15) == alltrim(SA2->A2_XUSRALT))
		msgAlert('Essa alteração foi feita pelo usuário: '+SA2->A2_XUSRALT+'. E não poderá ser liberado pelo mesmo.', 'A T E N Ç Ã O')
		Return
	EndIf

	n_ret := AxVisual("SA2",SA2->(RECNO()),2,,1)
	
	If n_ret = 1
		RecLock('SA2', .F.)
		SA2->A2_MSBLQL := '2'
		SA2->A2_XUSRAPR := cusername
		SA2->A2_XDTAPR	:= ddatabase
		SA2->A2_XHRAPR	:= substr(time(),1,5)
		MsUnLock()
		msgalert('Fornecedor liberado com sucesso!', 'A T E N Ç Ã O')
	EndIf

Return
	