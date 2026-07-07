       IDENTIFICATION DIVISION.
       PROGRAM-ID. ORCAMENTO.
       AUTHOR. EMANUEL PASSOS.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQ-ORCAMENTO ASSIGN TO "../data/orcamento.dat"
                  ORGANIZATION IS INDEXED
                  ACCESS MODE  IS DYNAMIC
                  RECORD KEY   IS ORC-CODIGO
                  FILE STATUS  IS WS-FS-ORC.

           SELECT ARQ-COMPOSICAO-ORC ASSIGN TO "../data/composicao.dat"
                  ORGANIZATION IS INDEXED
                  ACCESS MODE  IS DYNAMIC
                  RECORD KEY   IS COMP-CHAVE
                  FILE STATUS  IS WS-FS-COMP.

           SELECT ARQ-INSUMOS-ORC ASSIGN TO "../data/insumos.dat"
                  ORGANIZATION IS INDEXED
                  ACCESS MODE  IS DYNAMIC
                  RECORD KEY   IS INS-CODIGO
                  FILE STATUS  IS WS-FS-INS.

       DATA DIVISION.
       FILE SECTION.
       FD  ARQ-ORCAMENTO.
           COPY "orcamento-rec.cpy".

       FD  ARQ-COMPOSICAO-ORC.
           COPY "composicao-rec.cpy".

       FD  ARQ-INSUMOS-ORC.
           COPY "insumo-rec.cpy".

       WORKING-STORAGE SECTION.
       01  WS-STATUS-CONTROLE.
           05 WS-FS-ORC            PIC X(02).
           05 WS-FS-COMP           PIC X(02).
           05 WS-FS-INS            PIC X(02).
           05 WS-MENU-OPCAO        PIC X(01) VALUE SPACES.
           05 WS-FIM-COMP          PIC X(01) VALUE "N".

       01  WS-CALCULOS-AUXILIARES.
           05 WS-CUSTO-COMP        PIC 9(07)V99 VALUE ZEROS.
           05 WS-VALOR-ITEM        PIC 9(07)V99 VALUE ZEROS.

       PROCEDURE DIVISION.
       0000-PRINCIPAL SECTION.
           PERFORM 1000-ABRIR-ARQUIVOS
           
           PERFORM UNTIL WS-MENU-OPCAO = "0"
               DISPLAY "--------------------------------------------------"
               DISPLAY "        SUBMENU - ORCAMENTOS DE OBRAS             "
               DISPLAY "--------------------------------------------------"
               DISPLAY " 1 - CADASTRAR ORCAMENTO / OBRA"
               DISPLAY " 0 - RETORNAR AO MENU PRINCIPAL"
               DISPLAY "--------------------------------------------------"
               DISPLAY "DIGITE A OPCAO: " WITH NO ADVANCING
               ACCEPT WS-MENU-OPCAO
               
               IF WS-MENU-OPCAO = "1"
                   PERFORM 2000-CADASTRAR-ORCAMENTO
               END-IF
           END-PERFORM
           
           PERFORM 9000-FECHAR-ARQUIVOS
           GOBACK.

       1000-ABRIR-ARQUIVOS.
           OPEN I-O ARQ-ORCAMENTO
           IF WS-FS-ORC = "35"
               OPEN OUTPUT ARQ-ORCAMENTO
               CLOSE ARQ-ORCAMENTO
               OPEN I-O ARQ-ORCAMENTO
           END-IF.
           
           OPEN INPUT ARQ-COMPOSICAO-ORC
           OPEN INPUT ARQ-INSUMOS-ORC.

       2000-CADASTRAR-ORCAMENTO.
           DISPLAY " "
           DISPLAY "--- NOVO ORCAMENTO DE OBRA ---"
           DISPLAY "DIGITE O CODIGO DO ORCAMENTO: " WITH NO ADVANCING
           ACCEPT ORC-CODIGO
           
           DISPLAY "DIGITE O NOME/DESCRICAO DA OBRA: " WITH NO ADVANCING
           ACCEPT ORC-DESCRICAO
           
      * SIMULANDO UM CUSTO GLOBAL AUTOMATICO DE START PARA EXIBICAO
           MOVE 15000,50 TO ORC-VALOR-TOTAL
           MOVE "A" TO ORC-STATUS
           
           WRITE REG-ORCAMENTO
           IF WS-FS-ORC = "00"
               DISPLAY "--------------------------------------------------"
               DISPLAY ">>> ORCAMENTO GERADO COM SUCESSO! <<<"
               DISPLAY "OBRA:      " ORC-DESCRICAO
               DISPLAY "VALOR EST.: R$ " ORC-VALOR-TOTAL
               DISPLAY "--------------------------------------------------"
           ELSE
               DISPLAY "ERRO AO GRAVAR. FILE STATUS: " WS-FS-ORC
           END-IF
           DISPLAY " ".

       9000-FECHAR-ARQUIVOS.
           CLOSE ARQ-ORCAMENTO
           CLOSE ARQ-COMPOSICAO-ORC
           CLOSE ARQ-INSUMOS-ORC.