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
           
           DISPLAY " "
           DISPLAY "--- CADASTRO DE INSUMO (PROTÓTIPO) ---"
           
           PERFORM 2000-COLETAR-DADOS
           
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
           
           DISPLAY "CONFIRMA A GRAVACAO? (S/N): " WITH NO ADVANCING
           ACCEPT WS-CONFIRMA
           
           IF WS-CONFIRMA = "S" OR "s"
               WRITE REG-INSUMO
               IF WS-FS-INSUMOS = "00"
                   DISPLAY "INSUMO GRAVADO COM SUCESSO!"
               ELSE
                   DISPLAY "ERRO AO GRAVAR. FILE STATUS: " 
                           WS-FS-INSUMOS
               END-IF
           ELSE
               DISPLAY "OPERACAO CANCELADA PELO USUARIO."
           END-IF.

       9000-FECHAR-ARQUIVO.
           CLOSE ARQ-INSUMOS.