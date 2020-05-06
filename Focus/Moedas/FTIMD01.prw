#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ U_FTIMD01()  |  Autor ³ Tiago Silva (Focus Consultoria)  | 	Data ³ 12/01/18  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Programa que atualiza as 17 Moedas de acordo com o retorno do site do Bacen   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ l_Job (.T.=Job ou .F.=Manual)                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil                                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Específico³ FTI CONSULTING                                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                                       		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function FTIMD01(l_Job)

Local 	a_AteaATU 	:= GetArea()
Local 	a_AreaSZ1	:= SZ1->(GetArea())

//Default l_Job		:= .F.
                        
Private dDataRef	:= CTOD("//")
Private dDataAux	:= CTOD("//")
Private dDataDs		:= CTOD("//")
Private dData 		:= CTOD("//")
Private nValDolar	:= nValYen := nValEuro := 0
Private nValM02 	:= nValM03 := nValM04 := nValM05 := nValM06 := nValM07 := nValM08 := nValM09 := nValM10 := 0
Private nValM11 	:= nValM12 := nValM13 := nValM14 := nValM15 := nValM16 := nValM17 := nValM18 := nValM19 := 0
Private nValReal	:= 1.000000   
Private l_Ret		:= .F.
Private l_DtAnt		:= .F. //Quando For o Dia igual ao DataBase, Pega informação do Dia anterior e Grava no Dia Corrente
Private ctxt		:= "" //Vou usar esta variavel para usar o que era do André no WorkFlow
                                          
l_Job  := IIF( l_Job <> Nil, l_Job , .F. ) 

//Via Job (Automatico=.T. ou Manual=.F.)
If l_Job

	ConOut("-------------------------------------------------------")
	ConOut("- Execução Moedas Automatica FTI - "+Time())
	ConOut("-------------------------------------------------------")
	
	xExecMoeda()
	
	ConOut("-------------------------------------------------------")
	ConOut("- Fim Execução Moedas Automatica FTI - "+Time())
	ConOut("-------------------------------------------------------")
	
Else     
	//Tela Inicial
	Define MsDialog oDlg Title 'Atualização de Moedas - Vr20180925a' From 7,10 To 15,55	Of oMainWnd              
	@ 15 ,15  Say	'Esta Rotina tem como objetivo atualizar de forma'  		Of oDlg	Pixel  
	@ 25 ,15  Say	'automatica as 17 Moedas de acordo com o Site do Bacen.'  	Of oDlg Pixel  
	Define SButton From 40, 115 Type 01 Action ( l_Ret := .T. , oDlg:End()) 	Enable	Of oDlg   	
	Define SButton From 40, 145 Type 02 Action ( l_Ret := .F. , oDlg:End()) 	Enable	Of oDlg   	
	Activate MsDialog oDlg Center
    
	If l_Ret
		MsgRun("Atualizando MOEDAS, por favor, aguarde...", "Especifico FTI", {|| xExecMoeda()} )
    EndIf
EndIf

RestArea(a_AreaSZ1)         
RestArea(a_AteaATU)

Return Nil

/********************************************************************************************/

Static Function xExecMoeda()

Local nPass, cFile, cTexto, nLinhas, cLinha, cdata, cCompra, cVenda, J, K, L
Local l_DTVal 	:= .F. //Se a busca foi atraves de um Feriado Variavel
Local l_DtFDS	:= .F. //Para Sabado e Domingo não envia e-mail e não faz o Processo, pois, já foi feito na data de Sexta

//Verificação na Tabela Moedas SM2 se possui algum registro que precisa atualizar a Moeda
//fSM2Qry()

//Abre o Alias das Datas que foram encontradas para Atualizar a Moeda
//DbSelectArea("QRY")
//QRY->(DbGoTop())

//Refaz os ultimos 6 dias. O BCB não disponibiliza periodo maior de uma semana - Informação do Fonte do André
//Será mantido o mesmo processo, pois, TODO dia de manhã não tem o arquivo disponibilizado das moedas do DIA CORRENTE
//Assim no dia é feito com base no dia anterior e é atualizado no dia seguinte, por isso, é refeito sempre num periido de 6 dias.
//While !QRY->(Eof())

