#INCLUDE "AP5MAIL.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ FCLoja03 ³ Autor ³Claudio Dias Junior     (Focus Consultoria) ³Data ³ 29/06/16 ³±±
±±³          ³          ³       ³Tiago Dias              (Focus Consultoria) ³Data ³ 29/06/16 ³±±
±±³          ³          ³                                                                     ³±±
±±³          ³          ³       ³Produto de autoria Focus - Lojinha ERP      ³                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil => Nenhum                                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil => Nenhum                                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					  ³±±
±±³              ³  /  /  ³                                               					  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function FCLoja03()

Private o_DlgPrinc
Private o_Folders
Private o_Combo
Private c_AmbPrd	:= SuperGetMV("MV_XAMBPRD", .F., "", Nil)
Private c_ContaTST	:= SuperGetMV("MV_XMAILFC", .F., "", Nil)

c_AmbPrd 	:= AllTrim(c_AmbPrd) 	+ Space(250-Len(AllTrim(c_AmbPrd)))
c_ContaTST 	:= AllTrim(c_ContaTST) 	+ Space(250-Len(AllTrim(c_ContaTST)))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Interface                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG o_DlgPrinc TITLE "Fábrica FOCUS - Configuração de E-mail| Vr.29/06/2016 A | Tel.: 4063-6020" FROM 000,000 To 490,490 PIXEL

oTPaneTOP := TPanel():New(0,0,"",o_DlgPrinc,NIL,.T.,.F.,NIL,NIL,0,15,.T.,.F.)
oTPaneTOP:Align := CONTROL_ALIGN_TOP

oTPaneBOTTOM := TPanel():New(0,0,"",o_DlgPrinc,NIL,.T.,.F.,NIL,NIL,0,20,.T.,.F.)
oTPaneBOTTOM:Align := CONTROL_ALIGN_BOTTOM

oTPaneCENTER := TPanel():New(0,0,"",o_DlgPrinc,NIL,.T.,.F.,NIL,NIL,0,15,.T.,.F.)
oTPaneCENTER:Align := CONTROL_ALIGN_ALLCLIENT

@ 005, 005 FOLDER o_Folders OF oTPaneCENTER ;
PROMPT "E-mail Teste", "Grupos", "Help" ;
PIXEL SIZE 010, 010

o_Folders:Align := CONTROL_ALIGN_ALLCLIENT

//Folder do E-mail Teste
@ 010,005 SAY "MV_XAMBPRD - Informar Ambientes de PRODUCAO " 		PIXEL OF o_Folders:aDialogs[1]
@ 025,005 MSGET c_AmbPrd 	   			SIZE 200,08 				PIXEL OF o_Folders:aDialogs[1]
@ 025,210 Button OemToAnsi("Salvar")	SIZE 030,10 				PIXEL OF o_Folders:aDialogs[1] Action fAtuPar("MV_XAMBPRD")


@ 050,005 SAY "MV_XMAILFC - Informar contas que receberão Testes" 	PIXEL OF o_Folders:aDialogs[1]
@ 065,005 MSGET c_ContaTST 				SIZE 200,08 				PIXEL OF o_Folders:aDialogs[1]
@ 065,210 Button OemToAnsi("Salvar")	SIZE 030,10 				PIXEL OF o_Folders:aDialogs[1] Action fAtuPar("MV_XMAILFC")

@ 090,010 Button OemToAnsi("&FAZER VALIDAÇÃO SENDMAIL")	   	 		SIZE 230,15 PIXEL OF o_Folders:aDialogs[1] Action U_FSEnvMail()

//Folder das Grupos
//@ 010,010 Button OemToAnsi("&6 - VERIFICAÇÃO DE PRODUTOS COM SALDO NÃO INVENTARIADOS")	Size 230,25 PIXEL OF o_Folders:aDialogs[2] Action FAction(6)	//When (l_Admin .Or. c_DepUser == "LOGISTICA")
//@ 040,010 Button OemToAnsi("&7 - AJUSTAR QTD PARA PROCESSO RETROATIVO")					Size 230,25 PIXEL OF o_Folders:aDialogs[2] Action FAction(7)	//When (l_Admin .Or. c_DepUser == "LOGISTICA")

