#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CUSTOMERVENDOR |Autor ³Claudio Dias Junior (Focus Consultoria)|Data ³06/05/20 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Ponto de entrada MVC do MATA020                                               ³±±
±±³          ³ Substituiu P.E. MA020ALT.PRW e MA020TOK.PRW                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametro                                                               		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T./.F.                                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI                                                                  		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               					 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function CUSTOMERVENDOR()
    
Local a_AreaATU 	:= GetArea()
Local a_Param 		:= PARAMIXB
Local x_Ret 		:= .T.
Local o_Obj 		:= ""
Local c_IdPonto 	:= ""
Local c_IdModel 	:= ""
Local l_IsGrid 		:= .F.

Private c_Usuario 	:= cUserName
Private d_Data 		:= MsDate()
Private c_Hora 		:= SubStr(Time(),1,5) 


If a_Param <> NIL

	o_Obj 		:= a_Param[1]
	c_IdPonto 	:= a_Param[2]
	c_IdModel 	:= a_Param[3]
	l_IsGrid 	:= (Len(a_Param) > 3)

	If c_IdPonto == "FORMCOMMITTTSPOS"

		If a_Param[4] // INCLUSAO
			RecLock("SA2", .F.)
			SA2->A2_MSBLQL	:= "1"
			SA2->A2_XUSRINC	:= c_Usuario
			SA2->A2_XDTINC	:= d_Data
			SA2->A2_XHRINC	:= c_Hora
			SA2->(MsUnLock())
//--------- Envie e-mail para responsáveis
			fEnvMail("Inclusão")
		EndIf

	ElseIf c_IdPonto == "FORMCOMMITTTSPRE"

		If !a_Param[4] //ALTERACAO/EXCLUSÃO
			If ( FWFldGet("A2_BANCO") <> SA2->A2_BANCO .Or. FWFldGet("A2_AGENCIA") <> SA2->A2_AGENCIA .Or. FWFldGet("A2_NUMCON") <> SA2->A2_NUMCON )
//------------- Grava LOG de inclsão, além de BLOQUEAR novo registro
				RecLock("SA2", .F.)
				SA2->A2_MSBLQL	:= "1"
				SA2->A2_XUSRALT	:= c_Usuario
				SA2->A2_XDTALT	:= d_Data
				SA2->A2_XHRALT	:= c_Hora
				SA2->(MsUnLock())
//------------- Envie e-mail para responsáveis
				fEnvMail("Alteração")
			EndIf
		EndIf

	EndIf

EndIf

RestArea(a_AreaATU)

Return x_Ret 

//*********************************************************************************************************************************/

Static Function fEnvMail(c_Oper)

Local c_From 		:= GetMV("MV_RELACNT")
Local c_Email		:= GetMV("MV_XEMAFOR")
Local c_Copia		:= ""
Local c_Assunto		:= "FTI - " + c_Oper + " de fornecedor"
Local c_Attach		:= ""
Local c_Mensagem	:= fMailTexto(c_Oper)
Memowrite("MATA020_RDM_"+c_Oper+".Html",c_Mensagem)

// Parametro criado para desabilitar o envio do e-mail quando a contade disparo tiver problemas REF Chamado.: 35179
If GetMV("MV_XENVML") 
	U_FCSendMail(,,,c_From,c_Email,c_Copia,c_Assunto,c_Mensagem,c_Attach)
EndIf

Return Nil

//*********************************************************************************************************************************/

Static Function fMailTexto(c_Oper)
                       
Local c_Body := ""

