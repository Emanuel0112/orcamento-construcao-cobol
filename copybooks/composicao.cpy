      * COPYBOOK: COMPOSICAO-REC.CPY
      * LAYOUT DO REGISTRO DE COMPOSIÇÕES (RELAÇÃO SERVIÇOS X INSUMOS) 
       01 REG-COMPOSICACAO.
           05 COMP-CHAVE.
           10 COMP-CODIGO              PIC 9(06).
           10 COMP-COD-INSUMO          PIC 9(06).
           05 COMP-DESCRICAO           PIC X(40).
           05 COMP-UNIDADE-SERVICO     PIC X(03).
           05 COMP-COEFICIENTE         PIC 9(03)V9(04).
           05 COMP-STATUS              PIC X(01).
           05 FILLER                   PIC X(15).