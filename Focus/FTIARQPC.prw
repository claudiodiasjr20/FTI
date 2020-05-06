#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ U_FTIARQPC() |  Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 16/12/14  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Programa que lê arquivo da Empresa FTI e importa as informações em uma rotina ´±±
±±³			   automatica que gera um Pedido de Compra										 ´±±	                            
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil				                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil				                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI-Consulting                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Tiago Silva   ³04/02/20³ Chamado 45799                                               	 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function FTIARQPC()

Local oDlg 
Local a_AreaATU		:= GetArea()
Local a_Say    		:= {}
Local a_Button 		:= {}

Private l_Arq		:= .F.
Private l_Ret		:= .F.
Private l_Ok        := .F. 
Private lMsErroAuto := .F.
Private a_Dados  	:= {}
Private c_Caminho   := ""
Private c_CondPag	:= Space(30)
Private c_Titulo	:= "Importação de Arquivos - 04022020"

Default l_Job := .F.

//+----------------------------------------------------------------------------
//| Monta tela de interacao com usuario
//+----------------------------------------------------------------------------
aAdd(a_Say,"Este programa tem como objetivo Importar o Arquivo Texto do")
aAdd(a_Say,"ChromeRiver e gerar um Pedido de Compra.")

aAdd(a_Button, { 14 ,.T.,{|| l_Ret := .T., fCargaArq(1), FechaBatch()	}})
aAdd(a_Button, { 2  ,.T.,{|| FechaBatch()		 	   					}})

FormBatch(c_Titulo,a_Say,a_Button)			 

RestArea(a_AreaATU)

Return Nil  

