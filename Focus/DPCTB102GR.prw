#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ DPCTB102GR | Autor ³ Claudio Dias JR ( Focus Consultoria)  | Data ³ 01/07/15  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Ponto de entrada utilizado apos a gravação dos dados da tabela de lançamento  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil                                                             				 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil   	                                                     				 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³Específico³ FTI Consulting                                                          		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/


User Function DPCTB102GR()
                       
Local 	a_AreaATU 	:= GetArea()

Private n_Opc		:= PARAMIXB[1]
Private d_DtLanc	:= PARAMIXB[2]
Private c_Lote		:= PARAMIXB[3]
Private c_SubLote	:= PARAMIXB[4]
Private c_Doc		:= PARAMIXB[5]
Private c_MailTexto	:= ""

If n_Opc == 3 .Or. n_Opc == 4 // Se for INCLUSÂO/ALTERAÇÃO

	If fValid()
	    
		//Verificar quais informações usar para enviar o email
		c_From 		:= GetMV("MV_RELACNT")
		c_Email		:= GetMV("MV_XMSGCTB")
		c_Copia		:= ""
		c_Assunto	:= IIF(n_Opc==3,"INCLUSAO - ","ALTERACAO - ") + AllTrim(SM0->M0_FILIAL) + " - Lanc aprovacao Lote: " + c_Lote + " Sub-Lote:" + c_SubLote + " Doc:" + c_Doc
		c_Titulo	:= AllTrim(SM0->M0_FILIAL) + " - Lanc aprovacao Lote: " + c_Lote + " Sub-Lote:" + c_SubLote + " Doc:" + c_Doc
		c_Attach	:= "" 

		c_MailTexto := fCabecHTML()
		c_MailTexto += fCorpoHTML()
		c_MailTexto += fRodaHTML()

		c_Mensagem	:= c_MailTexto
						
		//Começa o processo de Envio do E-mail
		If GetMV("MV_XENVML") // Parametro criado para desabilitar o envio do e-mail quando a contade disparo tiver problemas REF Chamado.: 35179
			//U_ArqSendMail(,,,c_From,c_Email,c_Copia,c_Assunto,c_Mensagem,c_Attach)
			//Nova chamada padronizada de E-mail
			U_FCSendMail(,,,c_From,c_Email,c_Copia,c_Assunto,c_Mensagem,c_Attach)
		EndIf
	
	EndIf
	
EndIf
	
RestArea(a_AreaATU)

Return Nil

//*************************************************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CabecHTML  | Autor ³ Claudio Dias JR ( Focus Consultoria)  | Data ³ 01/07/15  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta o E-mail para o envio                                                   ³±±
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
c_Cabec += '	<title> FTI - ENVIO CTB </title>'
c_Cabec += '</head>'
c_Cabec += '<table width="95%" border="0" align="center">'
c_Cabec += '<tr>'
c_Cabec += '	<td colspan="13" bgcolor="#000066">'
c_Cabec += '		<div><span class="formularioTit2"><H2>'+c_Titulo+'</H2></span></div>'
c_Cabec += '	</td>'
c_Cabec += '</tr>'
c_Cabec += '<tr>'
c_Cabec += '	<td colspan="10">&nbsp;</td>'
c_Cabec += '</tr>'
c_Cabec += '<tr>'
c_Cabec += '	<td colspan="10"><span class="formularioTit">E-mail gerado em '+DTOC(MsDate())+' às '+TIME()+'</span></td>'
c_Cabec += '</tr>'
c_Cabec += '<tr>'
c_Cabec += '	<td colspan="10"><span class="formularioTit">&nbsp;&nbsp;</span></td>'
c_Cabec += '</tr>'

Return (c_Cabec)

//*************************************************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fCorpoHTML | Autor ³ Claudio Dias JR ( Focus Consultoria)  | Data ³ 01/07/15  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta o E-mail para o envio                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil                                                             				 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ c_Corpo                                                       				 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fCorpoHTML()

