#INCLUDE "PROTHEUS.CH"
#INCLUDE "Rwmake.ch"
#INCLUDE "TOPCONN.CH"
/*
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                         FICHA TECNICA DO PROGRAMA                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma         ³ Ponto Entrada - Complementar a Baixa - Invoce
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricso        ³Ponto de Entrada Para Complemento informa��o do Banco    º±±
±±º                 ³ Solicita��o - Marcel/FTI                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor            ³Andre Salgado                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºData de Criacao  ³ 31/07/2015										      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
*/

User Function FA070TIT
**************************

local cArea   := getArea()

If SE1->E1_MOEDA > 1 .AND. CMOTBX="BX INVOICE"  	//Data 08/08/17=>Melhoria para S� gerar RA para Motivo de Baixa "INV" - Sol.Denis/Liana - Autor Andre/Introde
	nOpca		:= 1
	cBancoAdt	:= CriaVar("A6_COD")
	cAgenciaAdt	:= CriaVar("A6_AGENCIA")
	cNumCon		:= CriaVar("A6_NUMCON")
	
	DEFINE MSDIALOG oDlg FROM 15, 5 TO 25, 38 TITLE "Informe Dados - RA"
	@	1.0,2 	Say "Banco (RA) : "   Of oDlg
	@	1.0,7.5	MSGET cBancoAdt F3 "SA6" Valid CarregaSa6(@cBancoAdt) Of oDlg
	@	2.0,2 	Say "Agencia : " Of  oDlg
	@	2.0,7.5	MSGET cAgenciaAdt Valid CarregaSa6(@cBancoAdt,@cAgenciaAdt) Of oDlg
	@	3.0,2 	Say "Conta : "   Of  oDlg
	@	3.0,7.5	MSGET cNumCon Valid CarregaSa6(@cBancoAdt,@cAgenciaAdt,@cNumCon,,,.T.) Of oDlg
	@	 .3,1 TO 4.3,15.5 OF oDlg
	DEFINE SBUTTON FROM 060,097.1   TYPE 1 ACTION (nOpca := 1,If(!Empty(cBancoAdt).and. CarregaSa6(@cBancoAdt,@cAgenciaAdt,@cNumCon,,,.T.),oDlg:End(),nOpca:=0)) ENABLE OF oDlg
	ACTIVATE MSDIALOG oDlg
	
	
	cbco	:= cBancoAdt	//SE1->E1_PORTADO
	cbco	+= cAgenciaAdt	//SE1->E1_AGEDEP
	cbco	+= cNumCon		//SE1->E1_CONTA
	cCtaSA6 := Posicione("SA6",1,XFILIAL("SA6")+cbco,"A6_CONTA")
	
	RECLOCK("SE1",.F.)
	REPLACE E1_BASCOM5	WITH nvalestrang //(E1_BASCOM5 + nvalestrang) //nvalrec)     //SALVA O VALOR RECEBIDO PARA ATENDER A BX PARCIAL
	REPLACE E1_HIST		WITH cCtaSA6
	REPLACE E1_NRDOC	WITH cbco
	MSUNLOCK()
	
Endif

restarea(cArea)

Return(.t.)
