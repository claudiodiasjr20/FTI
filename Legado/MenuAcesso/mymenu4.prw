#Include "Protheus.ch"
#Include "TopConn.ch"
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  | MyMenu4.PRW    ³ Autor ³ Flavio Valentin  ³ Data ³ 04/06/14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatório de usuarios cadastrados no sistema.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum.                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil.                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³              |        ³                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MyMenu4()

Local n_Opca       := 0
Local o_Dlg        := Nil //Objeto da tela de interacao com o ZZS_USER
Local c_Desc1      := "Relatório contendo os usuários cadastrados no sistema."
Local c_EOL        := Chr(13) + Chr(10)
Local c_Perg       := "ESPUSZ" 
Local c_StartPat   := CURDIR() // \System\ ou equivalente
Local c_ExtTemp    := ".DBF" //extensao da tabela temporaria
Private a_Struct   := {} //Array que recebe a estrutura da tabela temporaria
Private c_ArqTrab  //Arquivo da Tabela temporaria
Private a_EstTrep  := {} //Colunas do TREPORT
Private c_TitRel   := "Relatório de usuários cadastrados no sistema"
Private c_NomeProg := "MyMenu4"
Private a_TodosUsr := {}

FCRIAPERG(c_Perg) //Chama a funcao para criacao das perguntas para o relatorio
PERGUNTE(c_Perg,.F.)

//Tela para interacao com ZZS_USER
Define MSDialog o_Dlg From 096,009 To 310,585 Title "><((((º> - "+c_TitRel Pixel
	@ 018,006 To 066,287 LABEL "" Of o_Dlg  Pixel
	@ 029,015 Say c_Desc1 Size 268,008 Of o_Dlg Pixel
	Define SButton From 080,190 Type 5 Action Pergunte(c_Perg,.T.) Enable Of o_Dlg
	Define SButton From 080,223 Type 1 Action (o_Dlg:End(),n_Opca:=1) Enable Of o_Dlg
	Define SButton From 080,255 Type 2 Action o_Dlg:End() Enable Of o_Dlg
Activate MSDialog o_Dlg Center

If n_Opca == 1
	FCRIATRAB() //Chama a funcao para criar a tabela temporaria
	PROCESSA( { || FSELARQ() } ) //chama a funcao que executa a query e a alimenta a tabela temporaria
EndIf

//Apara o arquivo temporario
If Select("TABTEMP") > 0
	dbSelectArea("TABTEMP") //Fecha a tabela temporaria
	dbCloseArea()
	FErase(c_StartPat+c_ArqTrab+c_ExtTemp) //Apaga o arquivo .dbf (tabela temporaria) gerado na \Sigaadv\
	FErase(c_StartPat+c_ArqTrab+OrdBagExt()) //Apaga o arquivo .idx (indice da tabela temporaria) gerado na \Sigaadv\
EndIf

Return(Nil)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao  | FSELARQ ³ Autor ³ Flavio Valentin          ³ Data ³ 09/05/14  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Funcao que pesquisa e gera as informacoes para o relatorio. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum.                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil.                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³              |        ³                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FSELARQ()

Local c_Query    := ""
Local c_NomeUsr  := ""
Local c_CargoUsr := ""
Local c_DeptoUsr := ""
Local d_DtIncl   := CTOD("//")
Local l_UsrBloq  := .F.
Local c_Emp      := ""
Local c_Mod      := ""
Local n_QtdReg   := 0
Local c_UserDe   := ""
Local c_UserAte  := ""
Local n_NroAces  := 0

c_UserDe  := MV_PAR01
c_UserAte := MV_PAR02

c_Query := " SELECT DISTINCT ZZS_USER " + Chr(13)
c_Query += " FROM "+RetSqlName("ZZS")+" ZZS ( NOLOCK ) " + Chr(13)
c_Query += " WHERE ZZS_FILIAL = '  ' " + Chr(13)
c_Query += " AND ZZS_USER BETWEEN '"+c_UserDe+"' AND '"+c_UserAte+"' " + Chr(13)
c_Query += " AND ZZS_STATUS IN ('H') " + Chr(13)
c_Query += " AND ZZS.D_E_L_E_T_ = ' ' " + Chr(13)
c_Query += " ORDER BY ZZS_USER " + Chr(13)

If Select("Q_ZZS") > 0
	Q_ZZS->(dbCloseArea())
EndIf

MemoWrite("MyMenu4.SQL",c_Query)

TCQUERY c_Query NEW ALIAS "Q_ZZS"

Count To n_QtdReg	

ProcRegua( n_QtdReg )

