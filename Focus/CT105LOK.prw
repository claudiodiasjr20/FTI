/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CT105LOK  �Autor  �Alexandre Sousa     � Data �  07/31/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada durante a validacao de linhas do lancto    ���
���          �contabil. Usado para atualizar os campos de tipo de saldo.  ���
�������������������������������������������������������������������������͹��
���Uso       �Especifico clientes FOCUS Consultoria.                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CT105LOK()

IF Left(FunName(),7) $ 'CTBA102/CTBA103/CTBA101'

 	M->CT2_TPSALD := '9'
 	M->CT2_ORIGEM := Alltrim('LANC MANUAL EM: ' + DTOC(MSDATE()) + " POR: " + cUserName)

	RecLock('TMP', .F.)                                                         
		TMP->CT2_TPSALD := '9'
		TMP->CT2_ORIGEM := Alltrim('LANC MANUAL EM: ' + DTOC(MSDATE()) + " POR: " + cUserName)
	MsUnLock()

EndIf 

Return .T.