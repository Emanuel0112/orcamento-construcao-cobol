      *    COPYBOOK: INSUMO-REC.CPY
      *    LAYOUT DO REGISTRO DE INSUMOS (MATERIAIS E MÃO DE OBRA)
     
       01 REG-INSUMO.
           05 INS-CODIGO            PIC 9(06).
           05 INS-DESCRICAO         PIC X(40).
           05 INS-UNIDADE-MEDIDA    PIC X(03).
           05 INS-VALOR-UNITARIO    PIC 9(05)V99.
           05 INS-TIPO              PIC X(01).
           05 INS-STATUS            PIC X(01).
           05 FILLER                PIC X(20).