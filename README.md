<div align="center">

# 🚀 AC — Arquitetura de Computadores

<p align="center">
  <img src="https://img.shields.io/github/repo-size/rafaelxo/AC?color=orange" alt="Repo Size">
  <img src="https://img.shields.io/github/stars/rafaelxo/AC?style=social" alt="Stars">
  <img src="https://img.shields.io/github/last-commit/rafaelxo/AC?color=red" alt="Last Commit">
</p>

**Repositório acadêmico contendo projetos e trabalhos da disciplina de Arquitetura de Computadores**

Implementação de circuitos digitais e processadores utilizando **Logisim** e **Verilog**

</div>

---

## 📚 Sobre

Este repositório documenta os projetos desenvolvidos durante a disciplina de **Arquitetura de Computadores (AC)**, com foco na implementação de circuitos digitais, processadores e sistemas computacionais.

- **AC1** — Construção do processador **SAP-1** (Simple As Possible) no simulador Logisim.
- **AC2** — Implementação de um processador **RV32I** (subconjunto da arquitetura RISC-V de 32 bits) em Verilog, com assembler próprio e testbench.

---

## 🗂️ Estrutura do Repositório

```
AC/
│
├── 📁 AC1/                                  # Arquitetura de Computadores I
│   ├── SAP.circ                             # Circuito do processador SAP-1 (Logisim)
│   ├── SAP.mp4                              # Vídeo demonstrativo do funcionamento
│   └── Trabalho Final - SAP 1.pdf          # Documentação do projeto
│
├── 📁 AC2/                                  # Arquitetura de Computadores II
│   ├── Trabalho Prático - AC2.pdf          # Documentação do projeto RV32I
│   └── 📁 RV32I/                           # Processador RISC-V RV32I em Verilog
│       ├── assembler.py                    # Assembler RISC-V escrito em Python
│       ├── program.hex                     # Programa de teste compilado (hex)
│       ├── programa_teste.s               # Programa de teste em assembly RISC-V
│       ├── 📁 src/                         # Módulos Verilog do processador
│       │   ├── top_processor.v            # Top-level — integração de todos os módulos
│       │   ├── control_unit.v             # Unidade de controle
│       │   ├── alu.v                      # Unidade Lógica e Aritmética (ALU)
│       │   ├── alu_control.v              # Controle da ALU
│       │   ├── branch_comp.v             # Comparador de desvio (branch)
│       │   ├── imm_gen.v                  # Gerador de imediatos
│       │   ├── reg_file.v                 # Banco de registradores (32 × 32 bits)
│       │   ├── pc.v                       # Program Counter
│       │   ├── instr_mem.v               # Memória de instruções
│       │   └── data_mem.v                # Memória de dados
│       └── 📁 tb/                          # Testbench
│           └── tb_top_processor.v        # Testbench do processador completo
│
└── 📄 README.md                             # Este arquivo
```

---

## 💻 AC1 — Processador SAP-1

### 📌 O que é o SAP-1?

O **SAP-1 (Simple As Possible - 1)** é um processador didático de 8 bits projetado para ensinar os fundamentos da arquitetura de computadores. Ele possui:

- **Largura de dados**: 8 bits
- **Arquitetura**: Von Neumann simplificada
- **Conjunto de instruções**: Reduzido (RISC-like)
- **Componentes principais**:
  - Program Counter (PC)
  - Memory Address Register (MAR)
  - RAM (16 bytes)
  - Instruction Register (IR)
  - Accumulator (ACC)
  - ALU (Arithmetic Logic Unit)
  - Output Register
  - Control Unit

### 📊 Conjunto de Instruções — SAP-1

| Instrução | Operação |
|:---------:|:---------|
| **LDA** | Carrega dados da memória para o acumulador |
| **ADD** | Soma o valor da memória com o acumulador |
| **SUB** | Subtrai o valor da memória do acumulador |
| **OUT** | Envia o valor do acumulador para a saída |
| **HLT** | Para a execução do programa |

### 🔧 Ferramenta