//	dDataRef := ""
//	dDataRef := QRY->M2_DATA  
For nPass := 6 to 0 step -1					
	dDataRef := dDataBase - nPass
	dDataDs	 := dDataRef //Para saber quando for Sabado ou Domingo para NÃO ENVIAR O EMAIL
	l_DtFDS	 := .F. //Sempre "volto" o valor para conferir os outros dias
	
	//Abre o Alias das Datas Variaveis (Tabela Criada SZ1)
	DbSelectArea("SZ1")
	//DbSetOrder(1)
	SZ1->(DbGoTop())
	While !SZ1->(Eof())
		If (dDataRef == SZ1->Z1_DATA)	//Dias Variáveis
			cFile	:= Dtos(dDataRef - 1)+'.csv'
			l_DTVal	:= .T.
		EndIf               
		SZ1->(dbSkip())
	Enddo

	If !(l_DTVal) 		   
		//Feriados Bancário Fixo
		If ( 	Dtos(dDataRef) == STR(Year(Date()),4)+'0101' )	//Dia Mundial da Paz
			cFile := Dtos(dDataRef - 1)+'.csv'
		ElseIf	Dtos(dDataRef) == STR(Year(Date()),4)+'0421'	//Dia de Tradentes
			cFile := Dtos(dDataRef - 1)+'.csv'
		ElseIf	Dtos(dDataRef) == STR(Year(Date()),4)+'0501'	//Dia do Trabalho
			cFile := Dtos(dDataRef - 1)+'.csv'
		ElseIf	Dtos(dDataRef) == STR(Year(Date()),4)+'0907'	//Dia da Independencia
			cFile := Dtos(dDataRef - 1)+'.csv'
		ElseIf	Dtos(dDataRef) == STR(Year(Date()),4)+'1012'	//Dia da N. Sra. Aparecida
			cFile := Dtos(dDataRef - 1)+'.csv'
		ElseIf	Dtos(dDataRef) == STR(Year(Date()),4)+'1102'	//Dia de Finados
			cFile := Dtos(dDataRef - 1)+'.csv'
		ElseIf	Dtos(dDataRef) == STR(Year(Date()),4)+'1115'	//Dia da Proclamação da Republica
			cFile := Dtos(dDataRef - 1)+'.csv'
		ElseIf	Dtos(dDataRef) == STR(Year(Date()),4)+'1225'	//Natal
			cFile := Dtos(dDataRef - 1)+'.csv'
		ElseIf	Dtos(dDataRef) == STR(Year(Date()),4)+'1231'	//Dia sem Expediente Bancário
			cFile := Dtos(dDataRef - 1)+'.csv'
			//Finais de Semana
		ElseIf	Dow(dDataRef) == 1					//Se for domingo
			//cFile := Dtos(dDataRef - 2)+'.csv'
			l_DtFDS := .T. //Não manda E-mail e não faz o processo
		ElseIf	Dow(dDataRef) == 7  				//Se for sabado
			//cFile := Dtos(dDataRef - 1)+'.csv'
			l_DtFDS := .T. //Não manda E-mail e não faz o processo
		//É feito este processo pois, TODO DIA de manhã, não tem o arquivo Final do Dia no Site do Banco Central 
		//NO DIA pego do dia anterior e posteriormente é atualizado com o arquivo Final DAQUELE dia que é disponível na parte da Tarde
		ElseIf dDataRef == dDataBase
			dDataAux := dDataRef
			dDataAnt := dDataRef - 1 //Tenho que pegar o dia ANTERIOR e verificar se ele é feriado 
			//Se o Dia anteriror foi feriado tenho que voltar dois dias
			DbSelectArea("SZ1")
			//DbSetOrder(1)
			SZ1->(DbGoTop())
			While !SZ1->(Eof())
				If (dDataAnt == SZ1->Z1_DATA)	//Dias Variáveis
					cFile	:= Dtos(dDataRef - 2)+'.csv'
					l_DTVal	:= .T.
				EndIf               
				SZ1->(dbSkip())
			Enddo
			If !(l_DTVal) 		   
				//Feriados Bancário Fixo
				If ( 	Dtos(dDataAnt) == STR(Year(Date()),4)+'0101' )	//Dia Mundial da Paz
					cFile := Dtos(dDataRef - 2)+'.csv'
				ElseIf	Dtos(dDataAnt) == STR(Year(Date()),4)+'0421'	//Dia de Tradentes
					cFile := Dtos(dDataRef - 2)+'.csv'
				ElseIf	Dtos(dDataAnt) == STR(Year(Date()),4)+'0501'	//Dia do Trabalho
					cFile := Dtos(dDataRef - 2)+'.csv'
				ElseIf	Dtos(dDataAnt) == STR(Year(Date()),4)+'0907'	//Dia da Independencia
					cFile := Dtos(dDataRef - 2)+'.csv'
				ElseIf	Dtos(dDataAnt) == STR(Year(Date()),4)+'1012'	//Dia da N. Sra. Aparecida
					cFile := Dtos(dDataRef - 2)+'.csv'
				ElseIf	Dtos(dDataAnt) == STR(Year(Date()),4)+'1102'	//Dia de Finados
					cFile := Dtos(dDataRef - 2)+'.csv'
				ElseIf	Dtos(dDataAnt) == STR(Year(Date()),4)+'1115'	//Dia da Proclamação da Republica
					cFile := Dtos(dDataRef - 2)+'.csv'
				ElseIf	Dtos(dDataAnt) == STR(Year(Date()),4)+'1225'	//Natal
					cFile := Dtos(dDataRef - 2)+'.csv'
				ElseIf	Dtos(dDataAnt) == STR(Year(Date()),4)+'1231'	//Dia sem Expediente Bancário
					cFile := Dtos(dDataRef - 2)+'.csv'
				ElseIf	Dow(dDataRef) == 2
					cFile := Dtos(dDataRef - 2)+'.csv'
				Else
					cFile := Dtos(dDataRef - 1)+'.csv'
				EndIf
			EndIf
			l_DtAnt  := .T.		
		//Dias Normais
		Else
			cFile := Dtos(dDataRef)+'.csv'
		EndIf
	EndIf

	If 	!(l_DtFDS) //Não manda E-mail e não faz o processo	

		//Link Oficial do Governo para busca a informação do (BC)Banco Central
		cTexto := httpGet('https://www4.bcb.gov.br/Download/fechamento/'+cFile)
		
		If !Empty(cTexto)
		
			nLinhas := MLCount(cTexto, 81)
			
			For J := 1 to nLinhas
		
				cLinha	:= Memoline(cTexto,81,j)
				cData  	:= Substr(cLinha,1,2)+"/"+Substr(cLinha,4,2)+"/"+Substr(cLinha,9,2)
				dData	:= Ctod(cData)
				cCompra := StrTran(Substr(cLinha,22,10),',','.')//Caso a empresa use o Valor de Compra nas linhas abaixo substitua por esta variável
				cVenda  := StrTran(Substr(cLinha,33,10),',','.')//Para conversão interna nas empresas normalmente usa-se Valor de Venda
				
				If	( Substr(cLinha,12,3)=='220' )	//Seleciona o Valor do Dolar  - MOEDA 2 Compra
					nValM02	:= Val(cCompra)
				EndIf
				
				If	( Substr(cLinha,12,3)=='220' )	//Seleciona o Valor do Dolar   - MOEDA 3 Venda
					nValM03	:= Val(cVenda)
				EndIf
				
				If	( Substr(cLinha,12,3)=='978' )	//Seleciona o Valor do Euro	  - MOEDA 4  Compra
					nValM04	:= Val(cCompra)
				EndIf
				
				If	( Substr(cLinha,12,3)=='978' )	//Seleciona o Valor do Euro   - MOEDA 5  Venda
					nValM05	:= Val(cVenda)
				EndIf
				
				If	( Substr(cLinha,12,3)=='470' )	//Seleciona o Valor do IYEN  - MOEDA 6 Compra
					nValM06	:= Val(cCompra)
				EndIf
				
				If	( Substr(cLinha,12,3)=='470' )	//Seleciona o Valor do IYEN   - MOEDA 7 Venda
					nValM07	:= Val(cVenda)
				EndIf
				
				If	( Substr(cLinha,12,3)=='165' )	//Seleciona o Valor do Canada  - MOEDA 8 Compra
					nValM08	:= Val(cCompra)
				EndIf
				
				If	( Substr(cLinha,12,3)=='165' )	//Seleciona o Valor do Canada  - MOEDA 9 Venda
					nValM09	:= Val(cVenda)
				EndIf
				
				If	( Substr(cLinha,12,3)=='205' )	//Seleciona o Valor do Hong Kong  - MOEDA10  Compra
					nValM10	:= Val(cCompra)
				EndIf
				
				If	( Substr(cLinha,12,3)=='205' )	//Seleciona o Valor do Hong Kong  - MOEDA11 Venda
					nValM11	:= Val(cVenda)
				EndIf
				
				If	( Substr(cLinha,12,3)=='150' )	//Seleciona o Valor do Australiano  - MOEDA12 Compra
					nValM12	:= Val(cCompra)
				EndIf
				
				If	( Substr(cLinha,12,3)=='150' )	//Seleciona o Valor do Australiano  - MOEDA13 Venda
					nValM13	:= Val(cVenda)
				EndIf
				
				If	( Substr(cLinha,12,3)=='540' )	//Seleciona o Valor do Libra   - MOEDA14 Compra
					nValM14	:= Val(cCompra)
				EndIf
				
				If	( Substr(cLinha,12,3)=='540' )	//Seleciona o Valor do Libra   - MOEDA15 Venda
					nValM15	:= Val(cVenda)
				EndIf
				
				If	( Substr(cLinha,12,3)=='195' )	//Seleciona o Valor do Cingapura  - MOEDA16 Compra
					nValM16	:= Val(cCompra)
				EndIf
				
				If	( Substr(cLinha,12,3)=='195' )	//Seleciona o Valor do Cingapura  - MOEDA17 Venda
					nValM17	:= Val(cVenda)
				EndIf
				
			Next J
			
		Endif
			
		n_DOW := Dow(dData)
		
		//De segunda a sexta
		If	( n_DOW >= 2 .And. n_DOW <= 6)				
			GravaDados()	      		 
			If dDataRef == dDataBase
				FTIMD01A()	
			EndIf
			//Se for Sexta, gravo o valores para sábado e domingo - Mantido da Regra original do Fonte AtuMoedas
			If ( n_DOW == 6 ) 
				For K := 1 to 2
					dData++
					//Grava os Valores de Sabado e Domingo
					GravaDados()	      		
				Next K
	
			Endif	
	
		EndIf 
				 
	EndIf

