#include "topconn.ch"
User Function SIGAATF()
	fGrvLog()
Return Nil
User Function SIGACFG()
	fGrvLog()
Return Nil
User Function SIGACOM()
	fGrvLog()
Return Nil
User Function SIGACTB()
	fGrvLog()
Return Nil
User Function SIGAEST()
	fGrvLog()
Return Nil
User Function SIGAFAT()
	fGrvLog()
Return Nil
User Function SIGAFIN()
	fGrvLog()
Return Nil
User Function SIGAFIS()
	fGrvLog()
Return Nil
User Function SIGAPCP()
	fGrvLog()
Return Nil
User Function SIGAQIE()
	fGrvLog()
Return Nil
User Function SIGARPM()
	fGrvLog()
Return Nil
User Function SIGAMNT()
	fGrvLog()
Return Nil
User Function SIGAQDO()
	fGrvLog()
Return Nil
User Function SIGAQIP()
	fGrvLog()
Return Nil
User Function SIGAEIF()
	fGrvLog()
Return Nil
User Function SIGAEEC()
	fGrvLog()
Return Nil
User Function SIGAAFV()
	fGrvLog()
Return Nil
User Function SIGAOMS()
	fGrvLog()
Return Nil
User Function SIGAWMS()
	fGrvLog()
Return Nil
User Function SIGAPMS()
	fGrvLog()
Return Nil
User Function SIGATMS()
	fGrvLog()
Return Nil
User Function SIGATMK()
	fGrvLog()
Return Nil
User Function SIGAACD()
	fGrvLog()
Return Nil
User Function SIGAVDOC()
	fGrvLog()
Return Nil
User Function SIGAAPD()
	fGrvLog()
Return Nil
User Function SIGACRD()
	fGrvLog()
Return Nil
User Function SIGAPCO()
	fGrvLog()
Return Nil
User Function SIGAGPR()
	fGrvLog()
Return Nil
User Function SIGAARM()
	fGrvLog()
Return Nil
User Function SIGAGCT()
	fGrvLog()
Return Nil
User Function SIGACRM()
	fGrvLog()
Return Nil
User Function SIGABPM()
	fGrvLog()
Return Nil
User Function SIGAFAS()
	fGrvLog()
Return Nil
User Function SIGAGPE()
	fGrvLog()
Return Nil
User Function SIGAGFE()
	fGrvLog()
Return Nil
User Function SIGAOFI()
	fGrvLog()
Return Nil
User Function SIGATEC()
	fGrvLog()
Return Nil


Static Function fGrvLog()
                         
	Local cArqMnu := "" //PROVISORIO
	
	c_QryIns := "INSERT INTO SIGALOG (FILIAL "
	c_QryIns += ",EMPRESA "
	c_QryIns += ",NUMMOD "
	c_QryIns += ",MODULO "
	c_QryIns += ",MENU "
	c_QryIns += ",CODUSR "
	c_QryIns += ",NOMUSR "
	c_QryIns += ",DATA "
	c_QryIns += ",HORA "
	c_QryIns += ",FUNCAO "
	c_QryIns += ",NOMFUN "
	c_QryIns += ",AMBIENTE "
	c_QryIns += ",DTBASE "
	c_QryIns += ",USRREDE "
	c_QryIns += ",CPUNAME) "
	c_QryIns += "VALUES ('"+SM0->M0_CODFIL+"'"
	c_QryIns += ", '"+SM0->M0_CODIGO+"'"
	c_QryIns += ", "+Str(nModulo, 0)+" "
	c_QryIns += ", '"+cModulo+"'"
	c_QryIns += ", '"+cArqMnu+"'"
	c_QryIns += ", '"+__CUSERID+"'"
	c_QryIns += ", '"+cUserName+"'"
	c_QryIns += ", '"+DTOS(MsDate())+"'"
	c_QryIns += ", '"+Time()+"'"
	c_QryIns += ", '"+Left(FunName(), 10)+"'"
	c_QryIns += ", '"+FunDesc()+"'"
	c_QryIns += ", '"+GetEnvServer()+"'"
	c_QryIns += ", '"+DTOS(dDataBase)+"'"
	c_QryIns += ", '"+LogUserName()+"'"
	c_QryIns += ", '"+ComputerName()+"')"
	
	TcSqlExec(c_QryIns)

	//If ( SM0->M0_CODIGO == "05" .And. dDataBase > CTOD("29/04/10") )
		//Final("Não é permitido utilizar data superior à 29/04/10 na GDCE")
	//Endif

Return Nil