#include "rwmake.ch"                                                                       

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณF240FIL   บAutor  ณFelipe Lima de Aguiar บ Data ณ  21/02/18 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณ Ponto de entrada para filtrar os titulos do contas a pagar บฑฑ
ฑฑบ          ณ conforme tipo de pagamento do bordero.              		  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function F240FIL()                                                                       

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis utilizadas no programa atraves da funcao    ณ
//ณ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ณ
//ณ identificando as variaveis publicas do sistema utilizadas no codigo ณ
//ณ Incluido pelo assistente de conversao do AP5 IDE                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetPrvt("_cFiltro,")

_cFiltro:=""
If cModPgto == "30"
   
   If cPort240 == "341"                                        
      _cFiltro := " SUBS(E2_CODBAR,1,3)=="+"'"+cPort240+"'"
   Else   
      _cFiltro := " !EMPTY(E2_CODBAR) "
   EndIf                                                                                                 
   
   _cFiltro += " .AND. SUBS(E2_CODBAR,1,1)<>'8' "
   
ElseIf cModPgto == "31"
   
   _cFiltro := " !EMPTY(E2_CODBAR)"
   
   If cPort240 == "341"                                         
      _cFiltro += " .AND. SUBS(E2_CODBAR,1,3)<>"+"'"+cPort240+"'"
   EndIf

   _cFiltro += " .AND. SUBS(E2_CODBAR,1,1)<>'8' "

ElseIf cModPgto == "01"
   _cFiltro := " Empty(E2_CODBAR)  .and. " 
   _cFiltro += "  GetAdvFval('SA2','A2_BANCO',xFilial('SA2')+E2_FORNECE+E2_LOJA,1)  =="+" '"+cPort240+ "'" 

ElseIf cModPgto == "03" 
   _cFiltro := " Empty(E2_CODBAR) .and. "// .and. "
   If cPort240 == "341"                                         
      _cFiltro += " E2_SALDO < 3000 .and. "   
   EndIf
   _cFiltro += " (  !Empty(GetAdvFval('SA2','A2_BANCO',xFilial('SA2')+E2_FORNECE+E2_LOJA,1))  "
   _cFiltro += "  .and. GetAdvFval('SA2','A2_BANCO'  ,xFilial('SA2')+E2_FORNECE+E2_LOJA,1)  <>"+"'"+cPort240+"'  )"

ElseIf cModPgto == "41" .or. cModPgto == "43"
   _cFiltro := " Empty(E2_CODBAR) .and. " 
   If cPort240 == "341"                                         
      _cFiltro += " E2_SALDO >= 3000 .and. "   
   EndIf
   _cFiltro += " (  !Empty(GetAdvFval('SA2','A2_BANCO',xFilial('SA2')+E2_FORNECE+E2_LOJA,1))  "
   _cFiltro += "  .and. GetAdvFval('SA2','A2_BANCO'  ,xFilial('SA2')+E2_FORNECE+E2_LOJA,1)  <>"+"'"+cPort240+"'  )"
 
ElseIf cModPgto == "13"  //--- Concessionarias

   _cFiltro := " !EMPTY(E2_CODBAR) .AND. SUBS(E2_CODBAR,1,1)=='8'"

ElseIf cModPgto == "16"  //--- Darf Normal - Selecionar com codigo de retencao e tipo TX              

   _cFiltro := " ( !Empty(E2_CODRET) .OR. !Empty(E2_CODREC) ) .AND. E2_TIPO == 'TX '"

ElseIf cModPgto == "17"  //--- GPS 

   _cFiltro := " E2_TIPO == 'INS'"

ElseIf cModPgto == "19"  //--- ISS  

   _cFiltro := " E2_TIPO == 'ISS'"

EndIf


Return(_cFiltro)        
