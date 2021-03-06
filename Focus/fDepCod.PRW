#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

//---------------------//
// POSI��ES DOS ARRAYS //
//---------------------//
#DEFINE COLTABEL 	1
#DEFINE COLCODPAF 	2
#DEFINE COLLJPAF 	3
#DEFINE COLCODCLI	4
#DEFINE COLLJCLI 	5
#DEFINE COLCGC   	6
#DEFINE COLTIPO		7
#DEFINE COLINDEX 	8

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fDepCod    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Fun��o que faz o De->Para nas tabelas SA1 e SA2 de acordo com regras passadas ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

User Function fDepCod()

	Local 	oDlg
	Local 	c_Title 	:= OemToAnsi("Atualiza��o dos Codigos e Lojas dos Clientes e Fornecedores.")
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
	c_Texto	:= "Esta atualiza��o pode demorar alguns minutos..."
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

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fCCodLj    |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013  ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Fun��o programada para atualizar os campos                                    ���
���          � A1_COD     => Ser� atualizado com um NOVO c�digo                              ���
���          � A1_LOJA    => Ser� atualizado com uma NOVA Loja                               ���
���          � A1_XCODPAF => Ser� atualizado com o c�digo ANTIGO                             ���
���          � A1_XLJPAF  => Ser� atualizado com a Loja ANTIGA                               ���
��������������������������������������������������������������������������������������������Ĵ��
���          � CAMPOS "PAF" CRIADO PARA CONTROLE, CASO NECESS�RIO, NOMENCLATURA HOMENAGEM    ���
���          � AO O PROJETO PAF DE 2007.. RS..                                               ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

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
	
		If 	&(a_BaseDP[n_BaseDP][COLTIPO]) $ "F#X#" .Or. Empty(c_PrfCGC) .Or. c_PrfCGC == "00000000" // F = PESSOA FISICA / X = EXPORTA��O

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

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fBaseDePara |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Array com as tabelas, campos e �ndice, dados necess�rios para o De->Para      ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fBaseDePara()

	aAdd( a_BaseDP,{"SA1", "A1_XCODPAF", "A1_XLJPAF", "A1_COD", "A1_LOJA", "A1_CGC", "A1_PESSOA" ,10}) // A1_FILIAL, A1_VINCULO, A1_CGC, R_E_C_N_O_, D_E_L_E_T_
	aAdd( a_BaseDP,{"SA2", "A2_XCODPAF", "A2_XLJPAF", "A2_COD", "A2_LOJA", "A2_CGC", "A2_TIPO"	 ,11}) // A2_FILIAL, A2_VINCULO, A2_CGC, R_E_C_N_O_, D_E_L_E_T_

Return 

//**********************************************************************************************************************************************************//

/*����������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � fDados      |Autor� Claudio Dias Junior (Focus Consultoria)| Data �13/06/2013 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Fun��o que contabiliza resgitros processados                                  ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Nil                                                                           ���
��������������������������������������������������������������������������������������������Ĵ��
���Espec�fico� ELETRO LUMINAR                                                          		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  � Manutencao Efetuada                                       		 ���
��������������������������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               					 ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������������*/

Static Function fDados()

	ProcRegua(n_Count) //Aqui voc� informa quantos registros ser�o processados

	For i := 1 To n_Count
	
      IncProc( Transform(n_Count, "@E 9999999") + " Registros sendo processadoe e atualizados. Dados da " + a_BaseDP[n_BaseDP][COLTABEL] + "..: " + Transform( (i/n_Count * 100), "@E 999.99") )
	
	Next i

Return

//**********************************************************************************************************************************************************//