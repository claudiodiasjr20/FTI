/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MA020TOK  ºAutor  ³Alexandre Martins   º Data ³  07/30/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada durante a validacao dos dados do fornecedorº±±
±±º          ³usado para regra de bloqueio quando alterado dados bancariosº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico clientes FOCUS CONSULTOIA.                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MA020TOK()

If INCLUI // .AND. .F.
	//Verificar quais informações usar para enviar o email
	//c_From 		:= "fti@focusconsultoria.net"
	c_From 		:= GetMV("MV_RELACNT")
	c_Email		:= GetMV("MV_XEMAFOR") //'alexandre.martins@focusconsultoria.net'//GetMV("MV_XPCCHRO")
	c_Copia		:= ""
	c_Assunto	:= "FTI - Inclusão de fornecedor"
	//Monta todo o Corpo do E-mail
	c_Mensagem	:= fMailTexto()
	memowrite("MA020TOK.html",c_Mensagem)
	c_Attach	:= ""
	
	//Começa o processo de Envio do E-mail
	If GetMV("MV_XENVML") // Parametro criado para desabilitar o envio do e-mail quando a contade disparo tiver problemas REF Chamado.: 35179
		//U_ArqSendMail(,,,c_From,c_Email,c_Copia,c_Assunto,c_Mensagem,c_Attach)
		//Nova chamada padronizada de E-mail
		U_FCSendMail(,,,c_From,c_Email,c_Copia,c_Assunto,c_Mensagem,c_Attach)
	EndIf
	
	M->A2_MSBLQL	:= '1'
	M->A2_XUSRINC	:= cUserName
	M->A2_XDTINC	:= dDataBase
	M->A2_XHRINC	:= substr(time(),1,5)
EndIf

Return .T.
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

c_MailDados += '<tr>'
c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Fornecedor</td>'
c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">CNPJ</td>'
//		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Tipo Fornecedor</td>'
c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Banco Anterior</td>'
c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Agencia Anterior</td>'
c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Conta Anterior</td>'
c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Novo Banco Informado</td>'
c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Nova Agencia Informada</td>'
c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Nova Conta Informada</td>'
c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Login de Inclusão</td>'
c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Data de Inclusão</td>'
c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Horário de Inclusão</td>'
c_MailDados += '</tr>'

//Informações do Arquivo
c_MailDados += '<tr>'
c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ M->A2_COD+'-'+M->A2_LOJA + ' - ' +Alltrim(M->A2_NOME) +  '</td>'
c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ M->A2_CGC+'</td>'
c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ "" + ' </td>'
c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ "" + ' </td>'
c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ "" + ' </td>'
c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ M->A2_BANCO   + ' </td>'
c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ M->A2_AGENCIA + ' </td>'
c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ M->A2_NUMCON  + ' </td>'
c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ cusername	+	'</td>'
c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ DtoC(ddatabase)	+	'</td>'
c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ substr(time(),1,5)	+	'</td>'
c_MailDados += '</tr>'

c_MailTexto := fCabecHTML()
c_MailTexto += c_MailDados
c_MailTexto += fRodaHTML()

Return c_MailTexto

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
c_Cabec += '	<title> '+SM0->M0_NOMECOM+' - Inclusão de Fornecedor </title>'
c_Cabec += '</head>'
c_Cabec += '<table width="95%" border="0" align="center">'
c_Cabec += '<tr>'
c_Cabec += '	<td colspan="14" bgcolor="#000066">'
c_Cabec += '		<div align="center"><span class="formularioTit2"><H2>'+SM0->M0_NOMECOM+' - Inclusão de fornecedor</H2></span></div>'
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