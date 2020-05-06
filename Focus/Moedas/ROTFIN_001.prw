//******************************************************************************************
// Programa:	ATUMOEDAS
// Data:		01/07/2015
// Objeto:		Atualiza e Projeta Moedas/Cambio - Buscando os Dados no BC (Banco Central)
// Uso:			Modulos Financeiro Protheus 11
// Autor:		Andre Salgado / INTRODE Integrated Solutions
//*******************************************************************************************

// Colocar as linhas abaixo no AP8SRV.INI
// [ONSTART]
// jobs=Moedas
// ;Tempo em Segundos 86400=24 horas
// RefreshRate=86400
//
// [Moedas]
// main=u_AtuMoedas
// Environment=Environment

#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/********************************************************************************************/

User Function AtuMoedas()
                        
Private dDataRef	:= CTOD("//")
Private dData 		:= CTOD("//")
Private nValDolar	:= nValYen := nValEuro := 0
Private nValM02 	:= nValM03 := nValM04 := nValM05 := nValM06 := nValM07 := nValM08 := nValM09 := nValM10 := 0
Private nValM11 	:= nValM12 := nValM13 := nValM14 := nValM15 := nValM16 := nValM17 := nValM18 := nValM19 := 0
Private nValReal	:= 1.000000

MsgRun("Atualizando MOEDAS, por favor, aguarde...", "Especifico FTI", {|| xExecMoeda()} )

Return Nil

/********************************************************************************************/

Static Function xExecMoeda()

Local nPass, cFile, cTexto, nLinhas, cLinha, cdata, cCompra, cVenda, J, K, L
                     
For nPass := 6 to 0 step -1					//Refaz os ultimos 6 dias. O BCB não disponibiliza periodo maior de uma semana
	dDataRef := dDataBase - nPass
	
	//Feriados Bancário Fixo
	If ( Dtos(dDataRef) == STR(Year(Date()),4)+'0101' )		//Dia Mundial da Paz
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
		//Feriado Bancário Variável 2007. Rever Anualmente
	ElseIf	Dtos(dDataRef) == STR(Year(Date()),4)+'0219'	//Segunda de Carnaval
		cFile := Dtos(dDataRef - 1)+'.csv'
	ElseIf	Dtos(dDataRef) == STR(Year(Date()),4)+'0220'	//Terça de Carnaval
		cFile := Dtos(dDataRef - 1)+'.csv'
	ElseIf	Dtos(dDataRef) == STR(Year(Date()),4)+'0406'	//Sexta-Feira da Paixão
		cFile := Dtos(dDataRef - 1)+'.csv'
	ElseIf	Dtos(dDataRef) == STR(Year(Date()),4)+'0607'	//Corpus Christi
		cFile := Dtos(dDataRef - 1)+'.csv'
		//Finais de Semana
	ElseIf	Dow(dDataRef) == 1					//Se for domingo
		cFile := Dtos(dDataRef - 2)+'.csv'
	ElseIf	Dow(dDataRef) == 7  				//Se for sabado
		cFile := Dtos(dDataRef - 1)+'.csv'

	//Dias Normais
	Else
		cFile := Dtos(dDataRef)+'.csv'
	EndIf
	
	//Link Oficial do Governo para busca a informação do (BC)Banco Central
	cTexto  := HttpGet('https://www4.bcb.gov.br/Download/fechamento/'+cFile)
	
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

//	IF dData=ddatabase
//		cSqlUpd := "DELETE "+RetSqlName("SM2")+" WHERE M2_DATA = '"+DTOS(DDATABASE)+"' "
//		TcSqlExec(cSqlUpd)
//	Endif
	
	n_DOW := Dow(dData)
	
	//Se for sexta
	If	( n_DOW >= 2 .And. n_DOW <= 6)				
		
		//Grava Valor da Taxa Sexta
		GravaDados()	      		 
		
		//Se for Sexta, gravo o valores para sábado e domingo
		If ( n_DOW == 6 ) 
			
			For K := 1 to 2
				dData++                    
				//Grava os Valores de Sabado e Domingo
				GravaDados()	      		
			Next K
		
		Endif
		
	EndIf 
	
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