c_Body += '<HTML><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
c_Body += '	<html xmlns="http://www.w3.org/1999/xhtml">'
c_Body += '	<style type="text/css">'
c_Body += '		.tituloPag { FONT-SIZE: 20px; COLOR: #666699; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Body += '		.formulario { FONT-SIZE: 10px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Body += '		.formulario5 { FONT-SIZE: 13px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Body += '		.formulario4 { FONT-SIZE: 13px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Body += '		.formulario2 { FONT-SIZE: 11px; COLOR: #333333; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; }'
c_Body += '		.formulario6 { FONT-SIZE: 12px; COLOR: #333333; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; }'
c_Body += '		.formulario7 { FONT-SIZE: 12px; COLOR: #FF0000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; }'
c_Body += '		.formulario3 { FONT-SIZE: 10px; COLOR: #FFFFFF; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Body += '		.formularioTit { FONT-SIZE: 13px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none;  }'
c_Body += '		.formularioTit2 { FONT-SIZE: 15px; COLOR: #FFFFFF; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Body += '		.formularioTit3 { FONT-SIZE: 13px; COLOR: #FFFFFF; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none;  }'
c_Body += '	</style>'
c_Body += '<head>'
c_Body += '	<title> ' + SM0->M0_NOMECOM + ' - ' + c_Oper + ' de Fornecedor </title>'
c_Body += '</head>'
c_Body += '<table width="95%" border="0" align="center">'
c_Body += '<tr>'
c_Body += '	<td colspan="14" bgcolor="#000066">'
c_Body += '		<div align="center"><span class="formularioTit2"><H2>' + SM0->M0_NOMECOM + ' - ' + c_Oper + ' de fornecedor</H2></span></div>'
c_Body += '	</td>'
c_Body += '</tr>'
c_Body += '<tr>'
c_Body += '	<td colspan="10">&nbsp;</td>'
c_Body += '</tr>'
c_Body += '<tr>'
c_Body += '	<td colspan="10"><span class="formularioTit">E-mail gerado em ' + DTOC(d_Data) + ' às ' + c_Hora + '</span></td>'
c_Body += '</tr>'
c_Body += '<tr>'
c_Body += '	<td colspan="10"><span class="formularioTit">&nbsp;&nbsp;</span></td>'
c_Body += '</tr>'

c_Body += '<tr>'
c_Body += '	<td bgcolor="#ECF0EE" class="formulario5">Fornecedor</td>'
c_Body += '	<td bgcolor="#ECF0EE" class="formulario5">CNPJ</td>'
c_Body += '	<td bgcolor="#ECF0EE" class="formulario5">Banco Anterior</td>'
c_Body += '	<td bgcolor="#ECF0EE" class="formulario5">Agencia Anterior</td>'
c_Body += '	<td bgcolor="#ECF0EE" class="formulario5">Conta Anterior</td>'
c_Body += '	<td bgcolor="#ECF0EE" class="formulario5">Novo Banco Informado</td>'
c_Body += '	<td bgcolor="#ECF0EE" class="formulario5">Nova Agencia Informada</td>'
c_Body += '	<td bgcolor="#ECF0EE" class="formulario5">Nova Conta Informada</td>'
c_Body += '	<td bgcolor="#ECF0EE" class="formulario5">Login de Alteração</td>'
c_Body += '	<td bgcolor="#ECF0EE" class="formulario5">Data de Alteração</td>'
c_Body += '	<td bgcolor="#ECF0EE" class="formulario5">Horário de Alteração</td>'
c_Body += '</tr>'
		
//Informações do Arquivo
c_Body += '<tr>'
c_Body += '	<td bgcolor="#F7F9F8" class="formulario6">' + SA2->A2_COD+'-'+SA2->A2_LOJA + ' - ' +Alltrim(SA2->A2_NOME) +  '</td>'			
c_Body += '	<td bgcolor="#F7F9F8" class="formulario6">' + SA2->A2_CGC				+ '</td>'
c_Body += '	<td bgcolor="#F7F9F8" class="formulario6">' + SA2->A2_BANCO   			+ '</td>'
c_Body += '	<td bgcolor="#F7F9F8" class="formulario6">' + SA2->A2_AGENCIA 			+ '</td>'
c_Body += '	<td bgcolor="#F7F9F8" class="formulario6">' + SA2->A2_NUMCON  			+ '</td>'
c_Body += '	<td bgcolor="#F7F9F8" class="formulario6">' + FWFldGet("A2_BANCO")   	+ '</td>'
c_Body += '	<td bgcolor="#F7F9F8" class="formulario6">' + FWFldGet("A2_AGENCIA") 	+ '</td>'
c_Body += '	<td bgcolor="#F7F9F8" class="formulario6">' + FWFldGet("A2_NUMCON") 	+ '</td>'
c_Body += '	<td bgcolor="#F7F9F8" class="formulario6">' + c_Usuario					+ '</td>'
c_Body += '	<td bgcolor="#F7F9F8" class="formulario6">' + DTOC(d_Data)				+ '</td>'
c_Body += '	<td bgcolor="#F7F9F8" class="formulario6">' + c_Hora					+ '</td>'
c_Body += '</tr>'

c_Body += '<tr>'
c_Body += '	<td class="formularioTit"><p>&nbsp;&nbsp;</p></td>'
c_Body += '</tr>'
c_Body += '<tr>'
c_Body += '	<td colspan="10"><span class="formularioTit">Mensagem Automática Microsiga - Favor não responder.</span></td>'
c_Body += '</tr>'
c_Body += '<tr>'
c_Body += '	<td colspan="10"><span class="formularioTit">Responsável: TI.</span></td>'
c_Body += '</tr>' 
c_Body += '<tr>'
c_Body += '	<td colspan="10"><span class="formularioTit">Rotina Originada pelo Ambiente.: '+ Upper(AllTrim(GetEnvServer())) +'</span></td>'
c_Body += '</tr>'
c_Body += '<tr>'
c_Body += '	<td colspan="10"><span class="formularioTit">Rotina Originada pela Rotina...: '+ ALLTRIM(FUNNAME()) +'</span></td>'
c_Body += '</tr>'
c_Body += '<tr>'
c_Body += '	<td class="formularioTit"><p>&nbsp;</p></td>'
c_Body += '</tr>'
c_Body += '</table>'
c_Body += '</body>'
c_Body += '</html>'     

Return c_Body

//*********************************************************************************************************************************/