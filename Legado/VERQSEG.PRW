#include "RWMake.Ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � VERQSEG  � Autor � Amauri Bailon       � Data � 29-06-2011 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Retorna .T. OU .F.    DEPENDENDO DO TIPO DE PAGAMENTO E EM ���
���          � QUAL SEGMENTO ELE SE ENCAIXARA                             ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � P10                                                        ���
�������������������������������������������������������������������������Ĵ��
��� DATA     � Analista Descricao da alteracao                            ���
�������������������������������������������������������������������������Ĵ��
���          �                                                            ���
���          �                                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

USER FUNCTION VERQSEG(_RecSeg)

_QualSegm := _RecSeg                                                       

_retor    := .F.    

dbselectarea("SEA")
dbsetorder(1)
dbseek(xfilial("SEA")+SE2->E2_NUMBOR+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA)
        

IF _QualSegm == "J"
   IF  SEA->EA_MODELO  == "30" .OR.  SEA->EA_MODELO  == "31"  
       _retor    := .T.
   ENDIF
ENDIF


IF _QualSegm == "N"     
   IF SEA->EA_MODELO $ "17/16/22/23/32/18/19/24/25/26/11"
       _retor    := .T.
   ENDIF
ENDIF

IF _QualSegm == "O"
   IF  SEA->EA_MODELO  == "13" .or. SEA->EA_MODELO  == "25" .or. SEA->EA_MODELO  == "27"
       _retor    := .T.
   ENDIF
ENDIF

return(_retor) 