ctxt :=  "Taxas :"+Dtoc(dData)   + c_EOL
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
c_ScriptUPD += "SET	M2_MOEDA1 = " + AllTrim(Str(nValReal)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA2 = " + AllTrim(Str(nValM02)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA3 = " + AllTrim(Str(nValM03)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA4 = " + AllTrim(Str(nValM04)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA5 = " + AllTrim(Str(nValM05)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA6 = " + AllTrim(Str(nValM06)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA7 = " + AllTrim(Str(nValM07)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA8 = " + AllTrim(Str(nValM08)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA9 = " + AllTrim(Str(nValM09)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA10 = " + AllTrim(Str(nValM10)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA11 = " + AllTrim(Str(nValM11)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA12 = " + AllTrim(Str(nValM12)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA13 = " + AllTrim(Str(nValM13)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA14 = " + AllTrim(Str(nValM14)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA15 = " + AllTrim(Str(nValM15)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA16 = " + AllTrim(Str(nValM16)) + " " + c_EOL
c_ScriptUPD += "	, M2_MOEDA17 = " + AllTrim(Str(nValM17)) + " " + c_EOL
c_ScriptUPD += "WHERE M2_DATA = '" + DTOS(dData) + "' " + c_EOL
c_ScriptUPD += "AND D_E_L_E_T_ = ' ' " + c_EOL
                                        
TcSqlExec(c_ScriptUPD)

/*
O BLOCO ABAIXO NAO FUNCIONA, SIMPLESMENTE "PULA" AS LINHAS QUE ATUALIZAM AS MOEDAS... ANALISAR

DbSelectArea("SM2")						
DbSetorder(1) //M2_DATA, R_E_C_N_O_, D_E_L_E_T_

//Grava no Banco de Dados do Sistema - SM2
If SM2->(DbSeek(DTOS(dData), .F.))
	Reclock('SM2', .F.)
Else
	Reclock('SM2', .T.)
	SM2->M2_DATA := dData
EndIf
SM2->M2_MOEDA1	:= nValReal				//Real

SM2->M2_MOEDA2	:= nValM02			//Moeda 02 - Dolar Compra
SM2->M2_MOEDA3	:= nValM03			//Moeda 03 - Dolar Venda
SM2->M2_MOEDA4	:= nValM04			//Moeda 04 - Euro Compra
SM2->M2_MOEDA5	:= nValM05			//Moeda 05 - Euro Venda

SM2->M2_MOEDA6	:= nValM06			//Moeda 06 - Iyen Compra
SM2->M2_MOEDA7	:= nValM07			//Moeda 07 - Iyen Venda
SM2->M2_MOEDA8	:= nValM08			//Moeda 08 - Canada Compra
SM2->M2_MOEDA9	:= nValM09			//Moeda 09 - Canada Venda
SM2->M2_MOEDA10	:= nValM10			//Moeda 10 - Hong Kong Compra
SM2->M2_MOEDA11	:= nValM11			//Moeda 11 - Hong Kong Venda
SM2->M2_MOEDA12	:= nValM12			//Moeda 12 - Australiano Compra
SM2->M2_MOEDA13	:= nValM13			//Moeda 13 - Australiano Venda
SM2->M2_MOEDA14	:= nValM14			//Moeda 14 - Libra Compra
SM2->M2_MOEDA15	:= nValM15			//Moeda 15 - Libra Venda
SM2->M2_MOEDA16	:= nValM16			//Moeda 16 - Cingapura Compra
SM2->M2_MOEDA17	:= nValM17			//Moeda 17 - Cingapura Venda

SM2->M2_INFORM	:= "S"
MsUnlock()
*/

Return Nil