#INCLUDE "PROTHEUS.CH"
#INCLUDE "XMLXFUN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "AP5MAIL.CH"

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � FTIJOB01 � Autor � Tiago Silva (Focus) � Data � 16/01/18   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina que gerencia o Job da FTI referente a atualiza��o   ���
���          � automatica das moedas via o Bacen.                         ���
�������������������������������������������������������������������������Ĵ��
���Espec�fico� FTI CONSULTING                                             ���
�������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                           ���
�������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/

User Function FTIJOB01()

//Preparar o Ambiente
Prepare Environment Empresa "05" Filial "01"

ConOut("--------------------------------------------------")
ConOut("- Atualiza��o Moedas Automatica FTI - "+Time())
ConOut("--------------------------------------------------")

U_FTIMD01(.T.)

//Encerro o ambiente
Reset Environment

Return Nil 