//Folder dos HELP
@ 005,005 SAY "O Parametro 'MV_XAMBPRD' deverá conter os AMBIENTES separados por ';'. Caso o envio do 	"  	PIXEL OF o_Folders:aDialogs[3]
@ 015,005 SAY "E-mail seja feito por algum AMBIENTE diferente do que está sendo especificado no mesmo, o" 	PIXEL OF o_Folders:aDialogs[3]
@ 025,005 SAY "e-mail será enviado para as contas cadastradas no Parâmetro 'MV_XFCMAIL'. No assunto  do " 	PIXEL OF o_Folders:aDialogs[3]
@ 035,005 SAY "mesmo será destacado qual a origem, informando o ambiente.  								" 	PIXEL OF o_Folders:aDialogs[3]
@ 045,005 SAY "                                                                                         "  	PIXEL OF o_Folders:aDialogs[3]
@ 055,005 SAY "Para seguir as regras passadas é necessário fazer uma padronização em todas as FUNÇÕES   "  	PIXEL OF o_Folders:aDialogs[3]
@ 065,005 SAY "responsáveis em enviar o E-mail. Todas deverão ser chamadas pela 'U_FCSendMail', a mesma "  	PIXEL OF o_Folders:aDialogs[3]
@ 075,005 SAY "recebe alguns parâmetros. Segue abaixo especificações:                                   "  	PIXEL OF o_Folders:aDialogs[3]
@ 085,005 SAY "                                                                                         "  	PIXEL OF o_Folders:aDialogs[3]
@ 095,005 SAY " 1º Parâmetro - Conta que será feita a autenticação, via default olhara o 'MV_RELACNT'   "  	PIXEL OF o_Folders:aDialogs[3]
@ 105,005 SAY " 2º Parâmetro - Senha que será feita a autenticação, via default olhara o 'MV_RELAPSW'   "  	PIXEL OF o_Folders:aDialogs[3]
@ 115,005 SAY " 3º Parâmetro - Servidor que será feita a autenticação, via default olhara o 'MV_RELSERV'"  	PIXEL OF o_Folders:aDialogs[3]
@ 125,005 SAY " 4º Parâmetro - Deverá conter a conta de ENVIO do E-mail                                 "  	PIXEL OF o_Folders:aDialogs[3]
@ 135,005 SAY " 5º Parâmetro - Informar contas de DESTINO                                               "  	PIXEL OF o_Folders:aDialogs[3]
@ 145,005 SAY " 6º Parâmetro - Informar contas que ficarão com CÓPIA                                    "  	PIXEL OF o_Folders:aDialogs[3]
@ 155,005 SAY " 7º Parâmetro - Informar o ASSUNTO do E-Mail                                             "  	PIXEL OF o_Folders:aDialogs[3]
@ 165,005 SAY " 8º Parâmetro - Informar CORPO do e-mail   				                                "  	PIXEL OF o_Folders:aDialogs[3]
@ 175,005 SAY " 9º Parâmetro - Informar caminho do ANEXO                                                "  	PIXEL OF o_Folders:aDialogs[3]
@ 185,005 SAY "Obs: a Aba grupos sera desenvolvida                                                      "	PIXEL OF o_Folders:aDialogs[3]

@ 003,010 Button OemToAnsi("&F E C H A R") 									Size 230,15 PIXEL OF oTPaneBOTTOM Action o_DlgPrinc:End()

//Activate Dialog mkwexp centered
ACTIVATE MSDIALOG o_DlgPrinc centered

Return Nil