//Só vai enviar E-mail das Taxas de segunda a sexta
//n_EDOW := Dow(dDataDs)
//If ( n_EDOW >= 2 .And. n_EDOW <= 6)				
//If ( n_EDOW >= 2 .And. n_EDOW <= 6)				
//	FTIMD01A()
//EndIf

Next nPass
	
Return Nil
          
/********************************************************************************************/

Static Function GravaDados()

Local c_ScriptUPD 	:= ""                          
Local c_EOL			:= Chr(13) + Chr(10)

cVr02 := transform(nValM02,"@E 999,999.9999")		//Moeda 02 - Dollar
cVr03 := transform(nValM03,"@E 999,999.9999")		//Moeda 03 - Dollar
cVr04 := transform(nValM04,"@E 999,999.9999")		//Moeda 04 - Euro
cVr05 := transform(nValM05,"@E 999,999.9999")		//Moeda 05 - Euro
cVr06 := transform(nValM06,"@E 999,999.9999")		//Moeda 06 - Iyen
cVr07 := transform(nValM07,"@E 999,999.9999")		//Moeda 07 - Iyen
cVr08 := transform(nValM08,"@E 999,999.9999")		//Moeda 08 - Canada
cVr09 := transform(nValM09,"@E 999,999.9999")		//Moeda 09 - Canada
cVr10 := transform(nValM10,"@E 999,999.9999")		//Moeda 10 - Hong Kong
cVr11 := transform(nValM11,"@E 999,999.9999")		//Moeda 11 - Hong Kong
cVr12 := transform(nValM12,"@E 999,999.9999")		//Moeda 12 - Australiano
cVr13 := transform(nValM13,"@E 999,999.9999")		//Moeda 13 - Australiano
cVr14 := transform(nValM14,"@E 999,999.9999")		//Moeda 14 - Libra
cVr15 := transform(nValM15,"@E 999,999.9999")		//Moeda 15 - Libra
cVr16 := transform(nValM16,"@E 999,999.9999")		//Moeda 16 - Cingapura
cVr17 := transform(nValM17,"@E 999,999.9999")		//Moeda 17 - Cingapura