/*******************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±	
±±³Programa  ³ fCargaArq() |  Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 16/12/14  	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Programa que realiza a importação do Arquivo Texto para um Pedido de Compra	 	 ´±±	                            
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nLinTitE - Quantas linhas de cabeçalho que não serão integradas possui o arquivo	 ´±± 					 					                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil				                                                             	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fCargaArq(n_LinTitE)   

Local oDlg
Local oCaminho
Local oCondPag
Local oMacro  
Local n_Lin       	:= 20
Local c_Msg       	:= "" 

Private a_File		:= {}
Private n_File		:= 0
Private c_EOL     	:= Chr(13)+Chr(10)			
Private c_Observa	:= "" 
Private n_LinTit    := If(ValType(n_LinTitE)=="N",n_LinTitE,0)
Private a_Arquivos  := {}
Private a_Arq	  	:= {}
Private c_Arq       := ""
Private c_Origem    := ""
Private c_NumPc		:= "" 
Private l_Erro		:= .T.
Private c_MailTexto := "" 
Private	l_AuxiRet	:=.F.

c_Caminho += Space(99-(Len(c_Caminho)))

//Clicou Botao Abrir
While(l_Ret)   
	Define MsDialog oDlg Title 'Importação de Arquivos' From 7,10 To 20,70 Of oMainWnd              
	@ 20 ,15  Say      	'Caminho do Arquivo :'                         				Of oDlg 	 Pixel  
	@ 30 ,15  MsGet    	oCaminho	Var c_Caminho	Picture "@!"     Size 200,09   	Of oDlg 	 Pixel
	@ 30 ,218 Button	"..."	Size  13,12 	Pixel Of oDlg Action c_Caminho := cGetFile('Arquivos .txt |*.txt' , 'Selecione o Caminho do Arquivo ', 1, '', .T., GETF_LOCALHARD+GETF_LOCALFLOPPY) //GETF_LOCALHARD+GETF_RETDIRECTORY ,.F., .T.)   
	@ 50 ,15  Say      	'Condição de Pagamento (Consulta via [F3]) :'               Of oDlg 	 Pixel  
	@ 60 ,15  MsGet    	oCondPag	Var c_CondPag	F3 "SE4" Picture "@"  Size 30,09   Of oDlg 	 Pixel 
	n_Lin += 15
    Define SButton From 73, 180 Type 01 Action (l_Ok := .T. , oDlg:End()) Enable Of oDlg   	
    Define SButton From 73, 210 Type 02 Action (l_Ok := .F. , oDlg:End()) Enable Of oDlg   	
   	Activate MsDialog oDlg Center
	If (Empty(c_Caminho) .Or. Empty(c_CondPag)) .And. l_Ok == .T.
		Alert("Por favor, preencha o Campo Caminho do Arquivo e Condição de Pagamento")	
   		l_Ret 	:= .T.
   	ElseIf !(l_Ok)
   		l_Ret 	:= .F.
   		Return Nil
   	Else
   		l_Ret 	:= .F.
   	EndIf 
EndDo

//Busca todos os arquivos aa serem processados
a_File := Directory(c_Caminho)

If Len(a_File) == 0
	l_OK := .F.
	c_Observa := "Não existem arquivos a serem importados"
	If ( !l_Job )
		MsgAlert(c_Observa, "Importação de Arquivo - Atenção")
	Endif
EndIf

If l_OK

	//Processa todos os arquivos
	For n_File := 1 To Len(a_File)
	
		l_OK 	:= .T.             
		c_File	:= a_File[n_File][1]
		
		nHandle := FT_FUse(c_Caminho)
		If ( nHandle = -1 )
			l_OK := .F.
			c_Observa := "Não existem arquivos a serem importados"
			MsgAlert(c_Observa, "Importação de Arquivo - Atenção")
		EndIf
		
		Processa({|| l_Erro := fCargArray(c_Caminho)},, "Realizando Importações...")
					
		If l_Erro
			c_Observa := "Arquivo Importado. "
			MsgInfo(c_Observa, "Importação de Arquivos - Sucesso")
		Else     
			c_Observa := "Arquivo não Importado. "
			MsgStop(c_Observa, "Importação de Arquivos - Erro")
			l_OK := .F.
		EndIf
		
		FClose( c_Caminho )
				
	Next n_File
	
	MsgInfo( "As Informações serão enviadas por Email", "I N F O R M A T I V O" )

	//Verificar quais informações usar para enviar o email
	//	c_From 		:= "fti@focusconsultoria.net"
	c_From 		:= GetMV("MV_RELACNT")
	c_Email		:= GetMV("MV_XPCCHRO")
	c_Copia		:= ""
	c_Assunto	:= "FTI - Importacao dos Arquivos Chrome River"
	c_Mensagem	:= c_MailTexto
	c_Attach	:= "" 
	
	//Começa o processo de Envio do E-mail
	If GetMV("MV_XENVML") // Parametro criado para desabilitar o envio do e-mail quando a contade disparo tiver problemas REF Chamado.: 35179 
		//U_ArqSendMail(,,,c_From,c_Email,c_Copia,c_Assunto,c_Mensagem,c_Attach)
		//Nova chamada padronizada de E-mail
		U_FCSendMail(,,,c_From,c_Email,c_Copia,c_Assunto,c_Mensagem,c_Attach)	
	EndIf
	
EndIf

Return Nil

/*******************************************************************************************************************/
 
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±	
±±³Programa  ³ fCargArray() |  Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 30/10/14  	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Função chamada para carregar dados do csv no array pra retorno		 	 	 	 ´±±	                            
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_Arq - Nome do arquivo que será usado  					 			 	 		 ´±±					 ´±±                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ l_Erro                                                          					 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fCargArray(c_Arq)

Local c_Linha  		:= ""
Local n_Lin    		:= 1 
Local n_TotLin 		:= 0
Local a_LinCabec 	:= "" 
Local aItens		:= {}
Local aCabec 		:= {}
Local aLinha		:= {}
Local c_File   		:= c_Arq
Local n_Handle 		:= 0 

Private a_NumPed	:= {}
Private a_TotPed	:= {}                         
Private a_Diver		:= {}
Private c_IDCHRO 	:= ""
Private c_PRODCHRO 	:= ""
Private n_TotalPed	:= 0
Private c_xCC		:= "" //Ch. 45799

