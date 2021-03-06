#INCLUDE 'RWMAKE.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F430VAR   �Autor  �Felipe Lima de Aguiar � Data �  21/02/18 ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de Entrada para retornar Juros e Multa quando nao    ���
���          � tiver no arquivo de retorno do banco.   					  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

USER FUNCTION F430VAR()

Local _aAreaSE2 := GetArea()    
Local _nDescon  := 0
Local _nAcresc  := 0

If !Empty(cNumTit)

   //Busca por IdCnab (sem filial)
   SE2->(dbSetOrder(13)) // IdCnab
   If SE2->(MsSeek(Substr(cNumTit,1,10)))
      
      _nAcresc  := Round(NoRound(xMoeda(SE2->E2_SDACRES,SE2->E2_MOEDA,1,dBaixa,3),3),2)
	  _nDecres  := Round(NoRound(xMoeda(SE2->E2_SDDECRE,SE2->E2_MOEDA,1,dBaixa,3),3),2)

      If (nMulta+nJuros) = 0 .and. _nAcresc > 0
        
          nMulta := _nAcresc
      
      EndIf
      
      If (nDescont) = 0 .and. _nDecres > 0
        
          nDescont := _nDecres
      
      EndIf

   Endif
		


EndIf

RestArea(_aAreaSE2)
	
Return()