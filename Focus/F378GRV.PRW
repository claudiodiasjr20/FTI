#Include "rwmake.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F378GRV   �Autor  �Felipe Lima de Aguiar � Data �  21/02/18 ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada para gravar os dados do contribuinte no   ���
���          � titulo gerado de PIS/COFINS/CSLL pela rotina de aglutinacao���
���			 � de imposto (FINA378) 									  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function F378GRV()

  Local _cCnpj    := ""
      
     //--- Retornar o CNPJ da Matriz - sempre 01 � Matriz.
     //---  1o. parametro: 02 - CNPJ
     //---  2o. parametro: 01 - Filial 01
     _cCnpj   :=  u_dadosSM0("02","01") 
     
     RECLOCK("SE2",.F.)
        SE2->E2_XCNPJC  := _cCnpj
        SE2->E2_XCONTR  := SM0->M0_NOMECOM   
        SE2->E2_E_APUR  := MV_PAR02  //-- Competencia mes/ano - Parametro Data Final da rotina
     MSUNLOCK()               
    
return