//Abre o arquivo 
n_Handle := Ft_Fuse(c_File)
If n_Handle == -1
   Return a_Dados
EndIf
Ft_FGoTop()                                                         
n_LinTot := FT_FLastRec()-1
ProcRegua(n_LinTot)
 
//-------------------------------------------//
//    Monta o cabecalho do arquivo           //
//-------------------------------------------//
a_LinCabec 	:= U_GetArr(FT_FReadln(), "|", .T.)
                                               
//---------------------------------------------------------------//
//   Valida se todos os campos obrigatorios estao no arquivo     //
//---------------------------------------------------------------//
Private n_ID		:= aScan (a_LinCabec, "ID")
Private n_LFN		:= aScan (a_LinCabec, "Last Name, First Name")
Private n_RID		:= aScan (a_LinCabec, "Report ID")
Private n_LNUM		:= aScan (a_LinCabec, "Line Number")
Private n_MNUM		:= aScan (a_LinCabec, "Matter Number")
Private n_CCO	  	:= aScan (a_LinCabec, "Cost Code Override")
Private n_EXTY		:= aScan (a_LinCabec, "Expense Type")
Private n_PAYME		:= aScan (a_LinCabec, "Pay Me", 26, 30)

//Pula as linhas de cabeçalho
While n_LinTit > 0 .AND. !Ft_FEof()
   Ft_FSkip()
   n_LinTit--
EndDo

//Monta o Array com as informações do Arquivo
While !FT_FEof()	
	IncProc()	
	aAdd(a_Dados, U_GetArr(FT_FReadln()+"|DIVERGECIA", "|", .T.) )
	FT_FSkip() 	
EndDo
                                            	
//VALIDACAO dos Campos dentro do Arquivo
l_Erro := fValida()

//Se Report ID já foi importado, pergunta se deseja importar novamente
For n := 1 To Len(a_Dados)
	If " Report ID já importado " $ a_Dados[n][Len(a_Dados[n])]
		If ApMsgYesNo("Report ID já importado, deseja importar novamente?","Importação de Arquivos") 		
			l_Erro  := .T.
			If l_AuxiRet
				l_Erro  := .F.
			EndIf
			Exit
		Else 
		    l_Erro  := .F.
		    Exit
		EndIf 
	EndIf 
Next n

