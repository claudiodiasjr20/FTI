/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FTICOM01  �Autor  �Alexandre Sousa     � Data �  08/03/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Aprovacao condicional do bloqueio de fornecedores.          ���
���          �Se A alterar B aprova. Se B alterar C aprova.               ���
�������������������������������������������������������������������������͹��
���Uso       �Especifico clientes FOCUS Consultoria.                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FTICOM01()

	Local c_aprova := GetMv("MV_XAPRFOR")
	
	If !(__cuserid $ c_aprova)
		msgalert('Sr. Usu�rio, voc� n�o tem acesso para liberar, procure o administrador.', "A T E N � � O")
		Return
	EndIf

	If SA2->A2_MSBLQL <> '1'
		msgalert('Esse fornecedore j� se encontra liberado.', 'A T E N � � O')
		Return
	EndIf

	If Empty(SA2->A2_XUSRALT)
		If (substr(alltrim(cUserName),1,15) == alltrim(SA2->A2_XUSRINC))
			msgAlert('Essa inclus�o foi feita pelo usu�rio: '+SA2->A2_XUSRINC+'. E n�o poder� ser liberado pelo mesmo.', 'A T E N � � O')
			Return
		EndIf
	ElseIf (substr(alltrim(cUserName),1,15) == alltrim(SA2->A2_XUSRALT))
		msgAlert('Essa altera��o foi feita pelo usu�rio: '+SA2->A2_XUSRALT+'. E n�o poder� ser liberado pelo mesmo.', 'A T E N � � O')
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
		msgalert('Fornecedor liberado com sucesso!', 'A T E N � � O')
	EndIf

Return
	