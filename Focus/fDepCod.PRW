#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

//---------------------//
// POSIÇÕES DOS ARRAYS //
//---------------------//
#DEFINE COLTABEL 	1
#DEFINE COLCODPAF 	2
#DEFINE COLLJPAF 	3
#DEFINE COLCODCLI	4
#DEFINE COLLJCLI 	5
#DEFINE COLCGC   	6
#DEFINE COLTIPO		7
#DEFINE COLINDEX 	8

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fDepCod    |Autor³ Claudio Dias Junior (Focus Consultoria)| Data ³13/06/2013 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Função que faz o De->Para nas tabelas SA1 e SA2 de acordo com regras passadas ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil                                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil                                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ ELETRO LUMINAR                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function fDepCod()

	Local 	oDlg
	Local 	c_Title 	:= OemToAnsi("Atualização dos Codigos e Lojas dos Clientes e Fornecedores.")
	Local 	n_Opca 		:= 0
	Local 	a_CA		:= { OemToAnsi("Confirma"), OemToAnsi("Abandona") }
	Local 	a_Says		:= {}
	Local 	a_Buttons	:= {}
	Private n_BaseDP	:= 0
	Private a_BaseDP	:= {}
	Private n_Count		:= 0

	c_Texto	:= "Este programa tem como objetivo atualizar o Cadastro"
	aAdd(a_Says, OemToAnsi(c_Texto)) 		
	c_Texto	:= "dos Codigos e Lojas dos Clientes e Fornecedores."
	aAdd(a_Says, OemToAnsi(c_Texto)) 	
	c_Texto	:= "Esta atualização pode demorar alguns minutos..."
	aAdd(a_Says, OemToAnsi(c_Texto)) 		
	aAdd(a_Buttons, { 1,.T.,{|o| n_Opca:= 1, If( .T., o:oWnd:End(), n_Opca:=0 ) }} )
	aAdd(a_Buttons, { 2,.T.,{|o| o:oWnd:End() }} )
	FormBatch( c_Title, a_Says, a_Buttons ,,220,380)

	If n_Opca == 1
		fBaseDePara()
 		For n_BaseDP:=1 To Len(a_BaseDP)
			Processa({|lend| fCCodLj()},"Atualizando Codigos e Lojas... Por favor aguarde.")
		Next

		c_Query := "UPDATE SA1050 SET A1_COD = '0'+RIGHT(A1_COD,5) WHERE D_E_L_E_T_ = ''"
		TcSqlExec(c_Query)
		
		c_Query := "UPDATE SA2050 SET A2_COD = '0'+RIGHT(A2_COD,5) WHERE D_E_L_E_T_ = '' AND A2_XCODPAF < 'ESTADO' OR  A2_XCODPAF = 'F00001'OR  A2_XCODPAF = 'ORION '"
		TcSqlExec(c_Query)

		MsgInfo("Concluida com sucesso!","A T U A L I Z A C A O !")
				
	Else
		MsgStop("Atualizacao Cancelada!","A B O R T A D O !")
	Endif

Return Nil
                                                                                                 
//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fCCodLj    |Autor³ Claudio Dias Junior (Focus Consultoria)| Data ³13/06/2013  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Função programada para atualizar os campos                                    ³±±
±±³          ³ A1_COD     => Será atualizado com um NOVO código                              ³±±
±±³          ³ A1_LOJA    => Será atualizado com uma NOVA Loja                               ³±±
±±³          ³ A1_XCODPAF => Será atualizado com o código ANTIGO                             ³±±
±±³          ³ A1_XLJPAF  => Será atualizado com a Loja ANTIGA                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³ CAMPOS "PAF" CRIADO PARA CONTROLE, CASO NECESSÁRIO, NOMENCLATURA HOMENAGEM    ³±±
±±³          ³ AO O PROJETO PAF DE 2007.. RS..                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil                                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil                                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ ELETRO LUMINAR                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fCCodLj()

	DbSelectArea(a_BaseDP[n_BaseDP][COLTABEL])
	DbSetOrder(a_BaseDP[n_BaseDP][COLINDEX]) 	// FILIAL + CGC
	DbGoTop()
         
	n_Count := n_Count + &(a_BaseDP[n_BaseDP][COLTABEL])->(RecCount())
      
	fDados()

	c_CodNew := "900000"
		
	While !Eof()     
	
		n_RecnoAtu	:= 0
		n_RecnoPrx	:= 0
		c_Count		:= 0
		c_PrfCGC	:= Left(&(a_BaseDP[n_BaseDP][COLCGC]),8)
		c_CodOld	:= Left(AllTrim(&(a_BaseDP[n_BaseDP][COLCODCLI])),6)
		c_LjOld		:= Left(AllTrim(&(a_BaseDP[n_BaseDP][COLLJCLI])),2)
		If  !Left(AllTrim(&(a_BaseDP[n_BaseDP][COLCODCLI])),6) $ "ESTADO#FGTS  #FOLHA #GOVSP #INPS  #MUNIC #UNIAO "
			c_CodNew 	:= Soma1(c_CodNew)
			c_LjNew		:= "01"
		Else
			c_LjNew		:= "01"
		EndIf
								
		n_RecnoAtu := Recno() 		// Grava Recno Atual
		DbSkip()
		n_RecnoPrx := Recno() 		// Grava Proximo Recno
		DbGoTo(n_RecnoAtu)			// Direciona o ponteiro para o n_RecnoAtu
	
		If 	&(a_BaseDP[n_BaseDP][COLTIPO]) $ "F#X#" .Or. Empty(c_PrfCGC) .Or. c_PrfCGC == "00000000" // F = PESSOA FISICA / X = EXPORTAÇÃO

			If  !Left(AllTrim(&(a_BaseDP[n_BaseDP][COLCODCLI])),6) $ "ESTADO#FGTS  #FOLHA #GOVSP #INPS  #MUNIC #UNIAO "