Local c_Corpo := ""

	c_Corpo := '<tr>'
	c_Corpo += '	<td colspan="10"><span class="formularioTit"><b>Data Lancamento: </b> '	+DTOC(d_DtLanc)	+'</span></td>'
	c_Corpo += '</tr>'
	c_Corpo += '<tr>'
	c_Corpo += '	<td colspan="10"><span class="formularioTit"><b>Lote: </b> '			+c_Lote			+'</span></td>'
	c_Corpo += '</tr>'
	c_Corpo += '<tr>'
	c_Corpo += '	<td colspan="10"><span class="formularioTit"><b>Sub-Lote: </b> '		+c_SubLote		+'</span></td>'
	c_Corpo += '</tr>'
	c_Corpo += '<tr>'
	c_Corpo += '	<td colspan="10"><span class="formularioTit"><b>Documento: </b> '		+c_Doc			+'</span></td>'
	c_Corpo += '</tr>'
	
	c_Corpo += '<tr>'
	c_Corpo += '	<td bgcolor="#ECF0EE" class="formulario5">Linha</td>'
	c_Corpo += '	<td bgcolor="#ECF0EE" class="formulario5">Tipo Lancamento</td>'
	c_Corpo += '	<td bgcolor="#ECF0EE" class="formulario5">Cta.Debito</td>'
	c_Corpo += '	<td bgcolor="#ECF0EE" class="formulario5">USGAAP Deb.</td>'
	c_Corpo += '	<td bgcolor="#ECF0EE" class="formulario5">CCusto Deb.</td>'
	c_Corpo += '	<td bgcolor="#ECF0EE" class="formulario5">CCusto USGAAP Deb.</td>'
	c_Corpo += '	<td bgcolor="#ECF0EE" class="formulario5">Cta.Credito</td>'
	c_Corpo += '	<td bgcolor="#ECF0EE" class="formulario5">USGAAP Cred</td>'
	c_Corpo += '	<td bgcolor="#ECF0EE" class="formulario5">CCusto Cred.</td>'
	c_Corpo += '	<td bgcolor="#ECF0EE" class="formulario5">CCusto USGAAP Cred.</td>'
	c_Corpo += '	<td bgcolor="#ECF0EE" class="formulario5">Valor</td>'
	c_Corpo += '	<td bgcolor="#ECF0EE" class="formulario5">Historico</td>'
	c_Corpo += '	<td bgcolor="#ECF0EE" class="formulario5">Feito por (Usuário)</td>'
	c_Corpo += '</tr>'

	DbSelectArea("CT2")
	DbSetOrder(1)//CT2_FILIAL, CT2_DATA, CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_LINHA, CT2_TPSALD, CT2_EMPORI, CT2_FILORI, CT2_MOEDLC, R_E_C_N_O_, D_E_L_E_T_
	DbGoTop()
	If DbSeek( xFilial("CT2") + DTOS(d_DtLanc) + c_Lote + c_SubLote + c_Doc )  

		While CT2->(!Eof()) .And. CT2->(DTOS(CT2_DATA)+CT2_LOTE+CT2_SBLOTE+CT2_DOC) == DTOS(d_DtLanc) + c_Lote + c_SubLote + c_Doc
		    
			c_GaapDeb  	:= GetAdvFval("CT1", "CT1_XCTFTI", xFilial("CT1") + CT2->CT2_DEBITO, 1, "" ) //CT1_FILIAL, CT1_CONTA, R_E_C_N_O_, D_E_L_E_T_
			c_GaapCred 	:= GetAdvFval("CT1", "CT1_XCTFTI", xFilial("CT1") + CT2->CT2_CREDIT, 1, "" ) //CT1_FILIAL, CT1_CONTA, R_E_C_N_O_, D_E_L_E_T_
			
			a_CCGaapDeb  := GetAdvFval("CTT", {"CTT_XFTILC","CTT_XFTIBS","CTT_XFTIDP","CTT_XFTISC"}, xFilial("CTT") + CT2->CT2_CCD, 1, "" ) //CTT_FILIAL, CTT_CUSTO, R_E_C_N_O_, D_E_L_E_T_ 
			a_CCGaapCred := GetAdvFval("CTT", {"CTT_XFTILC","CTT_XFTIBS","CTT_XFTIDP","CTT_XFTISC"}, xFilial("CTT") + CT2->CT2_CCC, 1, "" ) //CTT_FILIAL, CTT_CUSTO, R_E_C_N_O_, D_E_L_E_T_

			c_CCGaapDeb  := a_CCGaapDeb[1] + " " + a_CCGaapDeb[2] + " " + a_CCGaapDeb[3] + " " + a_CCGaapDeb[4]
			c_CCGaapCred := a_CCGaapDeb[1] + " " + a_CCGaapDeb[2] + " " + a_CCGaapDeb[3] + " " + a_CCGaapDeb[4]
			