If l_Erro
	DbSelectArea("SC7") 
	n_Pos 	:= 1
	n 		:= 1
	While n_Pos <= Len(a_Dados)
	    
	    aItens		:= {}
		n_IdAux		:= a_Dados[n][n_ID]
		c_IDCHRO	:= a_Dados[n][n_ID]

		While n_Pos <= Len(a_Dados) .And. a_Dados[n][n_ID] == n_IdAux
		    
		    n_TotalPed	:= 0
		    aCabec 		:= {}
   			aItens 		:= {}
   			c_PRODCHRO 	:= a_Dados[n][n_CCO]
			//Query para obter Informações do Fornecedor e Produto
			fQuery()
			//c_NumPc 	:= GetSXENum("SC7","C7_NUM")
			//ConfirmSX8()
			aAdd(a_NumPed,{a_Dados[n][n_RID], c_NumPc, Nil}) 
			n_Item		:= 0001	
			n_RIDAux	:= a_Dados[n][n_RID]
			
			//aAdd(aCabec, {"C7_NUM"		,c_NumPc				 })
		 	aAdd(aCabec, {"C7_EMISSAO"	,dDataBase				 })
		    aAdd(aCabec, {"C7_FORNECE"	,CVALTOCHAR(QRYF->FORNEC)})
			aAdd(aCabec, {"C7_LOJA"		,CVALTOCHAR(QRYF->LOJA)  })
		    aAdd(aCabec, {"C7_COND"		,ALLTRIM(c_CondPag)		 })
			aAdd(aCabec, {"C7_FILENT"  	,xFilial("SC7")   		 }) 
         	aAdd(aCabec, {"C7_CONTATO" 	," "    	   			 })
		    
		    While n_Pos <= Len(a_Dados) .And. a_Dados[n][n_ID] == n_IdAux .And. a_Dados[n][n_RID] == n_RIDAux
		        
		        c_PRODCHRO 	:= a_Dados[n][n_CCO]  
			  	c_IctaF 	:= SUBSTR(a_Dados[n][n_MNUM],1,6) + SUBSTR(a_Dados[n][n_MNUM],8)
		        c_xCC 		:= AllTrim(GetAdvFVal("CTD","CTD_XCC",xFilial("CTD")+c_IctaF,1,"")) //Ch. 45799                                        
		        //Query para obter Informações do Fornecedor e Produto
				fQuery()
		                                                                                                
				aAdd(aLinha, {"C7_ITEM"   	,CVALTOCHAR(STRZERO(n_Item,4))	,Nil})
				aAdd(aLinha, {"C7_PRODUTO"	,CVALTOCHAR(a_Dados[n][n_CCO])	,Nil})    
			    aAdd(aLinha, {"C7_UM"		,QRYP->UM						,Nil})             
			    aAdd(aLinha, {"C7_DESCRI"	,QRYP->DESCRI			 		,Nil})
			    aAdd(aLinha, {"C7_QUANT" 	,1 								,Nil})
			    aAdd(aLinha, {"C7_PRECO" 	,VAL(a_Dados[n][n_PAYME])		,Nil})
			    aAdd(aLinha, {"C7_TOTAL" 	,VAL(a_Dados[n][n_PAYME])		,Nil})
			    aAdd(aLinha, {"C7_LOCAL" 	,QRYP->LOCPAD					,Nil})    
			  	aAdd(aLinha, {"C7_ITEMCTA"  ,c_IctaF						,Nil})    
			  	aAdd(aLinha, {"C7_CC"  		,c_xCC							,Nil}) //Ch. 45799    
			    aAdd(aLinha, {"C7_XIDRPT"	,CVALTOCHAR(a_Dados[n][n_RID])	,Nil})
			    aadd(aLinha, {"C7_TES" 		,QRYP->TES						,Nil})
			    aadd(aItens, aLinha)
			    
			    aLinha := {}
			    n_TotalPed += VAL(a_Dados[n][n_PAYME]) 
			    n++
			    n_Pos++
				n_Item++
				DbSkip() 
				
			EndDo 
			    
				aAdd(a_TotPed,{c_NumPc, n_TotalPed, Nil})
			
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//| Inclusao do Pedido de Compra 								 |
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				MSExecAuto({|x,y,z,w| Mata120(x,y,z,w)},1, aCabec, aItens, 3)
				
				//Atualiza o número do pedido incluído
				a_NumPed[Len(a_NumPed)][2] := SC7->C7_NUM
				a_TotPed[Len(a_TotPed)][1] := SC7->C7_NUM
			
				If lMsErroAuto     
					MostraErro()
				EndIf 				
		EndDo	
	EndDo 
EndIf	

//libera o arquivo
FT_FUse() 

//Monta todo o Corpo do E-mail
c_MailTexto := fMailTexto()            

Return l_Erro