dData := If(Empty(dData),dDatabase,dData)	//Tem erro no Site do Banco Central, tem dias que não tem valor, vamos trazer do DIA anterior.

//No E-Mail ir a data Correta 
If l_DtAnt
	ctxt :=  "Taxas : "+Dtoc(dDataAux)  + c_EOL
Else 
	ctxt :=  "Taxas : "+Dtoc(dData)  	+ c_EOL
EndIf
ctxt +=  "02 Dolar Compra:"+cVr02+ c_EOL
ctxt +=  "03 Dolar Venda :"+cVr03+ c_EOL
ctxt +=  "04 Euro Compra :"+cVr04+ c_EOL
ctxt +=  "05 Euro Venda  :"+cVr05+ c_EOL
ctxt +=  "05 IYEN Compra :"+cVr06+ c_EOL
ctxt +=  "06 IYEN Venda  :"+cVr07+ c_EOL
ctxt +=  "08 Canada Compr:"+cVr08+ c_EOL
ctxt +=  "09 Canada Venda:"+cVr09+ c_EOL
ctxt +=  "10 H.Kong Compr:"+cVr10+ c_EOL
ctxt +=  "11 H.Kong Venda:"+cVr11+ c_EOL
ctxt +=  "12 Austr. Compr:"+cVr12+ c_EOL
ctxt +=  "13 Austr. Venda:"+cVr13+ c_EOL
ctxt +=  "14 Libra Compra:"+cVr14+ c_EOL
ctxt +=  "15 Libra Venda :"+cVr15+ c_EOL
ctxt +=  "16 Cingap Compr:"+cVr16+ c_EOL
ctxt +=  "17 Cingap Venda:"+cVr17+ c_EOL

