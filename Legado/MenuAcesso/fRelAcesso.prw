#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO2     � Autor � AP6 IDE            � Data �  10/05/19   ���
�������������������������������������������������������������������������͹��
���Descricao � Codigo gerado pelo AP6 IDE.                                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function fRelAcesso()

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := ""
Local cPict          := ""
Local titulo       := "Acessos ao ERP Protheus"
Local nLin         := 100

Local Cabec1       := ""
Local Cabec2       := ""
Local imprime      := .T.
Local aOrd          := {}

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 132
Private tamanho          := "M"
Private nomeprog         := "fRelAcessos" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "fRelAcessos" // Coloque aqui o nome do arquivo usado para impressao em disco
Private c_Perg      := "FRELACES01"
Private cString := "SA1"

//ValidPerg(c_Perg) //Chama a funcao para criacao das perguntas para o relatorio
//PERGUNTE(c_Perg, .F.)

//���������������������������������������������������������������������Ŀ
//� Monta a interface padrao com o usuario...                           �
//�����������������������������������������������������������������������

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//���������������������������������������������������������������������Ŀ
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//�����������������������������������������������������������������������

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  10/05/19   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local c_Query   := fGetQuery()
Local a_Cols    := {}

//Monta pagina de Legenda
Cabec1 := "L E G E N D A   D O S   A C E S S O S"
nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
nLin++

@nLin,001 PSAY "X � Pesquisa"
nLin++
@nLin,001 PSAY "XX � Pesquisa e Visualizacao"
nLin++
@nLin,001 PSAY "XXX � Consulta , Pesquisa e Visualizacao e Inclusao"
nLin++
@nLin,001 PSAY "XXXX � Consulta , Pesquisa e Visualizacao, Inclusao e alteracao"
nLin++
@nLin,001 PSAY "XXXXX �ou mais - �Consulta , Pesquisa e Visualizacao, Legenda, Inclusao, alteracao e exclusao"
nLin++

nLin := 80

Cabec1 := "USUARIO                   MODULO     FUNCAO     TITULO                         CHAVE           ACESSO     STATUS"
//         XXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXX XXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XXXXXXXXXX XXXXXXXXXX
//                 10        20        30        40        50        60        70        80        90        100       110       120       130       140       150        160       170       180       190       200
//         123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
a_Cols    := {1, 27, 38, 49, 80, 96, 107}

//���������������������������������������������������������������������Ŀ
//� SETREGUA -> Indica quantos registros serao processados para a regua �
//�����������������������������������������������������������������������
SetRegua(0)

If ( Select("QRY") > 0 )
    QRY->(DbCloseArea())
Endif

TcQuery c_Query New Alias "QRY"

DbSelectArea("QRY")
DbGoTop()

While ( QRY->(!EOF()) ) 

   //���������������������������������������������������������������������Ŀ
   //� Verifica o cancelamento pelo usuario...                             �
   //�����������������������������������������������������������������������
   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //���������������������������������������������������������������������Ŀ
   //� Impressao do cabecalho do relatorio. . .                            �
   //�����������������������������������������������������������������������
   If nLin > 55 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
      nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin++
   Endif

   // Coloque aqui a logica da impressao do seu programa...
   // Utilize PSAY para saida na impressora. Por exemplo:
   @nLin, a_Cols[01] PSAY QRY->ZZS_USER
   @nLin, a_Cols[02] PSAY QRY->ZZS_MODULO
   @nLin, a_Cols[03] PSAY QRY->ZZS_FUNCAO
   @nLin, a_Cols[04] PSAY QRY->ZZS_TITULO
   @nLin, a_Cols[05] PSAY QRY->ZZS_CHAVE
   @nLin, a_Cols[06] PSAY QRY->ZZS_ACESSO
   @nLin, a_Cols[07] PSAY "Ativo" //QRY->ZZS_STATUS
   nLin++

   QRY->(DbSkip()) 

EndDo

//���������������������������������������������������������������������Ŀ
//� Finaliza a execucao do relatorio...                                 �
//�����������������������������������������������������������������������

SET DEVICE TO SCREEN

//���������������������������������������������������������������������Ŀ
//� Se impressao em disco, chama o gerenciador de impressao...          �
//�����������������������������������������������������������������������

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

QRY->(DbCloseArea())

Return Nil

/**************************************************************************/

Static Function fGetQuery()

Local c_Query   := ""
Local c_EOL     := Chr(13) + Chr(10)

//Local c_ExcUsers    := GetMV("MV_XACE001") //Parametro com os usuarios exclu�dos
//Local c_IncModul    := GetMV("MV_XACE002") //Parametro com os M�dulos a utilizar

c_ExcUsers := "'douglas.franca', 'sidnei.naconesky', 'cinthia.russo'"
c_IncModul := "'SIGACOM','SIGAFAT','SIGAFIN','SIGACTB'"

c_Query := "SELECT ZZS_USER " + c_EOL
c_Query += " ,ZZS_MODULO " + c_EOL
c_Query += " ,ZZS_FUNCAO " + c_EOL
c_Query += " ,ZZS_TITULO " + c_EOL
c_Query += " ,ZZS_CHAVE " + c_EOL
c_Query += " ,ZZS_ACESSO " + c_EOL
c_Query += " ,ZZS_STATUS " + c_EOL
c_Query += "FROM ZZS050 AS ZZS (NOLOCK) " + c_EOL
c_Query += " WHERE ZZS.D_E_L_E_T_ = ' ' " + c_EOL
c_Query += " AND ZZS_STATUS = 'H' " + c_EOL
c_Query += " AND ZZS_USER NOT IN ("+c_ExcUsers+") " + c_EOL
//c_Query += " AND ZZS_MODULO IN ("+c_IncModul+") " + c_EOL
c_Query += "GROUP BY ZZS_USER, ZZS_MODULO, ZZS_FUNCAO, ZZS_TITULO, ZZS_CHAVE, ZZS_ACESSO, ZZS_STATUS " + c_EOL
c_Query += "ORDER BY ZZS_USER, ZZS_MODULO, ZZS_CHAVE " + c_EOL

Return c_Query

/*����������������������������������������������������������������������������������������������                                                                                                                                                            ��������������������
������������������������������������������������������������������������������������������������
��������������������������������������������������������������������������������������������Ŀ��
���Programa  � ValidPerg   |   Autor � Tiago Dias (Focus Consultoria)   |  	 Data � 21/08/14 ���
��������������������������������������������������������������������������������������������Ĵ��
���Descricao � Respons�vel em criar o SX1 com o Help.                                        ���
��������������������������������������������������������������������������������������������Ĵ��
���Parametros� c_Perg -> Grupo de perguntas a ser criado.                              		 ���
��������������������������������������������������������������������������������������������Ĵ��
���Retorno   � Parametros -> Nil                                                             ���
���������������������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������������������
����������������������������������������������������������������������������������������������*/

Static Function ValidPerg(c_Perg)

Local a_AreaATU := GetArea()
Local a_Regs    := {}

aAdd(a_Regs, {c_Perg,"01"  ,"Status  ?",""      ,""     ,"MV_CH1","C"    ,1      ,0       ,0     ,"C" ,""    ,"MV_PAR01",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })

RestArea(a_AreaATU)

Return Nil
