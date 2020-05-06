#include "rwmake.ch"
/*

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CONVLD    ºAutor  ³Felipe Lima de Aguiar º Data ³  21/02/18 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CONVERSAO DE LINHA DIGITAVEL PARA CODIGO DE BARRAS         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

USER FUNCTION CONVLD()
SETPRVT("cStr,cFgts")

cStr := LTRIM(RTRIM(M->E2_LINDIG))

IF VALTYPE(M->E2_LINDIG) == NIL .OR. EMPTY(M->E2_LINDIG)
	// Se o Campo está em Branco não Converte nada.
	cStr := ""
ELSE
	cStr := IF(LEN(cStr)<44,subs(cStr,1,33)+Strzero(val(Subs(cStr,34,14)),14),cStr)                            
    
ENDIF

DO CASE
	CASE LEN(cStr) == 47
		cStr := SUBSTR(cStr,1,4)+SUBSTR(cStr,33,15)+SUBSTR(cStr,5,5)+SUBSTR(cStr,11,10)+SUBSTR(cStr,22,10)
	CASE LEN(cStr) == 48
   
       cFgts := Substr(cStr,17,4)  //--- Posicao 17 - 4 caracteres igual a 0179 ou 0180 ou 0181 significa FGTS
       If cFgts == "0179" .or. cFgts == "0180" .or. cFgts == "0181"                 
          cStr := cStr+SPACE(48-LEN(cStr)) 
       Else
          cStr := SUBSTR(cStr,1,11)+SUBSTR(cStr,13,11)+SUBSTR(cStr,25,11)+SUBSTR(cStr,37,11)
	   EndIf
	OTHERWISE
		cStr := cStr+SPACE(48-LEN(cStr))
ENDCASE

RETURN(cStr)
