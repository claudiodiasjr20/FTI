/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MTA410    ºAutor  ³Alexandre Sousa     º Data ³  07/29/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada durante a inclusao do pedido de vendas.    º±±
±±º          ³Usado para gravar dados de log e enviar email de aviso      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico clientes Focus Consultoria.                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MTA410()


	If INCLUI
		M->C5_XUSRINC	:= cusername
		M->C5_XDTINC	:= ddatabase
		M->C5_XHRINC	:= substr(time(),1,5)
		M->C5_XUSRALT	:= ''
		M->C5_XDTALT	:= ctod('  /  /  ')
		M->C5_XHRALT	:= ''
		M->C5_XUSRAPR	:= ''
		M->C5_XDTAPR	:= ctod('  /  /  ')
		M->C5_XHRAPR	:= ''
	EndIf
	
	If ALTERA
		M->C5_XUSRALT	:= cusername
		M->C5_XDTALT	:= ddatabase
		M->C5_XHRALT	:= substr(time(),1,5)
		M->C5_XUSRAPR	:= ''
		M->C5_XDTAPR	:= ctod('  /  /  ')
		M->C5_XHRAPR	:= ''
	EndIf

	//Verificar quais informações usar para enviar o email
//	c_From 		:= "fti@focusconsultoria.net"
	c_From 		:= GetMV("MV_RELACNT")
	c_Email		:= GetMV("MV_XEMAPV") //'alexandre.martins@focusconsultoria.net'
	c_Copia		:= ""
	c_Assunto	:= "FTI - "+Iif(ALTERA, 'Alteração', 'Inclusão')+" de pedido de vendas"
	//Monta todo o Corpo do E-mail
	c_Mensagem	:= fMailTexto()  
	memowrite("MTA410.html",c_Mensagem)
	c_Attach	:= "" 
	
	//Começa o processo de Envio do E-mail
	If GetMV("MV_XENVML") // Parametro criado para desabilitar o envio do e-mail quando a contade disparo tiver problemas REF Chamado.: 35179
		//U_ArqSendMail(,,,c_From,c_Email,c_Copia,c_Assunto,c_Mensagem,c_Attach)
		//Nova Chamada padronizada de E-mail
		U_FCSendMail(,,,c_From,c_Email,c_Copia,c_Assunto,c_Mensagem,c_Attach)
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
Local nPosProd	:= aScan(aHeader,{|x| Alltrim(x[2]) == 'C6_PRODUTO'}) 
Local nPosTK	:= aScan(aHeader,{|x| Alltrim(x[2]) == 'C6_XCLVL'}) 
Local nPosCC	:= aScan(aHeader,{|x| Alltrim(x[2]) == 'C6_XCC'}) 
Local nPosOper	:= aScan(aHeader,{|x| Alltrim(x[2]) == 'C6_OPER'})
Local nPosMT	:= aScan(aHeader,{|x| Alltrim(x[2]) == 'C6_XITECTB'})
Local nPosVLR	:= aScan(aHeader,{|x| Alltrim(x[2]) == 'C6_VALOR'})

//If Len(a_NumPed) == 0
		c_MailDados += '<tr>'
		c_MailDados += '	<td><span class="formulario4">Número do Pedido: '+M->C5_NUM+'</span></td>'
		c_MailDados += '</tr>' 		
		c_MailDados += '<tr>'
		c_MailDados += '	<td colspan="10">&nbsp;</td>'
		c_MailDados += '</tr>'		
		c_MailDados += '<tr>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Cliente</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">CNPJ</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Tipo Cliente</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Cond.Pagto</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Msg NFe</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Produto</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">TimeKeeper</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Centro de Custo</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Tipo de Operação</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Matter</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Valor Bruto</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Login de Criação</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Data de Criação</td>'
		c_MailDados += '	<td bgcolor="#ECF0EE" class="formulario5">Horário de Criação</td>'
		c_MailDados += '</tr>'
	         
		//Informações do Arquivo
		For n := 1 To Len(aCols)
			c_MailDados += '<tr>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ M->C5_CLIENTE+'-'+M->C5_LOJACLI + ' - ' +Alltrim(GetAdvFval('SA1', 'A1_NOME', xFilial('SA1')+M->(C5_CLIENTE+C5_LOJACLI),1,'')) +  '</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ GetAdvFval('SA1', 'A1_CGC', xFilial('SA1')+M->(C5_CLIENTE+C5_LOJACLI),1,'')	+   '</td>'			
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ Iif(M->C5_TIPOCLI='F', "Cons.Final",IIf(M->C5_TIPOCLI='L',"Prod.Rural",Iif(M->C5_TIPOCLI='R',"Revendedor",Iif(M->C5_TIPOCLI='S',"Solidário","Exportação/Importação")))) +	'</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ M->C5_CONDPAG	+	'</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ M->C5_XMENNOT	+	'</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ aCols[n][nPosProd] 	  		+	'</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ aCols[n][nPosTK]			+	'</td>'
//			If a_Dados[n][Len(a_Dados[n])] == " Informações Ok "
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ aCols[n][nPosCC]			+	'	</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ aCols[n][nPosOper]			+	'	</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ aCols[n][nPosMT]			+	'	</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ Transform(aCols[n][nPosVLR], "@E 999,999.99")	+	'	</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ M->C5_XUSRINC	+	'</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ DtoC(M->C5_XDTINC)	+	'</td>'
			c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario6">'+ M->C5_XHRINC	+	'</td>'

//			Else
//				c_MailDados += '	<td bgcolor="#F7F9F8" class="formulario7">'+ a_Dados[n][Len(a_Dados[n])]	+	'</td>'			
//			EndIf
			c_MailDados += '</tr>'
		Next n
/*
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
*/

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
c_Cabec += '	<title> '+SM0->M0_NOMECOM+' - '+Iif(ALTERA, 'Alteração', 'Inclusão')+' de pedido de vendas </title>'
c_Cabec += '</head>'
c_Cabec += '<table width="95%" border="0" align="center">'
c_Cabec += '<tr>'
c_Cabec += '	<td colspan="14" bgcolor="#000066">'
c_Cabec += '		<div align="center"><span class="formularioTit2"><H2>'+SM0->M0_NOMECOM+' - '+Iif(ALTERA, 'Alteração', 'Inclusão')+' de pedido de vendas</H2></span></div>'
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