ConOut(ctxt)

c_ScriptUPD += "UPDATE " + RetSqlName("SM2") + " " + c_EOL
c_ScriptUPD += "SET	  M2_MOEDA1  = " + AllTrim(Str(nValReal)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA2  = " + AllTrim(Str(nValM02))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA3  = " + AllTrim(Str(nValM03))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA4  = " + AllTrim(Str(nValM04))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA5  = " + AllTrim(Str(nValM05))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA6  = " + AllTrim(Str(nValM06))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA7  = " + AllTrim(Str(nValM07))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA8  = " + AllTrim(Str(nValM08))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA9  = " + AllTrim(Str(nValM09))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA10 = " + AllTrim(Str(nValM10))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA11 = " + AllTrim(Str(nValM11))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA12 = " + AllTrim(Str(nValM12))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA13 = " + AllTrim(Str(nValM13))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA14 = " + AllTrim(Str(nValM14))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA15 = " + AllTrim(Str(nValM15))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA16 = " + AllTrim(Str(nValM16))  + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA17 = " + AllTrim(Str(nValM17))  + " " + c_EOL
c_ScriptUPD += "	, M2_XLOGDT = '" + AllTrim(DTOS(MsDate()))+ "'" + c_EOL //Seta Flag de Log
c_ScriptUPD += "	, M2_XLOGHR = '" + AllTrim(Left(Time(),5))+ "'" + c_EOL //Seta Flag de Log
If l_DtAnt
	c_ScriptUPD += "WHERE M2_DATA   = '" + DTOS(dDataAux) + "' "    + c_EOL
Else
	c_ScriptUPD += "WHERE M2_DATA   = '" + DTOS(dData) + "' "       + c_EOL 
EndIf
c_ScriptUPD += "AND D_E_L_E_T_ = ''"                                + c_EOL
                                        
TcSqlExec(c_ScriptUPD)

Return Nil

/*************************************************************************************/

Static Function FTIMD01A()

Local c_Html := ""

c_Html := '<HTML><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
c_Html += '	<html xmlns="http://www.w3.org/1999/xhtml">'
c_Html += '	<style type="text/css">'
c_Html += '		.tituloPag { FONT-SIZE: 20px; COLOR: #666699; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Html += '		.formulario { FONT-SIZE: 10px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Html += '		.formulario5 { FONT-SIZE: 13px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Html += '		.formulario4 { FONT-SIZE: 13px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Html += '		.formulario2 { FONT-SIZE: 11px; COLOR: #333333; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; }'
c_Html += '		.formulario6 { FONT-SIZE: 12px; COLOR: #333333; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; }'
c_Html += '		.formulario7 { FONT-SIZE: 12px; COLOR: #FF0000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; }'
c_Html += '		.formulario3 { FONT-SIZE: 10px; COLOR: #FFFFFF; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Html += '		.formularioTit { FONT-SIZE: 13px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none;  }'
c_Html += '		.formularioTit2 { FONT-SIZE: 15px; COLOR: #FFFFFF; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none; font-weight: bold; }'
c_Html += '		.formularioTit3 { FONT-SIZE: 13px; COLOR: #FFFFFF; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none;  }'
c_Html += '	</style>'
c_Html += '<head>'
c_Html += '	<title> '+SM0->M0_NOMECOM+' - Atualização Moedas </title>'
c_Html += '</head>'
c_Html += '<table width="95%" border="0" align="center">'
c_Html += '<tr>'
c_Html += '	<td colspan="14" bgcolor="#000066">'
c_Html += '		<div align="center"><span class="formularioTit2"><H2>'+SM0->M0_NOMECOM+' - Atualização Moedas</H2></span></div>'
c_Html += '	</td>'
c_Html += '</tr>'
c_Html += '<tr>'
c_Html += '	<td colspan="10">&nbsp;</td>'
c_Html += '</tr>'
c_Html += '<tr>'
c_Html += '	<td colspan="10"><span class="formularioTit">E-mail gerado em '+DtoC(MsDate())+' às '+Time()+'</span></td>'
c_Html += '</tr>'
c_Html += '<tr>'
c_Html += '	<td colspan="10"><span class="formularioTit">&nbsp;&nbsp;</span></td>'
c_Html += '</tr>'
c_Html += "<TABLE border='0' width='100%'align=left cellpadding='0' cellspacing='0' bordercolor='#cccccc' class='formulario2'>" 
c_Html += "<font face='Arial' size='3'><B>"+ctxt+"</B></font>"
c_Html += "</TABLE>"
c_Html += "<BR>"
c_Html += "<BR>"
c_Html += "<hr>"
c_Html += "<p style='margin-top: 0; margin-bottom: 0'><font size='1' color='#0000FF' face='Arial'>Mensagem Automática Protheus - </font><font size='3' color='#0000FF' face='Arial'>Favor não responder </font></p>"
c_Html += "<p style='margin-top: 0; margin-bottom: 0'><font size='1' color='#0000FF' face='Arial'>Responsável: TI </font></p>"
c_Html += "<p style='margin-top: 0; margin-bottom: 0'><font size='1' face='Arial'>Rotina Originada pelo Ambiente.: " + Upper(AllTrim(GetEnvServer())) + "</font></p>"
c_Html += "<p style='margin-top: 0; margin-bottom: 0'><font size='1' face='Arial'>Rotina Originada pela Rotina...: " + ALLTRIM(FUNNAME()) + "</font></p>"
c_Html += "</BODY>"
c_Html += "</HTML>"

c_From		:= GetMV("MV_XMLMOED") 
c_Copia 	:= "" //GetMV("MV_XMAILFC") // Enviado para os e-mails TESTE 
c_Assunto	:= "Atualizacao de Moedas Automatica - FTI"
c_Attach	:= ""
U_FCSendMail(Nil,Nil,Nil,GetMV("MV_RELACNT"),c_From,c_Copia,c_Assunto,c_Html,c_Attach)

Return Nil

/***************************************************************************************************/	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ fSM2Qry | Autor ³ Tiago Dias (Focus Consultoria) | Data ³ 13/01/15         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Monta a Query para selecionar os dados do relatorio.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil		  		                                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil   		    	                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fSM2Qry()

Local c_QryAux := ""
Local c_EOL	   := CHR(13)

//Estou usando o TOP 7 pois conforme esta no Fonte do André da Introde o Bacen 
//só disponibiliza os valores de uma semana (Não sei se isso é verdade)
c_QryAux :="SELECT	TOP 7 M2_DATA					"	+ c_EOL
c_QryAux +="FROM	" + RetSqlName("SM2") + " SM2	"	+ c_EOL
c_QryAux +="WHERE 	M2_XLOGDT=''					"	+ c_EOL 
c_QryAux +="AND	  	M2_XLOGHR=''					"	+ c_EOL
c_QryAux +="AND   	M2_DATA<='" + DTOS(MsDate()) + "'"	+ c_EOL
c_QryAux +="AND	  	SM2.D_E_L_E_T_ = ''				"	+ c_EOL
c_QryAux +="ORDER BY M2_DATA DESC					"	+ c_EOL
		
IF Select("QRY") > 0
	QRY->(dbCloseArea())
ENDIF

MemoWrite("QRYSM2.SQL", c_QryAux)

TcQuery c_QryAux New Alias "QRY"	                              

Return Nil

/***************************************************************************************************/	