O processador foi implementado no **Logisim**, um simulador de circuitos digitais educacional que permite visualização passo a passo da execução de instruções e do fluxo de dados entre os módulos.

---

## 💻 AC2 — Processador RV32I (RISC-V)

### 📌 O que é o RV32I?

O **RV32I** é o conjunto base de instruções inteiras de 32 bits da arquitetura **RISC-V**, uma ISA aberta e modular amplamente utilizada em pesquisa e indústria. Características:

- **Largura de dados**: 32 bits
- **Arquitetura**: RISC (Reduced Instruction Set Computer)
- **Banco de registradores**: 32 registradores de propósito geral (x0–x31)
- **Tipos de instrução**: R, I, S, B, U, J
- **Pipeline**: Implementação monociclo (single-cycle)

### 🔧 Módulos Implementados em Verilog

| Módulo | Descrição |
|:------:|:----------|
| `top_processor.v` | Integração de todos os componentes |
| `control_unit.v` | Geração de sinais de controle a partir do opcode |
| `alu.v` | Operações aritméticas e lógicas (ADD, SUB, AND, OR, XOR, SLT, etc.) |
| `alu_control.v` | Decodifica funct3/funct7 para operação da ALU |
| `branch_comp.v` | Comparações para instruções de desvio (BEQ, BNE, BLT, BGE…) |
| `imm_gen.v` | Extensão de sinal para imediatos de todos os formatos |
| `reg_file.v` | Banco de 32 registradores de 32 bits (x0 fixo em zero) |
| `pc.v` | Program Counter com atualização a cada ciclo |
| `instr_mem.v` | Memória de instruções (carrega arquivo `.hex`) |
| `data_mem.v` | Memória de dados com leitura e escrita |

### 🐍 Assembler Python

O projeto inclui um **assembler próprio** (`assembler.py`) escrito em Python que converte programas Assembly RISC-V (`.s`) para o formato hexadecimal (`.hex`) utilizado pelo simulador Verilog.

```bash
python assembler.py programa_teste.s
```

### 🧪 Testbench

O arquivo `tb/tb_top_processor.v` contém o testbench que executa o programa compilado (`program.hex`) e verifica o comportamento do processador ao longo dos ciclos de clock.

---

## 🛠️ Tecnologias Utilizadas

| Ferramenta | Uso |
|:-----------:|:----|
| 🔌 **Logisim** | Simulação de circuitos digitais — SAP-1 (AC1) |
| 📟 **Verilog (HDL)** | Implementação do processador RV32I (AC2) |
| 🐍 **Python** | Assembler RISC-V para geração de `.hex` |
| 📄 **PDF** | Documentação técnica dos projetos |
| 🎬 **Git LFS** | Gerenciamento de arquivos grandes (vídeo e PDF) |

---

## 📖 Conceitos Abordados

### Arquitetura de Computadores
- ✅ Organização de processadores (SAP-1 e RV32I)
- ✅ Ciclo de busca-decodificação-execução (Fetch-Decode-Execute)
- ✅ Arquitetura Von Neumann e RISC
- ✅ ISA RISC-V — tipos de instrução R, I, S, B, U, J
- ✅ Barramento de dados, endereços e controle

### Circuitos Digitais & HDL
- ✅ Portas lógicas, registradores e flip-flops
- ✅ Multiplexadores e decodificadores
- ✅ Descrição de hardware em Verilog
- ✅ Simulação com testbench

### Microarquitetura
- ✅ Datapath (caminho de dados)
- ✅ Control Unit (unidade de controle)
- ✅ Geração de imediatos (Immediate Generator)
- ✅ Desvios condicionais e incondicionais (Branch / Jump)
- ✅ Temporização e clock

---

## 📚 Material de Referência

- **Computer Organization and Design RISC-V Edition** — Patterson & Hennessy
- **Digital Design and Computer Architecture** — Harris & Harris
- **Arquitetura de Computadores** — William Stallings
- [RISC-V ISA Specification](https://riscv.org/technical/specifications/)

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
