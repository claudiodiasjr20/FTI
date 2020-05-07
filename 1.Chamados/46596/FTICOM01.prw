#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ FTICOM01 | Autor ³ Alexandre Sousa                        | Data ³ 08/03/2015 ³±±
±±³Programa  ³ Revisado | Autor ³ Claudio Dias Junior (Focus Consultoria)| Data ³ 06/05/2020 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Aprovacao condicional do bloqueio de fornecedores.                            ³±±
±±³          ³ Se A alterar B aprova. Se B alterar C aprova.                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametro                                                               		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametro                                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FIT                                                                  		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function FTICOM01()

Local a_AreaATU 	:= GetArea()
Local c_Usuario 	:= cUserName
Local d_Data 		:= MsDate()
Local c_Hora 		:= SubStr(Time(),1,5) 
Local c_UsrAprov  	:= GetMv("MV_XAPRFOR")

If !(__cuserid $ c_UsrAprov)
	MsgAlert("Sr. Usuário, você não tem acesso para liberar! Procure o administrador.", "A T E N Ç Ã O")
	Return Nil
EndIf

If SA2->A2_MSBLQL <> "1"
	MsgAlert("Esse fornecedor já se encontra liberado.", "A T E N Ç Ã O")
	Return Nil
EndIf

If Empty(SA2->A2_XUSRALT)
	If (SubStr(alltrim(c_Usuario),1,15) == alltrim(SA2->A2_XUSRINC))
		MsgAlert("Essa inclusão foi feita pelo usuário: "+SA2->A2_XUSRINC+". E não poderá ser liberado pelo mesmo.", "A T E N Ç Ã O")
		Return Nil
	EndIf
ElseIf (SubStr(alltrim(c_Usuario),1,15) == alltrim(SA2->A2_XUSRALT))
	MsgAlert("Essa alteração foi feita pelo usuário: "+SA2->A2_XUSRALT+". E não poderá ser liberado pelo mesmo.", "A T E N Ç Ã O")
	Return Nil
EndIf

n_Ret := AxVisual("SA2",SA2->(RECNO()),2,,1)

If n_Ret = 1
//-	Grava LOG de Aprovação e LIBERA REGISTRO
	RecLock("SA2", .F.)
	SA2->A2_MSBLQL	:= "2"
	SA2->A2_XUSRAPR	:= c_Usuario
	SA2->A2_XDTAPR	:= d_Data
	SA2->A2_XHRAPR	:= c_Hora
	SA2->(MsUnLock())
	MsgAlert("Fornecedor liberado com sucesso!", "A T E N Ç Ã O")
EndIf

RestArea(a_AreaATU)

Return Nil

//*********************************************************************************************************************************/