#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH"

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  �  GetArr  | Autor � Claudio Dias Junior (Focus Consultoria)  | Data � 03/06/09 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Separa os itens de uma string em joga dentro de um array.  			         ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� c_Text   => Texto que sera jogado pra dentro do array.                        ���
���          � c_Separ  => Caracter indicador de separacao do texto.                         ���
���          � l_Sobra  => Se .T. adiciona a sobra de texto no array.                        ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � a_Ret    => Array com os itens da string.                                     ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FISCHER BRASIL                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

User Function GetArr(c_Text, c_Separ, l_Sobra)

	Local a_Ret 	:= {}
	Local n_Pos 	:= 0
	Local c_TxtAux	:= ""
	Local c_Aux		:= ""
	
	Default l_Sobra	:= .F.
	
	For n_Pos := 1 To Len(c_Text)
	    
    	c_Aux := SubStr(c_Text, n_Pos, 1)
    	
    	If c_Aux == c_Separ
    		aAdd(a_Ret, c_TxtAux)
    		c_TxtAux := ""
    	Else
    		c_TxtAux += c_Aux
    	Endif

	Next n_Pos
	
	If l_Sobra .And. !Empty(c_TxtAux)
		aAdd(a_Ret, c_TxtAux)
	Endif

Return a_Ret

//**********************************************************************************************************************************************************//
