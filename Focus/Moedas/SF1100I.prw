#INCLUDE "Rwmake.ch"
#INCLUDE "TOPCONN.CH"
/*
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                         FICHA TECNICA DO PROGRAMA                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma         ³ SF1100I.PRW   										  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricso        ³Ponto de Entrada Para Complemento Informar Impostos     º±±
±±º                 ³  Solicita��o - Marcel                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor            ³Andre Salgado                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºData de Criacao  ³ 31/07/2015										      º±±
±±ºData de Melhoria ³ 13/02/2017 - Sol.Marcel - Vencto Imposto mesmo Titulo
±±ºData de Melhoria ³ 13/02/2017 - Sol.Marcel - Data Contabil.Imposto mesmo TIT.
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
*/

User Function SF1100I
**************************

Local lConfirma := .F.
Local nxCofins	:= nxPis := nxCSL := nxiss := nxIRF := nxCIDE := nxIof :=0
Local cCombo1	:= {"N=Nao","S=Sim"}
Local cTpIRF	:= " "
Private cNomFor := Posicione("SA2",1,xFilial("SA2")+SF1->(F1_FORNECE+F1_LOJA), "A2_NOME")


If SF1->F1_EST = "EX" .AND. SF1->F1_TXMOEDA <> 1
	
	//Tela apresentada para usuario
	@ 096,003 TO 450,680 DIALOG _OBJETO TITLE "Dados Adicionais  - Invoice: "+ SF1->F1_DOC
	
	@ 05,04  Say "Fornecedor: "+ cNomFor
	@ 20,04  Say "IRF p/ Provisao:"
	@ 20,90  Get nxIRF    picture "@E 999,999.99"  size 50,50
	@ 20,160 Say "IR RETIDO "
	@ 20,190 COMBOBOX cTpIRF ITEMS cCombo1 SIZE 50,50
	@ 35,04  Say "IOF p/ Provisao:"
	@ 35,90  Get nxIOF    picture "@E 999,999.99"  size 50,50
	@ 50,04  Say "CIDE p/ Provisao:"
	@ 50,90  Get nxCIDE	  picture "@E 999,999.99"  size 50,50
	@ 65,04  Say "PIS p/ Provisao:"
	@ 65,90  Get nxPis    picture "@E 999,999.99"  size 50,50
	@ 80,04  Say "COFINS p/ Provisao:"
	@ 80,90  Get nxCofins picture "@E 999,999.99"  size 50,50
	@ 95,04  Say "ISS p/ Provisao:"
	@ 95,90  Get nxISS    picture "@E 999,999.99"  size 50,50
	//	@ 110,04 Say "CSLL p/ Provisao:"
	//	@ 110,90 Get nxCSL    picture "@E 999,999.99"  size 50,50
	@ 125,04 Say "Obs. Informar em Moeda Original: US$, Euro,..."
	
	@ 140,90 BMPBUTTON TYPE 1 ACTION CLOSE(_OBJETO)  // Substituido pelo assistente de conversao do AP5 IDE em 23/06/01 ==>       @ 115,280 BMPBUTTON TYPE 1 ACTION Execute(OBOK)
	Activate Dialog _OBJETO CENTERED
	
	
	//Atualiza os dados na Tabela - SF1
	Reclock("SF1",.F.)
	SF1->F1_VALCOFI	:= Round(nxCofins * SF1->F1_TXMOEDA, 2)	//Taxa Cofins sobre Provisao Importação / Invoice
	SF1->F1_VALPIS	:= Round(nxPis * SF1->F1_TXMOEDA, 2)	//Taxa Pis  sobre Provisao Importação / Invoice
	SF1->F1_VALCSLL	:= Round(nxCsl * SF1->F1_TXMOEDA, 2)	//Taxa CSLL sobre Provisao Importação / Invoice
	SF1->F1_VALIRF	:= Round(nxIRF * SF1->F1_TXMOEDA, 2)	//Taxa IRF  sobre Provisao Importação / Invoice
	SF1->F1_VLCIDE	:= Round(nxCIDE * SF1->F1_TXMOEDA, 2)	//Taxa CIDE sobre Provisao Importação / Invoice
	SF1->F1_VALFDS	:= Round(nxIOF * SF1->F1_TXMOEDA, 2)	//Taxa IOF  sobre Provisao Importação / Invoice
	SF1->F1_ISS		:= Round(nxISS * SF1->F1_TXMOEDA, 2)	//Taxa IOF  sobre Provisao Importação / Invoice
	SF1->F1_TPFRETE := IF(cTpIRF = "S","C"," ")			//Irf Sera Retido na Importa��o da INVOICE
	MsUnlock()
	
	
	//Atualiza os dados na Tabela - SE2
	Reclock("SE2",.F.)
	SE2->E2_TPCTB	:= "1"
	MsUnlock()
	
	
	//Variavel	Titulo Pai
	cTitPai	:= SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)
	cxMoeda	:= SE2->E2_MOEDA
	cxTaxa	:= SF1->F1_TXMOEDA
	cnValSE2:= SE2->E2_VALOR
	cCCD	:= Posicione("SD1",1,xFilial("SD1")+SF1->(F1_DOC+F1_SERIE),"D1_CC")
	cITEMCTA:= Posicione("SD1",1,xFilial("SD1")+SF1->(F1_DOC+F1_SERIE),"D1_ITEMCTA")
	cDescMoeda := " "
	
	//Descri��o da Moeda
	IF cxMoeda=2
		cDescMoeda := "D�lar Americano Compra"
	ElseIF cxMoeda=3
		cDescMoeda := "D�lar Americano Venda"
	ElseIF cxMoeda=4
		cDescMoeda := "Euro Compra"
	ElseIF cxMoeda=5
		cDescMoeda := "Euro Vendas"
	ElseIF cxMoeda=6
		cDescMoeda := "Iene Compra"
	ElseIF cxMoeda=7
		cDescMoeda := "Iene Venda"
	ElseIF cxMoeda=8
		cDescMoeda := "D�lar Canadense Compra"
	ElseIF cxMoeda=9
		cDescMoeda := "D�lar Canadense Venda"
	ElseIF cxMoeda=10
		cDescMoeda := "D�lar Hong Kong Compra"
	ElseIF cxMoeda=11
		cDescMoeda := "D�lar Hong Kong Venda"
	ElseIF cxMoeda=12
		cDescMoeda := "D�lar Australiano Compra"
	ElseIF cxMoeda=13
		cDescMoeda := "D�lar Australiano Venda"
	ElseIF cxMoeda=14
		cDescMoeda := "Libra Esterlina Compra"
	ElseIF cxMoeda=15
		cDescMoeda := "Libra Esterlina Venda"
	ElseIF cxMoeda=16
		cDescMoeda := "D�lar Cingapura Compra"
	ElseIF cxMoeda=17
		cDescMoeda := "D�lar Cingapura Venda"
	ENdif
	
	
	
	//Titulo principal - Titulo Com Reten��o
	If cTpIRF = "S"
		Reclock("SE2",.f.)
		SE2->E2_TXMOEDA	:= cxTaxa
		SE2->E2_IRRF	:= nxIRF
		SE2->E2_HIST	:= "TIT C/ RET IRRF"
		SE2->E2_VALOR	:= cnValSE2 - nxIRF
		//		SE2->E2_VALLIQ	:= SE2->E2_VALOR - nxIRF
		SE2->E2_SALDO	:= cnValSE2 - nxIRF
		SE2->E2_VLCRUZ	:= SE2->E2_VLCRUZ - Round(nxIRF * cxTaxa,2)
		
		//		SE2->E2_HIST	:= "INVOICE NR."+SF1->F1_DOC
		SE2->E2_NOMEMOE := UPPER(cDescMoeda)
		SE2->E2_CCD		:= cCCD
		SE2->E2_ITEMD	:= cITEMCTA
		SE2->E2_CTAUSGA	:= "3101"
		SE2->E2_TPCTB	:= "1"
		
		SE2->E2_PARCIR := "1"
		SE2->E2_PRETPIS:= "1"
		SE2->E2_PRETCOF:= "1"
		SE2->E2_PRETCSL:= "1"
		MsUnlock()
	Endif
	
	
	//Atualiza Tit Pi
	If cTpIRF <> "S"
		Reclock("SE2",.f.)
		SE2->E2_TXMOEDA	:= cxTaxa
		SE2->E2_HIST	:= "INVOICE NR."+SF1->F1_DOC
		SE2->E2_NOMEMOE := UPPER(cDescMoeda)
		SE2->E2_CCD		:= cCCD
		SE2->E2_ITEMD	:= cITEMCTA
		SE2->E2_CTAUSGA	:= "3101"
		SE2->E2_TPCTB	:= "1"
		SE2->E2_PARCIR := "1"
		SE2->E2_PRETPIS:= "1"
		SE2->E2_PRETCOF:= "1"
		SE2->E2_PRETCSL:= "1"
		MsUnlock()
	Endif
	
	dVencto := SE2->E2_VENCTO
	dVencto := IF(EMPTY(dVencto), SF1->F1_EMISSAO, dVencto)
	
	//Atualiza IRF
	IF nxIRF > 0
		
		//		dbselectArea("SE2")
		//		DbSetOrder( 1 )
		//		IF !DBSEEK( xFilial("SE2") +  SF1->F1_PREFIXO + SF1->F1_DOC, .T. )
		cForTit	:= "UNIAO 02"	//Informar o Codigo do Fornecedor Codigo (06) + Loja (02)
		cNatTit	:= Posicione("SA2",1,xFilial("SA2")+cForTit,"A2_NATUREZ")
		cNOMTit	:= Posicione("SA2",1,xFilial("SA2")+cForTit,"A2_NREDUZ")
		
		Reclock("SE2",.T.)
		SE2->E2_FILIAL 	:= xFilial("SE2")
		SE2->E2_PREFIXO	:= SF1->F1_SERIE
		SE2->E2_NUM		:= SF1->F1_DOC
		SE2->E2_PARCELA	:= "T"
		SE2->E2_TIPO	:= "TX"
		SE2->E2_NATUREZ	:= cNatTit
		SE2->E2_FORNECE	:= LEFT(cForTit,6)
		SE2->E2_LOJA	:= RIGHT(cForTit,2)
		SE2->E2_NOMFOR	:= cNOMTit
		SE2->E2_EMISSAO	:= SF1->F1_EMISSAO
		SE2->E2_VENCTO	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_VENCREA	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_EMIS1	:= SF1->F1_DTDIGIT
		SE2->E2_VENCORI	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_HIST	:= "IMPOSTOS INVOICE - IRF"
		SE2->E2_VALOR	:= nxIRF //IMPOSTOS
		SE2->E2_SALDO	:= nxIRF //IMPOSTOS
		SE2->E2_MOEDA	:= SF1->F1_MOEDA
		SE2->E2_ORIGEM	:= "MATA100"
		SE2->E2_FILORIG	:= XFILIAL("SE2")
		SE2->E2_TITPAI 	:= cTitPai
		SE2->E2_MOEDA	:= cxMoeda
		SE2->E2_TXMOEDA	:= cxTaxa
		SE2->E2_VLCRUZ 	:= Round(nxIRF * cxTaxa,2)
		
		SE2->E2_NOMEMOE := UPPER(cDescMoeda)
		SE2->E2_CCD		:= cCCD
		SE2->E2_ITEMD	:= cITEMCTA
		SE2->E2_CTAUSGA	:= "3101"
		SE2->E2_TPCTB	:= "1"
		
		
		MsUnlock()
	Endif
	//	Endif
	
	
	//Atualiza IOF
	IF nxIOF > 0
		cForTit	:= "UNIAO 01"	//Informar o Codigo do Fornecedor Codigo (06) + Loja (02)
		cNatTit	:= Posicione("SA2",1,xFilial("SA2")+cForTit,"A2_NATUREZ")
		cNOMTit	:= Posicione("SA2",1,xFilial("SA2")+cForTit,"A2_NREDUZ")
		
		Reclock("SE2",.T.)
		SE2->E2_FILIAL 	:= xFilial("SE2")
		SE2->E2_PREFIXO	:= SF1->F1_SERIE
		SE2->E2_NUM		:= SF1->F1_DOC
		SE2->E2_PARCELA	:= "U"
		SE2->E2_TIPO	:= "TX"
		SE2->E2_NATUREZ	:= cNatTit
		SE2->E2_FORNECE	:= LEFT(cForTit,6)
		SE2->E2_LOJA	:= RIGHT(cForTit,2)
		SE2->E2_NOMFOR	:= cNOMTit
		SE2->E2_EMISSAO	:= SF1->F1_EMISSAO
		SE2->E2_VENCTO	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_VENCREA	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_EMIS1	:= SF1->F1_DTDIGIT
		SE2->E2_VENCORI	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_HIST	:= "IMPOSTOS INVOICE - IOF"
		SE2->E2_VALOR	:= nxIOF //IMPOSTOS
		SE2->E2_SALDO	:= nxIOF //IMPOSTOS
		SE2->E2_MOEDA	:= SF1->F1_MOEDA
		SE2->E2_ORIGEM	:= "MATA100"
		SE2->E2_FILORIG	:= XFILIAL("SE2")
		SE2->E2_TITPAI 	:= cTitPai
		SE2->E2_MOEDA	:= cxMoeda
		SE2->E2_TXMOEDA	:= cxTaxa
		SE2->E2_VLCRUZ 	:= Round(nxIOF * cxTaxa,2)
		
		SE2->E2_NOMEMOE := UPPER(cDescMoeda)
		SE2->E2_CCD		:= cCCD
		SE2->E2_ITEMD	:= cITEMCTA
		SE2->E2_CTAUSGA	:= "3101"
		SE2->E2_TPCTB	:= "1"
		
		MsUnlock()
	Endif
	
	
	//Atualiza CIDE
	IF nxCIDE > 0
		cForTit	:= "UNIAO 03"	//Informar o Codigo do Fornecedor Codigo (06) + Loja (02)
		cNatTit	:= Posicione("SA2",1,xFilial("SA2")+cForTit,"A2_NATUREZ")
		cNOMTit	:= Posicione("SA2",1,xFilial("SA2")+cForTit,"A2_NREDUZ")
		
		Reclock("SE2",.T.)
		SE2->E2_FILIAL 	:= xFilial("SE2")
		SE2->E2_PREFIXO	:= SF1->F1_SERIE
		SE2->E2_NUM		:= SF1->F1_DOC
		SE2->E2_PARCELA	:= "V"
		SE2->E2_TIPO	:= "TX"
		SE2->E2_NATUREZ	:= cNatTit
		SE2->E2_FORNECE	:= LEFT(cForTit,6)
		SE2->E2_LOJA	:= RIGHT(cForTit,2)
		SE2->E2_NOMFOR	:= cNOMTit
		SE2->E2_EMISSAO	:= SF1->F1_EMISSAO
		SE2->E2_VENCTO	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_VENCREA	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_EMIS1	:= SF1->F1_DTDIGIT
		SE2->E2_VENCORI	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_HIST	:= "IMPOSTOS INVOICE - CIDE"
		SE2->E2_VALOR	:= nxCIDE //IMPOSTOS
		SE2->E2_SALDO	:= nxCIDE //IMPOSTOS
		SE2->E2_MOEDA	:= SF1->F1_MOEDA
		SE2->E2_ORIGEM	:= "MATA100"
		SE2->E2_FILORIG	:= XFILIAL("SE2")
		SE2->E2_TITPAI 	:= cTitPai
		SE2->E2_MOEDA	:= cxMoeda
		SE2->E2_TXMOEDA	:= cxTaxa
		SE2->E2_VLCRUZ 	:= Round(nxCIDE * cxTaxa,2)
		
		SE2->E2_NOMEMOE := UPPER(cDescMoeda)
		SE2->E2_CCD		:= cCCD
		SE2->E2_ITEMD	:= cITEMCTA
		SE2->E2_CTAUSGA	:= "3101"
		SE2->E2_TPCTB	:= "1"
		
		MsUnlock()
	Endif
	
	//Atualiza Pis
	IF nxPis > 0
		cForTit	:= "UNIAO 04"	//Informar o Codigo do Fornecedor Codigo (06) + Loja (02)
		cNatTit	:= Posicione("SA2",1,xFilial("SA2")+cForTit,"A2_NATUREZ")
		cNOMTit	:= Posicione("SA2",1,xFilial("SA2")+cForTit,"A2_NREDUZ")
		
		Reclock("SE2",.T.)
		SE2->E2_FILIAL 	:= xFilial("SE2")
		SE2->E2_PREFIXO	:= SF1->F1_SERIE
		SE2->E2_NUM		:= SF1->F1_DOC
		SE2->E2_PARCELA	:= "W"
		SE2->E2_TIPO	:= "TX"
		SE2->E2_NATUREZ	:= cNatTit
		SE2->E2_FORNECE	:= LEFT(cForTit,6)
		SE2->E2_LOJA	:= RIGHT(cForTit,2)
		SE2->E2_NOMFOR	:= cNOMTit
		SE2->E2_EMISSAO	:= SF1->F1_EMISSAO
		SE2->E2_VENCTO	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_VENCREA	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_EMIS1	:= SF1->F1_DTDIGIT
		SE2->E2_VENCORI	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_HIST	:= "IMPOSTOS INVOICE - PIS"
		SE2->E2_VALOR	:= nxPis //IMPOSTOS
		SE2->E2_SALDO	:= nxPis //IMPOSTOS
		SE2->E2_MOEDA	:= SF1->F1_MOEDA
		SE2->E2_ORIGEM	:= "MATA100"
		SE2->E2_FILORIG	:= XFILIAL("SE2")
		SE2->E2_TITPAI 	:= cTitPai
		SE2->E2_MOEDA	:= cxMoeda
		SE2->E2_TXMOEDA	:= cxTaxa
		SE2->E2_VLCRUZ 	:= Round(nxPis * cxTaxa,2)
		
		SE2->E2_NOMEMOE := UPPER(cDescMoeda)
		SE2->E2_CCD		:= cCCD
		SE2->E2_ITEMD	:= cITEMCTA
		SE2->E2_CTAUSGA	:= "3101"
		SE2->E2_TPCTB	:= "1"
		
		MsUnlock()
	Endif
	
	//Atualiza Cofins
	IF nxCofins > 0
		cForTit	:= "UNIAO 05"	//Informar o Codigo do Fornecedor Codigo (06) + Loja (02)
		cNatTit	:= Posicione("SA2",1,xFilial("SA2")+cForTit,"A2_NATUREZ")
		cNOMTit	:= Posicione("SA2",1,xFilial("SA2")+cForTit,"A2_NREDUZ")
		
		Reclock("SE2",.T.)
		SE2->E2_FILIAL 	:= xFilial("SE2")
		SE2->E2_PREFIXO	:= SF1->F1_SERIE
		SE2->E2_NUM		:= SF1->F1_DOC
		SE2->E2_PARCELA	:= "X"
		SE2->E2_TIPO	:= "TX"
		SE2->E2_NATUREZ	:= cNatTit
		SE2->E2_FORNECE	:= LEFT(cForTit,6)
		SE2->E2_LOJA	:= RIGHT(cForTit,2)
		SE2->E2_NOMFOR	:= cNOMTit
		SE2->E2_EMISSAO	:= SF1->F1_EMISSAO
		SE2->E2_VENCTO	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_VENCREA	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_EMIS1	:= SF1->F1_DTDIGIT
		SE2->E2_VENCORI	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_HIST	:= "IMPOSTOS INVOICE - COFINS"
		SE2->E2_VALOR	:= nxCofins //IMPOSTOS
		SE2->E2_SALDO	:= nxCofins //IMPOSTOS
		SE2->E2_VLCRUZ	:= nxCofins //IMPOSTOS
		SE2->E2_MOEDA	:= SF1->F1_MOEDA
		SE2->E2_ORIGEM	:= "MATA100"
		SE2->E2_FILORIG	:= XFILIAL("SE2")
		SE2->E2_TITPAI 	:= cTitPai
		SE2->E2_MOEDA	:= cxMoeda
		SE2->E2_TXMOEDA	:= cxTaxa
		SE2->E2_VLCRUZ 	:= Round(nxCofins * cxTaxa,2)
		
		SE2->E2_NOMEMOE := UPPER(cDescMoeda)
		SE2->E2_CCD		:= cCCD
		SE2->E2_ITEMD	:= cITEMCTA
		SE2->E2_CTAUSGA	:= "3101"
		SE2->E2_TPCTB	:= "1"
		
		MsUnlock()
	Endif
	
	//Atualiza ISS
	IF nxISS > 0
		cForTit	:= "MUNIC 01"	//Informar o Codigo do Fornecedor Codigo (06) + Loja (02)
		cNatTit	:= Posicione("SA2",1,xFilial("SA2")+cForTit,"A2_NATUREZ")
		cNOMTit	:= Posicione("SA2",1,xFilial("SA2")+cForTit,"A2_NREDUZ")
		
		Reclock("SE2",.T.)
		SE2->E2_FILIAL 	:= xFilial("SE2")
		SE2->E2_PREFIXO	:= SF1->F1_SERIE
		SE2->E2_NUM		:= SF1->F1_DOC
		SE2->E2_PARCELA	:= "Y"
		SE2->E2_TIPO	:= "TX"
		SE2->E2_NATUREZ	:= cNatTit
		SE2->E2_FORNECE	:= LEFT(cForTit,6)
		SE2->E2_LOJA	:= RIGHT(cForTit,2)
		SE2->E2_NOMFOR	:= cNOMTit
		SE2->E2_EMISSAO	:= SF1->F1_EMISSAO
		SE2->E2_VENCTO	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_VENCREA	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_EMIS1	:= SF1->F1_DTDIGIT
		SE2->E2_VENCORI	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_HIST	:= "IMPOSTOS INVOICE - ISS"
		SE2->E2_VALOR	:= nxISS //IMPOSTOS
		SE2->E2_SALDO	:= nxISS //IMPOSTOS
		SE2->E2_VLCRUZ	:= nxISS //IMPOSTOS
		SE2->E2_MOEDA	:= SF1->F1_MOEDA
		SE2->E2_ORIGEM	:= "MATA100"
		SE2->E2_FILORIG	:= XFILIAL("SE2")
		SE2->E2_TITPAI 	:= cTitPai
		SE2->E2_MOEDA	:= cxMoeda
		SE2->E2_TXMOEDA	:= cxTaxa
		SE2->E2_VLCRUZ 	:= Round(nxISS * cxTaxa,2)
		
		SE2->E2_NOMEMOE := UPPER(cDescMoeda)
		SE2->E2_CCD		:= cCCD
		SE2->E2_ITEMD	:= cITEMCTA
		SE2->E2_CTAUSGA	:= "3101"
		SE2->E2_TPCTB	:= "1"
		
		MsUnlock()
	Endif
	
	
	//Atualiza CSLL
	IF nxCSL > 0
		Reclock("SE2",.T.)
		SE2->E2_FILIAL 	:= xFilial("SE2")
		SE2->E2_PREFIXO	:= SF1->F1_SERIE
		SE2->E2_NUM		:= SF1->F1_DOC
		SE2->E2_PARCELA	:= "Z"
		SE2->E2_TIPO	:= "TX"
		SE2->E2_NATUREZ	:= " "
		SE2->E2_FORNECE	:= "UNIAO"
		SE2->E2_LOJA	:= "01"
		SE2->E2_NOMFOR	:= "CSL"
		SE2->E2_EMISSAO	:= SF1->F1_EMISSAO
		SE2->E2_VENCTO	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_VENCREA	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_EMIS1	:= SF1->F1_DTDIGIT
		SE2->E2_VENCORI	:= dVencto //SF1->F1_EMISSAO
		SE2->E2_HIST	:= "IMPOSTOS INVOICE - CSL"
		SE2->E2_VALOR	:= nxCSL //IMPOSTOS
		SE2->E2_SALDO	:= nxCSL //IMPOSTOS
		SE2->E2_VLCRUZ	:= nxCSL //IMPOSTOS
		SE2->E2_MOEDA	:= SF1->F1_MOEDA
		SE2->E2_ORIGEM	:= "MATA100"
		SE2->E2_FILORIG	:= XFILIAL("SE2")
		SE2->E2_TITPAI 	:= cTitPai
		SE2->E2_MOEDA	:= cxMoeda
		SE2->E2_TXMOEDA	:= cxTaxa
		SE2->E2_VLCRUZ 	:= Round(nxCSL * cxTaxa,2)
		
		SE2->E2_NOMEMOE := UPPER(cDescMoeda)
		SE2->E2_CCD		:= cCCD
		SE2->E2_ITEMD	:= cITEMCTA
		SE2->E2_CTAUSGA	:= "3101"
		SE2->E2_TPCTB	:= "1"
		
		MsUnlock()
	Endif
Endif

Return
