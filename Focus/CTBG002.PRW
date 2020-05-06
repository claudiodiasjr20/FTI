#INCLUDE "RWMAKE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma   ³ CTBG002  º Autor ³ Sidnei Naconesky - FOCUS  ºData³04.11.2015º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao  ³ Verifica se necessita do CCUSTO a partir da Conta Contabil   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros ³ Conta Contábil - verifica a obrigatoriedade no Plano Contas  º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBG002(c_Conta) 

Local a_AreaATU   := GetArea()
Local c_Retorno   := ""
Local c_AceitaCC  := "2" // False
Local c_ParaRET   := GetMV('MV_XCCPADR')
Local c_CCSE2	  := IIF(!EMPTY(SE2->E2_CCD),SE2->E2_CCD,Posicione("SD1",1,xFilial("SD1")+SE2->E2_NUM+SE2->E2_PREFIXO+SE2->E2_FORNECE+SE2->E2_LOJA,"D1_CC"))
//				     Essa Condição foi solicitada no Projeto - se o Titulo nao tiver CCUSTO vai buscar na Nota de Origem // 

DbSelectArea("CT1")
DbSetOrder(1)
DbGoTop()
If DbSeek(xFilial("CT1")+c_Conta)
	c_AceitaCC	 := CT1->CT1_CCOBRG
Else
	c_AceitaCC	 := "2"
EndIf

If 	c_AceitaCC == "1" 
	c_Retorno := IIf( !Empty(c_CCSE2), c_CCSE2 , c_ParaRET )
Endif

RestArea(a_AreaATU)
Return c_Retorno
//**********************************************************************************************************************************************************//