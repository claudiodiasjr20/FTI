#Include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F050INS   ºAutor  ³Felipe Lima de Aguiar º Data ³  21/02/18 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada para gravar os dados do contribuinte no   º±±
±±º          ³ titulo gerado de INSS.                					  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function F050INS()

  Local _cRotina  := Alltrim(FunName())
  Local _cNome    := ""
  Local _cFornece := ""
  Local _cLoja    := ""
  Local _cCnpj    := ""
  Local _cRazao   := ""
  Local _cMes     := "" 
  Local _cAno     := "" 

 If _cRotina == "FINA050" .or. _cRotina == "MATA103" .or. _cRotina == "FINA750"
     
     If _cRotina == "FINA050" .or. _cRotina == "FINA750"                  
        _cFornece := M->E2_FORNECE
        _cLoja    := M->E2_LOJA
        _cMes     := Subs(Dtos(M->E2_EMISSAO),5,2) 
        _cAno     := Subs(Dtos(M->E2_EMISSAO),1,4) 
     Else           
        _cFornece := SF1->F1_FORNECE        
        _cLoja    := SF1->F1_LOJA
        _cMes     := Subs(Dtos(SF1->F1_EMISSAO),5,2) 
        _cAno     := Subs(Dtos(SF1->F1_EMISSAO),1,4) 
     EndIf          
     
     _cNome  := GetAdvFval("SA2","A2_NREDUZ",xFilial("SA2")+_cFornece+_cLoja,1)
     _cCnpj  := GetAdvFval("SA2","A2_CGC"   ,xFilial("SA2")+_cFornece+_cLoja,1)
     _cRazao := GetAdvFval("SA2","A2_NOME"  ,xFilial("SA2")+_cFornece+_cLoja,1)

     RECLOCK("SE2",.F.)
     SE2->E2_HIST    := "INSS "+_cNome
     SE2->E2_XCNPJC  := _cCnpj
     SE2->E2_XCONTR  := _cRazao   
     SE2->E2_CODREC := "2631"  // Fixo 2631 porque para terceiros é sempre este.
     SE2->E2_E_APUR  := LastDay(CTOD("01"+"/"+_cMes+"/"+_cAno))  //-- Competencia mes/ano referente a data de emissao da NF
     

     MSUNLOCK()               
    
  EndIf  
RETURN   