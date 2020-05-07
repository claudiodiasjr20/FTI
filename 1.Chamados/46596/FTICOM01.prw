#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � FTICOM01 | Autor � Alexandre Sousa                        | Data � 08/03/2015 ���
���Programa  � Revisado | Autor � Claudio Dias Junior (Focus Consultoria)| Data � 06/05/2020 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Aprovacao condicional do bloqueio de fornecedores.                            ���
���          � Se A alterar B aprova. Se B alterar C aprova.                                 ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� Parametro                                                               		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Parametro                                                                     ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� FIT                                                                  		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

User Function FTICOM01()

Local a_AreaATU 	:= GetArea()
Local c_Usuario 	:= cUserName
Local d_Data 		:= MsDate()
Local c_Hora 		:= SubStr(Time(),1,5) 
Local c_UsrAprov  	:= GetMv("MV_XAPRFOR")

If !(__cuserid $ c_UsrAprov)
	MsgAlert("Sr. Usu�rio, voc� n�o tem acesso para liberar! Procure o administrador.", "A T E N � � O")
	Return Nil
EndIf

If SA2->A2_MSBLQL <> "1"
	MsgAlert("Esse fornecedor j� se encontra liberado.", "A T E N � � O")
	Return Nil
EndIf

If Empty(SA2->A2_XUSRALT)
	If (SubStr(alltrim(c_Usuario),1,15) == alltrim(SA2->A2_XUSRINC))
		MsgAlert("Essa inclus�o foi feita pelo usu�rio: "+SA2->A2_XUSRINC+". E n�o poder� ser liberado pelo mesmo.", "A T E N � � O")
		Return Nil
	EndIf
ElseIf (SubStr(alltrim(c_Usuario),1,15) == alltrim(SA2->A2_XUSRALT))
	MsgAlert("Essa altera��o foi feita pelo usu�rio: "+SA2->A2_XUSRALT+". E n�o poder� ser liberado pelo mesmo.", "A T E N � � O")
	Return Nil
EndIf

n_Ret := AxVisual("SA2",SA2->(RECNO()),2,,1)

If n_Ret = 1
//-	Grava LOG de Aprova��o e LIBERA REGISTRO
	RecLock("SA2", .F.)
	SA2->A2_MSBLQL	:= "2"
	SA2->A2_XUSRAPR	:= c_Usuario
	SA2->A2_XDTAPR	:= d_Data
	SA2->A2_XHRAPR	:= c_Hora
	SA2->(MsUnLock())
	MsgAlert("Fornecedor liberado com sucesso!", "A T E N � � O")
EndIf

RestArea(a_AreaATU)

Return Nil

//*********************************************************************************************************************************/