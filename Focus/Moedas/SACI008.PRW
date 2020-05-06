//FA070CA4 - O ponto de entrada FA070CA4 sera executado apos confirmacao do cancelamento da baixa do contas a receber. 
//http://tdn.totvs.com.br/display/softwaregestao/FA070CA4+-+Permite+cancelar+baixa 

#INCLUDE "PROTHEUS.CH"
#INCLUDE "Rwmake.ch"
#INCLUDE "TOPCONN.CH"
/*
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                         FICHA TECNICA DO PROGRAMA                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma         ³ Ponto Entrada - Complementar a Baixa - Invoce
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricso        ³Ponto de Entrada Cria o RA conforme a baixa da Invoice   º±±
±±º                 ³, ou seja, titulo controlado em outra MOEDA              º±±
±±º                 ³, SOLICITA��O - MARCEL                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor            ³Andre Salgado                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºData de Criacao  ³ 31/07/2015										      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
*/

User Function SACI008
**************************

local cArea   := getArea()

//Regra, s� gera para Titulos controlados em Outra Moeda
If SE1->E1_MOEDA > 1 .and. SE5->E5_MOTBX="USG"	//baixa invoice
	
	nOpca		:= 1
	cBancoAdt	:= SUBSTR(SE1->E1_NRDOC,1,03)
	cAgenciaAdt	:= SUBSTR(SE1->E1_NRDOC,4,05)
	cNumCon		:= SUBSTR(SE1->E1_NRDOC,9,10)
	
	//Variaveis
	cPref	:= SE1->E1_PREFIXO
	cNum	:= SE1->E1_NUM
	cNat	:= SE1->E1_NATUREZ
	cbco	:= cBancoAdt	//SE1->E1_PORTADO
	cAgenc 	:= cAgenciaAdt	//SE1->E1_AGEDEP
	cConta  := cNumCon		//SE1->E1_CONTA
	cClien	:= SE1->E1_CLIENTE
	cLoja	:= SE1->E1_LOJA
	cNomCli	:= SE1->E1_NOMCLI
	nVlr	:= nvalrec
	cPedOrig:= SE1->E1_PEDIDO
	nVlrOrig:= SE1->E1_BASCOM5 //SE1->E1_VALOR
	
	nParcRA := Substr(SE1->E1_VEND4, 1, 1)		//Campo utilizado para controlar as parcelas do RA, que precisa ser criado em sequencial de Bx Parcial
	
	//Update - Atualiza o RA, parcela "Z" na ultima parcela - Regra Solicitada pelo Marcel/Financeiro - FTI 16/03/16
	IF nParcRA = "Z"
		
		dbSelectArea("SE1")
		dbSetOrder(1)
		dbSeek(xFilial("SE1")+cPref+cNum+"Z"+"RA")
		
		If Found()
			Reclock("SE1",.F.)
			SE1->E1_VENCREA := dDataBase
			SE1->E1_VALOR 	:= SE1->E1_VALOR + nVlr
			SE1->E1_SALDO	:= SE1->E1_SALDO + nVlr
			SE1->E1_VLCRUZ	:= SE1->E1_VLCRUZ+ nVlr
			SE1->E1_STATUS	:= "A"
			MsUnlock()
			
			//Atualiza os dados na Tabela - SE5
			Reclock("SE5",.T.)
			SE5->E5_FILIAL	:= xFilial("SE5")
			SE5->E5_DATA 	:= dDatabase
			SE5->E5_TIPO 	:= "RA"
			SE5->E5_MOEDA	:= "01"
			SE5->E5_VALOR	:= nVlr
			SE5->E5_NATUREZ	:= cNat
			SE5->E5_BANCO	:= cbco
			SE5->E5_AGENCIA	:= cAgenc
			SE5->E5_CONTA	:= cConta
			SE5->E5_RECPAG	:= "R"
			SE5->E5_BENEF	:= cNomCli
			SE5->E5_HISTOR	:= "BX INVOICE"
			SE5->E5_TIPODOC	:= "RA"
			SE5->E5_VLMOED2	:= nVlr
			SE5->E5_LA		:= "S"
			SE5->E5_PREFIXO	:= cPref
			SE5->E5_NUMERO	:= cNum
			SE5->E5_PARCELA	:= "Z"
			SE5->E5_CLIFOR	:= cClien
			SE5->E5_LOJA	:= cLoja
			SE5->E5_DTDIGIT	:= dDatabase
			SE5->E5_MOTBX	:= "NOR"
			SE5->E5_DTDISPO	:= dDatabase
			SE5->E5_FILORIG	:= SM0->M0_CODFIL
			SE5->E5_CLIENTE := cClien
			MsUnlock()
			
			AVISO("ATENCAO","O Valor do RA sera somado na ultima parcela 'Z'  -   Nr. "+cPref+" "+cNum+" Z",{"OK"})
		Endif
		

	Else
		//INSERT - Inclui SE1 - Grava ultima Parcela do RA criada - Solicita��o Marcel

		//Atualizar o Contador de Sequencia Parcela
		nParcE1 := Soma1(nParcRA)
		RECLOCK("SE1",.F.)
		REPLACE E1_VEND4	WITH nParcE1
		MSUNLOCK()
		
		
		//Atualiza os dados na Tabela - SE1
		Reclock("SE1",.T.)
		SE1->E1_FILIAL	:= xFilial("SE1")
		SE1->E1_PREFIXO	:= cPref
		SE1->E1_NUM		:= cNum
		SE1->E1_PARCELA	:= nParcE1
		SE1->E1_TIPO	:= "RA"
		SE1->E1_NATUREZ := cNat
		SE1->E1_PORTADO := cbco
		SE1->E1_AGEDEP  := cAgenc
		SE1->E1_CONTA	:= cConta
		SE1->E1_CLIENTE := cClien
		SE1->E1_LOJA 	:= cLoja
		SE1->E1_NOMCLI	:= cNomCli
		SE1->E1_EMISSAO := dDataBase
		SE1->E1_VENCTO  := dDataBase
		SE1->E1_VENCREA := dDataBase
		SE1->E1_VALOR 	:= nVlr
		SE1->E1_EMIS1	:= dDataBase
		SE1->E1_HIST	:= "GERADO BX INVOICE"
		SE1->E1_LA		:= "S"
		SE1->E1_SALDO	:= nVlr
		SE1->E1_VLCRUZ	:= nVlr
		SE1->E1_VENCORI := dDatabase
		SE1->E1_MOEDA 	:= 1
		SE1->E1_STATUS  := "A"
		SE1->E1_ORIGEM	:= "FINA040"
		SE1->E1_FLUXO 	:= "S"
		SE1->E1_FILORIG := SM0->M0_CODFIL
		SE1->E1_MSFIL 	:= SM0->M0_CODFIL
		SE1->E1_MSEMP	:= SM0->M0_CODIGO
		SE1->E1_PEDIDO	:= cPedOrig
		SE1->E1_BASCOM5	:= nVlrOrig		//Deixa Salvo o valor Original da Invoice
		MsUnlock()
		
		
		//Atualiza os dados na Tabela - SE5
		Reclock("SE5",.T.)
		SE5->E5_FILIAL	:= xFilial("SE5")
		SE5->E5_DATA 	:= dDatabase
		SE5->E5_TIPO 	:= "RA"
		SE5->E5_MOEDA	:= "01"
		SE5->E5_VALOR	:= nVlr
		SE5->E5_NATUREZ	:= cNat
		SE5->E5_BANCO	:= cbco
		SE5->E5_AGENCIA	:= cAgenc
		SE5->E5_CONTA	:= cConta
		SE5->E5_RECPAG	:= "R"
		SE5->E5_BENEF	:= cNomCli
		SE5->E5_HISTOR	:= "BX INVOICE"
		SE5->E5_TIPODOC	:= "RA"
		SE5->E5_VLMOED2	:= nVlr
		SE5->E5_LA		:= "S"
		SE5->E5_PREFIXO	:= cPref
		SE5->E5_NUMERO	:= cNum
		SE5->E5_PARCELA	:= nParcE1
		SE5->E5_CLIFOR	:= cClien
		SE5->E5_LOJA	:= cLoja
		SE5->E5_DTDIGIT	:= dDatabase
		SE5->E5_MOTBX	:= "NOR"
		SE5->E5_DTDISPO	:= dDatabase
		SE5->E5_FILORIG	:= SM0->M0_CODFIL
		SE5->E5_CLIENTE := cClien
		MsUnlock()
		
		AVISO("ATENCAO","Foi criado o titulo RA para esta Invoice Nr. "+cPref+" "+cNum+" "+nParcE1 ,{"OK"})
	Endif
Endif
restarea(cArea)

Return
