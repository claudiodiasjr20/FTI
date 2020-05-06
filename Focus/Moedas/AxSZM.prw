// Cadastro de Moedas
// Autor - Andre Luis / Introde - 18/09/2015
//#include "rwmake.ch"  
#INCLUDE "PROTHEUS.CH"
User Function AxSZM()

/*/
+----------------------------------------------------------------+
| Define Array contendo as Rotinas a executar do programa +
| ----------- Elementos contidos por dimensao ------------ +
| 1. Nome a aparecer no cabecalho +
| 2. Nome da Rotina associada +
| 3. Usado pela rotina +
| 4. Tipo de Transacao a ser efetuada +
| 1 - Pesquisa e Posiciona em um Banco de Dados +
| 2 - Simplesmente Mostra os Campos +
| 3 - Inclui registros no Bancos de Dados +
| 4 - Altera o registro corrente +
| 5 - Remove o registro corrente do Banco de Dados +
+----------------------------------------------------------------+
/*/
PRIVATE aRotina := { { "Pesquisar" ,"AxPesqui", 0 , 1},; //"Pesquisar"
{ "Visualizar" ,"AxVisual", 0 , 2},; //"Visualizar"
{ "Incluir" ,"AxInclui", 0 , 3},; //"Incluir"
{ "Alterar" ,"AxAltera", 0 , 4},; //"Alterar"
{ "Excluir" ,"AxDeleta", 0 , 5, 3} } //"Excluir"


//{ "Excluir" ,"FA010Del", 0 , 5, 3} } //"Excluir"
//+----------------------------------------------------------------+
//| Define o cabecalho da tela de atualizacoes |
//+----------------------------------------------------------------+
PRIVATE cCadastro := "Cadastro de Moedas" //"Atualizacao de Naturezas"
//+----------------------------------------------------------------+
//| Endereca funcao Mbrowse |
//+----------------------------------------------------------------+
mBrowse( 6, 1,22,75,"SZM")
Return
