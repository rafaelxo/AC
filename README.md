<div align="center">

# 🚀 AC — Arquitetura de Computadores

<p align="center">
  <img src="https://img.shields.io/github/repo-size/rafaelxo/AC?color=orange" alt="Repo Size">
  <img src="https://img.shields.io/github/stars/rafaelxo/AC?style=social" alt="Stars">
  <img src="https://img.shields.io/github/last-commit/rafaelxo/AC?color=red" alt="Last Commit">
</p>

**Repositório acadêmico contendo projetos e trabalhos da disciplina de Arquitetura de Computadores**

Implementação de circuitos digitais e processadores utilizando **Logisim**

</div>

---

## 📚 Sobre

Este repositório documenta os projetos desenvolvidos durante a disciplina de **Arquitetura de Computadores (AC)**, com foco na implementação de circuitos digitais, processadores e sistemas computacionais básicos.

O principal projeto é a **construção do processador SAP-1** (Simple As Possible), implementado no simulador Logisim, demonstrando conceitos fundamentais de organização e arquitetura de computadores.

---

## 🗂️ Estrutura do Repositório

```
AC/
│
├── 📁 AC1/                           # Arquitetura de Computadores I
│   ├── SAP.circ                      # Circuito do processador SAP-1 (Logisim)
│   ├── SAP.mp4                       # Vídeo demonstrativo do funcionamento
│   └── Trabalho Final - SAP 1.pdf    # Documentação do projeto
│
└── 📄 README.md                      # Este arquivo
```

---

## 💻 Projeto Principal:  Processador SAP-1

### 📌 O que é o SAP-1? 

O **SAP-1 (Simple As Possible - 1)** é um processador didático de 8 bits projetado para ensinar os fundamentos da arquitetura de computadores. Ele possui:

- **Largura de dados**: 8 bits
- **Arquitetura**: Von Neumann simplificada
- **Conjunto de instruções**:  Reduzido (RISC-like)
- **Componentes principais**:
  - Program Counter (PC)
  - Memory Address Register (MAR)
  - RAM (16 bytes)
  - Instruction Register (IR)
  - Accumulator (ACC)
  - ALU (Arithmetic Logic Unit)
  - Output Register
  - Control Unit

### 🔧 Implementação

O processador foi implementado no **Logisim**, um simulador de circuitos digitais educacional que permite: 
- Visualização do funcionamento de cada componente
- Simulação passo a passo da execução de instruções
- Análise do fluxo de dados entre os módulos

### 📊 Conjunto de Instruções

O SAP-1 possui um conjunto reduzido de instruções para operações básicas: 
- **LDA** (Load): Carrega dados da memória para o acumulador
- **ADD** (Add): Soma o valor da memória com o acumulador
- **SUB** (Subtract): Subtrai o valor da memória do acumulador
- **OUT** (Output): Envia o valor do acumulador para a saída
- **HLT** (Halt): Para a execução do programa

### 🎥 Demonstração

O repositório inclui um vídeo (`SAP.mp4`) demonstrando:
- Funcionamento do processador
- Execução de programas de exemplo
- Análise do comportamento dos sinais de controle

---

## 🛠️ Tecnologias Utilizadas

| Ferramenta | Uso |
|: ----------:|:----|
| 🔌 **Logisim** | Simulação de circuitos digitais e implementação do SAP-1 |
| 📄 **PDF** | Documentação técnica do projeto |
| 🎬 **Git LFS** | Gerenciamento de arquivos grandes (vídeo e PDF) |

---

## 📖 Conceitos Abordados

### Arquitetura de Computadores
- ✅ Organização de processadores
- ✅ Ciclo de busca-decodificação-execução (Fetch-Decode-Execute)
- ✅ Unidade de controle e sinais de controle
- ✅ Barramento de dados, endereços e controle
- ✅ Arquitetura Von Neumann

### Circuitos Digitais
- ✅ Portas lógicas (AND, OR, NOT, XOR)
- ✅ Registradores e flip-flops
- ✅ Multiplexadores e decodificadores
- ✅ Unidade Lógica e Aritmética (ALU)
- ✅ Memória RAM

### Microarquitetura
- ✅ Datapath (caminho de dados)
- ✅ Control Unit (unidade de controle)
- ✅ Microprogramação
- ✅ Temporização e clock

---

## 📚 Material de Referência

O trabalho foi baseado em conceitos de:
- **Arquitetura de Computadores** por William Stallings
- **Computer Organization and Design** (Patterson & Hennessy)
- **Digital Design and Computer Architecture** (Harris & Harris)

---

## 👤 Autor

**Rafael**  
[![GitHub](https://img.shields.io/badge/GitHub-rafaelxo-181717?style=for-the-badge&logo=github)](https://github.com/rafaelxo)

---

## 📄 Licença

Este repositório é destinado exclusivamente a **fins educacionais** e acadêmicos. 

---

## ⭐ Agradecimentos

Se este conteúdo foi útil para você, considere dar uma ⭐ no repositório!

---

<div align="center">

**Desenvolvido durante o curso de Ciência da Computação**

</div>
