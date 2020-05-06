/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � FVLDITCTB  |Autor� Flavio Valentin     (Focus Consultoria)| Data � 02/01/2017 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Fun��o para validar Matters Bloqueados                                        ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� Campos: CTD_BLOQ, C6_XITECTB                                                  ���
���          � Consulta Padr�o: CTD Realizado um filtro para apresentar s� os n�o Bloqueados ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � l_Ret                                                                         ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI                                                                     		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

#Include "Protheus.ch"

User Function FVLDITCTB(c_Cpo)

Local l_Ret := .T.
             
dbSelectArea("CTD")
dbSetOrder(1) //CTD_FILIAL, CTD_ITEM, R_E_C_N_O_, D_E_L_E_T_
If dbSeek(xFilial("CTD")+c_Cpo,.F.)
	
	If CTD->CTD_BLOQ == "1"
		l_Ret := .F.
		MsgStop("Este MATTER encontra-se bloqueado para uso.","Inconsist�ncia")
	EndIf      
	           
	If CTD->CTD_CLASSE<>"2" // ANALITICO
		l_Ret := .F.
		MsgStop("Este MATTER NAO eh Analitico - Corrigir Cadastro Matter","Inconsist�ncia")
	EndIf      
	
Else
	l_Ret := .F.
	MsgStop("Registro n�o encontrado","Inconsist�ncia")
EndIf

Return(l_Ret)