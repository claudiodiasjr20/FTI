#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH"

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � EFELANC    | Autor � Claudio Dias JR ( Focus Consultoria)  | Data � 15/07/15  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Ponto de entrada localizado na efetivacao do Lancamento, Item a Item          ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� Nil                                                             				 ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Nil   	                                                     				 ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI Consulting                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

User Function EFELANC()
                       
Local a_AreaATU := GetArea()

RecLock("CT2", .F.)
	CT2->CT2_CONFST = "1" 
	CT2->CT2_DTCONF = MsDate()
	CT2->CT2_HRCONF = Time()
	CT2->CT2_USRCNF = cUserName
MsUnLock()
	
RestArea(a_AreaATU)

Return Nil

//*************************************************************************************************************************************************/