/***********************************************************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fAtuPar ³ Autor ³Claudio Dias Junior     (Focus Consultoria) ³Data ³ 29/06/16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Função que atualizará/Criará os parâmetros necessários                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_NomPar => Nome do Parâmetro que irá ser criado/alterado                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil => Nenhum                                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fAtuPar(c_NomPar)

If c_NomPar == "MV_XAMBPRD"

	DbSelectArea("SX6")
	DbSetorder(1)
	If !DbSeek("  MV_XAMBPRD", .F.)
		RecLock("SX6", .T.)
			Replace X6_VAR 		With "MV_XAMBPRD"
			Replace X6_TIPO		With "C"
			Replace X6_CONTEUD	With c_AmbPrd
			Replace X6_DESCRIC	With "Informar ambientes que os usuarios deverao receber"
			Replace X6_DESC1	With "os E-mail, por exemplo: PRODUCAO;COMPILA;         "
			Replace X6_DESC2	With "EMERGENCIA; Separar por ';' Ponto e Virgula       "
		MsUnLock()
	Else
		PutMV("MV_XAMBPRD", c_AmbPrd )
	Endif
	
	MsgInfo("Parâmetro atualizado com sucesso!", "Parâmetro => "+c_NomPar)
	
ElseIf c_NomPar == "MV_XMAILFC"

	DbSelectArea("SX6")
	DbSetorder(1)
	If !DbSeek("  MV_XMAILFC", .F.)
		RecLock("SX6", .T.)
			Replace X6_VAR 		With "MV_XMAILFC"
			Replace X6_TIPO		With "C"
			Replace X6_CONTEUD	With c_ContaTST
			Replace X6_DESCRIC	With "Contas de Email resp. em receber os TESTES dos usu"
			Replace X6_DESC1	With "arios. Serao enviados para essa conta email envia-"
			Replace X6_DESC2	With "dos nos ambientes diferentes do Param MV_XAMBPRD  "
		MsUnLock()
	Else
		PutMV("MV_XMAILFC", c_ContaTST)
	Endif
	
	MsgInfo("Parâmetro atualizado com sucesso!", "Parâmetro => "+c_NomPar)
	
EndIf

Return Nil

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³  GetArr  | Autor ³ Claudio Dias Junior (Focus Consultoria)  | Data ³ 03/06/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Separa os itens de uma string em joga dentro de um array.  			         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_Text   => Texto que sera jogado pra dentro do array.                        ³±±
±±³          ³ c_Separ  => Caracter indicador de separacao do texto.                         ³±±
±±³          ³ l_Sobra  => Se .T. adiciona a sobra de texto no array.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ a_Ret    => Array com os itens da string.                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function GetArr(c_Text, c_Separ, l_Sobra)

	Local a_Ret 	:= {}
	Local n_Pos 	:= 0
	Local c_TxtAux	:= ""
	Local c_Aux		:= ""
	
	Default l_Sobra	:= .F.
	
	For n_Pos := 1 To Len(c_Text)
	    
    	c_Aux := SubStr(c_Text, n_Pos, 1)
    	
    	If c_Aux == c_Separ
    		aAdd(a_Ret, c_TxtAux)
    		c_TxtAux := ""
    	Else
    		c_TxtAux += c_Aux
    	Endif

	Next n_Pos
	
	If l_Sobra .And. !Empty(c_TxtAux)
		aAdd(a_Ret, c_TxtAux)
	Endif

Return a_Ret

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ FCSendMail  | Autor ³Claudio Dias (Focus Consultoria)     | Data ³ 29/06/2016 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Envio de e-mail                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametos                                                                	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Parametos                                                                	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

//U_FCSendMail( Nil, Nil, Nil,"claudio.dias@focusconsultoria.net","claudio.dias@focusconsultoria.net","","TESTE","TESTE",Nil)
User Function FCSendMail(cAccount,cPassword,cServer,cFrom,cEmail,cCopia,cAssunto,cMensagem,cAttach)

Local cEmailTo 		:= cEmail
Local cEmailcc 		:= cCopia
Local lResult  		:= .F.
Local cError   		:= ""
Local i        		:= 0
Local cArq     		:= ""
Local a_AmbPrd 		:= ""

Default cAccount 	:= 	GetMV("MV_RELACNT")// PARAMETRO QUE RECEBE O E-MAIL REMETENTE
Default cPassword	:=	GetMV("MV_RELAPSW")// PARAMETRO QUE RECEBE A SENHA
Default cServer		:=	GetMV("MV_RELSERV")// PARAMETRO QUE RECEBE O SERVIDOR SMTP
Default cAttach		:=  ""


CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword RESULT lResult     // CONECTA COM O SERVIDOR SMTP
                   
lAuth := GetMV("MV_RELAUTH")
If lAuth
	lOk := MailAuth (cAccount, GetMV("MV_RELAPSW"))
	If !lOk
		lOk := QAGetMail()
	Endif               
Endif 

If lResult
    
    a_AmbPrd   := GetArr( GetMV("MV_XAMBPRD"), ";", .T. ) // Ambientes de PRODUCAO que deverão enviar para os e-mails configurados 
    n_ExistAmb := aScan(a_AmbPrd, { |x| UPPER(x) == UPPER(AllTrim(GetEnvServer())) })
    
  	If n_ExistAmb == 0 // Se for ZERO Não está na relação de AMBIENTES em PRODUCAO e será enviado para os e-mails TESTE
		cEmailTo := GetMV("MV_XMAILFC") 
		cEmailcc := "" 
		cAssunto := UPPER(AllTrim(GetEnvServer())) + " - " + cAssunto
	Endif 
			
	SEND MAIL FROM cFrom ;       // ENVIA O E-MAIL
	TO      	cEmailTo;
	CC     	    cEmailcc;
	SUBJECT 	cAssunto;
	BODY    	cMensagem;
	ATTACHMENT  cAttach  ;
	RESULT lResult 
		
	If !lResult
		//Erro no envio do email
		GET MAIL ERROR cError
  		Help(" ",1,"ATENCAO",,cError,4,5)
	EndIf
	
	DISCONNECT SMTP SERVER      // DISCONECTA O SERVIDOR SMTP
	
Else

	//Erro na conexao com o SMTP Server 
	GET MAIL ERROR cError
	Help(" ",1,"ATENCAO",,cError,4,5)

EndIf

Return lResult

//***********************************************************************************************************************************************************//