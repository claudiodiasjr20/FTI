/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT450END  �Autor  �Alexandre Sousa     � Data �  08/05/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada durante a aprovacao do pedido de vendas    ���
���          �(credito) usado para gravar informacoes de log.             ���
�������������������������������������������������������������������������͹��
���Uso       �Especifico clientes Focus Consultoria.                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MT450END()

	RecLock('SC5', .F.)
	SC5->C5_XUSRAPR	:= cusername
	SC5->C5_XDTAPR	:= ddatabase
	SC5->C5_XHRAPR	:= substr(time(),1,5)
	MsUnLock()


Return