Q_ZZS->(dbGotop())
c_NomeUsr  := ""
c_CargoUsr := ""
c_DeptoUsr := ""
d_DtIncl   := CTOD("//")
l_UsrBloq  := .F.
c_Emp      := ""
c_Mod      := ""
n_NroAces  := 0
Do While Q_ZZS->(!Eof())	

	IncProc("Selecionando os registros a serem impressos...")
	
	c_NomeUsr  := U_fGetDepUsr("",AllTrim(Q_ZZS->ZZS_USER),.F.,1,4) //Nome do Usuarios
	c_CargoUsr := U_fGetDepUsr("",AllTrim(Q_ZZS->ZZS_USER),.F.,1,13)//Cargo
	c_DeptoUsr := U_fGetDepUsr("",AllTrim(Q_ZZS->ZZS_USER),.F.,1,12)//Depto
	n_NroAces  := U_fGetDepUsr("",AllTrim(Q_ZZS->ZZS_USER),.F.,1,15)//Acessos simultaneos
	d_DtIncl   := U_fGetDepUsr("",AllTrim(Q_ZZS->ZZS_USER),.F.,1,24)//Dt Inclusao
	l_UsrBloq  := U_fGetDepUsr("",AllTrim(Q_ZZS->ZZS_USER),.F.,1,17)//Status
	c_Emp      := FXRETEMP(Q_ZZS->ZZS_USER)
	c_Mod      := FXRETMOD(Q_ZZS->ZZS_USER)

	If ValType(l_UsrBloq) == "L"
		c_UsrBloq := Iif( !(l_UsrBloq),"Não","Sim" )
	EndIf

	If !Empty(c_NomeUsr)
		RecLock("TABTEMP",.T.)
		TABTEMP->LOGIN   := Q_ZZS->ZZS_USER
		TABTEMP->NOME    := c_NomeUsr
		TABTEMP->CARGO   := c_CargoUsr
		TABTEMP->DEPTO   := c_DeptoUsr
		TABTEMP->DTINCL  := d_DtIncl
		TABTEMP->BLOQ    := c_UsrBloq
		TABTEMP->NACESSO := n_NroAces
		TABTEMP->EMP     := c_Emp
		TABTEMP->MODULOS := c_Mod
		TABTEMP->( MSUnlock() )
	EndIf
	
	Q_ZZS->(dbSkip())

EndDo

//Se tem registro da tabela temporaria, chama funcao para imprimir o relatorio em TReport
If TABTEMP->( RecCount() ) > 0
	o_Report:= ESPRELDF()
	o_Report:PrintDialog()
Else
	MsgStop("Esta pesquisa não trouxe resultados","Vazio")
	Return(Nil)
EndIf

Return(Nil)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    | FCRIATRAB()  ³ Autor ³ Flavio Valentin    ³ Data ³ 09/05/14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Funcao para criar a tabela temporaria.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum.                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil.                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³              |        ³                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FCRIATRAB()

Local a_Area  := GetArea()
Local c_Order := ""
Local a_Cpos  := {}

aAdd(a_Cpos,{"LOGIN"  ,"C",TAMSX3("ZZS_USER"  )[1],TAMSX3("ZZS_USER"  )[2],"USUARIO"       })
aAdd(a_Cpos,{"NOME"   ,"C",60                     ,                     00,"NOME"          })
aAdd(a_Cpos,{"CARGO"  ,"C",30                     ,                     00,"CARGO"         })
aAdd(a_Cpos,{"DEPTO"  ,"C",30                     ,                     00,"DEPTO"         })
aAdd(a_Cpos,{"DTINCL" ,"D",08                     ,                     00,"DATA INCL."    })
aAdd(a_Cpos,{"BLOQ"   ,"C",03                     ,                     00,"BLOQUEADO?"    })//Sim/Nao
aAdd(a_Cpos,{"NACESSO","N",10                     ,                     00,"Nº ACESSOS"    })
aAdd(a_Cpos,{"EMP"    ,"C",100                    ,                     00,"EMPRESA/FILIAL"})
aAdd(a_Cpos,{"MODULOS","C",100                    ,                     00,"MODULOS"       })

// Cria a estrutura (campos) para a tabela temporaria
i:=0
For i := 1 To Len(a_Cpos)
	aAdd(a_Struct,{a_Cpos[i][1],a_Cpos[i][2],a_Cpos[i][3],a_Cpos[i][4]})//Campo,Tipo,Tamanho,Decimal
	aAdd(a_EstTrep,{a_Cpos[i][1],a_Cpos[i][5],a_Cpos[i][3],"@!"})
Next i

If Select("TABTEMP") > 0
	dbSelectArea("TABTEMP") //Fecha a tabela temporaria
	dbCloseArea()
EndIf

//Criacao da tabela temporaria de acordo com a estrutura do array a_Struct
c_Order   := "DTOS(DTINCL)+LOGIN"
c_ArqTrab := CriaTrab(a_Struct,.T.)
dbUseArea(.T.,__LocalDriver,c_ArqTrab,"TABTEMP")
IndRegua("TABTEMP",c_ArqTrab+OrdBagExt(),c_Order)

RestArea(a_Area)

Return(Nil)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  | ESPRELDF ³ Autor ³ Flavio Valentin       ³ Data ³ 09/05/14  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Chama o TReport para Impressao do relatorio.                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum.                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ o_Report => relatorio.                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³              |        ³                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ESPRELDF()

Local o_Report   := Nil
Local o_Section1 := Nil
Local o_Cell     := Nil 

o_Report:= TReport():New(c_NomeProg,c_TitRel,,{ |o_Report| ESPREPRINT(o_Report)},c_TitRel) 
o_Report:SetLandscape()
o_Report:SetTotalInLine(.F.)
o_Report:ShowHeader()