//			If !Empty(c_PrfCGC)                  
				Reclock(a_BaseDP[n_BaseDP][COLTABEL],.F.)
						&(a_BaseDP[n_BaseDP][COLCODPAF]	) 	:= 	c_CodOld
						&(a_BaseDP[n_BaseDP][COLLJPAF]	) 	:= 	c_LjOld
						&(a_BaseDP[n_BaseDP][COLCODCLI]	)	:= 	c_CodNew
						&(a_BaseDP[n_BaseDP][COLLJCLI]	)	:= 	c_LjNew
				MsUnlock()
			Else
				Reclock(a_BaseDP[n_BaseDP][COLTABEL],.F.)
						&(a_BaseDP[n_BaseDP][COLCODPAF]	) 	:= 	c_CodOld
						&(a_BaseDP[n_BaseDP][COLLJPAF]	) 	:= 	c_LjOld
				MsUnlock()				
			EndIf
			
			DbGoTo(n_RecnoPrx)  	// Direciona o ponteiro para o n_RecnoPrx
	
		ElseIf  &(a_BaseDP[n_BaseDP][COLTIPO]) $ "J#" // J = PESSOA JURIDICA
			
			While !Eof() .And. Left(&(a_BaseDP[n_BaseDP][COLCGC]),8) == c_PrfCGC
			
					c_CodOld	:= Left(AllTrim(&(a_BaseDP[n_BaseDP][COLCODCLI])),6)
					c_LjOld		:= Left(AllTrim(&(a_BaseDP[n_BaseDP][COLLJCLI])),2)
					c_Count++
					
					If  !Left(AllTrim(&(a_BaseDP[n_BaseDP][COLCODCLI])),6) $ "ESTADO#FGTS  #FOLHA #GOVSP #INPS  #MUNIC #UNIAO "
//					If !Empty(c_PrfCGC)
						Reclock(a_BaseDP[n_BaseDP][COLTABEL],.F.)
								&(a_BaseDP[n_BaseDP][COLCODPAF]	)	:= 	c_CodOld
								&(a_BaseDP[n_BaseDP][COLLJPAF]	)	:= 	c_LjOld
								&(a_BaseDP[n_BaseDP][COLCODCLI]	)	:= 	c_CodNew
								&(a_BaseDP[n_BaseDP][COLLJCLI]	)	:= 	IIF(c_Count==1, c_LjNew, c_LjNew := Soma1(c_LjNew) )
						MsUnlock()
					Else
						Reclock(a_BaseDP[n_BaseDP][COLTABEL],.F.)
								&(a_BaseDP[n_BaseDP][COLCODPAF]	) 	:= 	c_CodOld
								&(a_BaseDP[n_BaseDP][COLLJPAF]	) 	:= 	c_LjOld
						MsUnlock()				
					EndIf
		
				DbSkip()
				
	        EndDo	        
 
		EndIf
			
	EndDo
	
Return Nil

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fBaseDePara |Autor³ Claudio Dias Junior (Focus Consultoria)| Data ³13/06/2013 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Array com as tabelas, campos e índice, dados necessários para o De->Para      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil                                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil                                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ ELETRO LUMINAR                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fBaseDePara()

	aAdd( a_BaseDP,{"SA1", "A1_XCODPAF", "A1_XLJPAF", "A1_COD", "A1_LOJA", "A1_CGC", "A1_PESSOA" ,10}) // A1_FILIAL, A1_VINCULO, A1_CGC, R_E_C_N_O_, D_E_L_E_T_
	aAdd( a_BaseDP,{"SA2", "A2_XCODPAF", "A2_XLJPAF", "A2_COD", "A2_LOJA", "A2_CGC", "A2_TIPO"	 ,11}) // A2_FILIAL, A2_VINCULO, A2_CGC, R_E_C_N_O_, D_E_L_E_T_

Return 

//**********************************************************************************************************************************************************//

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fDados      |Autor³ Claudio Dias Junior (Focus Consultoria)| Data ³13/06/2013 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Função que contabiliza resgitros processados                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil                                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil                                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ ELETRO LUMINAR                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fDados()

	ProcRegua(n_Count) //Aqui você informa quantos registros serão processados

	For i := 1 To n_Count
	
      IncProc( Transform(n_Count, "@E 9999999") + " Registros sendo processadoe e atualizados. Dados da " + a_BaseDP[n_BaseDP][COLTABEL] + "..: " + Transform( (i/n_Count * 100), "@E 999.99") )
	
	Next i

Return

//**********************************************************************************************************************************************************//