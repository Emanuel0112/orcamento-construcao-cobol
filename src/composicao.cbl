       IDENTIFICATION DIVISION.
       PROGRAM-ID. COMPOSICAO.
       AUTHOR. EMANUEL PASSOS.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQ-COMPOSICAO ASSIGN TO "../data/composicao.dat"
                  ORGANIZATION IS INDEXED
                  ACCESS MODE  IS DYNAMIC
                  RECORD KEY   IS COMP-CHAVE
                  FILE STATUS  IS WS-FS-COMP.

           SELECT ARQ-INSUMOS-COMP ASSIGN TO "../data/insumos.dat"
                  ORGANIZATION IS INDEXED
                  ACCESS MODE  IS DYNAMIC
                  RECORD KEY   IS INS-CODIGO
                  FILE STATUS  IS WS-FS-INS.

       DATA DIVISION.
       FILE SECTION.
       FD  ARQ-COMPOSICAO.
           COPY "composicao-rec.cpy".

       FD  ARQ-INSUMOS-COMP.
           COPY "insumo-rec.cpy".

       WORKING-STORAGE SECTION.
       01  WS-STATUS-CONTROLE.
           05 WS-FS-COMP           PIC X(02).
           05 WS-FS-INS            PIC X(02).
           05 WS-MENU-OPCAO        PIC X(01) VALUE SPACES.

       PROCEDURE DIVISION.
       0000-PRINCIPAL SECTION.
           PERFORM 1000-ABRIR-ARQUIVOS
           
           PERFORM UNTIL WS-MENU-OPCAO = "0"
               DISPLAY "--------------------------------------------------"
               DISPLAY "        SUBMENU - COMPOSICOES DE PRECOS (CPU)     "
               DISPLAY "--------------------------------------------------"
               DISPLAY " 1 - ASSOCIAR INSUMO A UM SERVICO"
               DISPLAY " 0 - RETORNAR AO MENU PRINCIPAL"
               DISPLAY "--------------------------------------------------"
               DISPLAY "DIGITE A OPCAO: " WITH NO ADVANCING
               ACCEPT WS-MENU-OPCAO
               
               IF WS-MENU-OPCAO = "1"
                   PERFORM 2000-ESTRUTURAR-SERVICO
               END-IF
           END-PERFORM
           
           PERFORM 9000-FECHAR-ARQUIVOS
           GOBACK.

       1000-ABRIR-ARQUIVOS.
           OPEN I-O ARQ-COMPOSICAO
           IF WS-FS-COMP = "35"
               OPEN OUTPUT ARQ-COMPOSICAO
               CLOSE ARQ-COMPOSICAO
               OPEN I-O ARQ-COMPOSICAO
           END-IF.
           
           OPEN INPUT ARQ-INSUMOS-COMP.

       2000-ESTRUTURAR-SERVICO.
           DISPLAY " "
           DISPLAY "--- VINCULAR INSUMO AO SERVICO ---"
           DISPLAY "DIGITE O CODIGO DA COMPOSICAO (SERVICO): "
                   WITH NO ADVANCING
           ACCEPT COMP-CODIGO
           
           DISPLAY "DESCRICAO DO SERVICO (EX: ALVENARIA DE TIJOLO): "
                   WITH NO ADVANCING
           ACCEPT COMP-DESCRICAO
           
           DISPLAY "UNIDADE DO SERVICO (EX: M2, M3, VB): "
                   WITH NO ADVANCING
           ACCEPT COMP-UNIDADE-SERVICO

           DISPLAY "DIGITE O CODIGO DO INSUMO A INCLUIR: "
                   WITH NO ADVANCING
           ACCEPT COMP-COD-INSUMO

      * PROCURA NO OUTRO ARQUIVO SE O INSUMO REALMENTE EXISTE
           MOVE COMP-COD-INSUMO TO INS-CODIGO
           READ ARQ-INSUMOS-COMP INVALID KEY
               DISPLAY ">>> ERRO: INSUMO NAO EXISTE NO CADASTRO DE BASE! <<<"
           NOT INVALID KEY
               DISPLAY "INSUMO VALIDADO: " INS-DESCRICAO
               DISPLAY "DIGITE O COEFICIENTE/QTD NECESSARIA: "
                       WITH NO ADVANCING
               ACCEPT COMP-COEFICIENTE
               
               MOVE "A" TO COMP-STATUS
               WRITE REG-COMPOSICACAO
               
               IF WS-FS-COMP = "00"
                   DISPLAY ">>> ITEM VINCULADO COM SUCESSO! <<<"
               ELSE
                   DISPLAY "ERRO AO SALVAR. FILE STATUS: " WS-FS-COMP
               END-IF
           END-READ
           DISPLAY " ".

       9000-FECHAR-ARQUIVOS.
           CLOSE ARQ-COMPOSICAO
           CLOSE ARQ-INSUMOS-COMP.