o_Section1:=TRSection():New(o_Report,c_TitRel,{"TABTEMP"})
o_Report:SetTotalInLine(.F.)

For i := 1 To Len(a_EstTrep)
	TRCell():New(o_Section1,a_EstTrep[i][1],"TABTEMP",a_EstTrep[i][2],a_EstTrep[i][4],a_EstTrep[i][3] ,/*lPixel*/,/*{|| code-block de impressao }*/)
Next i

Return(o_Report)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  | ESPREPRINT ³ Autor ³ Flavio Valentin     ³ Data ³ 09/05/14  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Carrega as variaveis para impressao do relatorio.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum.                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum.                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³              |        ³                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ESPREPRINT(o_Report)

Local o_Section1 := o_Report:Section(1)

o_Section1:Init()
o_Section1:SetHeaderSection(.T.)

dbSelectArea("TABTEMP")
TABTEMP->( dbGotop() )

o_Report:SetMeter(TABTEMP->(RecCount()))

While TABTEMP->( !Eof() )

	If o_Report:Cancel()
		Exit
	EndIf

	o_Report:IncMeter()
	
	For i := 1 to Len(a_EstTrep)
		o_Section1:Cell(a_EstTrep[i][1]):SetValue(&("TABTEMP->" + a_EstTrep[i][1]))
		o_Section1:Cell(a_EstTrep[i][1]):SetAlign("LEFT")
	Next i
	
	o_Section1:PrintLine()
	
	TABTEMP->( dbSkip() )
	
EndDo

o_Section1:Finish()

Return


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    | FXRETMOD()   ³ Autor ³ Flavio Valentin    ³ Data ³ 04/06/14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Funcao que retorna os modulos que Usuario tem acesso.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_Login => Login do Usuario.                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil.                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³              |        ³                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FXRETMOD(c_Login)

Local a_Area   := GetArea()
Local c_Query  := ""
Local c_Retorn := ""
Local n_QtdReg := 0
Local n_Cont   := 0

c_Query := " SELECT DISTINCT ZZS_MODULO "
c_Query += " FROM "+RetSqlName("ZZS")+" ZZS ( NOLOCK ) "
c_Query += " WHERE ZZS_FILIAL = '"+xFilial("ZZS")+"' "
c_Query += " AND UPPER(ZZS_USER) = '"+UPPER(c_Login)+"' "
c_Query += " AND ZZS_STATUS = 'H' "
c_Query += " AND ZZS.D_E_L_E_T_ = ' ' "

If Select("Q_ZZS2") > 0
	Q_ZZS2->(dbCloseArea())
EndIf

MemoWrite("Q_ZZS2.SQL",c_Query)

TCQUERY c_Query NEW ALIAS "Q_ZZS2"

Count To n_QtdReg

ProcRegua( n_QtdReg )

Q_ZZS2->(dbGotop())
c_Retorn := ""
n_Cont   := 0
Do While Q_ZZS2->(!Eof())
	
	IncProc("Módulos do Usuário: "+c_Login)
	
	n_Cont := n_Cont + 1
	
	c_Retorn += RTRIM(Q_ZZS2->ZZS_MODULO)+Iif(n_Cont < n_QtdReg,";","")

	Q_ZZS2->(dbSkip())

EndDo

RestArea(a_Area)

Return(c_Retorn)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    | FXRETEMP()   ³ Autor ³ Flavio Valentin    ³ Data ³ 04/06/14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Funcao que retorna as empresas que Usuario tem acesso.      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_Login => Login do Usuario.                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil.                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³              |        ³                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FXRETEMP(c_Login)

Local a_Area   := GetArea()
Local a_Emp    := ""
Local c_Retorn := ""

a_Emp := U_fGetDepUsr("",c_Login,.F.,2,6) 

If VALTYPE(a_Emp) == "A"
	ProcRegua(Len(a_Emp))
	For i := 1 To Len(a_Emp)
		IncProc("Empresas do Usuário: "+c_Login)
		If a_Emp[i] == "@@@@"
			c_Retorn := "Todas"
		Else	
			c_Retorn += Left(a_Emp[i],2)+"/"+Right(a_Emp[i],2)+Iif(i < Len(a_Emp),";","")
		EndIf
	Next i
EndIf

RestArea(a_Area)

Return(c_Retorn)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    | FCRIAPERG()  ³ Autor ³ Flavio Valentin    ³ Data ³ 04/06/14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Funcao para criar as perguntas.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ c_Perg => Grupo de Perguntas.                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil.                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Manutencao Efetuada                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³              |        ³                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FCRIAPERG(c_Perg)

PutSx1(c_Perg,"01","Usuário de ?" ,"","","MV_CH1","C",15,0,0,"G","","US3","","","MV_PAR01","","","","" ,"","","","","","","","","","","","","","","")
PutSx1(c_Perg,"02","Usuário Ate ?","","","MV_CH2","C",15,0,0,"G","","US3","","","MV_PAR02","","","","" ,"","","","","","","","","","","","","","","")

Return(Nil)