//--------- Informações do Arquivo - Report ID x Numero do Pedido
			c_Corpo += '<tr>'
			c_Corpo += '	<td bgcolor="#F7F9F8" class="formulario6">'+ CT2->CT2_LINHA	+   '</td>'
			c_Corpo += '	<td bgcolor="#F7F9F8" class="formulario6">'+ fBuscaTp(CT2->CT2_DC)	+   '</td>'
			c_Corpo += '	<td bgcolor="#F7F9F8" class="formulario6">'+ CT2->CT2_DEBITO	+   '</td>'
			c_Corpo += '	<td bgcolor="#F7F9F8" class="formulario6">'+ c_GaapDeb	+   '</td>'
			c_Corpo += '	<td bgcolor="#F7F9F8" class="formulario6">'+ CT2->CT2_CCD	+   '</td>'
			c_Corpo += '	<td bgcolor="#F7F9F8" class="formulario6">'+ c_CCGaapDeb	+   '</td>'
			c_Corpo += '	<td bgcolor="#F7F9F8" class="formulario6">'+ CT2->CT2_CREDIT	+   '</td>'
			c_Corpo += '	<td bgcolor="#F7F9F8" class="formulario6">'+ c_GaapCred	+   '</td>'
			c_Corpo += '	<td bgcolor="#F7F9F8" class="formulario6">'+ CT2->CT2_CCC	+   '</td>'
			c_Corpo += '	<td bgcolor="#F7F9F8" class="formulario6">'+ c_CCGaapCred	+   '</td>'
			c_Corpo += '	<td bgcolor="#F7F9F8" class="formulario6">'+ Transform(CT2->CT2_VALOR, "@E 999,999,999,999.99" )+   '</td>'
			c_Corpo += '	<td bgcolor="#F7F9F8" class="formulario6">'+ CT2->CT2_HIST	+   '</td>'
			c_Corpo += '	<td bgcolor="#F7F9F8" class="formulario6">'+ CT2->CT2_ORIGEM	+   '</td>'
			c_Corpo += '</tr>'
			
			CT2->(DbSkip()) 
			
		EndDo
	
	EndIF
	

Return c_Corpo

//*************************************************************************************************************************************************/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fRodaHTML | Autor ³ Claudio Dias JR ( Focus Consultoria)  | Data ³ 01/07/15  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta o E-mail para o envio                                                   ³±±
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

Static Function fValid()

l_Ret := .F.

DbSelectArea("CT2")
DbSetOrder(1)//CT2_FILIAL, CT2_DATA, CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_LINHA, CT2_TPSALD, CT2_EMPORI, CT2_FILORI, CT2_MOEDLC, R_E_C_N_O_, D_E_L_E_T_
DbGoTop()
If DbSeek( xFilial("CT2") + DTOS(d_DtLanc) + c_Lote + c_SubLote + c_Doc )  

	While CT2->(!Eof()) .And. CT2->(DTOS(CT2_DATA)+CT2_LOTE+CT2_SBLOTE+CT2_DOC) == DTOS(d_DtLanc)+c_Lote+c_SubLote+c_Doc
		If CT2->CT2_TPSALD == "9"
			l_Ret := .T.
			Exit
		EndIF
		CT2->(DbSkip()) 
	EndDo

EndIF


Return l_Ret

/******************************************************************************************************************************************************************************************************************/

Static Function fBuscaTp(c_Tipo)

Local c_DescTipo := "Sem Tipo"

If c_Tipo == "1"
	c_DescTipo := "Debito"
Elseif c_Tipo == "2"
	c_DescTipo := "Credito"
Elseif c_Tipo == "3"
	c_DescTipo := "Partida Dobrada"
Elseif c_Tipo == "4"                
	c_DescTipo := "Cont.Hist."
Elseif c_Tipo == "5"
	c_DescTipo := "Rateio"
Elseif c_Tipo == "6"
	c_DescTipo := "Lcto Padrao"
EndIf

Return c_DescTipo
/******************************************************************************************************************************************************************************************************************/