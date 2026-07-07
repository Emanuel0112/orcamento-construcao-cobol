      *PROGRAMA: INSUMOS.CBL
      *OBJETIVO: MANUTENCAO DE ARQUIVOS INDEXADO E INSUMOS.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. INSUMOS.
       AUTHOR. EMANUEL PASSOS.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQ-INSUMOS ASSIGN TO "../data/insumos.dat"
           ORGANIZATION IS INDEXED
           ACCESS MODE  IS DYNAMIC
           RECORD KEY IS INS-CODIGO
           FILE STATUS  IS WS-FS-INSUMOS.

       DATA DIVISION.
       FILE SECTION.
           FD  ARQ-INSUMOS.
      *PUXA O CONTRATO DE DADOS QUE CRIAMOS NA PASTA COPYBOOKS
           COPY "copybooks/insumos.cpy".
       WORKING-STORAGE SECTION.
       01  WS-DIVISORES.
           05 WS-FS-INSUMOS        PIC X(02).
           05 WS-CONFIRMA          PIC X(01) VALUE SPACES.
           05 WS-FIM-ARQUIVO       PIC X(01) VALUE "N".

       01  WS-TELA-ENTRADA.
           05 WS-TXT-VALOR         PIC X(08).

PROCEDURE DIVISION.
       0000-PRINCIPAL SECTION.
           PERFORM 1000-ABRIR-ARQUIVO
           
           PERFORM UNTIL WS-CONFIRMA = "0"
               DISPLAY "--------------------------------------------------"
               DISPLAY "          SUBMENU - GERENCIAMENTO DE INSUMOS       "
               DISPLAY "--------------------------------------------------"
               DISPLAY " 1 - CADASTRAR NOVO INSUMO"
               DISPLAY " 2 - CONSULTAR INSUMO POR CODIGO"
               DISPLAY " 0 - RETORNAR AO MENU PRINCIPAL"
               DISPLAY "--------------------------------------------------"
               DISPLAY "DIGITE A OPCAO: " WITH NO ADVANCING
               ACCEPT WS-CONFIRMA
               
               EVALUATE WS-CONFIRMA
                   WHEN "1"
                       PERFORM 2000-COLETAR-DADOS
                   WHEN "2"
                       PERFORM 3000-CONSULTAR-DADO
                   WHEN "0"
                       CONTINUE
                   WHEN OTHER
                       DISPLAY "OPCAO INVALIDA!"
               END-EVALUATE
           END-PERFORM.
           
           PERFORM 9000-FECHAR-ARQUIVO
           GOBACK.

       1000-ABRIR-ARQUIVO.
           OPEN I-O ARQ-INSUMOS
           IF WS-FS-INSUMOS = "35"
               OPEN OUTPUT ARQ-INSUMOS
               CLOSE ARQ-INSUMOS
               OPEN I-O ARQ-INSUMOS
           END-IF.

       2000-COLETAR-DADOS.
           DISPLAY " "
           DISPLAY "--- NOVO CADASTRO ---"
           DISPLAY "DIGITE O CODIGO DO INSUMO (6 DIGITOS): " 
                   WITH NO ADVANCING
           ACCEPT INS-CODIGO
           
           DISPLAY "DESCRICAO DO MATERIAL/MAO DE OBRA: " 
                   WITH NO ADVANCING
           ACCEPT INS-DESCRICAO
           
           DISPLAY "UNIDADE DE MEDIDA (EX: M3, KG, H): " 
                   WITH NO ADVANCING
           ACCEPT INS-UNIDADE-MEDIDA
           
           DISPLAY "VALOR UNITARIO (EX: 00150,50): " 
                   WITH NO ADVANCING
           ACCEPT INS-VALOR-UNITARIO
           
           DISPLAY "TIPO (M-MATERIAL / O-MAO DE OBRA): " 
                   WITH NO ADVANCING
           ACCEPT INS-TIPO
           
           MOVE "A" TO INS-STATUS
           
           WRITE REG-INSUMO
           IF WS-FS-INSUMOS = "00"
               DISPLAY ">>> INSUMO GRAVADO COM SUCESSO! <<<"
           ELSE
               DISPLAY "ERRO AO GRAVAR. FILE STATUS: " WS-FS-INSUMOS
           END-IF
           DISPLAY " ".

       3000-CONSULTAR-DADO.
           DISPLAY " "
           DISPLAY "--- CONSULTA DE INSUMO ---"
           DISPLAY "DIGITE O CODIGO PARA BUSCA: " WITH NO ADVANCING
           ACCEPT INS-CODIGO
           
      * O READ PROCURA DIRETAMENTE PELA CHAVE (INS-CODIGO)
           READ ARQ-INSUMOS INVALID KEY
               DISPLAY ">>> INSUMO NAO ENCONTRADO! <<<"
           NOT INVALID KEY
               DISPLAY "--------------------------------------------------"
               DISPLAY "CODIGO:    " INS-CODIGO
               DISPLAY "DESCRICAO: " INS-DESCRICAO
               DISPLAY "UNIDADE:   " INS-UNIDADE-MEDIDA
               DISPLAY "VALOR UN:  R$ " INS-VALOR-UNITARIO
               DISPLAY "STATUS:    " INS-STATUS
               DISPLAY "--------------------------------------------------"
           END-READ
           DISPLAY " ".

       9000-FECHAR-ARQUIVO.
           CLOSE ARQ-INSUMOS.