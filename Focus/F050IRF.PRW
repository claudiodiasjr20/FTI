#Include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F050IRF   ºAutor  ³Felipe Lima de Aguiar º Data ³  21/02/18 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada para gravar histórico no titulo de IRRF   º±±
±±º          ³ Código da Retenção e Gera Dirf SIM.                 		  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function F050IRF()

  Local _cRotina  := Alltrim(FunName())
  Local _cCnpj    := ""
  Local _cMes     := "" 
  Local _cAno     := "" 
  
  If _cRotina == "FINA050" .or. _cRotina == "MATA103" .or. _cRotina == "FINA750"
     
      _cMes     := Subs(Dtos(SE2->E2_VENCREA),5,2) 
      _cAno     := Subs(Dtos(SE2->E2_VENCREA),1,4) 
                                                                                     
      
      //--- Retornar o CNPJ da Matriz - sempre 01 é Matriz.
      //---  1o. parametro: 02 - CNPJ
      //---  2o. parametro: 01 - Filial 01
      _cCnpj   :=  u_dadosSM0("02","01") 
 
     
     RECLOCK("SE2",.F.)
     If Empty(Alltrim(SE2->E2_CODRET))
        SE2->E2_CODRET  := "1708"
     EndIf
     SE2->E2_DIRF        := "1"
     SE2->E2_XCNPJC   := _cCnpj
     SE2->E2_XCONTR  := SM0->M0_NOMECOM   
     SE2->E2_E_APUR  := (CTOD("01"+"/"+_cMes+"/"+_cAno)-1)  //-- Competencia mes/ano - Ultimo dia do mes anterior a data do vencimento do imposto
     SE2->E2_HIST       := _cRotina+" "+SE2->E2_CODRET
     
     MSUNLOCK()               
  
  Else
  
     RECLOCK("SE2",.F.)
     SE2->E2_HIST       := _cRotina+" "+SE2->E2_CODRET
     MSUNLOCK()               
  
  EndIf

RETURN   