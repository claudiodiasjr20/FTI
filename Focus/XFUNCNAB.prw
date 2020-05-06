#Include "Protheus.ch"
#Include "RwMake.ch"
#Include "TopConn.ch"                       

/*=======================================================
Autor: Cintia Araujo
Data:	01.2015
---------------------------------------------------------
Descricao: Funcao generica - CNAB - Codigo de Conta
=========================================================*/

User Function fCta(cBco, cCtaBco, cDVCta, nTipo, cAgenc)

	Local   cCtaRet  := ""
	Local   nTamCta  := IIf(cBco == "399", 6, 5 )
	Default cCtaBco  := ""
	Default cDVCta   := " "                      
	Default nTipo    := 0                                       
	Default cAgenc   := ""
	
	cCtaBco := AllTrim(StrTran(cCtaBco,"-",""))                                         
	                                                                       
	If Empty(cDVCta) .And. Len(cCtaBco) > nTamCta                            
		cDVCta  := Right(cCtaBco,1)
		cCtaBco := Left(cCtaBco, Len(cCtaBco) -1)
	EndIf                                           
	
	cCtaBco := PadL(Left(cCtaBco, nTamCta), nTamCta, "0") + cDVCta
	
	cCtaRet := Iif( nTipo == 1, IIf(cBco == "399", PadL((AllTrim(cAgenc)+ Left(cCtaBco, nTamCta)), 12, "0"), PadL(Left(cCtaBco, nTamCta), 12, "0") ), Right(cCtaBco,1) )
 	
Return(cCtaRet)   

/*=======================================================
Autor: Cintia Araujo
Data:	01.2015
---------------------------------------------------------                     
Descricao: Funcao generica - CNAB - Codigo de Agencia
=========================================================*/  
User Function fAge(cBco, cAgencia, cDvAge, nTipo)                            
	
	Local   cAgeRet  := ""
	Local   nTamAge  := IIf(cBco == "399", 5, 4 )
	Default cAgencia := " "
	Default cDvAge   := " "                       
	Default nTipo    := 0
	                                        
	cAgencia := AllTrim(StrTran(cAgencia,"-",""))                          
	
	If Empty(cDvAge)
		If Len(cAgencia) > nTamAge
			cAgencia := Right(cAgencia,1)
			cAgencia := Left(cAgencia, Len(cAgencia) -1)
		EndIf                              
	EndIf
	                                                                                        
	cAgencia := PadL(Left(cAgencia, nTamAge), nTamAge, "0") + cDvAge
	
	cAgeRet := Iif( nTipo == 1, PadL(Left(cAgencia, nTamAge),5,"0"), Right(cAgencia,1) )
	
Return(cAgeRet)
