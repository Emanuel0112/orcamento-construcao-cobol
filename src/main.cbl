       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN.
       AUTHOR. EMANUEL PASSOS.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LK-OPCAO             PIC X(01) VALUE SPACES.
          88 OP-INSUMOS        VALUE "1".
          88 OP-COMPOSICOES    VALUE "2".
          88 OP-ORCAMENTOS     VALUE "3".
          88 OP-SAIR           VALUE "0".


       PROCEDURE DIVISION.
       0000-PRINCIPAL SECTION.
           PERFORM UNTIL OP-SAIR
               PERFORM 1000-EXIBIR-MENU
               PERFORM 2000-PROCESSAR-OPCAO
           END-PERFORM

           DISPLAY " "
           DISPLAY "SISTEMA ENCERRADO COM SUCESSO. ATE MAIS!"
           STOP RUN.

       1000-EXIBIR-MENU.
           DISPLAY "=================================================="
           DISPLAY "      SISTEMA DE ORCAMENTO DE CONSTRUCAO CIVIL     "
           DISPLAY "=================================================="
           DISPLAY " 1 - GERENCIAR INSUMOS (MATERIAIS / MAO DE OBRA)"
           DISPLAY " 2 - GERENCIAR COMPOSICOES DE CUSTOS"
           DISPLAY " 3 - GERENCIAR ORCAMENTOS DE OBRAS"
           DISPLAY " 0 - SAIR DO SISTEMA"
           DISPLAY "=================================================="
           DISPLAY "DIGITE A OPCAO DESEJADA: " WITH NO ADVANCING
           ACCEPT LK-OPCAO.

       2000-PROCESSAR-OPCAO.
           EVALUATE TRUE
               WHEN OP-INSUMOS
                   DISPLAY " "
                   DISPLAY ">>> REDIRECIONANDO PARA O MODULO DE INSUMO... <<<"
                   DISPLAY " "
                   CALL "INSUMO"
                   DISPLAY " "
                   DISPLAY ">>> RETORNADO AO MENU PRINCIPAL <<<"
                   DISPLAY " "
               WHEN OP-COMPOSICOES
                   DISPLAY " "
                   DISPLAY ">>> REDIRECIONANDO PARA O MODULO DE COMPOSICAO... <<<"
                   DISPLAY " "
                   CALL "COMPOSICAO"
                   DISPLAY " "
                   DISPLAY ">>> RETORNADO AO MENU PRINCIPAL <<<"
                   DISPLAY " "
               WHEN OP-ORCAMENTOS
                   DISPLAY " "
                   DISPLAY ">>> REDIRECIONANDO PARA O MODULO DE ORCAMENTO... <<<"
                   DISPLAY " "
                   CALL "ORCAMENTO"
                   DISPLAY " "
                   DISPLAY ">>> RETORNADO AO MENU PRINCIPAL <<<"
                   DISPLAY " "
               WHEN OP-SAIR
                   CONTINUE
               WHEN OTHER
                   DISPLAY " "
                   DISPLAY "OPCAO INVALIDA! TENTE NOVAMENTE."
                   DISPLAY " "
           END-EVALUATE.