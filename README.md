# 🏗️ Sistema de Engenharia de Custos e Orçamentos em COBOL

Análise, desenvolvimento e suporte de um sistema core para estimativa de custos e orçamentação de obras civis, desenvolvido em COBOL estruturado e modular.

## 💼 O Problema de Negócio
No setor de construção civil, a precisão no cálculo do custo direto (materiais e mão de obra) e indireto (BDI - Benefícios e Despesas Indiretas) determina o sucesso financeiro de um empreendimento. Este sistema automatiza o gerenciamento de tabelas de insumos, a montagem de composições de preços unitários (CPU) e a consolidação do orçamento final da obra.

## 🛠️ Arquitetura e Tecnologia
* **Linguagem:** COBOL (Padrão ANSI)
* **Persistência:** Arquivos Indexados (Simulação de VSAM) para alta performance em leitura e escrita.
* **Interface:** Modo Linha de Comando (CUI) focado em eficiência de processamento.
* **Ferramental:** VS Code, Zowe Explorer, Git e GitHub.

## 📂 Estrutura do Projeto
* `/src`: Códigos-fonte principais (`.cbl`).
* `/copybooks`: Estruturas de dados reutilizáveis (`.cpy`).
* `/data`: Arquivos físicos de dados gerados pelo sistema.

## 🚀 Como Executar
*(Instruções de compilação serão adicionadas ao longo do desenvolvimento)*