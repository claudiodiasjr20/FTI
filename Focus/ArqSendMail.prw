#INCLUDE "AP5MAIL.CH"
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ArqSendMail()| Autor ³Tiago Dias (Focus Consultoria)| Data ³ 05/08/14 		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Envio de e-mail                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cAccount,cPassword,cServer,cFrom,cEmail,cCopia,cAssunto,cMensagem,cAttach     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil                                                               	     	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI Consulting                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function ArqSendMail(cAccount,cPassword,cServer,cFrom,cEmail,cCopia,cAssunto,cMensagem,cAttach)

Local cEmailTo 	:= cEmail
Local cEmailcc 	:= cCopia
Local lResult  	:= .F.
Local cError   	:= ""
Local i        	:= 0
Local cArq     	:= ""	 

Private x_Mensagem 	:= cMensagem
Private c_Texto1 	:= "" 
Private c_Texto2 	:= "" 
Private c_Texto3 	:= "" 

Default cAccount 	:= 	GetMV("MV_RELACNT")
Default cPassword	:=	GetMV("MV_RELAPSW")
Default cServer		:=	GetMV("MV_RELSERV")


If ValType(x_Mensagem) == "A"
	fAdapText()
Else   
	c_Texto1 := x_Mensagem
EndIf


CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword RESULT lResult
                                                                         
                        
lAuth := GetMV("MV_RELAUTH")
If lAuth
	lOk := MailAuth (cAccount, GetMV("MV_RELAPSW"))
	If !lOk
		lOk := QAGetMail()
	Endif               
Endif

If lResult
/*
	//////////////////////////////////////////////////////////////
	//INSERIDO POR DOUGLAS V. FRANCA EM 09/06/04                //
	//MOTIVO.: E-MAILS DE TESTES ESTAVAM INDO PARA OS USUARIOS. //
	//////////////////////////////////////////////////////////////
	If Upper(AllTrim(GetEnvServer())) <> "PRODUCAO"
		cEmailTo := ""
		cEmailcc := ""
	Endif
	////////////////////////
	//TERMINO DA ALTERACAO//
	//////////////////////// 
*/
	SEND MAIL FROM cFrom ;
	TO      	cEmailTo;
	CC     	    cEmailcc;
	SUBJECT 	IIF( !Empty(c_Texto2), cAssunto + " - PARTE 1", cAssunto );
	BODY    	c_Texto1;
	ATTACHMENT  cAttach ;
	RESULT lResult
	If !lResult
		//Erro no envio do email
		GET MAIL ERROR cError
		Help(" ",1,"ATENCAO",,cError,4,5)
	EndIf
	
	If !Empty(c_Texto2)
		SEND MAIL FROM cFrom ;
		TO      	cEmailTo;
		CC     	    cEmailcc;
		SUBJECT 	cAssunto + " - PARTE 2";
		BODY    	c_Texto2;
		ATTACHMENT  cAttach ;
		RESULT lResult
		If !lResult
			//Erro no envio do email
			GET MAIL ERROR cError
			Help(" ",1,"ATENCAO",,cError,4,5)
		EndIf
	EndIf  
	
	If !Empty(c_Texto3)
		SEND MAIL FROM cFrom ;
		TO      	cEmailTo;
		CC     	    cEmailcc;
		SUBJECT 	cAssunto+ " - PARTE 3";
		BODY    	c_Texto3;
		ATTACHMENT  cAttach ;
		RESULT lResult
		
		If !lResult
			//Erro no envio do email
			GET MAIL ERROR cError
			Help(" ",1,"ATENCAO",,cError,4,5)
		EndIf
	EndIf
		
	DISCONNECT SMTP SERVER
Else
	//Erro na conexao com o SMTP Server
	GET MAIL ERROR cError
	
	Help(" ",1,"ATENCAO",,cError,4,5)
EndIf

Return(lResult)

//****************************************************************************************************************//

Static Function fAdapText()

For i := 1 To Len(x_Mensagem)

	If Len(c_Texto1) < 1000000
		c_Texto1 += x_Mensagem[i]
	Else      
		If Len(c_Texto2) < 1000000
			c_Texto2 += x_Mensagem[i]
		Else
			c_Texto3 += x_Mensagem[i]
		EndIf
	EndIf
	
Next i

Return Nil

//****************************************************************************************************************//