/*******************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±	
±±³Programa  ³ fValida() |  Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 20/12/14  	 	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Função que valida as informações do Arquivo ChromeRiver						 	 ´±±	                            
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil						 			 	 							 			 ´±±                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ l_Erro                                                            	 			 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fValida()

Private c_IDCHRO 	:= ""
Private c_PRODCHRO 	:= ""
     
For n := 1 To Len(a_Dados)
    
    l_RetOk 	:= .T.
    c_IDCHRO 	:= a_Dados[n][n_ID]
	c_PRODCHRO 	:= a_Dados[n][n_CCO]
	//Query para obter Informações do Fornecedor e Produto
	fQuery()	  
      
	DBSelectArea("SC7")
	DBOrderNickName("IDRPT")	//C7_FILIAL, C7_XIDRPT, R_E_C_N_O_, D_E_L_E_T_
	DBGoTop()
	If DBSeek (xfilial("SC7")+a_Dados[n][n_RID])
		If a_Dados[n][Len(a_Dados[n])] == "DIVERGECIA"
			a_Dados[n][Len(a_Dados[n])] := " Report ID já importado "
		Else
			a_Dados[n][Len(a_Dados[n])] += " Report ID já importado "
		EndIf
	    l_Erro  := .F.
		l_RetOk := .F.
	EndIf

	DBSelectArea("SA2")
	DBOrderNickName("IDCHRO")	//A2_FILIAL, A2_XIDCHRO, R_E_C_N_O_, D_E_L_E_T_
	DBGoTop()
	If !DBSeek (xfilial("SA2")+a_Dados[n][n_ID])
		If a_Dados[n][Len(a_Dados[n])] == "DIVERGECIA"
			a_Dados[n][Len(a_Dados[n])] := " Fornecedor não Cadastrado "
		Else
			a_Dados[n][Len(a_Dados[n])] += " Fornecedor não Cadastrado "
		EndIf
		l_Erro  	:= .F.
		l_RetOk 	:= .F.
		l_AuxiRet	:= .T.
	EndIf 
	
	If VAL(QRYF->BLOQ) == 1
		If a_Dados[n][Len(a_Dados[n])] == "DIVERGECIA"
			a_Dados[n][Len(a_Dados[n])] := " Fornecedor Bloqueado "
		Else
			a_Dados[n][Len(a_Dados[n])] += " Fornecedor Bloqueado "
		EndIf
		l_Erro  	:= .F.
		l_RetOk 	:= .F.
		l_AuxiRet	:= .T.
	   
	EndIf

	DBSelectArea("SB1")
	DBSetOrder(1)				//B1_FILIAL, B1_COD, R_E_C_N_O_, D_E_L_E_T_ 
	DBGoTop()
	If !DBSeek (xfilial("SB1")+a_Dados[n][n_CCO])
		If a_Dados[n][Len(a_Dados[n])] == "DIVERGECIA"
			a_Dados[n][Len(a_Dados[n])] := " Produto não Cadastrado "
		Else
			a_Dados[n][Len(a_Dados[n])] += " Produto não Cadastrado "
		EndIf
		l_Erro  	:= .F.
		l_RetOk 	:= .F.
		l_AuxiRet	:= .T.
	EndIf 
	
	If VAL(QRYP->BLOQ) == 1
		If a_Dados[n][Len(a_Dados[n])] == "DIVERGECIA"
			a_Dados[n][Len(a_Dados[n])] := " Produto Bloqueado "
		Else
			a_Dados[n][Len(a_Dados[n])] += " Produto Bloqueado "
		EndIf
		l_Erro  	:= .F.
		l_RetOk 	:= .F.
		l_AuxiRet	:= .T.
	EndIf
	
	DBSelectArea("CTD")
	DBSetOrder(1)				//CTD_FILIAL, CTD_ITEM, R_E_C_N_O_, D_E_L_E_T_
	DBGoTop()
	c_IctaF := SUBSTR(a_Dados[n][n_MNUM],1,6) + SUBSTR(a_Dados[n][n_MNUM],8)
	If !DBSeek (xfilial("CTD")+c_IctaF)
		If a_Dados[n][Len(a_Dados[n])] == "DIVERGECIA"
			a_Dados[n][Len(a_Dados[n])] := " Item de Conta Contabil não Cadastrado "
		Else
			a_Dados[n][Len(a_Dados[n])] += " Item de Conta Contabil não Cadastrado "
		EndIf
		l_Erro  	:= .F.
		l_RetOk 	:= .F.
		l_AuxiRet	:= .T.
	EndIf 
	
	If VAL(a_Dados[n][n_PAYME]) <= 0 
		If a_Dados[n][Len(a_Dados[n])] == "DIVERGECIA"
			a_Dados[n][Len(a_Dados[n])] := " Valor do item menor ou igual a Zero "
		Else
			a_Dados[n][Len(a_Dados[n])] += " Valor do item menor ou igual a Zero "
		EndIf
		l_Erro  	:= .F.
		l_RetOk 	:= .F.
		l_AuxiRet	:= .T.
 	EndIf 
 	
 	If l_RetOk 
		If a_Dados[n][Len(a_Dados[n])] == "DIVERGECIA"
			a_Dados[n][Len(a_Dados[n])] := " Informações Ok "
		Else
			a_Dados[n][Len(a_Dados[n])] += " Informações Ok "
		EndIf
 	EndIf

Next n  
	
Return l_Erro

/*******************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fQuery   |     Autor ³ Tiago Dias (Focus Consultoria)   | 	Data ³ 18/10/14  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta a Query para selecionar os dados para a inclusão do Pedido de Compra    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil                                                             				 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil                                                             				 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fQuery()

Local c_QueryF 	:= ""
Local c_QueryP 	:= ""
Local c_EOL		:= CHR(13)

c_QueryF += "SELECT	   		A2_XIDCHRO		AS IDCHRO	"	+ c_EOL
c_QueryF += "			,	A2_COD			AS FORNEC	"	+ c_EOL
c_QueryF += "			,	A2_LOJA			AS LOJA		"	+ c_EOL
c_QueryF += "			,	A2_MSBLQL		AS BLOQ		"	+ c_EOL
c_QueryF += "											"	+ c_EOL
c_QueryF += "FROM " + RetSqlName("SA2") + " SA2		   	"	+ c_EOL
c_QueryF += "											"	+ c_EOL
c_QueryF += "WHERE SA2.D_E_L_E_T_='' 				 	"	+ c_EOL
c_QueryF += "AND A2_XIDCHRO	= '" + c_IDCHRO + "'		"	+ c_EOL

c_QueryP += "SELECT	   		B1_UM		AS UM			"	+ c_EOL
c_QueryP += "			,	B1_LOCPAD	AS LOCPAD		"	+ c_EOL
c_QueryP += "			,	B1_TE		AS TES			"	+ c_EOL
c_QueryP += "			,	B1_MSBLQL	AS BLOQ			"	+ c_EOL
c_QueryP += "			,	B1_DESC		AS DESCRI		"	+ c_EOL
c_QueryP += "											"	+ c_EOL
c_QueryP += "FROM " + RetSqlName("SB1") + " SB1		   	"	+ c_EOL
c_QueryP += "											"	+ c_EOL
c_QueryP += "WHERE SB1.D_E_L_E_T_='' 				 	"	+ c_EOL
c_QueryP += "AND B1_COD	= '" + c_PRODCHRO + "'			"	+ c_EOL

//---------------------------------------------------------------//
// FECHANDO QUERY CASO A MESMA ESTEJA SENDO UTILIZADA            //
//---------------------------------------------------------------//
If Select("QRYF") > 0
	QRYF->(DbCloseArea())
Endif  

If Select("QRYP") > 0
	QRYP->(DbCloseArea())
Endif 

// Gravo QUERY Fornecedor
MemoWrite("FTIARQPCF.SQL", c_QueryF)  
TCQUERY c_QueryF NEW ALIAS "QRYF"

// Gravo QUERY Produto
MemoWrite("FTIARQPCP.SQL", c_QueryP) 
TCQUERY c_QueryP NEW ALIAS "QRYP"

Return Nil

//*************************************************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fMailTexto   |   Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 26/12/14  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta o E-mail para o envio do Status das informações divergentes do arquivo  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil                                                             				 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ c_MailTexto                                                     				 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fMailTexto()
                       
Local c_MailDados := ""

If Len(a_NumPed) == 0
		c_MailDados += '<tr>'
		c_MailDados += '	<td><span class="formulario4">Número do Pedido não Gerado. </span></td>'
		c_MailDados += '</tr>' 		
		c_MailDados += '<tr>'
		c_MailDados += '	<td colspan="10">&nbsp;</td>'
		c_MailDados += '</tr>'		
		c_MailDados += '<tr>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">ID</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Last Name, First Name</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Report ID</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Matter Number</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Cost Code Override</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Expense Type</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Pay Me</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Status</td>'
		c_MailDados += '</tr>'
	         
		//Informações do Arquivo
		For n := 1 To Len(a_Dados)
			c_MailDados += '<tr>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[n][n_ID]      			+   '</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[n][n_LFN]      		+   '</td>'			
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[n][n_RID] 	   	   		+	'</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[n][n_MNUM]	   	   		+	'</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[n][n_CCO]     	  		+	'</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[n][n_EXTY] 	  		+	'</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[n][n_PAYME]			+	'</td>'
			If a_Dados[n][Len(a_Dados[n])] == " Informações Ok "
				c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[n][Len(a_Dados[n])]	+	'</td>'
			Else
				c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario7">'+ a_Dados[n][Len(a_Dados[n])]	+	'</td>'			
			EndIf
			c_MailDados += '</tr>'
		Next n
Else
	For n := 1 To Len(a_NumPed)
	    c_MailDados += '<tr>'
		c_MailDados += '	<td colspan="2"><span class="formulario4">Número do Pedido: '+a_NumPed[n][2]+'</span></td>'
		c_MailDados += '</tr>'		
		c_MailDados += '<tr>'
		c_MailDados += '	<td colspan="10">&nbsp;</td>'
		c_MailDados += '</tr>'		
		c_MailDados += '<tr>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">ID</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Last Name, First Name</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Report ID</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Matter Number</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Cost Center</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Cost Code Override</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Expense Type</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Pay Me</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Status</td>'
		c_MailDados += '</tr>'
	         
		//Informações do Arquivo - Report ID x Numero do Pedido
		For i := 1 To Len(a_Dados)
			If a_NumPed[n][1] == a_Dados[i][10]
				c_MailDados += '<tr>'
				c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[i][n_ID]      			+   '</td>'
				c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[i][n_LFN]      		+   '</td>'
				c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[i][n_RID]    	  		+	'</td>'
				c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[i][n_MNUM]   	  		+	'</td>' 
				c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ c_xCC				   	  		+	'</td>'
				c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[i][n_CCO]     	  		+	'</td>'
				c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[i][n_EXTY] 	  		+	'</td>'
				c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[i][n_PAYME]			+	'</td>'
				If a_Dados[i][Len(a_Dados[i])] == " Informações Ok "
					c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ a_Dados[i][Len(a_Dados[i])]	+	'</td>'
				Else
					c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario7">'+ a_Dados[i][Len(a_Dados[i])]	+	'</td>'			
				EndIf				
				c_MailDados += '</tr>'
			EndIf
		Next i
		
		///Informações do Arquivo - Total x Numero do Pedido 
		For j := 1 To Len(a_TotPed)
			If a_NumPed[n][2] == a_TotPed[j][1]
				c_MailDados += '<tr>'
				c_MailDados += '	<td colspan="6"> </td>'
				c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario5">Total: '+ CVALTOCHAR(a_TotPed[j][2]) +	'</td>'
				c_MailDados += '</tr>'
			EndIf
		Next j
		
		c_MailDados += '<tr>'
		c_MailDados += '	<td colspan="10">&nbsp;</td>'
		c_MailDados += '</tr>'
	Next n
EndIf

c_MailTexto := fCabecHTML()
c_MailTexto += c_MailDados
c_MailTexto += fRodaHTML()

Return c_MailTexto

//*************************************************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CabecHTML   |   Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 26/12/14  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta o E-mail para o envio do Status das informações divergentes do arquivo  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil                                                             				 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ c_Cabec	                                                     				 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fCabecHTML()

Local c_Cabec := "" 

//**********************************************************************************
//                             CABECALHO DO EMAIL
//**********************************************************************************             

c_Cabec += '<HTML><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
c_Cabec += '	<html xmlns="http://www.w3.org/1999/xhtml">'
c_Cabec += '	<style type="text/css">'
c_Cabec += '		.tituloPag { FONT-SIZE: 20px; COLOR: #666699; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Cabec += '		.formulario { FONT-SIZE: 10px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Cabec += '		.formulario5 { FONT-SIZE: 13px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Cabec += '		.formulario4 { FONT-SIZE: 13px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Cabec += '		.formulario2 { FONT-SIZE: 11px; COLOR: #333333; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; }'
c_Cabec += '		.formulario6 { FONT-SIZE: 12px; COLOR: #333333; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; }'
c_Cabec += '		.formulario7 { FONT-SIZE: 12px; COLOR: #FF0000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; }'
c_Cabec += '		.formulario3 { FONT-SIZE: 10px; COLOR: #FFFFFF; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Cabec += '		.formularioTit { FONT-SIZE: 13px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none;  }'
c_Cabec += '		.formularioTit2 { FONT-SIZE: 15px; COLOR: #FFFFFF; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Cabec += '		.formularioTit3 { FONT-SIZE: 13px; COLOR: #FFFFFF; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none;  }'
c_Cabec += '	</style>'
c_Cabec += '<head>'
c_Cabec += '	<title> FTI - IMPORTAÇÃO DOS ARQUIVOS CHROME RIVER </title>'
c_Cabec += '</head>'
c_Cabec += '<table width="95%" border="0" align="center">'
c_Cabec += '<tr>'
c_Cabec += '	<td colspan="10" bgcolor="#000066">'
c_Cabec += '		<div align="center"><span class="formularioTit2"><H2>FTI - IMPORTAÇÃO DOS ARQUIVOS CHROME RIVER</H2></span></div>'
c_Cabec += '	</td>'
c_Cabec += '</tr>'
c_Cabec += '<tr>'
c_Cabec += '	<td colspan="10">&nbsp;</td>'
c_Cabec += '</tr>'
c_Cabec += '<tr>'
c_Cabec += '	<td colspan="10"><span class="formularioTit">E-mail gerado em '+DtoC(MsDate())+' às '+Time()+'</span></td>'
c_Cabec += '</tr>'
c_Cabec += '<tr>'
c_Cabec += '	<td colspan="10"><span class="formularioTit">&nbsp;&nbsp;</span></td>'
c_Cabec += '</tr>'

Return (c_Cabec)

//*************************************************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fRodaHTML   |   Autor ³ Tiago Dias (Focus Consultoria)  | 	Data ³ 26/12/14  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta o E-mail para o envio do Status das informações divergentes do arquivo  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil                                                             				 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ c_Rodape                                                     				 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fRodaHTML()  

Local c_Rodape 		:= "" 
Local c_Ambiente	:= Upper(AllTrim(GetEnvServer()))
Local c_Rotina		:= ALLTRIM(FUNNAME())

//**********************************************************************************
//                             RODAPE DO EMAIL
//**********************************************************************************

c_Rodape += '<tr>'
c_Rodape += '	<td class="formularioTit"><p>&nbsp;&nbsp;</p></td>'
c_Rodape += '</tr>'
c_Rodape += '<tr>'
c_Rodape += '	<td colspan="10"><span class="formularioTit">Mensagem Automática Microsiga - Favor não responder.</span></td>'
c_Rodape += '</tr>'
c_Rodape += '<tr>'
c_Rodape += '	<td colspan="10"><span class="formularioTit">Responsável: TI.</span></td>'
c_Rodape += '</tr>' 
c_Rodape += '<tr>'
c_Rodape += '	<td colspan="10"><span class="formularioTit">Rotina Originada pelo Ambiente.: '+ c_Ambiente +'</span></td>'
c_Rodape += '</tr>'
c_Rodape += '<tr>'
c_Rodape += '	<td colspan="10"><span class="formularioTit">Rotina Originada pela Rotina...: '+ c_Rotina +'</span></td>'
c_Rodape += '</tr>'
c_Rodape += '<tr>'
c_Rodape += '	<td class="formularioTit"><p>&nbsp;</p></td>'
c_Rodape += '</tr>'
c_Rodape += '</table>'
c_Rodape += '</body>'
c_Rodape += '</html>'     

Return (c_Rodape)

/******************************************************************************************************************************************************************************************************************/