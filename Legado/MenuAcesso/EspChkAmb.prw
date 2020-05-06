#INCLUDE "RWMAKE.CH"
#Include "COLORS.ch"
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ESPCHKAMB ³ Autor ³ Douglas Viegas Franca ³ Data ³08/05/2009³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Verifica o Ambiente utilizado                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Aplicacao ³Avisar o usuario que ele esta utilizando um ambiente de TES-³±±
±±³          ³tes.                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³Desenvolvimento FOCUS CONSULTORIA                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               ³±±
±±³              ³        ³                                               ³±±  
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function ESPCHKAMB()                

Local a_User		:= PswRet()   
Local l_Admin		:= .F.
Local l_AmbProd		:= .F.      
Local c_UserMenu	:= AllTrim(Replace(a_User[1][2], ".", "_"))

Private c_Ambiente 	:= AllTrim(GetEnvServer())
Private c_CodUser 	:= RetCodUsr()
Private a_AmbProd	:= {"FTI-Producao","FTI-Emergencia","Compila","Job"} //Informar aqui o nome de todos os ambientes de PRODUCAO

For n_Amb := 1 To Len(a_AmbProd)

	If ( Upper(c_Ambiente) == Upper(a_AmbProd[n_Amb]) )
		l_AmbProd := .T.
	Endif

Next n_Amb

If ( !l_AmbProd )

	oFont22N	:= TFont():New("Verdana",0,22,,.T.,,,,.F.,.F.)  //NEGRITO
	oFont28N	:= TFont():New("Verdana",0,28,,.T.,,,,.F.,.F.)  //NEGRITO
	
	@ 065,000 To 300,600 Dialog oDlgAviso Title OemToAnsi("Aviso Importante")
	@ 020,005 Say OemToAnsi("A t e n ç ã o !!!  Ambiente.: "+c_Ambiente) Size 400,020 Object o_Atencao COLOR CLR_RED
	@ 050,005 Say OemToAnsi("Você está utilizando um ambiente específico para TESTES.") Object o_Texto COLOR CLR_RED
	
	@ 085,130 Button OemToAnsi("Continuar") Size 36,16 Action close(oDlgAviso)
	
	o_Atencao:oFont := oFont28N
	o_Texto:oFont := oFont22N
	
	Activate Dialog oDlgAviso centered

Endif

PSWORDER(1) 

//Verifica se o usuario e administrador      
For i := 1 to Len(a_User[1][10])  
	If a_User[1][10][i] == "000000"
		l_Admin	:= .T. 
		Exit
	EndIf
Next i                                                 	

//Verifica se as configuracoes do menu dos usuarios estao corretas   
If !l_Admin
	For i := 1 to Len(a_User[3])         
		If Substr(a_User[3][i],3,1) <> "X"  
			If !Upper(c_UserMenu) $ Upper(a_User[3][i]) 
				Final("Mod["+Left(a_User[3][i], 2)+"]. Usuario não corresponde ao menu cadastrado, verificar com I.T.")
				Exit	
			EndIf	
		EndIf
	Next i
EndIf
	
Return Nil